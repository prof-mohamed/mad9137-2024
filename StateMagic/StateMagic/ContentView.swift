//
//  ContentView.swift
//  StateMagic
//
//  Created by Mohamed El-Halawani on 2024-11-08.
//

import SwiftUI

struct Property: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var address: String
}

class ViewModel: ObservableObject {
    
    @Published var properties = [
        ["name": "house2", "address": "124 second St"],
        ["name": "house3", "address": "444 thrid Ave"]
    ]
    
    @Published var isShowing: Bool = false
    
    func printSomething()  {
        print("Something")
    }
}

struct ContentView: View {
    
    @StateObject var contentData = ViewModel()
    
    @EnvironmentObject var helper: Helper
    
    var body: some View {
        VStack {
            List(contentData.properties, id: \.self) { property in
                NavigationLink {
                    PropertyDetailView(contentData: contentData)
                } label: {
                    VStack {
                        Text("Property name: \(property["name"]!) " )
                        Text("Address: \(property["address"]!)")
                        Text(contentData.isShowing ? "yes" : "no")
                        Text("\(helper.value)")
                    }
                }
            }
            
            Button("Add") {
                contentData.properties.append(["name": "house1", "address":"111 first St"])
                helper.value = 2
            }
        }
        .padding()
    }
}

struct PropertyDetailView: View {
    
    @ObservedObject var contentData: ViewModel
    @EnvironmentObject var helper: Helper
    
    var body: some View {
        
        VStack {
            Text(contentData.properties.first!["name"]!)
            Text(contentData.properties.first!["address"]!)
            Text(contentData.isShowing ? "yes" : "no")
            Text("\(helper.value)")
        }
        
        Button("update") {
            
            if var first = contentData.properties.first {
                contentData.properties.dropFirst()
                first["name"] = "Updated House"
                contentData.properties.insert(first, at: 0)
            }
            contentData.isShowing.toggle()
        }
    }
}

#Preview {
    ContentView()
}
