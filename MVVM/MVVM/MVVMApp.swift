//
//  MVVMApp.swift
//  MVVM
//
//  Created by Mohamed El-Halawani on 2024-11-22.
//

import SwiftUI

@main
struct MVVMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel(), text: "")
        }
    }
}
