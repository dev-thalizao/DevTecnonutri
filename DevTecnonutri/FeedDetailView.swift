//
//  FeedDetailView.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/18/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import Foundation

protocol FeedDetailView {
    func startLoading()
    func finishLoading()
    func setFeed(item: Item)
    func showMessage(message: String)
}
