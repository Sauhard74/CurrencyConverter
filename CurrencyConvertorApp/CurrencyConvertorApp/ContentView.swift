import SwiftUI

struct CurrencyConverterView: View {
    @State private var baseCurrency = "INR"
    @State private var targetCurrency = "USD"
    @State private var amount: String = ""
    @State private var convertedAmount: String = "0.00"
    @State private var isConverting = false
    @State private var showAnimation = false
    @State private var isDarkMode = false

    let currencies = ["USD", "EUR", "INR", "GBP", "JPY"]

    var body: some View {
        ZStack {
            // Background Gradient
            BackgroundGradient(isDarkMode: isDarkMode)
            
            VStack(spacing: 20) {
                // Header
                HeaderView(isDarkMode: $isDarkMode)
                
                // Input Section
                InputSection(amount: $amount, baseCurrency: $baseCurrency, targetCurrency: $targetCurrency, currencies: currencies)

                // Convert Button
                ConvertButton(isConverting: $isConverting, showAnimation: $showAnimation, startConversion: startConversion)

                // Coin Animation
                if showAnimation {
                    CoinAnimationView(fromCurrency: baseCurrency, toCurrency: targetCurrency, convertedAmount: convertedAmount)
                        .frame(height: 300)
                }

                // Converted Amount (Initially Hidden)
                if !showAnimation {
                    ConvertedAmountView(
                        convertedAmount: convertedAmount,
                        targetCurrency: targetCurrency,
                        toCurrency: "",  
                        showAnimation: $showAnimation
                    )

                }
            }
            .padding()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }

    func startConversion() {
        guard !amount.isEmpty, let amountValue = Double(amount) else {
            return
        }
        isConverting = true
        showAnimation = true
        
        withAnimation(.easeInOut(duration: 6)) {
            showAnimation = true
        }
        
        fetchConversionRate(base: baseCurrency, target: targetCurrency, amount: amountValue) { rate in
            DispatchQueue.main.async {
                self.convertedAmount = String(format: "%.2f", rate)
                self.isConverting = false
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            withAnimation {
                self.showAnimation = false
            }
        }
    }

    func fetchConversionRate(base: String, target: String, amount: Double, completion: @escaping (Double) -> Void) {
        let urlString = "https://api.exchangerate-api.com/v4/latest/\(base)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let rates = json["rates"] as? [String: Double],
                  let targetRate = rates[target] else {
                completion(0.0)
                return
            }
            let convertedValue = amount * targetRate
            completion(convertedValue)
        }.resume()
    }
}

struct CurrencyConverterView_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyConverterView()
    }
}

