//
//  Models.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 19/02/25.
//

import Foundation
import SwiftData

@Model
class User {
    @Attribute(.unique) var id: UUID
    @Relationship(deleteRule: .cascade) var crypto: [Investment]?
    @Relationship(deleteRule: .cascade) var stock: [Investment]?
    @Relationship(deleteRule: .cascade) var reit: [Investment]?
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

@Model
class Investment {
    var type: TypeInvestment
    var identifier: String
    var value: Double
    var appliedValue: Double
    var qtd: Int?

    init(type: TypeInvestment, identifier: String, value: Double, appliedValue: Double, qtd: Int? = 1) {
        self.identifier = identifier
        self.type = type
        self.value = value
        self.appliedValue = appliedValue
    }
}

enum TypeInvestment: Codable, CaseIterable {
    case crypto
    case stock
    case reit
}
