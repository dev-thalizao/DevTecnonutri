//
//  NetworkService.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    func get(url: String, onSuccess: @escaping (Any) -> Void, onFail: @escaping (NSError) -> Void){
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            switch response.result {
                case .success(let value):
                    onSuccess(value)
                case .failure(let error):
                    onFail(error as NSError)
            }
        }
    }
}
