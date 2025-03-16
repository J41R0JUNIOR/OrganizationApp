//
//  Wallet_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 16/03/25.
//

import SwiftUI

struct Wallet_C: View {
    var wallet: Wallet
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.backGround1)
                .shadow(radius: 5)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("wallet: \(wallet.name)")
                        .font(.title)
                        .bold()
                    Text("\(wallet.currency) \(String(format: "%.2f", wallet.value))")
                    
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .foregroundStyle(.main3)
        }
        .scaledToFit()
    }
}

#Preview {
    Wallet_C(wallet: .init(name: "Default", currency: .dollar, value: 1250.33))
}

#Preview {
    Balance_V()
}
