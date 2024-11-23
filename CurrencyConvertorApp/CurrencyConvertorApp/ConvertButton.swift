//
//  ConvertButton.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.
//
import SwiftUI

struct ConvertButton: View {
    @Binding var isConverting: Bool
    @Binding var showAnimation: Bool
    let startConversion: () -> Void
    
    var body: some View {
        Button(action: startConversion) {
            Text(isConverting ? "Converting..." : "Convert")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    Color(red: 85/255, green: 173/255, blue: 155/255)// For #55AD9B
                    
                )
                .cornerRadius(10)
                .shadow(radius: 5)
        }
        .disabled(isConverting)
        .opacity(isConverting ? 0.7 : 1)
    }
}


