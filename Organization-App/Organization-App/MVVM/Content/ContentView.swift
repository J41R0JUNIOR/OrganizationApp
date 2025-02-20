//
//  ContentView.swift
//  Organization-App
//
//  Created by The Godfather Júnior on 19/02/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            CapitalView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            InvestedView()
                .tabItem {
                    Image(systemName: "person.circle")
                }
        }.onAppear {
            Task{
                try await Manager_SwiftData.shared.fetchUser()

            }
        }
    }
}

#Preview {
    ContentView()
}
