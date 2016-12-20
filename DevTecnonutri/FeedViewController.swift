//
//  FeedViewController.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import SVProgressHUD
import CCBottomRefreshControl
import ReachabilitySwift

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noFeedAvailable: UILabel!
    var reachability = Reachability()!
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
        
        // Init refresh controls
        self.tableView.refreshControl = UIRefreshControl.init()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.reloadDataFromServer), for: .valueChanged)
        self.tableView.bottomRefreshControl = UIRefreshControl.init()
        self.tableView.bottomRefreshControl.addTarget(self, action: #selector(self.incrementDataFromServer), for: .valueChanged)
        
        // Setup presenter
        feedPresenter.attachView(view: self);
        reloadDataFromServer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // First load or pull to refresh
    func reloadDataFromServer(){
        if(self.reachability.isReachable){
            self.noFeedAvailable.isHidden = true
            feedPresenter.getFeeds(loadMode: LoadMode.refresh)
        } else {
            self.alertForInternetUnavailable()
        }
    }
    
    // Infinite scroll
    func incrementDataFromServer(){
        if(self.reachability.isReachable){
            self.noFeedAvailable.isHidden = true
            feedPresenter.getFeeds(loadMode: LoadMode.scrolling)
        } else {
            self.alertForInternetUnavailable()
        }
    }

    func alertForInternetUnavailable(){
        self.finishLoading()
        if(self.feedData.count == 0){
            self.noFeedAvailable.text = "Sem conexão com a internet. Puxe para atualizar!"
            self.noFeedAvailable.isHidden = false
        }
        
        self.showMessage(message: "Verifique sua conexão com a internet.", isError: true)
    }
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
        
        let item = feedData[indexPath.row]
        cell.setupCell(item: item)
        cell.delegate = self
        
        return cell
    }
}

extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row == (feedData.count - 2)){
            tableView.bottomRefreshControl?.beginRefreshing()
            self.incrementDataFromServer()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = feedData[indexPath.row]
        
        let feedDetailViewController = FeedDetailViewController()
        feedDetailViewController.item = item
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
}

extension FeedViewController: FeedView {
    func startLoading(){
        SVProgressHUD.show()
    }
    
    // Dismiss all activity loaders
    func finishLoading(){
        if(SVProgressHUD.isVisible()){
            SVProgressHUD.dismiss()
        }
        self.tableView.refreshControl?.endRefreshing()
        self.tableView.bottomRefreshControl?.endRefreshing()
    }
    
    func setFeed(items: [Item], loadMode: LoadMode){
        // Prevent a empty array
        if(items.count > 0){
            if(loadMode == LoadMode.refresh){
                self.feedData = items
            } else {
                self.feedData.append(contentsOf: items)
            }
            self.tableView.reloadData()
        } else {
            setEmptyFeed()
        }
    }
    
    func setEmptyFeed(){
        self.noFeedAvailable.text = "Conteúdo não disponível"
        self.noFeedAvailable.isHidden = false
    }
    
    func showMessage(message: String, isError: Bool){
        let alert = UIAlertController.init(title: "Tecnonutri", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let style: UIAlertActionStyle = isError ? .destructive : .default
        let action = UIAlertAction.init(title: "Ok", style: style, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension FeedViewController: FeedTableViewCellDelegate {
    func didTapProfileImage(user: User) {
        let userDetailViewController = UserDetailViewController()
        userDetailViewController.user = user
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
}
