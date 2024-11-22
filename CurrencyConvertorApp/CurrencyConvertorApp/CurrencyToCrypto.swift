//
//  CurrencyToCrypto.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.
//

import SwiftUI

struct CurrencyToCryptoButton: View {
    @Binding var isCryptoView: Bool // To switch between currency and crypto view
    @State private var isAnimating = false

    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.6)) {
                    isAnimating.toggle() // Trigger animation
                    isCryptoView.toggle() // Switch between views
                }
            }) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 100, height: 100)
                        .shadow(radius: 10)
                    Circle()
                        .stroke(lineWidth: 4)
                        .foregroundColor(Color.blue)
                        .frame(width: 110, height: 110)
                        .scaleEffect(isAnimating ? 1.2 : 1) // Vibrant ring effect
                        .animation(.easeInOut(duration: 0.6), value: isAnimating)
                    
                    Text(isCryptoView ? "Crypto" : "Currency")
                        .foregroundColor(Color.black)
                        .bold()
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
