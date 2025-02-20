//
//  Manager_SwiftData.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 19/02/25.
//

import Foundation
import SwiftData

@MainActor
@Observable
class Manager_SwiftData {
    static var shared: Manager_SwiftData = .init()
    
    var user: User?
    var userInvestments: [Investment] = []
    var container: ModelContainer
    var context: ModelContext?
    
    init() {
        self.container = .appContainer
        self.context = ModelContext(container)
    }
    
    func createUser() async throws {
        if let existingUser = try context?.fetch(FetchDescriptor<User>()).first {
            self.user = existingUser
            return
        }
        
        let newUser = User(name: "Jairo")
        context?.insert(newUser)
        
        await saveData()
        
        self.user = newUser
    }
    
    func fetchUser() async throws {
        self.user = try context?.fetch(FetchDescriptor<User>()).first
        
        if user == nil {
            try await createUser()
        }
    }

    func fetchInvestments() async throws {
        guard let user = user else {
            return
        }
        
        if let investmentsData = user.investments {
            do {
                let returnData: [Investment] = try decode(content: investmentsData)
                self.userInvestments = returnData
            } catch {
                print("Erro ao decodificar investimentos: \(error)")
            }
        }
        
    }
    
    func addInvestment(_ data: Investment) async {
        guard let user = user else {
            return
        }
        
        userInvestments.append(data)
        
        if let encodedData = encode(content: userInvestments) {
            user.investments = encodedData
            
            await saveData()
            
        } else {
            print("Erro ao codificar investimentos.")
        }
    }
    
    func deleteAll() async throws {
        user?.investments = nil
        
        await saveData()
        
    }
    
    func saveData() async {
        do {
            try context?.save()
        } catch {
            print("Erro ao salvar investimento: \(error)")
        }
    }
}
