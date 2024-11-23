//
//  SwitchView.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.
//
import SwiftUI

struct ContentView: View {
    @State private var isCryptoView = false
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            // Background (before sucking in the content)
            Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
            
            // Switch views based on isCryptoView state
            if isCryptoView {
                CryptoExchangeRateView()
                    .transition(.asymmetric(insertion: .scale, removal: .scale))
            } else {
                CurrencyExchangeRateView()
                    .transition(.asymmetric(insertion: .scale, removal: .scale))
            }
            
            // Circular Button
            CurrencyToCryptoButton(isCryptoView: $isCryptoView)
                .position(x: UIScreen.main.bounds.width / 2, y: 50)
        }
        .animation(.easeInOut(duration: 1), value: isCryptoView)
    }
}



struct CurrencyExchangeRateView: View {
    var body: some View {
        VStack {
            Text("Currency Exchange Rates")
                .font(.largeTitle)
                .bold()
            // Add your currency exchange rate content here
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct CryptoExchangeRateView: View {
    var body: some View {
        VStack {
            Text("Crypto Exchange Rates")
                .font(.largeTitle)
                .bold()
            // Add your crypto exchange rate content here
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray)
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
