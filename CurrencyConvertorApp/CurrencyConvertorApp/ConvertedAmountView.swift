// ConvertedAmountView.swift
// CurrencyConvertorApp
//
// Created by Sauhard Gupta on 19/11/24.

import SwiftUI

struct ConvertedAmountView: View {
    let convertedAmount: String
    let targetCurrency: String
    let toCurrency: String // New property for the target currency context
    @Binding var showAnimation: Bool
    
    // Dark mode check
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            // Converted Amount with toCurrency context
            if !showAnimation {
                Text("Converted Amount: \(convertedAmount) \(targetCurrency)")
                    .font(.title2.bold())
                    .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.8) : Color(red: 32/255, green: 105/255, blue: 93/255))
                    .padding(.top, 20)
                    .opacity(showAnimation ? 0 : 1)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 1), value: showAnimation)
            }
        }
    }
}

struct ConvertedAmountView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConvertedAmountView(
                convertedAmount: "100.00",
                targetCurrency: "USD",
                toCurrency: "EUR",
                showAnimation: .constant(false)
            )
            .background(Color.gray)
            .preferredColorScheme(.light) // Light mode preview
            .previewLayout(.sizeThatFits)

            ConvertedAmountView(
                convertedAmount: "100.00",
                targetCurrency: "USD",
                toCurrency: "EUR",
                showAnimation: .constant(false)
            )
            .background(Color.gray)
            .preferredColorScheme(.dark) // Dark mode preview
            .previewLayout(.sizeThatFits)
        }
    }
}
