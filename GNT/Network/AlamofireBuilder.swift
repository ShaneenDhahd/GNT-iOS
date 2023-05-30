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
	

    func submitForm(name: String, username: String, gov: String, comment: String, gps: String,  completion: @escaping (ApiCallback<FormModel?>)->()){
        
        let parameters: [String: Any] =
        [
            "name": name,
            "username": username,
            "gov": gov,
            "comment": comment,
            "gps": gps
        ]
        
        makeRequest(url: .submit, method: .post, parameters: parameters) { submitData in
            completion(self.parseData(data: submitData))
        }
    }
    
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
    func refresh(completion: @escaping (ApiCallback<LoginModel?>)->() ){
        
        makeRequest(url: .refresh, method: .post){ loginData in
            completion(self.parseData(data: loginData))
        }
    }
    func logout(completion: @escaping (ApiCallback<LogoutModel?>)->() ){
        
        makeRequest(url: .logout, method: .post){ loginData in
            completion(self.parseData(data: loginData))
        }
    }
    func getForms(completion: @escaping (ApiCallback<FormsModel?>)->() ){
        
        makeRequest(url: .listData, method: .post){ loginData in
            completion(self.parseData(data: loginData))
        }
    }
    
    func getGovs(completion: @escaping (ApiCallback<GovernmentsModel?>)->()){
        makeRequest(url: .getGovernesses) { govs in
            completion(self.parseData(data: govs))
        }
    }
    
    private func makeRequest(url: Endpoint, method: HTTPMethod = .get, parameters: Parameters? = [:], encoder: ParameterEncoding = URLEncoding.default, completion: @escaping (Data?)->()  ){
        
        var header: HTTPHeaders? = HTTPHeaders()
        if let user = UserInformation.user {
            header?.add(HTTPHeader(name: "Authorization", value: "Bearer \(user.data.accessToken)"))
        }
        
        af.request(url.url, method: method, parameters: parameters, encoding: encoder, headers: header).response { data in
			completion(data.data)
		}
	}
	
	private func parseData<Model: Decodable>(data: Data?) -> ApiCallback<Model> {
        guard let data = data else {return ApiCallback.failure(nil)}
        let str = String(decoding: data, as: UTF8.self)
		do {
			let data = try JSONDecoder().decode(Model.self, from: data)
			return .success(model: data)
		} catch {
            let errorModel = try? JSONDecoder().decode(ErrorModel.self, from: data)
			return .failure(errorModel)
		}
	}
}
