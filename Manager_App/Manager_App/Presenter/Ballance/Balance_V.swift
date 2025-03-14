//
//  Ballance_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct Balance_V: View {
    @State var data: [Investment] = [
        .init(type: "Crypto", value: 10, color: .red),
        .init(type: "CDB", value: 12, color: .green),
        .init(type: "Stocks", value: 50, color: .orange),
        .init(type: "NFT", value: 30, color: .purple),
    ]
    
    @State var data2: [Investment] = [
        .init(type: "Crypto", value: 10, color: .red),
        .init(type: "CDB", value: 12, color: .green),
    ]
    
    @State private var dashItems: [DashboardItem] = [
        .init(id: "chart"),
        .init(id: "chart1"),
    ]
    
    @State var draggedItem: DashboardItem?
    
    var body: some View {
        
        VStack {
            
            dashboardView(for: .init(id: "mainBalance"))
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack() {
                    ForEach(dashItems) { item in
                        dashboardView(for: item)
                            .padding(.horizontal)
                            .onDrag {
                                self.draggedItem = item
                                return NSItemProvider()
                            }
                            .onDrop(of: [.text], delegate: DropViewDelegate(destinationItem: item, itens: $dashItems, draggedItem: $draggedItem))
                    }
                }
            }
        }
        .padding()
        .background(Color.backGround)
    }
    
    @ViewBuilder
    func dashboardView(for item: DashboardItem) -> some View {
        switch item.id {
        case "mainBalance":
            MainBalance_C(data: $data, income: .constant(221.4), outcome: .constant(542.3), currency: .constant(.dollar))
        case "chart":
            CustomChart_C(data: $data)
        default:
            CustomChart_C(data: $data2)
//                        EmptyView()
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
