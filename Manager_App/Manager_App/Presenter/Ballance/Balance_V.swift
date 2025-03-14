//
//  Ballance_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct Balance_V: View {
    @State var data: [Investment] = []

    @State private var dashItems: [DashboardItem] = [
        .init(id: "chart"),
    ]
    
    @State var draggedItem: DashboardItem?
    
    var body: some View {
        
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
            
            Button {
                SwiftData_Manager.shared.addInvestment(investment: .init(type: "Crypto", symbol: Currency.dollar.rawValue, value: 10, color: Color.green.toHex()))
                
                SwiftData_Manager.shared.fetch(onCompletition: { result in
                    switch result {
                    case .success(let investments):
                        self.data = investments.first?.investments ?? []
                    case .failure(let error):
                        print(error)
                    }
                })
            } label: {
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
            }

        }
        .padding()
        .background(Color.backGround)

        .task {
            SwiftData_Manager.shared.fetch(onCompletition: { result in
                switch result {
                case .success(let investments):
                    self.data = investments.first?.investments ?? []
                case .failure(let error):
                    print(error)
                }
            })
        }
    }
    
    @ViewBuilder
    func dashboardView(for item: DashboardItem) -> some View {
        switch item.id {
        case "mainBalance":
            MainBalance_C(data: $data, income: .constant(221.4), outcome: .constant(542.3), currency: .constant(.dollar))
        case "chart":
            CustomChart_C(data: $data)
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
    Content_V()
}
