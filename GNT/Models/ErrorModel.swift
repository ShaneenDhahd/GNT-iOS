//
//  ErrorMODEL.swift
//  GNT
//
//  Created by Shaneen on 5/29/23.
//

//   let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: jsonData)

import Foundation

// MARK: - ErrorModel
struct ErrorModel: Codable {
    let error: String
}
