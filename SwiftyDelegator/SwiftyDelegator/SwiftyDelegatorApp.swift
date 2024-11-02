//
//  SwiftyDelegatorApp.swift
//  SwiftyDelegator
//
//  Created by Mohamed El-Halawani on 2024-10-30.
//

import SwiftUI

@main
struct SwiftyDelegatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(model: Model(), delegate: ActionsDelegate())
        }
    }
}
