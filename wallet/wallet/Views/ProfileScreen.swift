//
//  ProfileScreen.swift
//  wallet
//
//  Created by Francisco Gindre on 1/22/20.
//  Copyright © 2020 Francisco Gindre. All rights reserved.
//
import SwiftUI
import ZcashLightClientKit

fileprivate struct ScreenConstants {
    static let buttonHeight = CGFloat(48)
    static let horizontalPadding = CGFloat(30)
}

struct ProfileScreen: View {
    enum Destination: Int, Identifiable, Hashable {
        case feedback
        case seedBackup
        case nuke
        var id: Int {
            return self.rawValue
        }
    }
    
    @EnvironmentObject var appEnvironment: ZECCWalletEnvironment
    @Environment(\.presentationMode) var presentationMode
    @State var nukePressed = false
    @State var copiedValue: PasteboardItemModel?
    @State var alertItem: AlertItem?
    @State var showingSheet: Bool = false
    @State var shareItem: ShareItem? = nil
    @State var destination: Destination?
    @State private var enableUNS = UserSettings.shared.enableUNS ?? false

    var body: some View {
        NavigationView {
            ZStack {
                ZcashBackground()
                ScrollView {
                    VStack(alignment: .center) {
                        VStack {
                            Toggle(isOn: $enableUNS) {
                                Text("Enable Unstoppable Domains")
                                    .foregroundColor(.white)
                                    .zcashButtonBackground(shape: .roundedCorners(fillStyle: .outline(color: .white, lineWidth: 1)))
                                    .frame(height: ScreenConstants.buttonHeight)
                                    .font(.system(size: 15))
                            }.onChange(of: enableUNS) { value in
                                UserSettings.shared.enableUNS  = value
                            }
                            
                            Button(action: {
                                let url = URL(string: "https://buy.moonpay.com/?apikey=pk_live_SWNmrQMVF1fkyfdkQAX6nbzA2sCUXpMk&currencyCode=zec")!
                                
                                UIApplication.shared.open(url)}) {
                                    Text("Buy ZEC via MoonPay")
                                        .foregroundColor(.white)
                                        .zcashButtonBackground(shape: .roundedCorners(fillStyle: .outline(color: .white, lineWidth: 1)))
                                        .frame(height: ScreenConstants.buttonHeight)
                                }
                            
                            Button(action: {
                                let url = URL(string: "https://sideshift.ai/")!
                                
                                UIApplication.shared.open(url)}) {
                                    Text("Fund my wallet via SideShift.ai")
                                        .foregroundColor(.white)
                                        .zcashButtonBackground(shape: .roundedCorners(fillStyle: .outline(color: .white, lineWidth: 1)))
                                        .frame(height: ScreenConstants.buttonHeight)
                                }
                            
                            Button(action: {
                                let url = URL(string: "https://twitter.com/NighthawkWallet")!
                                
                                UIApplication.shared.open(url)}) {
                                    Text("@NighthawkWallet")
                                        .foregroundColor(.black)
                                        .zcashButtonBackground(shape: .roundedCorners(fillStyle: .solid(color: Color.zYellow)))
                                        .frame(height: ScreenConstants.buttonHeight)
                                }
                            
                            NavigationLink(destination: LazyView(
                                SeedBackup(hideNavBar: false)
                                    .environmentObject(self.appEnvironment)
                            ), tag: Destination.seedBackup, selection: $destination
                            ) {
                                Text("button_backup")
                                    .foregroundColor(.white)
                                    .zcashButtonBackground(shape: .roundedCorners(fillStyle: .outline(color: .white, lineWidth: 1)))
                                    .frame(height: ScreenConstants.buttonHeight)
                                
                            }
                            Button(action: {
                                self.showingSheet = true
                            }){
                                Text("Rescan Wallet".localized())
                                    .foregroundColor(.zYellow)
                                    .zcashButtonBackground(shape: .roundedCorners(fillStyle: .outline(color: .zYellow, lineWidth: 1)))
                                    .frame(height: ScreenConstants.buttonHeight)
                            }
                            
                            ActionableMessage(message: "\("Nighthawk".localized()) v\(ZECCWalletEnvironment.appVersion ?? "Unknown")", actionText: "Build \(ZECCWalletEnvironment.appBuild ?? "Unknown")", action: {})
                                .disabled(true)
                            
                            Button(action: {
                                self.nukeWallet()
                            }) {
                                Text("NUKE WALLET".localized())
                                    .foregroundColor(.red)
                                    .zcashButtonBackground(shape: .roundedCorners(fillStyle: .outline(color: .red, lineWidth: 1)))
                                    .frame(height: ScreenConstants.buttonHeight)
                            }
                            
                            NavigationLink(destination: LazyView (
                                NukeWarning().environmentObject(self.appEnvironment)
                            ), isActive: self.$nukePressed) {
                                EmptyView()
                            }.isDetailLink(false)
                            
                        }
                        .padding(.horizontal, ScreenConstants.horizontalPadding)
                        .padding(.bottom, 15)
                        .alert(item: self.$copiedValue) { (p) -> Alert in
                            PasteboardAlertHelper.alert(for: p)
                        }
                    }
                }
                .padding(.horizontal, ScreenConstants.horizontalPadding)
                .padding(.bottom, 30)
                .alert(item: self.$copiedValue) { (p) -> Alert in
                    PasteboardAlertHelper.alert(for: p)
                }
                .actionSheet(isPresented: $showingSheet) {
                    ActionSheet(
                        title: Text("Do you want to re-scan your wallet?"),
                        message: Text("roll back your local data and sync it again"),
                        buttons: [
                            .destructive(Text("Wipe"), action: {
                                do {
                                    try self.appEnvironment.wipe(abortApplication: false)
                                    self.alertItem = AlertItem(type: .feedback(
                                        message: "SUCCESS! Wallet data cleared. Please relaunch to rescan!",
                                        action: {
                                            abort()
                                        }))
                                } catch {
                                    self.alertItem = AlertItem(
                                        type: AlertType.actionable(
                                            title: "Wipe Failed",
                                            message: "Wipe operation failed with error \(error). You might want to screenshot this. Your app could work properly. You can close it and restart it, or nuke it.",
                                            destructiveText: "NUKE WALLET".localized(),
                                            destructiveAction: { self.nukeWallet() },
                                            dismissText: "Close App",
                                            dismissAction: {
                                                abort()
                                            })
                                    )
                                }
                            }),
                            .default(Text("Quick Re-Scan"), action: {
                                self.appEnvironment.synchronizer.quickRescan()
                                self.presentationMode.wrappedValue.dismiss()
                            }),
                            .default(Text("Dismiss".localized()))
                        ]
                    )
                }
                .sheet(item: self.$shareItem, content: { item in
                    ShareSheet(activityItems: [item.activityItem])
                })
                .alert(item: self.$alertItem, content: { a in
                    a.asAlert()
                })
                .navigationBarTitle("", displayMode: .inline)
                .navigationBarHidden(false)
                .navigationBarItems(trailing: ZcashCloseButton(action: {
                    tracker.track(.tap(action: .profileClose), properties: [:])
                    self.presentationMode.wrappedValue.dismiss()
                }).frame(width: 30, height: 30))
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarHidden(false)
            navigationBarItems(trailing: ZcashCloseButton(action: {
                tracker.track(.tap(action: .profileClose), properties: [:])
                self.presentationMode.wrappedValue.dismiss()
            }).frame(width: 30, height: 30))
        }
    }
    
    func nukeWallet() {
        self.nukePressed = true
    }
}
