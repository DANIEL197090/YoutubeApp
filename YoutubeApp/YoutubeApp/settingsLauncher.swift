//
//  settingsLauncher.swift
//  YoutubeApp
//
//  Created by Decagon on 13/12/2021.
//

import UIKit

class settingsLauncher : NSObject {
  let blackView = UIView()
  lazy var collectionView: UICollectionView =  {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    return collectionView
  }()
  
  
  @objc func showSettings() {
    // show menu bar
    if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      window.addSubview(blackView)
      window.addSubview(collectionView)
      
      let height : CGFloat = 200
      let y = window.frame.height - height
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: 200)
      
      
      blackView.frame = window.frame
      blackView.alpha = 0
      
      UIView.animate(withDuration: 0.5, animations: {
        self.blackView.alpha = 1
        self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }, completion: nil)
    }
  }
  @objc func  handleDismiss() {
    UIView.animate(withDuration: 0.5, animations: {
      self.blackView.alpha = 0
    }, completion: nil)
  }
  override init() {
    super.init()
  }
}
