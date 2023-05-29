//
//  GovernemtsModel.swift
//  GNT
//
//  Created by Shaneen on 5/29/23.
//

//   let governmentsModel = try? JSONDecoder().decode(GovernmentsModel.self, from: jsonData)

import Foundation

// MARK: - GovernmentsModelElement
struct GovernmentModel: Codable {
    let govID: Int
    let govName: String

    enum CodingKeys: String, CodingKey {
        case govID = "gov_id"
        case govName = "gov_name"
    }
}

typealias GovernmentsModel = [GovernmentModel]
