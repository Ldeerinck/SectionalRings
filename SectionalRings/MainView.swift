//
//  MainView.swift
//  SectionalRings
//
//  Created by Chuck Deerinck on 5/2/25.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var globalSettings: Globals
    @EnvironmentObject var landables: Landables
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Map")
                }
                .environmentObject(globalSettings)
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
                .environmentObject(globalSettings)
            AirportView()
                .tabItem {
                    Image(systemName: "airplane")
                    Text("Airports")
                }
                .environmentObject(landables)
        }
        .environmentObject(Globals())
        //.environmentObject(Landables())
    }
}
    

#Preview {
    MainView()
}
