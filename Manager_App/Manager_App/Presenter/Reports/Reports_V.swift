//
//  Reports_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 13/03/25.
//

import SwiftUI

struct Reports_V: View {
    @State var reports: [MonthReport] = [
        .init(month: .now, report: [
            .init(date: Date(), value: 32, name: "BTC"),
            .init(date: Date(), value: -234),
            .init(date: Date(), value: 22.5, name: "BBAS3"),
            .init(date: Date(), value: -33),
            .init(date: Date(), value: -244.65, name: "BBAS3"),
        ]),
        .init(month: Calendar.current.date(byAdding: .month, value: -1, to: .now)!, report: [
            .init(date: Calendar.current.date(byAdding: .month, value: -1, to: .now)!, value: 150, name: "AAPL"),
            .init(date: Calendar.current.date(byAdding: .month, value: -1, to: .now)!, value: -50),
        ]),
        .init(month: Calendar.current.date(byAdding: .month, value: -2, to: .now)!, report: [
            .init(date: Calendar.current.date(byAdding: .month, value: -2, to: .now)!, value: 300, name: "TSLA"),
            .init(date: Calendar.current.date(byAdding: .month, value: -2, to: .now)!, value: -75),
        ]),
    ]
    
    @State private var selectedMonth: Date = .now
    
    var selectedReport: MonthReport? {
        reports.first { Calendar.current.isDate($0.month, equalTo: selectedMonth, toGranularity: .month) }
    }
    
    var body: some View {
        VStack {
       
            Picker("Mês", selection: $selectedMonth) {
                ForEach(reports.map(\.month), id: \.self) { month in
                    Text(month.formatted(.dateTime.year().month(.twoDigits)))
                        .tag(month)
                }
            }
            .pickerStyle(.menu)
            .foregroundStyle(.white)
            .tint(.white)
            
      
            if let report = selectedReport {
                ScrollView {
                    ForEach(report.report) { report in
                        Report_C(report: .constant(report))
                    }
                }
            } else {
                Text("Nenhum relatório disponível para este mês.")
                    .foregroundStyle(.white)
            }
        }
        .padding()
        .background(.backGround)
    }
}

#Preview {
    Reports_V()
}

