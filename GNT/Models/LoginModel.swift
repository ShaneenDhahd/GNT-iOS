//
//  LoginModel.swift
//  GNT
//
//  Created by Shaneen on 5/28/23.
//

//   let loginModel = try? JSONDecoder().decode(LoginModel.self, from: jsonData)

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, tokenType: String
    let expiresIn: Int
    let user: User

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int
    let username, email, lastlogin: String
    let lastip: String?
    let governorates: String
    let uGroup: Int
    let notify: String
}
