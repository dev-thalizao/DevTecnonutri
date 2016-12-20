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
        
        // Start SVProgressHUD if it is the first load
        if(self.firstLoad){
            self.feedDetailView?.startLoading()
            self.firstLoad = false
        }

        // Fetch details about the selected feed
        feedService.getFeed(feedHash: item.feedHash, onSuccess: { (response) -> Void in
            self.feedDetailView?.finishLoading()
            
            let json = JSON(response)
            
            if(json["success"].boolValue){
                self.feedDetailView?.setFeed(item: Item(json: json["item"]))
            } else {
                self.feedDetailView?.showMessage(message: "Não foi possível encontrar os detalhes dessa publicação", isError: true)
            }
        }, onFail: { (error) -> Void in
            self.feedDetailView?.finishLoading()
            self.feedDetailView?.showMessage(message: "Algo estranho aconteceu :(", isError: true)
        })
    }
}
