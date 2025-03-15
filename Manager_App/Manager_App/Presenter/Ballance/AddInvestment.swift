//
//  AddInvestment.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//

import SwiftUI
import Foundation

struct AddInvestment: View {
    
    @Binding var showModal: Bool
    
    @State private var selectedType: TypesInvesment = .stocks

    @State private var value: Double = 0
    @State private var qtd: Double = 0
    
    @State private var subtractFromBudget: Bool = false

    @State private var identifier: String = ""
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
                            ZStack{
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
                        TextField("Value", value: $value, formatter: NumberFormatter())
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(8)
                            .keyboardType(.numberPad)
                    }
                    
                    VStack {
                        Text("Qtd").foregroundStyle(.white)
                        TextField("Qtd", value: $qtd, formatter: NumberFormatter())
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(8)
                            .keyboardType(.numberPad)
                    }
                    
                    
                }.padding()
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

#Preview {
    AddInvestment(showModal: .constant(false))
}

