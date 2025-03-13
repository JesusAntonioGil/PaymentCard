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
    
    var rawCardNumber: String {
        number.replacingOccurrences(of: " ", with: "")
    }
}


enum ActiveField {
    case none
    case number
    case name
    case month
    case year
    case cvv
}


struct ContentView: View {
    // View Properties
    @State private var card: Card = .init()
    @FocusState private var activeField: ActiveField?
    
    
    var body: some View {
        VStack(spacing: 15) {
            ZStack {
                /*MeshGradient(
                    width: 4,
                    height: 4,
                    points: [
                        .init(0, 0), .init(0.33, 0), .init(0.66, 0), .init(1, 0),
                        .init(0, 0.33), .init(0.33, 0.33), .init(0.66, 0.33), .init(1, 0.33),
                        .init(0, 0.66), .init(0.33, 0.66), .init(0.66, 0.66), .init(1, 0.66),
                        .init(0, 1), .init(0.33, 1), .init(0.66, 1), .init(1, 1)
                    ],
                    colors: [
                        .indigo, .blue, .purple, .pink,
                        .blue, .purple, .pink, .red,
                        .purple, .pink, .red, .orange,
                        .pink, .red, .orange, .yellow
                    ]
                )
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .overlay {
                    CardFrontView()
                }*/
                
                RoundedRectangle(cornerRadius: 25)
                    .fill(.red.mix(with: .blue, by: 0.2))
                    .overlay {
                        CardBackView()
                    }
                    .frame(height: 200)
            }
            .frame(height: 200)
            
            CustomtextField(title: "Card Number", hint: "", value: $card.number) {
                card.number = String(card.number.group(" ", count: 4).prefix(19))
            }
            .focused($activeField, equals: .number)
            
            CustomtextField(title: "Card Name", hint: "", value: $card.name) {
                
            }
            .focused($activeField, equals: .name)
            
            HStack(spacing: 10) {
                CustomtextField(title: "Month", hint: "", value: $card.month) {
                    card.month = String(card.month.prefix(2))
                }
                .focused($activeField, equals: .month)
                
                CustomtextField(title: "Year", hint: "", value: $card.year) {
                    card.year = String(card.year.prefix(2))
                }
                .focused($activeField, equals: .year)
                
                CustomtextField(title: "CVV", hint: "", value: $card.cvv) {
                    card.cvv = String(card.cvv.prefix(3))
                }
                .focused($activeField, equals: .cvv)
            }
            .keyboardType(.numberPad)
            
            Spacer(minLength: 0)
        }
        .padding()
    }
    
    
    @ViewBuilder
    private func CardFrontView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            VStack(alignment: .leading, spacing: 4) {
                Text("CARD NUMBER")
                    .font(.caption)
                
                Text(String(card.rawCardNumber.dummyText("*", count: 16).prefix(16)).group(" ", count: 4))
                    .font(.title2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(10)
            .frame(maxWidth: .infinity)
            
            HStack(spacing: 10) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("CARD HOLDER")
                        .font(.caption)
                    
                    Text(card.name.isEmpty ? "YOUR NAME" : card.name)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(10)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("EXPIRES")
                        .font(.caption)
                    
                    HStack(spacing: 4) {
                        Text(String(card.month.prefix(2)).dummyText("M", count: 2))
                        
                        Text("/")
                        
                        Text(String(card.year.prefix(2)).dummyText("Y", count: 2))
                    }
                }
                .padding(10)
            }
        }
        .foregroundStyle(.white)
        .monospaced()
        .contentTransition(.numericText())
        .animation(.snappy, value: card)
        .padding(15)
    }
    
    @ViewBuilder
    private func CardBackView() -> some View {
        VStack(spacing: 15) {
            Rectangle()
                .fill(.black)
                .frame(height: 45)
                .padding(.horizontal, -15)
                .padding(.top, 10)
            
            VStack(alignment: .trailing, spacing: 6) {
                Text("CVV")
                    .font(.caption)
                    .padding(.trailing, 10)
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(.white)
                    .frame(height: 45)
                    .overlay(alignment: .trailing) {
                        Text(String(card.cvv.prefix(3)).dummyText("*", count: 3))
                            .foregroundStyle(.black)
                            .padding(.trailing, 15)
                    }
            }
            .foregroundStyle(.white)
            .monospaced()
            
            Spacer(minLength: 0)
        }
        .padding(15)
        .contentTransition(.numericText())
        .animation(.snappy, value: card)
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
        .onChange(of: value) { oldValue, newValue in
            onChange()
        }
    }
}



#Preview {
    ContentView()
}



extension String {
    func group(_ character: Character, count: Int) -> String {
        var modifiedString = self.replacingOccurrences(of: String(character), with: "")
        
        for index in 0..<modifiedString.count {
            if index % count == 0 && index != 0 {
                let groupCharactersCount = modifiedString.count(where: { $0 == character })
                let stringIndex = modifiedString.index(modifiedString.startIndex, offsetBy: index + groupCharactersCount)
                modifiedString.insert(character, at: stringIndex)
            }
        }
        
        return modifiedString
    }
    
    func dummyText(_ character: Character, count: Int) -> String {
        var tempText = self.replacingOccurrences(of: String(character), with: "")
        let remaining = min(max(count - tempText.count, 0), count)
        
        if remaining > 0 {
            tempText.append(String(repeating: character, count: remaining))
        }
        
        return tempText
    }
}
