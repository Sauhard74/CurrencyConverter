//
//  CurrencyPicker.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.
//
import SwiftUI

struct CurrencyPicker: View {
    let label: String
    @Binding var selection: String
    let currencies: [String]
    
    // Dark mode check
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(label)
                .font(.caption)
                .foregroundColor(Color(red: 85/255, green: 173/255, blue: 155/255))
            
            Picker(label, selection: $selection) {
                ForEach(currencies, id: \.self) { currency in
                    Text(currency)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color(red: 32/255, green: 105/255, blue: 93/255)) // Set text color based on dark mode
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: 100)
            .padding(5)
            .background(Color.white.opacity(0.2))
            .cornerRadius(10)
        }
    }
}
