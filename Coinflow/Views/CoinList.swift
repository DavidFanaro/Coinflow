//
//  CoinList.swift
//  Coinflow
//
//  Created by David Fanaro on 8/30/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import SwiftUI

struct CoinList: View {
    @EnvironmentObject var coinService: CoinCapService

    var body: some View {
        List(coinService.coinData, id: \.id){ coin in
            
            NavigationLink(destination: CoinDetailView(coin: coin)){
            Text("\(coin.name)")
            }
        }
    }
}

struct CoinList_Previews: PreviewProvider {
    static var previews: some View {
        CoinList()
    }
}
