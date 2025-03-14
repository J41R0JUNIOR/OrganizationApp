//
//  ModelContainer_Ext.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//


import Foundation
import SwiftData

extension ModelContainer {
    
    static let appContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for: User.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
            return container
        } catch {
            fatalError("Failed to create appContainer")
        }
    }()
}
