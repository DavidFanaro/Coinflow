//
//  ContentView.swift
//  Coinflow
//
//  Created by David Fanaro on 8/29/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var coinService: CoinCapService
    @State var isLoading = true
    
    @ViewBuilder
    var body: some View {
        
        
        if coinService.didRecieveData {
            NavigationView{
                CoinList().environmentObject(coinService)
            }
        }else{
            LoadingView()
        }
        
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
