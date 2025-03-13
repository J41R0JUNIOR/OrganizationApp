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
    var month: String
    var report: [String: Double]
}

struct DashboardItem: Identifiable, Equatable {
    var id: String
}
