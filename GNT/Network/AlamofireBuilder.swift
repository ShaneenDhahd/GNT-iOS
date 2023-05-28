//
//  AlamofireBuilder.swift
//  Covid Tracker
//
//  Created by Shaneen Dhahd on 05/11/2022.
//

import Foundation
import Alamofire

class AlamofireBuilder {
	private let af = Alamofire.AF
	
	
	private func parseData<Model: Decodable>(data: Data?) -> ApiCallback<Model> {
		guard let data = data else {return ApiCallback.failure("Data are nil")}
		do {
			let data = try JSONDecoder().decode(Model.self, from: data)
			return .success(model: data)
		} catch {
			return .failure(error.localizedDescription)
		}
	}
}
