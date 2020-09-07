//
//  CoinCapService.swift
//  Coinflow
//
//  Created by David Fanaro on 8/30/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import Foundation

class CoinCapService: ObservableObject {
    
    let baseUrl = "https://api.coincap.io/v2/assets"
    
    @Published var didRecieveData = false
    @Published var coinData:[ListCoin] = []
    
    func getAllCoins(){
        print("Start get coins")
        guard let url = URL(string: baseUrl) else {
            print("Failed to set url")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, res, err in
            
            print("Started datatask")
            
            guard let response = res as? HTTPURLResponse else {
                return
            }
            switch response.statusCode{
            case 200:
                DispatchQueue.main.async {self.didRecieveData = true}
                
                guard let jsonData = data else{
                    print("Error: No data received \(err.debugDescription)")
                    return
                }
                guard let coinDataArray = try? JSONDecoder().decode(ListCoinDataArray.self, from: jsonData) else{
                    print("Error: Failed to decode json")
                    return
                }
                
                DispatchQueue.main.async {
                    self.coinData = coinDataArray.data
                }
            case 400...499:
                print("Error: No data received \(err.debugDescription)")
                DispatchQueue.main.async {self.didRecieveData = false}
                return
            default:
                print("Error: unknown \(err.debugDescription)")
                DispatchQueue.main.async {self.didRecieveData = false}
                return
            }
            
        }.resume()
    }
    
    init() {
        print("Started coin cap service")
        getAllCoins()
    }
    
}
