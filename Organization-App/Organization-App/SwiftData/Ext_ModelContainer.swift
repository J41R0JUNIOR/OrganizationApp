//
//  AppContainer.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 19/02/25.
//

import Foundation
import SwiftData

extension ModelContainer{
    static let appContainer: ModelContainer = {
        do{
            let container = try ModelContainer(for: User.self, configurations: ModelConfiguration(isStoredInMemoryOnly: false))
            return container
        }catch{
            fatalError("Failed to create appcontainer")
        }
    }()
}
