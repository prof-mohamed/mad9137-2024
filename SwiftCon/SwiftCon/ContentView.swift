//
//  ContentView.swift
//  SwiftCon
//
//  Created by Mohamed El-Halawani on 2024-11-01.
//

import SwiftUI

struct ContentView: View {
    
    let con = Con()
    var body: some View {
        VStack {
            Button("Get Average") {
                Task {
                    
                    let response = await con.calculateAverage()
                    
                    switch response {
                    case .success(let value):
                        print(value)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
