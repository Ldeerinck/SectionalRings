//
//  SectionalRingsApp.swift
//  SectionalRings
//
//  Created by Luke Deerinck on 4/25/25.
//

import SwiftUI

@main
struct SectionalRingsApp: App {
    @StateObject private var globalSettings = Globals()
    @StateObject private var landables = Landables()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(globalSettings)
                .environmentObject(landables)
        }
    }
}
