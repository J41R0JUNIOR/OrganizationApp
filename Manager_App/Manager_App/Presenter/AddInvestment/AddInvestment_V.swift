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

struct AddInvestment_V: View {
    @Binding var showModal: Bool
    
    @State private var selectedType: TypesInvesment = .stocks
    @State private var value: Double = 0
    @State private var qtd: Double = 0
    @State private var subtractFromWallet: Bool = false
//    @State private var walletChosed: Wallet = .init(name: "", currency: .dollar, value: 0)
    @State private var walletChosed: Wallet?

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
                
                Toggle("Subtract from Wallet?", isOn: $subtractFromWallet)
                
                if subtractFromWallet {
                    HStack{
                        Text("Select the wallet")
                        
                        Picker("Wallet", selection: $walletChosed) {
                            ForEach(SwiftData_Manager.shared.user?.wallets ?? [], id: \.id) { wallet in
                                Text(wallet.name)
                                    .tag(wallet as Wallet?)
                            }
                        }
                        .pickerStyle(.menu)

                        Spacer()
                    }
                }
                
                Spacer()
                
                Button {
                    if(walletChosed != nil){
                        SwiftData_Manager.shared.addInvestment(Investment(identifier: identifier, symbol: .dollar, type: selectedType, value: value, qtd: qtd), wallet: subtractFromWallet ? walletChosed : nil)
                        showModal.toggle()
                    }
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
    AddInvestment_V(showModal: .constant(false))
}
