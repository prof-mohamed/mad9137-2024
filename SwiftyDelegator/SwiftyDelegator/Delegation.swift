//
//  Delegation.swift
//  SwiftyDelegator
//
//  Created by Mohamed El-Halawani on 2024-10-30.
//

import Foundation

struct Task: Identifiable {
    var id: UUID = UUID()
    
    let image: String
    let title: String
}

class Model: ObservableObject {
    
    @Published var tasks: [Task] = [
        Task(image: "globe", title: "Travel"),
        Task(image: "gamecontroller", title: "Play"),
    ]
    
    @Published var selectedTask: Task?
}

class ActionsDelegate {
    
    var action: ((Task) -> Void)?
}

extension ActionsDelegate: ContentViewDelegate {
    func add(completion: @escaping Adder) {
        let task = Task(image: "plus", title: "New Task")
        
        DispatchQueue.global().async {
            // endpoint call
            
            DispatchQueue.main.async {
                completion(task)
            }
            
        }
    }
    
    func remove(id: UUID, model: Model) {
        var tempTasks = model.tasks
        tempTasks.removeAll { $0.id == id }
        model.tasks = tempTasks
    }
}
