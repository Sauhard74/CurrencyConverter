//
//  CoinAnimationView.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.

import SwiftUI

struct CoinAnimationView: View {
    let fromCurrency: String
    let toCurrency: String
    let convertedAmount: String

    @State private var coinPosition = CGSize(width: 0, height: -200) // Initial position for coin
    @State private var showLoop = false // Circular loop visibility
    @State private var animationComplete = false // Track animation completion
    @State private var hideBaseCoin = false // Hide the base coin once converted coin pops out

    var body: some View {
        ZStack {
            // Circular Loop
            Circle()
                .strokeBorder(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 8
                )
                .frame(width: 150, height: 150)
                .opacity(showLoop ? 1 : 0)
                .scaleEffect(showLoop ? 1 : 0.5)
                .animation(.easeInOut(duration: 1), value: showLoop)

            // Base Currency Coin
            if !hideBaseCoin {
                baseCoinView
                    .offset(coinPosition)
                    .zIndex(2)
                    .onAppear {
                        startBaseCoinAnimation()
                    }
            }

            // Converted Currency Coin (Pops out from the same position)
            convertedCoinView
                .offset(coinPosition)
                .scaleEffect(animationComplete ? 1 : 0.5)
                .opacity(animationComplete ? 1 : 0)
                .zIndex(3)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.5), value: animationComplete)

            // Converted Amount Display
            if animationComplete {
                Text("\(convertedAmount) \(toCurrency)")
                    .font(.title.bold())
                    .foregroundColor(.green)
                    .transition(.opacity)
                    .padding(.top, 250)
            }
        }
    }

    // Base Coin View
    private var baseCoinView: some View {
        ZStack {
            Image(systemName: currencySymbol(for: fromCurrency))
                .resizable()
                .frame(width: 80, height: 80)
                .foregroundColor(.yellow)

            if fromCurrency == "INR" {
                Text("₹")
                    .font(.largeTitle.bold())
                    .foregroundColor(.yellow)
            }
        }
    }

    // Converted Coin View
    private var convertedCoinView: some View {
        ZStack {
            Image(systemName: currencySymbol(for: toCurrency))
                .resizable()
                .frame(width: 130, height: 130) // Slightly larger for pop effect
                .foregroundColor(.green)

            if toCurrency == "INR" {
                Text("₹")
                    .font(.largeTitle.bold())
                    .foregroundColor(.green)
                
            }
        }
    }

    // Base coin animation logic
    func startBaseCoinAnimation() {
        withAnimation(.easeInOut(duration: 2)) {
            coinPosition = .zero // Move to the center
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showLoop = true // Show the circular loop

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                showLoop = false // Hide the loop
                startConvertedCoinAnimation()
            }
        }
    }

    // Converted coin animation logic
    func startConvertedCoinAnimation() {
        withAnimation(.easeInOut(duration: 2)) {
            hideBaseCoin = true // Hide the base coin
            animationComplete = true // Show the converted coin and amount
        }
    }

    // Helper function to map currency codes to valid SF Symbols
    func currencySymbol(for currency: String) -> String {
        switch currency {
        case "USD": return "dollarsign.circle.fill"
        case "EUR": return "eurosign.circle.fill"
        case "GBP": return "sterlingsign.circle.fill"
        case "JPY": return "yensign.circle.fill"
        case "INR": return "circle" // Custom handling for INR
        default: return "questionmark.circle.fill" // Fallback for unsupported currencies
        }
    }
}
