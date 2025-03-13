//
//  Ballance_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct Balance_V: View {
    
    var body: some View {
        
        VStack{
            
            MainBalance_C(total: .constant(123.2), income: .constant(221.4), outcome: .constant(542.3), currency: .constant(.dollar))
            
            ScrollView(.vertical) {
                
                CustomChart_C(data: .constant([
                    .init(type: "Bitcoin", quantity: 10, color: .red),
                    .init(type: "Ethereum", quantity: 40, color: .blue),
                    .init(type: "CDB", quantity: 12, color: .green),
                    .init(type: "Stocks", quantity: 50, color: .orange),
                    .init(type: "NFT", quantity: 30, color: .purple),
                    
                ]))
            }
        }
        .padding(.horizontal)
        .background(Color.backGroundPurple)
    }
}

#Preview {
    Balance_V()
}
