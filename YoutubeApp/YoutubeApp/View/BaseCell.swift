//
//  BaseCell.swift
//  YoutubeApp
//
//  Created by Decagon on 13/12/2021.
//

import UIKit

class BaseCell : UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  func setupView() {
    
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
