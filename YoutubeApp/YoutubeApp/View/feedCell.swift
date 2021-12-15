//
//  feedCell.swift
//  YoutubeApp
//
//  Created by Decagon on 15/12/2021.
//

import UIKit
class FeedCell : BaseCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  lazy var collectionView: UICollectionView =  {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.layer.cornerRadius = 10
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  
  var videos : [Video]?
  // fetch data from api
  func fetchData(){
    ApiService.sharedInstance.fetchVideos { (video: [Video]) in
      self.videos = video
      self.collectionView.reloadData()
    }
  }
  
  override func setupView() {
    super.setupView()
    fetchData()
    addSubview(collectionView)
    collectionView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 20, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "CellId")
    backgroundColor = .brown
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return videos?.count ?? 0
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as? VideoCell else {return UICollectionViewCell()}
    cell.video = videos?[indexPath.row]
    cell.backgroundColor = .white
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //  let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: frame.width, height: 350)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
