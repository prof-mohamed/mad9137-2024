//
//  ContentView.swift
//  SwiftyDelegator
//
//  Created by Mohamed El-Halawani on 2024-10-30.
//

import SwiftUI


typealias Adder = (Task) -> Void
typealias integer = Int


protocol ContentViewDelegate {
    func add(completion: @escaping Adder)
    func remove(id: UUID, model: Model)
}

struct ContentView: View {

   
    @ObservedObject var model: Model
    
    var delegate: ContentViewDelegate
    
    var body: some View {
        Button("Add") {
            delegate.add { task in
                model.tasks.append(task)
            }
        }
        
        List(model.tasks) { task in
            HStack {
                Image(systemName: task.image)
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text(task.title)
                Spacer()
                Button("Delete") {
                    delegate.remove(id: task.id, model: model)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(model: Model(), delegate: ActionsDelegate())
}
