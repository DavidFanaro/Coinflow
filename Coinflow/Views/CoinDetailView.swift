//
//  CoinDetailView.swift
//  Coinflow
//
//  Created by David Fanaro on 8/31/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import SwiftUI

struct CoinDetailView: View {
    
    @ObservedObject var liveCoinService = CoinDetailService()
    
    var coin: ListCoin?
    
    
    var body: some View {
        VStack {
            Text("\(coin?.name ?? "Error")")
            Text("\(liveCoinService.price ?? "Error")")
        }.onAppear{
            DispatchQueue(label: "LoadingData").async {
                self.liveCoinService.create(name: self.coin?.id ?? "" )
                self.liveCoinService.livePrice()
            }
        }.onDisappear{
            self.liveCoinService.disconnet()
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView()
    }
}
