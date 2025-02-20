//
//  Investments.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 19/02/25.
//

import SwiftData
import Foundation


enum InvestmentTypeModel {
    final class Stock: Investment {
        var quantity: Int
        
        init(identifier: String, value: Double, quantity: Int) {
            self.quantity = quantity
            super.init(identifier: identifier, type: "STOCK", value: value)
        }
        
        required init(backingData: any SwiftData.BackingData<Investment>) {
            fatalError("init(backingData:) has not been implemented")
        }
        
        required init(from decoder: any Decoder) throws {
            fatalError("init(from:) has not been implemented")
        }
    }

    final class Reit: Investment {
        var quantity: Int
        
        init(identifier: String, value: Double, quantity: Int) {
            self.quantity = quantity
            super.init(identifier: identifier, type: "REIT", value: value)
        }
        
        required init(backingData: any SwiftData.BackingData<Investment>) {
            fatalError("init(backingData:) has not been implemented")
        }
        
        required init(from decoder: any Decoder) throws {
            fatalError("init(from:) has not been implemented")
        }
    }
    
    final class Crypto: Investment {
        var quantity: Double
        var a: Int
        
        init(identifier: String, value: Double, quantity: Double, a: Int) {
            self.quantity = quantity
            self.a = a
            super.init(identifier: identifier, type: "CRYPTO", value: value)
        }
        
        required init(backingData: any SwiftData.BackingData<Investment>) {
            fatalError("init(backingData:) has not been implemented")
        }
        
        required init(from decoder: any Decoder) throws {
            fatalError("init(from:) has not been implemented")
        }
    }
}


class Investment: Codable, Identifiable {
    var id : UUID = UUID()
    var identifier: String
    var type: String
    var value: Double

    init(identifier: String = "", type: String = "", value: Double = 0) {
        self.identifier = identifier
        self.type = type
        self.value = value
    }
}
