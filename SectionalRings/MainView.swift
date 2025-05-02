//
//  MainView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/2/25.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            AirportView()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Airports")
                }
        }
    }
}

#Preview {
    MainView()
}
