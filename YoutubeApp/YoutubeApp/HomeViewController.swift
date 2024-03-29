//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Decagon on 10/12/2021.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
  
  let titles = ["Home", "Trending", "Subcription","Profile"]
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    navigationItem.title = "Home"
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height:
                                            view.frame.height))
    titleLabel.text = "   Home"
    titleLabel.textColor = .white
    navigationItem.titleView = titleLabel
    titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.backgroundColor = .red
    navigationController?.navigationBar.isTranslucent =  false
    navigationController?.navigationBar.tintColor = .red
    collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cellId")
    collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: "trendingCellId")
    collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: "SubscriptionCellId")
    setupMenuBar()
    setupNavBarButtons()
    
  }
  
  lazy var menuBar: MenuBar = {
    let menu = MenuBar()
    menu.backgroundColor = .red
    menu.homeController = self
    return menu
  }()
  
  func setupNavBarButtons() {
    let   searchIcon  = UIImage(systemName: "pencil")?.withRenderingMode(.alwaysOriginal)
    let  searchBarButtonItem = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(pencilClicked))
    
    let moreBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    //set flow Layout
    if let  flowLayout =  collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
      flowLayout.scrollDirection = .horizontal
      flowLayout.minimumLineSpacing = 0
    }
    collectionView.isPagingEnabled = true
  }
  
  //let settingLauncher = SettingsLauncher()
  lazy var  settingLauncher : SettingsLauncher = {
    let launcher = SettingsLauncher()
    launcher.homeController = self
    return launcher
  }()
  
  @objc func handleSearch() {
    // show menu bar
    settingLauncher.showSettings()
  }
  
  @objc  func pencilClicked() {
    scrollToMenuIndex(menuIndex: 2)
  }
  
  
  func scrollToMenuIndex(menuIndex: Int){
    collectionView.isPagingEnabled = false
    self.collectionView.scrollToItem(at:IndexPath(item: menuIndex, section: 0), at: .left, animated: true)
    setTitleForIndex(Index: menuIndex)
  }
  
  func showSettingController(setting : Settings) {
    let settingsController = SettingsViewController()
    settingsController.navigationItem.title = setting.name.rawValue
    navigationController?.pushViewController(settingsController, animated: true)
  }
  
  
  private func  setupMenuBar() {
    view.addSubview(menuBar)
    // navigationController?.hidesBarsOnSwipe = true
    menuBar.anchorWithConstantsToTop(top: view.topAnchor, left: view.leftAnchor, bottom:  view.topAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: -40, rightConstant: 0)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    // print(scrollView.contentOffset.x )
    collectionView.isPagingEnabled = true
    menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
  }
  
  private func setTitleForIndex(Index: Int) {
    if let  titleLabel = navigationItem.titleView as?  UILabel {
      titleLabel.text = titles[Int(Index)]
    }
  }
  
  override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    let index =  targetContentOffset.pointee.x  / view.frame.width
    menuBar.collectionView.selectItem(at:IndexPath(item: Int(index), section: 0),  animated: true, scrollPosition: UICollectionView.ScrollPosition.right)
    print(targetContentOffset.pointee.x  / view.frame.width)
    setTitleForIndex(Index: Int(index))
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    4
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier : String
    if indexPath.item  == 1 {
      identifier = "trendingCellId"
    } else if indexPath.item == 2 {
      identifier =  "SubscriptionCellId"
    } else {
      identifier =  "cellId"
    }
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //  let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: view.frame.width, height: view.frame.height - 50)
  }
  
}

