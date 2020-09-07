//
//  LoadingView.swift
//  Coinflow
//
//  Created by David Fanaro on 8/30/20.
//  Copyright © 2020 David Fanaro. All rights reserved.
//

import SwiftUI

struct LoadingView: View {
    @State var isLoading = true

    var body: some View {
        
        VStack{
            Text("Loading")
            ActivityIndicator(isAnimating: $isLoading, style: .large)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
