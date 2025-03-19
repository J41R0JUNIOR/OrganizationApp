//
//  Ballance_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI
import Charts

struct Balance_V: View {
    
    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            
            VStack {
                MainBalance_C().padding()
                
                List{
                    
                    CustomChart_C(data: .init(get: { SwiftData_Manager.shared.user?.investments ?? [] }, set: { _ in }))
                    
                    Wallets_C()
                }
                .scrollContentBackground(.hidden)
                
            }
            .overlay(content: {
  
                
                    AddButton_C()
                
      
            })
        }
    }
}


#Preview {
    Balance_V()
}

