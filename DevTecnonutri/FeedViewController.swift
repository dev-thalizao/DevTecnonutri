//
//  FeedViewController.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/14/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import SDWebImage

class FeedViewController: UITableViewController, FeedView {

    private let feedPresenter = FeedPresenter(feedService: FeedService())
    private var feedData = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView .register(UINib.init(nibName: "FeedTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedTableViewCell")
        
        feedPresenter.attachView(view: self);
        feedPresenter.getFeed()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source and delegate
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        
        // Configure the cell...
        let item = feedData[indexPath.row]
        cell.profileName.text = item.profile.name
        cell.profileGoal.text = item.profile.generalGoal
        cell.profileImage.sd_setImage(with: URL(string: item.profile.imageUrl))
        
        cell.profileImage.sd_setImage(with: URL(string: item.imageUrl), placeholderImage: UIImage.init(named: "profile_placeholder"))
        
        cell.mealImage.sd_setImage(with: URL(string: item.imageUrl))
        cell.mealDate.text = "Data da refeição \(DateUtils.formatToPattern(date: item.date, pattern: "dd/MM/yyyy"))"
        cell.mealEnergy.text = "\(item.energy) kcal"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 340.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - FeedView delegate
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
