//
//  SettingsScreen.swift
//  ECC-Wallet
//
//  Created by Piyush Sharma on 8/8/21.
//  Copyright © 2021 Francisco Gindre. All rights reserved.
//

import SwiftUI

struct SettingsScreen: View {
    @State private var selectedAppearance = 1
    @Binding var theme: ColorScheme?
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        NavigationView {
            ZStack {
                Color.yellow
                Form {
                    Section(header: Text("Choose App Appearance")) {
                        if #available(iOS 14.0, *) {
                            Picker(selection: $selectedAppearance, label: Text("Theme")) {
                                Text("System Default").tag(1)
                                Text("Light").tag(2)
                                Text("Dark").tag(3)
                            }
                            .onChange(of: selectedAppearance) { value in
                                print(selectedAppearance)
                                switch selectedAppearance {
                                case 1:
                                    //print("System Default")
                                    theme = nil
                                case 2:
                                    //print("Light")
                                    theme = .light
                                    UserSettings.shared.userTheme = false
                                case 3:
                                    //print("Dark")
                                    theme = .dark
                                    UserSettings.shared.userTheme = true
                                default:
                                    break
                                }
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                        //...
                    }
                    //...
                }
            }
        } //<- Closing `NavigationView`
        .onAppear {
            switch theme {
            case .none:
                selectedAppearance = 1
            case .light:
                selectedAppearance = 2
            case .dark:
                selectedAppearance = 3
            default:
                break
            }
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    @State static var theme: ColorScheme? = .dark

    static var previews: some View {
        SettingsScreen(theme: $theme)
            .environment(\.colorScheme, .dark)
    }
}
