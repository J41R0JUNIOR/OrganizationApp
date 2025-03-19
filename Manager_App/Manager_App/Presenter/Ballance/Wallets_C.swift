//
//  Wallets_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 19/03/25.
//

import SwiftUI

struct Wallets_C: View {
    var body: some View {
        VStack {
            ForEach(SwiftData_Manager.shared.user?.wallets ?? []){ wallet in
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.backGround1)
                    
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(wallet.name)")
                                .font(.title)
                                .bold()
                            Text("$\(String(format: "%.2f", wallet.value))")
                            
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .foregroundStyle(.main3)
                }
                .scaledToFit()
            }
        }
    }
}

#Preview {
    Wallets_C()
}
