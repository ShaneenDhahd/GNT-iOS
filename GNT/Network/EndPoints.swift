//
//  EndPoints.swift
//  Covid Tracker
//
//  Created by Shaneen Dhahd on 09/11/2022.
//

import Foundation
enum Endpoint {
	private var baseURL: String { return "https://mapi.giganet.iq/api/" }
	
	case login
    case logout
    case submit
    case listData
    case getGovernesses
    case refresh
	
	
	private var fullPath: String {
		var endpoint:String
		switch self {
			case .login:
				endpoint = "auth/login"
            case .logout:
                endpoint = "logout"
            case .submit:
                endpoint = "auth/submit"
            case .listData:
                endpoint = "listData"
            case .getGovernesses:
                endpoint = "v1/getGovernesses"
            case .refresh:
                endpoint = "refresh"
		}
		return baseURL + endpoint
	}
	
	var url: URL {
		guard let url = URL(string: fullPath) else {
			preconditionFailure("The url used in \(Endpoint.self) is not valid")
		}
		return url
	}
}
