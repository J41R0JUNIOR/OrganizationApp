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
            
            Reports_V()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Reports")
                }
            
            Settings_V()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .task {
            SwiftData_Manager.shared.fetch { result in
                switch result {
                case .success(let data):
                    print("Data fetched: \(data)")
                    if data.isEmpty {
                        SwiftData_Manager.shared.save(user: .init(name: "Jaior", investments: [], monthReports: []))
                    }
                case .failure(let error):
                    print("Error fetching data: \(error)")
                    
                }
            }
        }
        
        .foregroundStyle(.main3)
        .tint(Color.main3)
    }
}

#Preview {
    Content_V()
}
