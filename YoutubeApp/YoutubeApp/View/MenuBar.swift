//
//  MenuBar.swift
//  YoutubeApp
//
//  Created by Decagon on 12/12/2021.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
  
  lazy var collectionView : UICollectionView = {
    let layout = UICollectionViewFlowLayout ()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .red
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
  }()
  var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
  
  func setUpHorizontalBar() {
    let horizontalBarView = UIView()
    horizontalBarView.backgroundColor = .white
    horizontalBarView.translatesAutoresizingMaskIntoConstraints = false
    addSubview(horizontalBarView)
    horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor)
    horizontalBarLeftAnchorConstraint?.isActive = true
    horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5).isActive = true
    horizontalBarView.heightAnchor.constraint(equalTo: heightAnchor, constant: 4).isActive = true
    horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4).isActive = true
  }
  
  let imagesNames = ["house.fill","message.fill","globe.americas.fill","person.fill"]
  var homeController : HomeController?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpHorizontalBar()
    collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cellId")
    addSubview(collectionView)
    collectionView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 8, rightConstant: 0)
    let selectedIndexPath =  NSIndexPath(item: 0, section: 0)
    collectionView.selectItem(at: selectedIndexPath as IndexPath, animated: true, scrollPosition: .bottom)
    //    collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    //    collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MenuCell
    cell.imageView.image = UIImage(systemName: imagesNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
    cell.tintColor = .gray
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width / 4, height: frame.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    homeController?.scrollToMenuIndex(menuIndex: indexPath.item)
   
  }
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
