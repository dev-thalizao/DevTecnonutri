//
//  UserService.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/18/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import Alamofire

class UserService {

    func getProfileDetail(id: NSNumber, onSuccess: @escaping (Any) -> Void, onFail: @escaping (NSError) -> Void){
        Alamofire.request(Endpoint.profileDetail + id.stringValue, method: .get).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
                onSuccess(value)
            case .failure(let error):
                onFail(error as NSError)
            }
        }
    }
}
