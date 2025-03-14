//
//  DataStructures.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 13/03/25.
//

import Foundation
import SwiftUICore


enum Currency: String {
    case dollar = "$"
}

struct Investment: Identifiable {
    var id: UUID = .init()
    var type: String
    var symbol: Currency = .dollar
    var value: Double
    var qtd: Double?
    var color: Color
}

struct MonthReport {
    var month: Date
    var report: [Report]
}

struct Report: Identifiable {
    var id: UUID = .init()
    var date: Date
    var value: Double
    var name: String?
    var symbol: Currency = .dollar
}

struct DashboardItem: Identifiable, Equatable {
    var id: String
}
