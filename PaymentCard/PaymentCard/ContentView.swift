//
//  ContentView.swift
//  PaymentCard
//
//  Created by Jesus Antonio Gil on 13/3/25.
//

import SwiftUI



struct Card: Hashable {
    var name: String = ""
    var number: String = ""
    var cvv: String = ""
    var month: String = ""
    var year: String = ""
}



struct ContentView: View {
    // View Properties
    @State private var card: Card = .init()
    
    
    var body: some View {
        VStack(spacing: 15) {
            CustomtextField(title: "Card Number", hint: "", value: $card.name) {
                
            }
            
            CustomtextField(title: "Card Name", hint: "", value: $card.name) {
                
            }
            
            HStack(spacing: 10) {
                CustomtextField(title: "Month", hint: "", value: $card.name) {
                    card.month = String(card.month.prefix(2))
                }
                
                CustomtextField(title: "Year", hint: "", value: $card.name) {
                    card.year = String(card.year.prefix(2))
                }
                
                CustomtextField(title: "CVV", hint: "", value: $card.name) {
                    card.cvv = String(card.cvv.prefix(2))
                }
            }
            
            Spacer(minLength: 0)
        }
        .padding()
    }
}


struct CustomtextField: View {
    var title: String
    var hint: String
    @Binding var value: String
    var onChange: () -> ()
    // View Properties
    @FocusState private var isActive: Bool
                
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(.gray)
            
            TextField(hint, text: $value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .contentShape(.rect)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isActive ? .blue : .gray.opacity(0.5), lineWidth: 1.5)
                        .animation(.snappy, value: isActive)
                }
                .focused($isActive)
        }
    }
}



#Preview {
    ContentView()
}
