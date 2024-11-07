//
//  HTTPClient.swift
//  JSONPlaceholder
//
//  Created by Mohamed El-Halawani on 2024-11-06.
//

import Foundation

struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let username: String
    let company: [String: String]
    let address: Address
}

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
}

struct HTTPClient {
    static func fetchData(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion(.failure(URLError.badURL as! Error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data!)
                completion(.success(users))
            } catch {
                print(error)
            }
            
            // using callbacks
//            do {
//                if let data = data {
//                    let dictData = try JSONSerialization.jsonObject(with: data)
//                    if let convertedData = dictData as? [[String: Any]] {
//                        print(convertedData[0]["name"]!)
//                    }
//                }
//            } catch {
//                print(error)
//            }
            
        }
        
        
        task.resume()
        
    }
    
    
    static func asyncFetchData() async throws -> Result<[User], Error> {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return.failure(URLError.badURL as! Error)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
            
        do{
            let users = try JSONDecoder().decode([User].self, from: data)
            return .success(users)
        } catch {
            print(error)
            return .failure(error)
        }
    }
}
