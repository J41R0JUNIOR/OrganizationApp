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
            
            VStack {
                
                Button {
                    SwiftData_Manager.shared.removeAllInvestments()
                } label: {
                    Image(systemName: "trash.fill")
                    Text("Restore Default")
//                        .font(.largeTitle)
                        .foregroundStyle(.main3)
                }
            }
        }
    }
}

#Preview {
    Settings_V()
}
