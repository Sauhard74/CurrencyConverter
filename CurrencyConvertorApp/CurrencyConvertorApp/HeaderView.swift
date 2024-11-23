//
//  HeaderView.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.
//

import SwiftUI

struct HeaderView: View {
    @Binding var isDarkMode: Bool
    
    var body: some View {
        HStack {
            Text("Currency Converter")
                .font(.largeTitle.bold())
                .foregroundColor(isDarkMode ? Color(red: 218/255, green: 180/255, blue: 45/255)
: Color(red: 32/255, green: 105/255, blue: 93/255) // For #26433D
 )
            
            Spacer()
            
            // Sun/Moon Toggle
            Button(action: { isDarkMode.toggle() }) {
                Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                    .font(.title2)
                    .foregroundColor(isDarkMode ? Color(red: 218/255, green: 180/255, blue: 45/255): Color(red: 4/255, green: 55/255, blue: 18/255) // For #26433D
)
                    .padding()
                    .background(
                        Circle()
                            .fill(isDarkMode ? Color.yellow.opacity(0.2) : Color.blue.opacity(0.2))
                    )
            }
        }
        .padding()
    }
}
