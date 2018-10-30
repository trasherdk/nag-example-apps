//
//  QSAPI.swift
//  QuickSprout
//
//  Created by Brian Vestergaard Danielsen on 08/10/2018.
//  Copyright © 2018 Spiir A/S. All rights reserved.
//

import Foundation


public struct QSAPI {
  
  static let BASE_URL: String = "http://localhost:3000"
  
  static func initAuth(endpoint: URL, language: String, redirectUrl: String, completionBlock: @escaping (String) -> Void) {
    let parameters = ["language" : language, "redirectUrl": redirectUrl,]
    if let request = buildPostRequest(endpoint: endpoint, body: parameters) {
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
  
  static func tokens(code: String, completionBlock: @escaping (String) -> Void) {
    let params = ["code" : code]
    if let request = buildPostRequest(endpoint: URL(string: BASE_URL + "/tokens")!, body: params) {
      let session = URLSession.shared
      session.dataTask(with: request) { (data, response, error) in
        if let data = data {
          do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

            if let session = json?["session"] as? [String: Any], let accessToken = session["accessToken"] as? String {
              DispatchQueue.main.async {
                completionBlock(accessToken);
              }
            }
          } catch {
            print("ERROR! ERROR! ERROR! ERROR!")
          }
        }
      }.resume()
    }
  }
  
  static func accounts(accessToken: String, completionBlock: @escaping ([QSAccount]) -> Void) {
    let params = ["token" : accessToken]
    if let request = buildPostRequest(endpoint: URL(string: BASE_URL + "/accounts")!, body: params) {
      let session = URLSession.shared
      session.dataTask(with: request) { (data, response, error) in
        if let data = data {
          do {
            var acccoutsr: [QSAccount] = []
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
              if let accounts = json["accounts"] as? [Any] {
                for account in accounts {
                  if let _account = account as? [String: Any] {
                    var accounta = QSAccount(providerId: "", name: "", iban: "", currency: "", bookedBalance: "")
                    if let _providerId = _account["providerId"] as? String {
                      accounta.providerId = _providerId
                    }
                    if let _name = _account["name"] as? String {
                      accounta.name = _name
                    }
                    if let _number = _account["number"] as? [String: Any], let _iban = _number["iban"] as? String {
                      accounta.iban = _iban
                    }
                    if let _currency = _account["currency"] as? String {
                      accounta.currency = _currency
                    }
                    if let _bookedBalance = _account["bookedBalance"] as? String {
                      accounta.bookedBalance = _bookedBalance
                    }
                    acccoutsr.append(accounta)
                  }
                }
              }
            }
            DispatchQueue.main.async {
              completionBlock(acccoutsr);
            }
          } catch {
            print("ERROR! ERROR! ERROR! ERROR!")
          }
        }
      }.resume()
    }
  }
  
  private static func buildPostRequest(endpoint: URL, body: [String: String]) -> URLRequest? {
    var request = URLRequest(url: endpoint)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
      print("invalid JSON body")
      return nil
    }
    request.httpBody = httpBody
    return request
  }
}
