//
//  StateMagicApp.swift
//  StateMagic
//
//  Created by Mohamed El-Halawani on 2024-11-08.
//

import SwiftUI

class Helper: ObservableObject {
    @Published var value: Int = 0
}

@main
struct StateMagicApp: App {
    let helper = Helper()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
            }
            .environmentObject(helper)
        }
    }
}
