//
//  FeedDetailPresenter.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/18/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeedDetailPresenter {
    
    private let feedService: FeedService
    private var feedDetailView: FeedDetailView?
    private var firstLoad = true
    
    init(feedService: FeedService) {
        self.feedService = feedService
    }
    
    func attachView(view: FeedDetailView){
        self.feedDetailView = view;
    }
    
    func detachView(){
        self.feedDetailView = nil
    }
    
    func getFeed(item: Item){
        
        if(self.firstLoad){
            self.feedDetailView?.startLoading()
            self.firstLoad = false
        }

        feedService.getFeed(feedHash: item.feedHash, onSuccess: { (response) -> Void in
            let json = JSON(response)
            
            if(json["success"].boolValue){
                self.feedDetailView?.setFeed(item: Item(json: json["item"]))
            } else {
                // Error msg
            }
            
            self.feedDetailView?.finishLoading()
        }, onFail: { (error) -> Void in
            // Error msg
        })
    }
}
