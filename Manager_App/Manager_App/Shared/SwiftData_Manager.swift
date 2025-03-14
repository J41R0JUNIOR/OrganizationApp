//
//  SwiftData_Manager.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//

import Foundation
import SwiftData




@Observable
class SwiftData_Manager {
    static var shared = SwiftData_Manager()
    var container: ModelContainer?
    var context: ModelContext?
    var user: User?
   
    
    init() {
        do{
            container = .appContainer
            if let container {
                context = ModelContext(container)
            }
        }
    }
    
    func save(user: User) {
        if let context = context {
            context.insert(user)
            do {
                try context.save()
            } catch {
                print("Error saving data: \(error)")
            }
        }
        fetch()
    }
    
    func addInvestment(investment: Investment) {
        if let user = user {
            user.investments.append(investment)
            save(user: user)
        } 
        fetch()
        
    }
    
    func removeAllInvestments() {
        guard let user = user, let context = context else {
            return
        }

        user.investments = []

        do {
            try context.save()
        } catch {
            print("\(error)")
        }

        fetch()
    }



    func fetch() {
        let descriptor = FetchDescriptor<User>()
        
        if let context = context {
            do {
                let data = try context.fetch(descriptor)
                
                self.user = data.first
                
                if user == nil {
                    save(user: .init(name: "", investments: [], monthReports: []))
                }
                
    
            } catch {
                print(error)
            }
        }
    }

    func delete(user: User) {
        if let context = context {
            context.delete(user)
            do {
                try context.save()
            } catch {
                print("Error saving after delete: \(error)")
            }
        }
    }
    
    func deleteAll() {
        if let context = context {
            let descriptor = FetchDescriptor<User>()
            do {
                let data = try context.fetch(descriptor)
                data.forEach { context.delete($0) }
                
                try context.save()
            } catch {
                print("Error deleting all data: \(error)")
            }
        }
    }
}
