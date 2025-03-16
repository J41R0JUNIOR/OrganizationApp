//
//  AddInvestment.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//

import SwiftUI
import Foundation

enum ActiveField {
    case value, qtd
}

struct AddInvestment: View {
    @Binding var showModal: Bool
    @State private var selectedType: TypesInvesment = .stocks
    @State private var value: String = ""
    @State private var qtd: String = ""
    @State private var subtractFromBudget: Bool = false
    @State private var identifier: String = ""
    @State private var activeField: ActiveField? = nil
    
    
    
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
                
                TextField("Name", text: $identifier)
                    .textFieldStyle(.roundedBorder)
                    .foregroundStyle(Color.backGround)
                
                HStack {
                    CustomTextField(title: "Value", value: $value, activeField: $activeField, field: .value)
                    CustomTextField(title: "Quantity", value: $qtd, activeField: $activeField, field: .qtd)
                }
                .padding()
                
                Toggle("Subtract from Budget?", isOn: $subtractFromBudget)
                
                Spacer()
                
                Button {
                    SwiftData_Manager.shared.addInvestment(.init(identifier: identifier, symbol: Currency.dollar.rawValue, type: selectedType.rawValue, value: Double(value) ?? 0.0, qtd: Double(qtd) ?? 0.0), subtractFromBudget: subtractFromBudget)
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
            .overlay(
                Group {
                    if activeField != nil {
                        VStack {
                            Spacer()
                            CustomNumericKeyboard(input: getActiveBinding(), onDismiss: { activeField = nil })
                                .transition(.move(edge: .bottom))
                                .animation(.spring(), value: activeField)
                        }
                    }
                }
            )
            .foregroundStyle(.white)
            .background(Color.backGround)
        }
    }
    
    private func getActiveBinding() -> Binding<String> {
        switch activeField {
        case .value: return $value
        case .qtd: return $qtd
        case .none: return .constant("")
        }
    }
}

struct CustomTextField: View {
    var title: String
    @Binding var value: String
    @Binding var activeField: ActiveField?
    var field: ActiveField
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.backGround1)
            
            Text(value.isEmpty ? "\(title)" : value)
                .foregroundStyle(value.isEmpty ? .gray : .white)
        }
        .aspectRatio(3.5, contentMode: .fit)
        .onTapGesture {
            activeField = field
        }
    }
}

struct CustomNumericKeyboard: View {
    @Binding var input: String
    var onDismiss: (() -> Void)?
    
    let buttons: [[String]] = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "⌫"]
    ]
    
    var body: some View {
        VStack(spacing: 10) {
           
       
                HStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        Text("Typed: \(input)")
                            .font(.system(size: 16))
                            .padding(.horizontal, 5)
                    }
                    
                    Spacer()
                    
                    Button {
                        onDismiss?()
                    } label: {
                        Text("Done")
                    }
                }
                
//                .scaledToFit()
                .foregroundStyle(.white)
                .padding()
              
            
            
            ForEach(buttons, id: \ .self) { row in
                HStack() {
                    ForEach(row, id: \ .self) { key in
                        Button(action: {
                            handleKeyPress(key)
                        }) {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.backGround2)
                                    .frame(height: 50)
                                    
                                Text(key)
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .scaledToFit()
        .background(Color.backGround)
        .opacity(0.9)
        .cornerRadius(10)
        
    }
    
    
    private func handleKeyPress(_ key: String) {
        if key == "⌫" {
            if !input.isEmpty {
                input.removeLast()
            }
        } else if key == "." {
            if !input.contains(".") {
                input.append(".")
            }
        } else {
            input.append(key)
        }
    }
}

#Preview {
    CustomNumericKeyboard(input: .constant(""), onDismiss: {})
}

#Preview {
    AddInvestment(showModal: .constant(false))
}

