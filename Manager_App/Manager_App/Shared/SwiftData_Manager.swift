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
    static let shared = SwiftData_Manager()
    
    private var container: ModelContainer
    private var context: ModelContext
    var user: User?
    
    init() {
         do {
             #warning("Não esquecer trocar pro appContainer")
             
             let testContainer = ModelContainer.appContainer
             self.container = testContainer
             self.context = ModelContext(testContainer)
             
             fetch()
         }
     }
    
    func save() {
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }

    func saveUser(_ user: User) {
        context.insert(user)
        save()
    }

    
    func addInvestment(_ investment: Investment, subtractFromBudget: Bool = false) {
        guard let user else { return }
     
//        if subtractFromBudget && investment.value < user.budget{
//            user.budget -= investment.value
//            addReport(.init(date: .now, value: -investment.value, symbol: Currency.dollar.rawValue))
//        } else if subtractFromBudget && investment.value > user.budget {
//            return
//        }
        
        user.investments.append(investment)
        save()
    }
    
    func addMonthReport(for month: Date = .now) {
        guard let user else { return }
        
        if !user.monthReports.contains(where: { Calendar.current.isDate($0.month, inSameDayAs: month) }) {
            user.monthReports.append(MonthReport(month: month, report: []))
            save()
        }
    }
    
    func addReport(_ report: Report) {
        guard let user else { return }
        
        if let monthReport = user.monthReports.first(where: { Calendar.current.isDate($0.month, inSameDayAs: .now) }) {
            monthReport.report.append(report)
        } else {
            addMonthReport()
            user.monthReports.last?.report.append(report)
        }
        
        save()
    }
    
    func removeAllInvestments() {
        guard let user else { return }
        
        user.investments.removeAll()
        save()
    }
    
    func fetch() {
        let descriptor = FetchDescriptor<User>()
        
        do {
            let data = try context.fetch(descriptor)
            self.user = data.first
            
            if user == nil {
                let newUser = User(name: "", investments: [], monthReports: [], wallets: [Wallet(name: "Default", currency: .dollar, value: 0)])
                saveUser(newUser)
                self.user = newUser
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
    
    func delete(_ user: User) {
        context.delete(user)
        save()
    }
    
    func deleteAll() {
        let descriptor = FetchDescriptor<User>()
        
        do {
            let data = try context.fetch(descriptor)
            data.forEach { context.delete($0) }
            save()
        } catch {
            print("Error deleting all data: \(error)")
        }
    }
}
