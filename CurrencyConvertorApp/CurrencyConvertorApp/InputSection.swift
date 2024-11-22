//
//  InputSection.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.
//

import SwiftUI

struct InputSection: View {
    @Binding var amount: String
    @Binding var baseCurrency: String
    @Binding var targetCurrency: String
    let currencies: [String]
    
    var body: some View {
        VStack(spacing: 15) {
            TextField("Enter Amount", text: $amount)
                .keyboardType(.decimalPad)
                .padding()
                .background(Color.white.opacity(0.2))
                .cornerRadius(10)
                .foregroundColor(.black)
                .font(.title2)
            
            HStack {
                CurrencyPicker(label: "From", selection: $baseCurrency, currencies: currencies)
                
                Spacer()
                
                Button(action: { swap(&baseCurrency, &targetCurrency) }) {
                    Image(systemName: "arrow.left.arrow.right.circle.fill")
                        .font(.system(size: 40))
                        .foregroundColor( Color(red: 85/255, green: 173/255, blue: 155/255)) // Corrected the color syntax
                        .padding()
                }
                .accessibilityLabel("Swap currencies")
                
                CurrencyPicker(label: "To", selection: $targetCurrency, currencies: currencies)
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.white.opacity(0.2))
        .cornerRadius(15)
        .shadow(radius: 5)
    }

    // Swap function to exchange currencies
    func swap(_ baseCurrency: inout String, _ targetCurrency: inout String) {
        let temp = baseCurrency
        baseCurrency = targetCurrency
        targetCurrency = temp
    }
}
