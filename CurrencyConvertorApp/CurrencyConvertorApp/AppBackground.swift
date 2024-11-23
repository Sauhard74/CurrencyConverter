//
//  AppBackground.swift
//  CurrencyConvertorApp
//
//  Created by Sauhard Gupta on 19/11/24.
//
import SwiftUI

struct BackgroundGradient: View {
    let isDarkMode: Bool
    
    var body: some View {
        LinearGradient(
            colors: isDarkMode
                ? [Color.black, Color(red: 0.15, green: 0.15, blue: 0.15), Color(red: 0.10, green: 0.10, blue: 0.10)]  // Dark mode gradient (black to dark charcoal)
                : [
                    Color(red: 149/255, green: 210/255, blue: 179/255), // For #95D2B3 (top)
                    Color(red: 241/255, green: 248/255, blue: 232/255) // For #F1F8E8 (bottom)
                ],  // Light mode gradient
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
