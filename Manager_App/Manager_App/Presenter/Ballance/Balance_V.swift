//
//  Ballance_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct Balance_V: View {
    
    @State private var dashItems: [DashboardItemType] = [
        .chart,

    ]
    
    @State var draggedItem: DashboardItemType?
    @State var showAddInvestment: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                dashboardView(for: .mainBalance)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(dashItems, id: \.id) { item in
                            dashboardView(for: item)
                                .onDrag {
                                    self.draggedItem = item
                                    return NSItemProvider()
                                }
                                .onDrop(of: [.text], delegate: DropViewDelegate(destinationItem: item, itens: $dashItems, draggedItem: $draggedItem))
                        }
                    }
                }
                
                HStack {
                    Button {
                        showAddInvestment.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.main3)
                    }
                }
            }
        }
        .padding()
        .background(Color.backGround)
        .sheet(isPresented: $showAddInvestment) {
            AddInvestment_V(showModal: $showAddInvestment)
        }
        .task {
            SwiftData_Manager.shared.fetch()
            
            for n in SwiftData_Manager.shared.user?.wallets ?? [] {
                self.dashItems.append(.wallet(id: n.id, n))
            }
        }
    }
    
    @ViewBuilder
    func dashboardView(for item: DashboardItemType) -> some View {
        switch item {
        case .mainBalance:
            MainBalance_C(income: .constant(221.4), outcome: .constant(542.3), currency: .constant(.dollar))
            
        case .chart:
            CustomChart_C(data: Binding(
                get: { SwiftData_Manager.shared.user?.investments ?? [] },
                set: { SwiftData_Manager.shared.user?.investments = $0 }
            ))
            
        case .wallet(let id, let wallet):
            Wallet_C(wallet: wallet)
        }
    }
}

enum DashboardItemType: Identifiable, Equatable {
    case mainBalance
    case chart
    case wallet(id: UUID, Wallet)
    
    var id: String {
        switch self {
        case .mainBalance: return "mainBalance"
        case .chart: return "chart"
        case .wallet(let id, let wallet): return "wallet-\(id)"
        }
    }
}

struct DropViewDelegate: DropDelegate {
    let destinationItem: DashboardItemType
    @Binding var itens: [DashboardItemType]
    @Binding var draggedItem: DashboardItemType?
    
    func dropUpdated(info: DropInfo) -> DropProposal {
        return DropProposal(operation: .move)
    }
    
    func performDrop(info: DropInfo) -> Bool {
        draggedItem = nil
        return true
    }
    
    func dropExited(info: DropInfo) {
        if let draggedItem {
            let fromIndex = itens.firstIndex(of: draggedItem)
            if let fromIndex {
                let toIndex = itens.firstIndex(of: destinationItem)
                if let toIndex, fromIndex != toIndex {
                    withAnimation {
                        self.itens.move(fromOffsets: IndexSet(integer: fromIndex), toOffset: (toIndex > fromIndex ? (toIndex + 1) : toIndex))
                    }
                }
            }
        }
    }
}

#Preview {
    Balance_V()
}

