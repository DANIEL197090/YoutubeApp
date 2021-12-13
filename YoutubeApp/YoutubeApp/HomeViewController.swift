//
//  ViewController.swift
//  YoutubeApp
//
//  Created by Decagon on 10/12/2021.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
  
//  var videos : [Video] = {
//       var KanyeChannel = Channel()
//    KanyeChannel.name = "KanyeIsTheBestChannel"
//    KanyeChannel.profileImageName = "kanye"
//
//      var blankSpaceVideo =  Video()
//    blankSpaceVideo.thumbNailImageName =  "images-5"
//    blankSpaceVideo.title = "Princess Taylor Queen"
//    blankSpaceVideo.numberOfView = 2452342243
//    blankSpaceVideo.channel = KanyeChannel
//
//  var badBloodVideo =  Video()
//    badBloodVideo.thumbNailImageName =  "pix"
//    badBloodVideo.title = "Taylor Swift - Bad blood featuring Kendrick"
//    badBloodVideo.channel = KanyeChannel
//    badBloodVideo.numberOfView = 63453463
//  return [blankSpaceVideo, badBloodVideo]
//  }()
  
  var videos : [Video]?
  
  func fetchData(){
    let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
    
    URLSession.shared.dataTask(with: url! as URL) { [self] data, response, error in
      if error != nil  {
        print(error as Any)
      }
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
        self.videos = [Video]()
      
        for dictionary in json as! [[String : AnyObject]] {
          let video =  Video()
          let channel = Channel()
          let channelDictionary = dictionary["channel"] as? [String: AnyObject]
          video.title = dictionary["title"] as? String
          video.numberOfView = dictionary["number_of_views"] as? NSNumber
          video.thumbNailImageName = dictionary["thumbnail_image_name"] as? String
          channel.profileImageName = channelDictionary?["profile_image_name"] as? String
          channel.name = channelDictionary?["name"] as? String
          video.channel = channel
          videos?.append(video)
        }
        DispatchQueue.main.async {
          self.collectionView.reloadData()
        }
     
        print(json)
      }catch  let jsonError {
          print(jsonError)
      }
    
    }.resume()
    
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
    // Do any additional setup after loading the view.
    navigationItem.title = "Home"
    let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height:
                                            view.frame.height))
    titleLabel.text = "Home"
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
  
  var settingLauncher = settingsLauncher()
  
  @objc func handleSearch() {
    // show menu bar
    settingLauncher.showSettings()
  }
  
  
  private func  setupMenuBar() {
    view.addSubview(menuBar)
    
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

