//
//  ContentView.swift
//  JSONPlaceholder
//
//  Created by Mohamed El-Halawani on 2024-11-06.
//

import SwiftUI

struct ContentView: View {
    @State var users: [User] = []
    
    var body: some View {
        VStack {
            Button("Fetch Users") {
                Task {
                    let result = try await HTTPClient.asyncFetchData()
                    switch result {
                    case .success(let users):
                        self.users = users
                    case .failure(let error):
                        print(error)
                    }
                }

                // using callbacks
//                HTTPClient.fetchData() { result in
//                    switch result {
//                    case .success(let users):
//                        self.users = users
//                    case .failure(let error):
//                        print(error)
//                    }
//                }
            }
            
            ForEach(users) { user in
                Text(user.name)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
