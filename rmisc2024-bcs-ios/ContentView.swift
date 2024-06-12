//
//  ContentView.swift
//  rmisc2024-bcs-ios
//
//  Created by Hiro Protagonist on 6/2/24.
//

import SwiftUI

// this simple application will have two views
// the home view will display the most recent 10-K Cybersecurity filings
// in a list view which will link out to the Board Cybersecurity post
// there will also be an Account view where the user can login to their account
// and receive a JWT token
// the application will follow the MVVM design pattern

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Text("Home")
                Label("Home", systemImage: "house")
            }
            
            NavigationView {
                AccountView()
            }
            .tabItem {
                Text("Username")
                Label("Username", systemImage: "person")
            }
        }
    }
}


#Preview {
    ContentView()
}
