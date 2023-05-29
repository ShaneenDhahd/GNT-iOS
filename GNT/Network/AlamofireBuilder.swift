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
	

    func login(email: String, password: String, completion: @escaping (ApiCallback<LoginModel?>)->() ){
        let parameters: [String: Any] =
        [
            "email": email,
            "password": password
        ]
        
        makeRequest(url: .login, method: .post, parameters: parameters) { loginData in
            completion(self.parseData(data: loginData))
        }
    }
    
    private func makeRequest(url: Endpoint, method: HTTPMethod = .get, parameters: Parameters, encoder: ParameterEncoding = URLEncoding.default, completion: @escaping (Data?)->()  ){
		af.request(url.url, method: method, parameters: parameters, encoding: encoder, requestModifier: { request in
			request.cachePolicy = .reloadIgnoringCacheData
		}).response { data in
			completion(data.data)
		}
	}
	
	private func parseData<Model: Decodable>(data: Data?) -> ApiCallback<Model> {
        guard let data = data else {return ApiCallback.failure(nil)}
        let str = String(decoding: data, as: UTF8.self)
        print("data string \(str)")
		do {
			let data = try JSONDecoder().decode(Model.self, from: data)
			return .success(model: data)
		} catch {
            let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data)
			return .failure(errorModel)
		}
	}
}
