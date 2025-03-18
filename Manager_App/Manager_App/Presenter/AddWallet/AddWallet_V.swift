//
//  AddWallet_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 18/03/25.
//

import SwiftUI

import SwiftUI
import Foundation

struct AddWallet_V: View {
    @Binding var isPresented: Bool
    
    @State private var name: String = ""
    @State private var selectedCurrency: Currency = .dollar
    @State private var value: Double = 0

    var body: some View {
        VStack {
            Text("Add Wallet")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(.white)

            Spacer()

            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading) {
                    Text("Wallet Name").foregroundStyle(.white)
                    TextField("Enter name", text: $name)
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(8)
                }

                VStack(alignment: .leading) {
                    Text("Initial Value").foregroundStyle(.white)
                    TextField("00.00", text: $value.formattedNumber())
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(8)
                        .keyboardType(.decimalPad)
                }

                VStack(alignment: .leading) {
                    Text("Currency").foregroundStyle(.white)
                    Picker("Currency", selection: $selectedCurrency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.rawValue)
                                .tag(currency)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .padding()
            .foregroundStyle(.black)

            Spacer()

            Button {
                let newWallet = Wallet(name: name, currency: selectedCurrency, value: value)
                SwiftData_Manager.shared.addWallet(newWallet)
                isPresented.toggle()
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
                isPresented.toggle()
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
        .foregroundStyle(.white)
        .background(Color.backGround)
    }
}

#Preview {
    AddWallet_V(isPresented: .constant(false))
}
