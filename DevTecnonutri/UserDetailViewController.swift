//
//  UserDetailViewController.swift
//  DevTecnonutri
//
//  Created by Thales Frigo on 12/16/16.
//  Copyright © 2016 Thales Frigo. All rights reserved.
//

import UIKit
import SVProgressHUD
import CCBottomRefreshControl
import ReachabilitySwift

// Customize collectionViewCells
private let sectionInsets = UIEdgeInsets(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
private let itemsPerRow: CGFloat = 3

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noFeedAvailable: UILabel!
    let userDetailPresenter = UserDetailPresenter(userService: UserService())
    var reachability = Reachability()!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set navbar
        self.setNavbar()

        // Setup collectionView
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib.init(nibName: "FeedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "feedCollectionCell")
        self.collectionView.register(UINib.init(nibName: "UserHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "userHeaderCell")
        self.collectionView.refreshControl = UIRefreshControl.init()
        self.collectionView.refreshControl?.addTarget(self, action: #selector(reloadDataFromServer), for: .valueChanged)
        self.collectionView.bottomRefreshControl = UIRefreshControl.init()
        self.collectionView.bottomRefreshControl.addTarget(self, action: #selector(incrementDataFromServer), for: .valueChanged)
        
        userDetailPresenter.attachView(view: self)
        reloadDataFromServer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // First load or pull to refresh
    func reloadDataFromServer(){
        if(self.reachability.isReachable){
            self.noFeedAvailable.isHidden = true
            userDetailPresenter.getUserDetails(user: user, loadMode: LoadMode.refresh)
        } else {
            self.alertForInternetUnavailable()
        }
    }
    
    // Infinite scroll
    func incrementDataFromServer(){
        if(self.reachability.isReachable){
            self.noFeedAvailable.isHidden = true
            userDetailPresenter.getUserDetails(user: user, loadMode: LoadMode.scrolling)
        } else {
            self.alertForInternetUnavailable()
        }
    }
    
    func alertForInternetUnavailable(){
        self.finishLoading()
        if(self.user.items.count == 0){
            self.noFeedAvailable.text = "Sem conexão com a internet. Puxe para atualizar!"
            self.noFeedAvailable.isHidden = false
        }
        
        self.showMessage(message: "Verifique sua conexão com a internet.", isError: true)
    }
    
    func setNavbar(){
        self.navigationItem.title = user.name
        self.navigationItem.titleView?.sizeToFit()
        
        let backButton = UIBarButtonItem.init(title: nil, style: .plain, target: self, action: #selector(backToThePreviousViewController))
        backButton.image = UIImage(named: "back_button")
        backButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func backToThePreviousViewController(){
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension UserDetailViewController: UserDetailView {
    func startLoading(){
        SVProgressHUD.show()
    }
    
    // Dismiss all activity loaders
    func finishLoading(){
        if(SVProgressHUD.isVisible()){
            SVProgressHUD.dismiss()
        }
        self.collectionView.refreshControl?.endRefreshing()
        self.collectionView.bottomRefreshControl?.endRefreshing()
    }
    
    func setEmptyFeed() {
        self.noFeedAvailable.text = "Conteúdo não disponível"
        self.noFeedAvailable.isHidden = false
    }
    
    func setUser(user: User) {
        self.user = user
        self.collectionView.reloadData()
    }
    
    func showMessage(message: String, isError: Bool){
        let alert = AlertUtils.getAlertOnlyForOkButton(title: "DevTecnonutri", message: message, isError: isError)
        self.present(alert, animated: true, completion: nil)
    }
}

extension UserDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        let height = StringUtils.getTextHeightForView(text: user.name as NSString, width: width - 32.0, font: UIFont(name: "HelveticaNeue-Light", size: 16.0)!)
        
        return CGSize(width: width, height: 244 + height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if(indexPath.row == user.items.count - 1){
            collectionView.bottomRefreshControl?.beginRefreshing()
            self.incrementDataFromServer()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.user.items[indexPath.item]
        let feedDetailViewController = FeedDetailViewController()
        feedDetailViewController.item = item
        self.navigationController?.pushViewController(feedDetailViewController, animated: true)
    }
}

extension UserDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCollectionCell", for: indexPath) as! FeedCollectionViewCell
        
        let item = user.items[indexPath.row]
        cell.setupCell(item: item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "userHeaderCell", for: indexPath) as! UserHeaderCollectionReusableView
        
        headerView.setupCell(user: self.user)
        
        return headerView
    }
    
    
}
