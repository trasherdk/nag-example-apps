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
                        print(error)
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
                        var accountItems: [QSAccount] = []
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let accounts = json["accounts"] as? [Any] {
                                for account in accounts {
                                    if let _account = account as? [String: Any] {
                                        var accountItem = QSAccount(id: "", providerId: "", name: "", iban: "", currency: "", bookedBalance: 0)
                                        if let _id = _account["id"] as? String {
                                            accountItem.id = _id
                                        }
                                        if let _providerId = _account["providerId"] as? String {
                                            accountItem.providerId = _providerId
                                        }
                                        if let _name = _account["name"] as? String {
                                            accountItem.name = _name
                                        }
                                        if let _number = _account["number"] as? [String: Any], let _iban = _number["iban"] as? String {
                                            accountItem.iban = _iban
                                        }
                                        if let _currency = _account["currency"] as? String {
                                            accountItem.currency = _currency
                                        }
                                        if let _bookedBalance = _account["bookedBalance"] as? Double {
                                            accountItem.bookedBalance = _bookedBalance
                                        }
                                        accountItems.append(accountItem)
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            completionBlock(accountItems);
                        }
                    } catch {
                        print(error)
                    }
                }
                }.resume()
        }
    }
    
    static func transactions(accessToken: String, accountId: String, completeBlock: @escaping ([QSTransaction]) -> Void) {
        let params = ["token" : accessToken]
        
        if let request = buildPostRequest(endpoint: URLUtils.url(url: BASE_URL + "/accounts/transactions?id=\(accountId)"), body: params) {
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    do {
                        var transactionsItems: [QSTransaction] = []
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let transactions = json["transactions"] as? [Any] {
                                for transaction in transactions {
                                    if let transaction = transaction as? [String: Any] {
                                        var transactionItem = QSTransaction(id: "", date: "", creationDate: "", text: "", type: "", amount: 0, currency: "", state: "")
                                        if let id = transaction["id"] as? String {
                                            transactionItem.id = id
                                        }
                                        if let date = transaction["date"] as? String {
                                            transactionItem.date = date
                                        }
                                        if let creationDate = transaction["creationDate"] as? String {
                                            transactionItem.creationDate = creationDate
                                        }
                                        if let text = transaction["text"] as? String {
                                            transactionItem.text = text
                                        }
                                        if let type = transaction["type"] as? String {
                                            transactionItem.type = type
                                        }
                                        if let amount = transaction["amount"] as? Double {
                                            transactionItem.amount = amount
                                        }
                                        if let currency = transaction["currency"] as? String {
                                            transactionItem.currency = currency
                                        }
                                        if let state = transaction["state"] as? String {
                                            transactionItem.state = state
                                        }
                                        transactionsItems.append(transactionItem)
                                    }
                                }
                            }
                        }
                        DispatchQueue.main.async {
                            completeBlock(transactionsItems)
                        }
                    } catch {
                        print(error)
                    }
                }
                }.resume()
        }
    }
    
    private static func buildPostRequest(endpoint: URL?, body: [String: String]) -> URLRequest? {
        guard let endpoint = endpoint else {
            print("Invalid URL")
            return nil
        }
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            print("Invalid JSON body")
            return nil
        }
        request.httpBody = httpBody
        return request
    }
}
