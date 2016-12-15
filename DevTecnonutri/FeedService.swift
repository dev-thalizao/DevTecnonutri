//
//  FeedService.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

//{
//    "feedHash": "1064651-2016-12-14-2",
//    "id": 20867745,
//    "profile": {
//        "id": 1064651,
//        "name": "Feh Vieira",
//        "image": "https://tnapp.blob.core.windows.net/profiles/1064651.jpg",
//        "general_goal": "Perder peso",
//        "following": false,
//        "badge": null,
//        "locale": "pt",
//        "items_count": 9,
//        "followers_count": 9,
//        "followings_count": 2
//    },
//    "meal": 2,
//    "date": "2016-12-14",
//    "liked": false,
//    "likes_count": 0,
//    "comments_count": 0,
//    "image": "https://tnapp.blob.core.windows.net/meals/1064651-2016-12-14-2.jpg",
//    "comment": "",
//    "place": null,
//    "address": null,
//    "energy": 192,
//    "carbohydrate": 36.9992,
//    "fat": 1.7988,
//    "protein": 7.2008,
//    "fat_trans": 0,
//    "fat_sat": 0.5,
//    "fiber": 3.0996,
//    "sugar": 0,
//    "sodium": 505.999,
//    "calcium": 82,
//    "iron": 0,
//    "moderation": 0,
//    "badge": null,
//    "locale": "pt"
//}

import Foundation
import SwiftyJSON

class FeedService: NetworkService {
    
    static let feedEndpoint = "http://api.tecnonutri.com.br/api/v4/feed"
    
    func getFeed(completion:@escaping (Array<Item>, NSError?) -> Void){
        self.get(url: FeedService.feedEndpoint,
           onSuccess: { (response) -> Void in
            
            // Parse json
            let json = JSON(response)
            
            // parse items
            let items = json["items"].arrayValue.map({ (jsonItem) -> Item in
                return self.parseItem(jsonItem: jsonItem)
            })
            
            completion(items, nil)
            
        }, onFail: { (error) -> Void in
            completion([], error)
        })
    }
    
    func parseItem(jsonItem: JSON) -> Item{
        // Parse profile
        let jsonProfile = jsonItem["profile"]
        let profile = Profile(name: jsonProfile["name"].stringValue,
                              imageUrl: jsonProfile["image"].stringValue,
                              generalGoal: jsonProfile["general_goal"].stringValue)
        
        // Parse date
        let date = DateUtils.formatDate(stringDate: jsonItem["date"].stringValue)
        
        // Parse item
        let item = Item(imageUrl: jsonItem["image"].stringValue,
                        mealType: Meal(rawValue: jsonItem["meal"].intValue)!,
                        date: date,
                        energy: jsonItem["energy"].floatValue,
                        profile: profile)
        
        return item
    }
    
}
