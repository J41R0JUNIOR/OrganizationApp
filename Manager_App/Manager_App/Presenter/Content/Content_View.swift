//
//  Content_View.swift
//  Manager_App
//
//  Created by The Godfather Júnior on 06/03/25.
//

import SwiftUI

struct Content_View: View {
    var body: some View {
        TabView {
            Balance_V()
                .tabItem {
                    Image(systemName: "house")
                    Text("Ballance")
                }
            
            Text("Settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .tint(.mainPurple) 
    }
}

#Preview {
    Content_View()
}
