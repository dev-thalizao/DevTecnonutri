//
//  FeedViewController.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let feedPresenter = FeedPresenter(feedService: FeedService())
    var feedData = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup tableView
        self.tableView.register(UINib.init(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 400
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Setup presenter
        feedPresenter.attachView(view: self);
        feedPresenter.getFeed()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        
        // Configure the cell...
        let item = feedData[indexPath.row]
        cell.setupCell(item: item)
        
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    
}

extension FeedViewController: FeedView {
    func startLoading(){
        
    }
    
    func finishLoading(){
        
    }
    
    func setFeed(items: [Item]){
        self.feedData = items;
        self.tableView.reloadData()
    }
    
    func setEmptyFeed(){
        
    }
    
    func showMessage(message: String){
        
    }
}

