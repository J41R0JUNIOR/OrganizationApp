//
//  Investment_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 19/03/25.
//

import SwiftUI

struct Investment_V: View {
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            
            

                List(TypesInvesment.allCases){ type in
                    Section(header: Text(type.rawValue)) {

                        ForEach(SwiftData_Manager.shared.user?.investments.filter({ $0.type == type.rawValue }) ?? []) { item in

                            HStack {
                                Text(item.identifier)
                                
                                Spacer()
//                                
                                Text("$\(item.value, specifier: "%.2f")")
                            }
                            .foregroundStyle(.main3)
                        }
                    }
                    .listRowBackground(Color.backGround1)
                    .foregroundStyle(Color.main3)
                }
                .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    Investment_V()
}
