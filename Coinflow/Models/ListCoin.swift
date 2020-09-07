//
//  ListCoin.swift
//  Coinflow
//
//  Created by David Fanaro on 8/30/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import Foundation

struct ListCoinDataArray: Codable {
    var data: [ListCoin]
    var timestamp: Int
}

struct ListCoinData: Codable {
    var data: ListCoin
    var timestamp: Int
}

struct ListCoin: Codable, Identifiable {
    var id: String
    var rank: String
    var symbol: String
    var name: String
    var supply: String
    var maxSuppy: String?
    var volumeUsd24Hr: String
    var priceUsd: String
    var changePercent24Hr: String
    var vwap23Hr: String?
}
