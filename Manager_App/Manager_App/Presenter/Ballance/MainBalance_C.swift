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
    
    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    var total: Double {
        let user = SwiftData_Manager.shared.user
        return (user?.investments.reduce(0) { $0 + $1.value } ?? 0) 
      }
    
    @State var balance: Double = 0.0
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.backGround2)
      
            VStack {
//                TextField("Qtd", text: Binding(
//                    get: {
//                        numberFormatter.string(from: NSNumber(value: balance)) ?? ""
//                    },
//                    set: { newValue in
//                        let cleanValue = newValue.replacingOccurrences(of: ",", with: ".")
//                        if let parsedValue = numberFormatter.number(from: cleanValue) {
//                            balance = parsedValue.doubleValue
//                        }
//                    }
//                ))
//                .padding(5)
//                .background(Color.white)
//                .cornerRadius(8)
//                .keyboardType(.decimalPad)
                
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

#Preview {
    Balance_V()
}
