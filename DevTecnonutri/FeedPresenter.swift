//
//  FeedPresenter.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedPresenter {
    
    private let feedService: FeedService
    private var feedView: FeedView?
    private var firstLoad = true
    private var pageNumber = 0
    private var timestamp: NSNumber = 0
    
    init(feedService: FeedService) {
        self.feedService = feedService
    }
    
    func attachView(view: FeedView){
        self.feedView = view;
    }
    
    func detachView(){
        self.feedView = nil
    }
    
    func getFeeds(loadMode: LoadMode){
        let params: [String: Any]?
        if(loadMode != LoadMode.refresh){
            params = ["p": self.pageNumber, "t": self.timestamp]
        } else {
            self.pageNumber = 0;
            self.timestamp = 0
            params = nil
        }
        
        if(self.firstLoad){
            self.feedView?.startLoading()
            self.firstLoad = false
        }
        
        feedService.getFeeds(params: params, onSuccess: { (response) -> Void in
            self.feedView?.finishLoading()
            
            // Parse json
            let json = JSON(response)
            
            if(json["success"].boolValue){
                // parse items
                let items = json["items"].arrayValue.map({ (jsonItem) -> Item in
                    return Item(json: jsonItem)
                })
                
                self.pageNumber += 1
                self.timestamp = json["t"].numberValue
                self.feedView?.setFeed(items: items, loadMode: loadMode)
            } else {
                self.feedView?.setFeed(items: [], loadMode: loadMode)
                self.feedView?.showMessage(message: "Houve um erro ao buscar o feed!", isError: true)
            }
        }, onFail: { (error) -> Void in
            self.feedView?.finishLoading()

            if(error.code == NSURLErrorNotConnectedToInternet){
                self.feedView?.showMessage(message: "Verifique sua conexão com a internet.", isError: true)
            } else {
                self.feedView?.showMessage(message: "Algo estranho aconteceu :(", isError: true)
            }
        })
    }
}
