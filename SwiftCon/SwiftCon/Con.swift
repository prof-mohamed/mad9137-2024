//
//  Con.swift
//  SwiftCon
//
//  Created by Mohamed El-Halawani on 2024-11-01.
//

import Foundation

enum AppError: Error {
    case invalidInput
    case invalidOutput
    case invalidState
}

enum ErrorType: String {
    case output
    case input
    case state
}

struct Con {
    
    func calculateAverage() async -> Result<String, AppError> {
        sleep(2)
        return .failure(.invalidOutput)
    }
    
    func calculateSum(type: String) async throws -> String {
        sleep(5)
        let comingType = ErrorType(rawValue: type)
        switch comingType {
        case .input:
            throw AppError.invalidInput
        case .output:
            throw AppError.invalidOutput
        case .state:
            throw AppError.invalidState
        case .none:
            throw AppError.invalidInput
        }
    }
}
