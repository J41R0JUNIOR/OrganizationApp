//
//  GeneralStructuresEnum.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 18/03/25.
//

import Foundation
import SwiftUI


struct DashboardItem: Identifiable, Equatable {
    var id: String
}

enum TypesInvesment: String, CaseIterable {
    
    case stocks
    case cryptos
    case reits
    case other
}

extension TypesInvesment: Identifiable {
    var id: UUID {
        .init()
    }
    
    
}
