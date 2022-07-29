//
//  UNS.swift
//  ECC-Wallet
//
//  Created by Amrit Jain on 07/07/22.
//  Copyright © 2022 Francisco Gindre. All rights reserved.
//

import Foundation
import UnstoppableDomainsResolution

class UNS {
    var supportedTLD: [String]
    struct TLD: Decodable{
        let tlds: [String]
    }
    init(){
        supportedTLD = []
    }
    
    func isValidUNSAddress(address: String, completionHandler: @escaping (Result<[String], Error>) -> Void)  {
        let enableUNS = UserSettings.shared.enableUNS ?? false
         if self.isValidUNS(address: address) && enableUNS {

           guard let resolution = try? Resolution() else {
              print ("Init of Resolution instance with default parameters failed...")
                return;
            }
            resolution.addr(domain: address, ticker: "ZEC")  { (result) in
               switch result {
                   case .success(let addr):
                       completionHandler(.success([address, addr]))
                   case .failure(_):
                       return;
               }
           }
        }
    }
    
     func isValidUNS(address: String) -> Bool{
         if supportedTLD.isEmpty {
             let url = URL(string: "https://resolve.unstoppabledomains.com/supported_tlds")!

             let task = URLSession.shared.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
                 guard let data = data else { return }
                 do {
                     let decodedData = try JSONDecoder().decode(TLD.self, from: data)
                     self.supportedTLD = decodedData.tlds
                 } catch {
                     return;
                 }
             }
             
             task.resume()
         }
        return supportedTLD.first(where: {address.contains($0)}) != nil || supportedTLD.isEmpty
    }

}
