//
//  SwiftData_Manager.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 14/03/25.
//

import Foundation
import SwiftData


class SwiftData_Manager {
    static var shared = SwiftData_Manager()
    var container: ModelContainer?
    var context: ModelContext?
   
    
    init() {
        do {
            container = try ModelContainer(for: User.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func save(user: User) {
        if let context = context {
            context.insert(user)
            do {
                try context.save()
                print("saved")
            } catch {
                print("Error saving data: \(error)")
            }
        }
    }
    
    func addInvestment(investment: Investment) {
        var user: User? = nil
        
        SwiftData_Manager.shared.fetch { result in
            switch result {
            case .success(let users):
                user = users.first
            case .failure(let error):
                print(error)
            }
        }
        
        if let user = user {
            user.investments.append(investment)
            save(user: user)
        }
        
    }

    func fetch(onCompletition: @escaping (Result<[User], Error>) -> Void) {
        let descriptor = FetchDescriptor<User>()
        
        if let context = context {
            do {
                let data = try context.fetch(descriptor)
                onCompletition(.success(data))
            } catch {
                onCompletition(.failure(error))
            }
        } else {
            onCompletition(.failure(NSError(domain: "ContextError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Context is nil"])))
        }
    }

    func delete(login: User) {
        if let context = context {
            context.delete(login)
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
