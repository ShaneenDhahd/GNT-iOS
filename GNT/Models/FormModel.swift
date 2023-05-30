//
//  SubmitModel.swift
//  GNT
//
//  Created by Shaneen on 5/30/23.
//

//   let governmentsModel = try? JSONDecoder().decode(GovernmentsModel.self, from: jsonData)

import Foundation

// MARK: - FormModel
struct FormModel: Codable {
    let message: String
    let data: FormUser
}
// MARK: - FormsModel
struct FormsModel: Codable {
    let message: String
    let data: [FormUser]
}

// MARK: - DataClass
struct FormUser: Codable {
    let name, username, gov, comment: String
    let gps, updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case name, username, gov, comment, gps
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
