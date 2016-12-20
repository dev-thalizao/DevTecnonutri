//
//  FeedDetailViewController.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import SVProgressHUD
import ReachabilitySwift

class FeedDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let feedDetailPresenter = FeedDetailPresenter(feedService: FeedService())
    var reachability = Reachability()!
    var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set navbar
        self.setNavbar()
        
        // Setup tableView
        self.tableView.register(UINib.init(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        self.tableView.register(UINib.init(nibName: "FeedDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "feedDetailCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 400
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Init refresh control
        self.tableView.refreshControl = UIRefreshControl.init()
        self.tableView.refreshControl?.addTarget(self, action: #selector(self.reloadDataFromServer), for: .valueChanged)
        
        // Setup presenter
        feedDetailPresenter.attachView(view: self);
        reloadDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavbar(){
        // Change title
        self.navigationItem.title = "\(item.mealType.getMealName()) de \(DateUtils.formatToPattern(date: item.date, pattern: "dd/MM/yyyy"))"
        self.navigationItem.titleView?.sizeToFit()
        
        // Create a custom back button
        let backButton = UIBarButtonItem.init(title: nil, style: .plain, target: self, action: #selector(backToThePreviousViewController))
        backButton.image = UIImage(named: "back_button")
        backButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func backToThePreviousViewController(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // First load or pull to refresh
    func reloadDataFromServer(){
        if(self.reachability.isReachable){
            feedDetailPresenter.getFeed(item: self.item)
        } else {
            self.alertForInternetUnavailable()
        }
    }
    
    func alertForInternetUnavailable(){
        self.finishLoading()
        self.showMessage(message: "Verifique sua conexão com a internet.", isError: true)
    }
}

extension FeedDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 1){
            return self.item.foods.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedTableViewCell
            
            cell.setupCellForDetail(item: item)
            cell.delegate = self
            return cell
        } else if(indexPath.section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedDetailCell", for: indexPath) as! FeedDetailTableViewCell
            
            cell.setupCell(food: item.foods[indexPath.row])
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feedDetailCell", for: indexPath) as! FeedDetailTableViewCell
            
            cell.setupCellForTotalNutrients(food: item.totalNutrients)
            return cell
        }
    }
}

extension FeedDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.section != 0){
            return 130.0
        } else {
            return UITableViewAutomaticDimension
        }
    }
}

extension FeedDetailViewController: FeedDetailView {
    func startLoading(){
        SVProgressHUD.show()
    }
    
    func finishLoading(){
        if(SVProgressHUD.isVisible()){
            SVProgressHUD.dismiss()
        }
        self.tableView.refreshControl?.endRefreshing()
    }
    
    func setFeed(item: Item){
        self.item = item
        self.tableView.reloadData()
    }
    
    func showMessage(message: String, isError: Bool){
        let alert = UIAlertController.init(title: "Tecnonutri", message: message, preferredStyle: UIAlertControllerStyle.alert)
        let style: UIAlertActionStyle = isError ? .destructive : .default
        let action = UIAlertAction.init(title: "Ok", style: style, handler: nil)
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension FeedDetailViewController: FeedTableViewCellDelegate {
    func didTapProfileImage(user: User) {
        let userDetailViewController = UserDetailViewController()
        userDetailViewController.user = user
        self.navigationController?.pushViewController(userDetailViewController, animated: true)
    }
}
