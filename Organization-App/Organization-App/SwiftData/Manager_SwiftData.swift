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
    
    func addInvestment(_ investment: Investment) async throws {
        guard let user = user else {
            print("Usuário não encontrado.")
            return
        }
        
        switch investment.type {
        case .crypto:
            user.crypto?.append(investment)
        case .stock:
            user.stock?.append(investment)
        case .reit:
            user.reit?.append(investment)
        }
        
        await saveData()
  
    }
    
    func deleteAll() async{
        user?.stock?.removeAll()
        user?.crypto?.removeAll()
        user?.reit?.removeAll()
        await saveData()
    }
    
    func saveData() async {
            do {
                try context?.save()
            } catch {
                print("Erro ao salvar investimento: \(error)")
            }
        }
    
    func deleteInvestment(type: TypeInvestment, _ index: IndexSet) async{
        switch type {
                
        case .crypto:
            user?.crypto?.remove(atOffsets: index)
        case .stock:
            user?.stock?.remove(atOffsets: index)
        case .reit:
            user?.reit?.remove(atOffsets: index)
        }
        
    }
}
