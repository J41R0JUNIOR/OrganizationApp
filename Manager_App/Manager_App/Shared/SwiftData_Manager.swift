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
        
        fetch()
    }

    func saveUser(_ user: User) {
        context.insert(user)
        save()
    }
    
    func toggleInvestment(){
        guard let user else { return }
        
        user.optionInvestment.toggle()
        save()
    }

    
    func addInvestment(_ investment: Investment, wallet: Wallet? = nil) {
        guard let user else { return }
        
        let newInvestment = investment
        newInvestment.identifier = newInvestment.identifier.uppercased()
        
        if let index = user.investments.firstIndex(where: { $0.identifier == newInvestment.identifier }) {
            user.investments[index].value += newInvestment.value
            user.investments[index].qtd? += newInvestment.qtd ?? 0
        } else {
            print(newInvestment.identifier)
            user.investments.append(newInvestment)
        }
        
        if let wallet {
            guard wallet.value >= newInvestment.value else {
                print(wallet.value, newInvestment.value)
                return
            }
            
            wallet.value -= newInvestment.value
            addReport(Report(date: .now, value: -newInvestment.value, wallet: wallet.name))
        }

        save()
    }

    
    func addWallet(_ wallet: Wallet) {
        guard let user else { return }
        
        user.wallets.append(wallet)
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
                let newUser = User(name: "", investments: [], monthReports: [], wallets: [Wallet(name: "Default", value: 0)])
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
