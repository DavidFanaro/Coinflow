//
//  CoinDetailService.swift
//  Coinflow
//
//  Created by David Fanaro on 8/31/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import Foundation

class CoinDetailService: ObservableObject {
    let url = "wss://ws.coincap.io/prices?assets="
    
    @Published var price: String?
    var coinName: String = ""
    
    var coin: [String:String]?
    
    var task:URLSessionWebSocketTask!

    
    func livePrice() {
        
        task.receive { result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received text message: \(text)")
                    guard let jsonData = try? JSONDecoder().decode([String:String].self, from: text.data(using: .utf8)!) else{
                        return
                    }
                    guard let priceStr = jsonData[self.coinName] else{
                        return
                    }
                    
                    guard let priceDouble = Double(priceStr) else {
                        return
                    }
                    let formatedPrice = String(format: "$%.02f", priceDouble)
                    
                    DispatchQueue.main.async {
                        self.price = formatedPrice
                    }
                    
                case .data(let data):
                    print("Received binary message: \(data)")
                    
                    
                    
                @unknown default:
                    print("Unknown Error")
                }
                self.livePrice()
            }
        }
            
        
        task.resume()
        
    }
    
    func disconnet() {
        let reason = "No longer listening"
        DispatchQueue.main.async {
            self.task.cancel(with: .goingAway, reason: reason.data(using: .utf8))
        }
        
    }
    
    func create (name:String) {
        coinName = name
        
        let currentUrl = URL(string: "\(url)\(coinName)")
        task = URLSession.shared.webSocketTask(with: currentUrl!)
    }
    
}

