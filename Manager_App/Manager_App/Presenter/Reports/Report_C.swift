//
//  Report_C.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 13/03/25.
//

import SwiftUI

struct Report_C: View {
    @Binding var report: Report
    var body: some View {
        
            HStack {
                
                Image(systemName: report.value < 0 ? "arrowshape.down.circle" : "arrowshape.up.circle")
                    .foregroundStyle(report.value < 0 ? .red : .green)
            
                VStack(alignment: .leading){
                    Text(report.name ?? "Error report name")
                        .bold()
                    
                    Text("\(report.symbol) \(String(format: "%.2f", report.value))")
                        .font(.caption)
                }
                
                Spacer()
             
                VStack(alignment: .trailing){
                    
                    Text("\(report.wallet) wallet")
                
                    Text(report.date.formatted(.dateTime.day().month(.twoDigits)))
                        .font(.caption)
                }
            }
            .padding(.vertical)
            .foregroundStyle(.white)
            .padding(.horizontal)
            .background(.backGround)
        
            .scaledToFit()
        }
}


#Preview {
    Reports_V()
}

#Preview {
    Report_C(report: .constant(.init(date: .now, value: -12, name: "BBAS3", symbol: .dollar, wallet: "Default")))
}
