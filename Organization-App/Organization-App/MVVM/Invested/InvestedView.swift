//
//  InvestedView.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 19/02/25.
//

import SwiftUI
import SwiftData

struct InvestedView: View {
    
    var body: some View {
        VStack {
            List {
                ForEach(Manager_SwiftData.shared.user?.investment ?? [], id: \.id) { investment in
                    HStack {
                        Text(investment.identifier)
                        Spacer()
                        Text("R$\(investment.value, specifier: "%.2f")")
                    }
                }
                .onDelete(perform: deleteInvestment)
                .onMove(perform: moveInvestment)
            }
            .toolbar { EditButton() }
            
            Spacer()
            
            HStack {
                Menu("MOCK INVESTMENT") {
                    Button("Stock") { addMockInvestment(investment: Investment(type: "STOCK", identifier: "BBAS3", value: 28.7, qtd: 10)) }
                    Button("Reit") { addMockInvestment(investment: Investment(type: "REIT", identifier: "XPML11", value: 28.7)) }
                    Button("Crypto") { addMockInvestment(investment: Investment(type: "CRYPTO", identifier: "BTC", value: 28.7, qtd: 1)) }
                }
                .buttonStyle(.borderedProminent)
                
                Button("Remove All") {
                    Task {
                        await Manager_SwiftData.shared.deleteAll()
                        Manager_SwiftData.shared.user?.investment?.removeAll()
                    }
                }
            }
        }
    }
    
    private func deleteInvestment(at offsets: IndexSet) {
        Task {
            
            await Manager_SwiftData.shared.deleteInvestment(offsets)
            
            Manager_SwiftData.shared.user?.investment?.remove(atOffsets: offsets)
        }
    }
    
    private func moveInvestment(from source: IndexSet, to destination: Int) {
        Manager_SwiftData.shared.user?.investment?.move(fromOffsets: source, toOffset: destination)
    }
    
    private func addMockInvestment(investment: Investment) {
        Task {
            
            try await Manager_SwiftData.shared.addInvestment(investment)
            Manager_SwiftData.shared.user?.investment?.append(investment)
        }
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    InvestedView()
        .modelContainer(modelContent)
}
