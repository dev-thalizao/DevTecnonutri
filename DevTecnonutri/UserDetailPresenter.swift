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
        // Prevent request when feed is over
        if(self.scrollIsOver){
            self.userDetailView?.finishLoading()
            return
        }
        
        // Create a query http paramters if needed
        let params: [String: Any]?
        if(loadMode != LoadMode.refresh){
            params = ["p": self.pageNumber, "t": self.timestamp]
        } else {
            self.pageNumber = 0;
            self.timestamp = 0
            params = nil
            self.scrollIsOver = false
        }
        
        // Start SVProgressHUD if it is the first load
        if(self.firstLoad){
            self.userDetailView?.startLoading()
            self.firstLoad = false
        }
        
        // Fetch details about the selected user
        userService.getProfileDetail(id: user.id, params: params, onSuccess: { (response) -> Void in
            self.userDetailView?.finishLoading()
            
            // Parse json
            let json = JSON(response)
            
            if(json["success"].boolValue){
                // Get updated user and merge or add items to it
                var userUpdated = User(json: json["profile"])
                if(loadMode != LoadMode.refresh){
                    userUpdated.items = user.items
                } else {
                    userUpdated.items = [Item]()
                }
                
                // parse items
                let items = json["items"].arrayValue.map({ (jsonItem) -> Item in
                    return Item(json: jsonItem)
                })
                
                // Verify if feed is over
                if(items.count > 0){
                    self.pageNumber += 1
                    self.timestamp = json["t"].numberValue
                    userUpdated.items.append(contentsOf: items)
                } else {
                    self.scrollIsOver = true
                }
                // Update view
                self.userDetailView?.setUser(user: userUpdated)
            } else {
                self.userDetailView?.showMessage(message: "Houve um erro ao buscar as publicações desse perfil", isError: true)
            }
        }, onFail: { (error) -> Void in
            self.userDetailView?.finishLoading()
            self.userDetailView?.showMessage(message: "Algo estranho aconteceu :(", isError: true)
        })
    }
}
