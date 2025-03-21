//
//  SwiftUIView.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 13/03/25.
//

import SwiftUI

struct Settings_V: View {
    var body: some View {
        //        VStack {
        //
        //        }.background(Color.backGroundPurple)
        ZStack{
            Color.backGround
                .ignoresSafeArea()
            
            List {
                
                Button {
                    SwiftData_Manager.shared.removeAllInvestments()
                } label: {
                    HStack {
                        Image(systemName: "trash.fill")
                        Text("Restore Default")
                        //                        .font(.largeTitle)
                            .foregroundStyle(.main3)
                    }
                }
                
                Button {
                    SwiftData_Manager.shared.toggleInvestment()
                } label: {
                    HStack {
                        Image(systemName: SwiftData_Manager.shared.user?.optionInvestment ?? false ? "checkmark.circle.fill" : "circle")
                        Text("Show Investments")
                    }
                }
            }
        }
    }
}

#Preview {
    Settings_V()
}
