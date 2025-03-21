//
//  DataStructures.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 13/03/25.
//

import Foundation
import SwiftUICore
import SwiftData

enum Currency: String, CaseIterable {
    case dollar = "$"
}

@Model
class User {
    var name: String
    var investments: [Investment]
    var monthReports: [MonthReport]
    var wallets: [Wallet]
    
    var optionInvestment: Bool
    
    init(name: String, investments: [Investment], monthReports: [MonthReport], wallets: [Wallet]) {
        self.name = name
        self.investments = investments
        self.monthReports = monthReports
        self.wallets = wallets
        self.optionInvestment = false
    }
}

@Model
class Wallet: Identifiable, Hashable {
    var id: UUID
    var name: String
//    var currency: String
    var value: Double
    
    init(name: String/*, currency: Currency*/, value: Double) {
        self.id = UUID()
        self.name = name
//        self.currency = currency.rawValue
        self.value = value
    }
    
    static func == (lhs: Wallet, rhs: Wallet) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

@Model
class Investment: Identifiable {
    var id: UUID
    var identifier: String
    var type: String
//    var symbol: String
    var value: Double
    var qtd: Double?
    
    init(identifier: String/*, symbol: Currency*/, type: TypesInvesment, value: Double, qtd: Double? = nil) {
        self.id = UUID()
        self.identifier = identifier
        self.type = type.rawValue
//        self.symbol = symbol.rawValue
        self.value = value
        self.qtd = qtd
    }
}

@Model
class MonthReport {
    var month: Date
    var report: [Report]
    
    init(month: Date, report: [Report]) {
        self.month = month
        self.report = report
    }
}

@Model
class Report: Identifiable {
    var id: UUID
    var date: Date
    var value: Double
    var wallet: String
    var name: String?
//    var symbol: String
    
    init(date: Date, value: Double, name: String? = nil/*, symbol: Currency*/, wallet: String) {
        self.id = UUID()
        self.date = date
        self.value = value
        self.name = name
//        self.symbol = symbol.rawValue
        self.wallet = wallet
    }
}

