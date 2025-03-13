//
//  MainDashBoard_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct MainBalance_C: View {
    
    @Binding var total: Double
    @Binding var income: Double
    @Binding var outcome: Double
    @Binding var currency: Currency
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.main)
//                .stroke(Color.white, lineWidth: 2)
                .shadow(radius: 10)

   
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
}



#Preview {
    MainBalance_C(total: .constant(123.2), income: .constant(221.4), outcome: .constant(542.3), currency: .constant(.dollar))
}

#Preview {
    Balance_V()
}

enum Currency: String {
    case dollar = "$"
}
