//
//  FeedViewController.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        
        // Init refresh control
        self.tableView.refreshControl = UIRefreshControl.init()
        //self.tableView.refreshControl?.backgroundColor
        //self.tableView.refreshControl?.tintColor
        self.tableView.refreshControl?.addTarget(self, action: #selector(reloadDataFromServer), for: .valueChanged)
        
        // Setup presenter
        feedPresenter.attachView(view: self);
        feedPresenter.getFeeds(loadMode: LoadMode.refresh)
    }
    
    func reloadDataFromServer(){
        feedPresenter.getFeeds(loadMode: LoadMode.refresh)
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
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == (feedData.count - 1)){
            feedPresenter.getFeeds(loadMode: LoadMode.scrolling)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = feedData[indexPath.row]
        print("Item clicked \(item)")
    }
}

extension FeedViewController: FeedView {
    func startLoading(){
        SVProgressHUD.show()
    }
    
    func finishLoading(){
        if(SVProgressHUD.isVisible()){
            SVProgressHUD.dismiss()
        }
        
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func setFeed(items: [Item], loadMode: LoadMode){
        if(loadMode == LoadMode.refresh){
            self.feedData = items
        } else {
            self.feedData.append(contentsOf: items)
        }
        self.tableView.reloadData()
    }
    
    func setEmptyFeed(){
        
    }
    
    func showMessage(message: String){
        
    }
}

