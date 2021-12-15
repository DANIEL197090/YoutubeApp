//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Decagon on 10/12/2021.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
  
  var videos : [Video]?
  
  func fetchData(){
    ApiService.sharedInstance.fetchVideos { (video: [Video]) in
      self.videos = video
      self.collectionView.reloadData()
    }
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
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
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "CellId")
    setupMenuBar()
    setupNavBarButtons()
  }
  
  let menuBar: MenuBar = {
    let menu = MenuBar()
    menu.backgroundColor = .red
    return menu
  }()
  
  func setupNavBarButtons() {
    let   searchIcon  = UIImage(systemName: "pencil")?.withRenderingMode(.alwaysOriginal)
    let  searchBarButtonItem = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(handleSearch))
    
    let moreBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.down")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
    navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
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
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as? VideoCell else {return UICollectionViewCell()}
    cell.video = videos?[indexPath.row]
    cell.backgroundColor = .white
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //  let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: view.frame.width, height: 350)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}

