//
//  MainDashBoard_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct MainBalance_C: View {
 
    @Binding var income: Double
    @Binding var outcome: Double
//    @Binding var monthReport: MonthReport <- use this instead of income and outcome
    @Binding var currency: Currency
    
    var total: Double {
        SwiftData_Manager.shared.user?.investments.reduce(0) { $0 + $1.value } ?? 0
      }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backGround2)
      
            VStack {
                Text("\(currency.rawValue)\(String(format: "%.2f", total))")
                    .font(.title)
                    .bold()
                
                HStack {
                    HStack {
                        Image(systemName: "arrowshape.up.circle")
                            .foregroundStyle(.green)
                        Text("\(currency.rawValue)\(String(format: "%.2f", income))")
                    }
                    
                    HStack{
                        Image(systemName: "arrowshape.down.circle")
                            .foregroundStyle(.red)
                        Text("\(currency.rawValue)\(String(format: "%.2f", outcome))")
                    }
                }
                .scaledToFit()
                
            }
            .foregroundStyle(.white)
            .scaledToFit()
            .padding(.horizontal)

        }
        .scaledToFit()
    }
    
    func calcTot() -> Double {
        var tot = 0.0
        
        for i in SwiftData_Manager.shared.user?.investments ?? [] {
            tot += Double(i.value)
        }
        return tot
    }
}

//#Preview {
//    MainBalance_C(data: .constant([
//        .init(type: "Crypto", value: 10, color: .red),
//        .init(type: "CDB", value: 12, color: .green),
//        .init(type: "Stocks", value: 50, color: .orange),
//        .init(type: "NFT", value: 30, color: .purple),
//    ]), income: .constant(221.4), outcome: .constant(542.3), currency: .constant(.dollar))
//}

#Preview {
    Balance_V()
}
