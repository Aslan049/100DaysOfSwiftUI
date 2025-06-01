//
//  ContentView.swift
//  MoneyConverting
//
//  Created by Aslan Korkmaz on 1.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var money: Double = 0.0
    @State private var selectedUnit: String = "Dolar"
    let moneyUnits = ["Dolar", "Lira"]
    
    var convertMoney: Double {
        if selectedUnit == "Dolar" {
            return money * 34.0
        } else {
            return money / 34.0
        }
    }
    
    
    var body: some View {
        Form {
            Picker("Choose a Money Unit", selection: $selectedUnit) {
                ForEach(moneyUnits, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.menu)
            
            
            Section("Money Input") {
                TextField("Enter Money", value: $money, format: .currency(code: selectedUnit == "Lira" ? "TRY": "USD"))
                    .keyboardType(.decimalPad)
            }
            
            Section("Converted Money") {
                if selectedUnit == "Dolar" {
                    Text("\(String(format: "%.1f", convertMoney)) TRY")
                } else {
                    Text("\(String(format: "%.2f", convertMoney)) USD")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
