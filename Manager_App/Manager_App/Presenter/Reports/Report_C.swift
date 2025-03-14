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
            
                
                VStack{
                    Text(report.name ?? "Average")
                        .bold()
                    
                    Text("\(report.symbol.rawValue) \(String(format: "%.2f", report.value))")
                        .font(.caption)

                }
                
                Spacer()
             

                    Text(report.date.formatted(.dateTime.day().month(.twoDigits)))
                        .font(.caption)
                 
            }
            .padding(.vertical)
            .foregroundStyle(.white)
            .padding(.horizontal)
            .background(.backGround)
        
            .scaledToFit()
        }
       
    
}

#Preview {
    Report_C(report: .constant(.init(date: .now, value: 32.55, name: "BTC")))
}

#Preview {
    Reports_V()
}
