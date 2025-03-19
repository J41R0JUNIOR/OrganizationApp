//
//  Wallets_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 19/03/25.
//

import SwiftUI

struct Wallets_C: View {
    var body: some View {
       
            Section(header: Text("Wallets")) {
                ForEach(SwiftData_Manager.shared.user?.wallets ?? []){ wallet in
                    HStack {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("\(wallet.name)")
                                .font(.title)
                                .bold()
                            Text("$\(String(format: "%.2f", wallet.value))")
                        }
                        .padding(.horizontal)
                    }
                    .foregroundStyle(.main3)
                }
            }
            .listRowBackground(Color.backGround1)
            .foregroundStyle(Color.main3)

        
    }
}

#Preview {
    Wallets_C()
}


#Preview {
    Balance_V()
}
