//
//  Ballance_V.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 12/03/25.
//

import SwiftUI

struct Balance_V: View {

    var body: some View {
        ZStack {
            Color.backGround
                .ignoresSafeArea()
            
            VStack {
                MainBalance_C()
                
                ScrollView(.vertical, showsIndicators: false) {

                    CustomChart_C(data: .init(get: { SwiftData_Manager.shared.user?.investments ?? [] }, set: { _ in }))
                    
                    Wallets_C()
                }
            }
            
            .padding()
            
            .overlay(content: {
                VStack {
                    Spacer()
                    AddButton_C()
                }.padding()
            })
          
        }
    }
}


#Preview {
    Balance_V()
}

