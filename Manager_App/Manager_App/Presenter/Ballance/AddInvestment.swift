//
//  AddInvestment.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//

import SwiftUI
import Foundation

import SwiftUI
import Foundation

struct AddInvestment: View {
    @Binding var showModal: Bool
    
    @State private var selectedType: TypesInvesment = .stocks
    @State private var value: Double = 0
    @State private var qtd: Double = 0
    @State private var subtractFromBudget: Bool = false
    @State private var identifier: String = ""
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Add Investment")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.white)
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.backGround3)
                    
                    HStack {
                        ForEach(TypesInvesment.allCases, id: \.self) { type in
                            ZStack {
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(selectedType == type ? Color.white : Color.clear)
                                
                                Text(type.rawValue.capitalized)
                                    .font(.caption)
                                    .foregroundStyle(.backGround)
                                    .onTapGesture {
                                        selectedType = type
                                    }
                            }
                        }
                    }
                    .padding(3)
                }
                .aspectRatio(12, contentMode: .fit)
                
                HStack {
                    VStack {
                        Text("Name").foregroundStyle(.white)
                        TextField("Name", text: $identifier)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                    
                    VStack {
                        Text("Value").foregroundStyle(.white)
                        TextField("00.00", text: $value.formattedNumber())
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(8)
                        .keyboardType(.decimalPad)
                    }
                    
                    VStack {
                        Text("Qtd").foregroundStyle(.white)
                        
                        TextField("00.00", text: $qtd.formattedNumber())
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(8)
                        .keyboardType(.decimalPad)
                    }
                }
                .padding()
                .foregroundStyle(.black)
                
                Toggle("Subtract from Budget?", isOn: $subtractFromBudget)
                
                Spacer()
                
                Button {
                    SwiftData_Manager.shared.addInvestment(.init(identifier: identifier, symbol: Currency.dollar.rawValue, type: selectedType.rawValue, value: value, qtd: qtd), subtractFromBudget: subtractFromBudget)
                    showModal.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("Confirm")
                            .bold()
                        Spacer()
                    }
                }
                .buttonStyle(.borderedProminent)
                
                Button {
                    showModal.toggle()
                } label: {
                    HStack {
                        Spacer()
                        Text("Cancel")
                            .bold()
                        Spacer()
                    }
                }
                .buttonStyle(.bordered)
            }
            .padding()
        }
        .foregroundStyle(.white)
        .background(Color.backGround)
    }
}


extension Binding where Value == Double {
    func formattedNumber() -> Binding<String> {
        let numberFormatter: NumberFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.locale = Locale(identifier: "en_US")
            formatter.minimumFractionDigits = 0
            formatter.maximumFractionDigits = 2
            return formatter
        }()
        
        return Binding<String>(
            get: {
                if self.wrappedValue == 0.0 {
                    return ""
                } else {
                    return numberFormatter.string(from: NSNumber(value: self.wrappedValue)) ?? ""
                }
            },
            set: { newValue in
                let cleanValue = newValue.replacingOccurrences(of: ",", with: ".")
                if let parsedValue = numberFormatter.number(from: cleanValue) {
                    self.wrappedValue = parsedValue.doubleValue
                }
            }
        )
    }
}


#Preview {
    AddInvestment(showModal: .constant(false))
}
