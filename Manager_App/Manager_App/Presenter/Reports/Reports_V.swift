//
//  Reports_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 13/03/25.
//

import SwiftUI

struct Reports_V: View {
   
    @State private var selectedMonth: Date = .now
    
    var selectedReport: MonthReport? {
        SwiftData_Manager.shared.user?.monthReports.first { Calendar.current.isDate($0.month, equalTo: selectedMonth, toGranularity: .month) }
    }
    
    var body: some View {
        ZStack {
            Color.backGround
            VStack {
                Picker("Mês", selection: $selectedMonth) {
                    ForEach(SwiftData_Manager.shared.user?.monthReports.map(\.month) ?? [], id: \.self) { month in
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
                    Text("No report available this month")
                        .foregroundStyle(.white)
                }
            }
            .padding()
        }
//        .ignoresSafeArea()
    }
}

#Preview {
    Reports_V()
}

