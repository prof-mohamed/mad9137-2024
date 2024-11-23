//
//  ContentView.swift
//  MVVM
//
//  Created by Mohamed El-Halawani on 2024-11-22.
//

import SwiftUI

// 1- Model
struct User: Codable {
    let id: UUID
    var firstName: String {
        willSet {
            print("Will set first name to \(newValue)")
        }
        
        didSet {
            print("Did set first name to \(oldValue)")
        }
    }
    let lastName: String
    let email: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

// 3- ViewModel
class ViewModel: ObservableObject {
    
    @Published var user: User = .init(
        id: .init(),
        firstName: "M",
        lastName: "H",
        email: "m@h.com"
    )
    
    var firstName: String {
        user.firstName
    }
    
    var lastName: String {
        user.lastName
    }
    
    var email: String {
        user.email
    }
    
    private func updateUser(fristName: String) {
        user.firstName = fristName
    }
    
    enum Action {
        case updateUser
        case deleteUser
        case addUser
    }
    
    func perform(action: Action, info: Any) {
        switch action {
            case .updateUser:
            updateUser(fristName: info as! String)
        default:
            break
        }
    }
}


// 2- View
struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    @State var text: String
    
    var body: some View {
        VStack {
            Text(viewModel.firstName)
            Text(viewModel.lastName)
            Text(viewModel.email)
            
            TextField("First Name", text: $text)
            
            Button("Update User") {
                viewModel.perform(action: .updateUser, info: text)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView(viewModel: .init(), text: "")
}
