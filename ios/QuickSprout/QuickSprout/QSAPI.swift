//
//  QSAPI.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 08/10/2018.
//  Copyright © 2018 Spiir A/S. All rights reserved.
//

import Foundation

public class QSAPI {
  static func initAuth(endpoint: URL, language: String, redirectUrl: String, completionBlock: @escaping (String) -> Void) {
    let parameters = [
      "language" : language,
      "redirectUrl": redirectUrl,
      ]
    
    var request = URLRequest(url: endpoint)
    
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
      print("invalid JSON body")
      return
    }
    
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
      if let response = response {
        print(response)
      }
      
      if let data = data {
        do {
          let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
          
          if let authUrl = json?["authUrl"] as? String {
            DispatchQueue.main.async {
              completionBlock(authUrl);
            }
          }
          
          if let error = json?["error"] as? String {
            print(error)
          }
        } catch {
          print(error)
        }
      }
      }.resume()
  }
}
