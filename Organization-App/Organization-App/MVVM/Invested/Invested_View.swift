//
//  InvestedView.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 19/02/25.
//

import SwiftUI
import SwiftData

struct Invested_View: View {
    @Bindable var vm = Invested_VM()
    
    var body: some View {
        VStack {
            List {
                vm.investmentSection(title: "Stocks", type: .stock, investments: Manager_SwiftData.shared.user?.stock ?? [])
                vm.investmentSection(title: "REITs", type: .reit, investments: Manager_SwiftData.shared.user?.reit ?? [])
                vm.investmentSection(title: "Cryptos", type: .crypto, investments: Manager_SwiftData.shared.user?.crypto ?? [])
            }
            .toolbar { EditButton() }
            
            Spacer()
            
            Text("Total: R$\(vm.total(), specifier: "%.2f")")
            
            HStack {
                Menu("ADD INVESTMENT") {
                    Button("Stock") { vm.addMockInvestment(investment: Investment(type: .stock, identifier: "BBAS3", value: 28.7, appliedValue: 10, qtd: 10)) }
                    Button("Reit") { vm.addMockInvestment(investment: Investment(type: .reit, identifier: "XPML11", value: 109.76, appliedValue: 10)) }
                    Button("Crypto") { vm.addMockInvestment(investment: Investment(type: .crypto, identifier: "BTC", value: 600000, appliedValue: 10, qtd: 1)) }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Remove All") {
                    Task {
                        await vm.removeAll()
                    }
                }
            }
        }
    }
}

#Preview {
    Invested_View()
        .modelContainer(.appContainer)
}
