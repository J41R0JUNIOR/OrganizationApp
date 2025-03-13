//
//  Content_View.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 06/03/25.
//

import SwiftUI

struct Content_V: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.backGround2
    }
    
    var body: some View {
        TabView {
            Balance_V()
                .tabItem {
                    Image(systemName: "house")
                    Text("Balance")
                }
            
            Settings_V()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .foregroundStyle(.main3)
        .tint(Color.main3)
    }
}

#Preview {
    Content_V()
}
