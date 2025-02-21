//
//  Invested_ VM.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 21/02/25.
//

import Foundation
import SwiftUI

@MainActor
@Observable
class Invested_VM {
    var m = Invested_M()
    internal func deleteInvestment(type:TypeInvestment, at offsets: IndexSet) {
        Task {
            await Manager_SwiftData.shared.deleteInvestment(type: type, offsets)
        }
    }
    
    func getInvestments(for type: TypeInvestment) -> Binding<[Investment]?>? {
        switch type {
        case .stock:
            return Binding(get: { Manager_SwiftData.shared.user?.stock }, set: { Manager_SwiftData.shared.user?.stock = $0 })
        case .crypto:
            return Binding(get: { Manager_SwiftData.shared.user?.crypto }, set: { Manager_SwiftData.shared.user?.crypto = $0 })
        case .reit:
            return Binding(get: { Manager_SwiftData.shared.user?.reit }, set: { Manager_SwiftData.shared.user?.reit = $0 })
        }
    }

    internal func moveInvestment(type: TypeInvestment, from source: IndexSet, to destination: Int) {
        if var investments = getInvestments(for: type)?.wrappedValue {
            investments.move(fromOffsets: source, toOffset: destination)
            getInvestments(for: type)?.wrappedValue = investments
        }
    }

    internal func addMockInvestment(investment: Investment) {
        if var investments = getInvestments(for: investment.type)?.wrappedValue {
            investments.append(investment)
            getInvestments(for: investment.type)?.wrappedValue = investments
        }
    }
    
    internal func removeAll() async {
        await Manager_SwiftData.shared.deleteAll()
    }
    
    internal func investmentRow(_ investment: Investment) -> some View {
        HStack {
            Text(investment.identifier)
            Spacer()
            Text("R$\(investment.value, specifier: "%.2f")")
        }
    }
    
    internal func investmentSection(title: String, type: TypeInvestment, investments: [Investment]) -> some View {
        Section(header: Text(title)) {
            ForEach(investments, id: \.id) { investment in
                self.investmentRow(investment)
            }
            .onDelete { indexSet in
                self.deleteInvestment(type: type, at: indexSet)
            }
            .onMove { indexSet, destination in
                self.moveInvestment(type: type, from: indexSet, to: destination)
            }
        }
    }
}
