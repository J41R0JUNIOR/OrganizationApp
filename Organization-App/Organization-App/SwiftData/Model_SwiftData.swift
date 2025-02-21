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
    @Relationship(deleteRule: .cascade) var investment: [Investment]?
    var name: String

    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

@Model
class Investment {
    var type: String
    var identifier: String
    var value: Double
    var qtd: Int?

    init(type: String, identifier: String, value: Double, qtd: Int? = 1) {
        self.identifier = identifier
        self.type = type
        self.value = value
    }
}
