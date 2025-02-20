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
        VStack{
            Spacer()
            
            List{
                ForEach(Manager_SwiftData.shared.userInvestments, id: \.id){qtd in
                    
                    HStack{
                        Text(qtd.identifier)
                        Text(qtd.value.description)
                    }
                }
            }
            
            Spacer()
            
            Button("mock investment"){
                Task{
                    
                    let investment = InvestmentTypeModel.Stock(identifier: "BBAS3", value: 28.7, quantity: 10)
                    
                    let investment2 = InvestmentTypeModel.Reit(identifier: "XPML11", value: 28.7, quantity: 10)
                    
//                    let investment = Investment(identifier: "BBAS3", value: 28.7)
                    
                    await Manager_SwiftData.shared.addInvestment(investment)
                    await Manager_SwiftData.shared.addInvestment(investment2)
                    
                }
            }.buttonStyle(.borderedProminent)
            
            Button("remove all"){
                Task{
                    try await Manager_SwiftData.shared.deleteAll()
                }
            }
        }.task {
            Task{
                try await Manager_SwiftData.shared.fetchInvestments()
            }
        }
    }
}

#Preview {
    let modelContent: ModelContainer = .appContainer
    InvestedView()
        .modelContainer(modelContent)
}
