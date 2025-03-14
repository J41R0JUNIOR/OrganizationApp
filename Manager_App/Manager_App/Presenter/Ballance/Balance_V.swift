//
//  Ballance_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct Balance_V: View {

    @State private var dashItems: [DashboardItem] = [
        .init(id: "chart"),
    ]
    
    @State var draggedItem: DashboardItem?
    
    @State var showAddInvestment: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            

        VStack {
            
            dashboardView(for: .init(id: "mainBalance"))
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack() {
                    ForEach(dashItems) { item in
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
                
//                Button {
//                    SwiftData_Manager.shared.addInvestment(investment: .init(identifier: "NoName", symbol: Currency.dollar.rawValue, type: TypesInvesment.reits.rawValue, value: 10))
//                    
//                } label: {
//                    Image(systemName: "plus.circle.fill")
//                        .font(.largeTitle)
//                        .foregroundStyle(.main3)
//                }
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
        .background(.backGround)
        .sheet(isPresented: $showAddInvestment, content: {AddInvestment()})

        .task {
            SwiftData_Manager.shared.fetch()
        }
    }
    
    @ViewBuilder
    func dashboardView(for item: DashboardItem) -> some View {
        switch item.id {
        case "mainBalance":
            MainBalance_C(income: .constant(221.4), outcome: .constant(542.3), currency: .constant(.dollar))
        case "chart":
            CustomChart_C(data: Binding(
                get: { SwiftData_Manager.shared.user?.investments ?? [] },
                set: { SwiftData_Manager.shared.user?.investments = $0 }
            ))
        default:
            EmptyView()
        }
    }
}

struct DropViewDelegate: DropDelegate {
    let destinationItem: DashboardItem
    @Binding var itens: [DashboardItem]
    
    @Binding var draggedItem: DashboardItem?
    
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
