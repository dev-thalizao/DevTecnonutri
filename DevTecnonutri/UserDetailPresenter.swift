//
//  UserDetailPresenter.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/18/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

class UserDetailPresenter {
    
    private let userService: UserService
    private var userDetailView: UserDetailView?
    private var firstLoad = true
    private var pageNumber = 0
    private var timestamp: NSNumber = 0
    private var scrollIsOver = false
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func attachView(view: UserDetailView){
        self.userDetailView = view;
    }
    
    func detachView(){
        self.userDetailView = nil
    }
    
    func getUserDetails(user: User, loadMode: LoadMode){
        
        if(self.scrollIsOver){
            print("Scroll is over")
            self.userDetailView?.finishLoading()
            return
        }
        
        let params: [String: Any]?

        if(loadMode != LoadMode.refresh){
            params = ["p": self.pageNumber, "t": self.timestamp]
        } else {
            self.pageNumber = 0;
            self.timestamp = 0
            params = nil
            self.scrollIsOver = false
        }
        
        if(self.firstLoad){
            self.userDetailView?.startLoading()
            self.firstLoad = false
        }
        
        userService.getProfileDetail(id: user.id, params: params, onSuccess: { (response) -> Void in
            // Parse json
            let json = JSON(response)
            
            if(json["success"].boolValue){
                // parse items
                
                var userUpdated = User(json: json["profile"])
                if(loadMode != LoadMode.refresh){
                    userUpdated.items = user.items
                } else {
                    userUpdated.items = [Item]()
                }
                
                let items = json["items"].arrayValue.map({ (jsonItem) -> Item in
                    return Item(json: jsonItem)
                })
                
                if(items.count <= 0){
                    self.scrollIsOver = true
                }
                
                userUpdated.items.append(contentsOf: items)
                
                self.userDetailView?.finishLoading()
                self.pageNumber += 1
                self.timestamp = json["t"].numberValue
                
                self.userDetailView?.setUser(user: userUpdated)
            } else {
                // Error msg
            }
        }, onFail: { (error) -> Void in
            // Error msg
        })
    }
}
