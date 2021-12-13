//
//  MenuCell.swift
//  YoutubeApp
//
//  Created by Decagon on 12/12/2021.
//

import UIKit

class MenuCell: BaseCell {
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "house")
    imageView.sizeToFit()
    imageView.tintColor = .gray
    return imageView
  }()
  
  override var isHighlighted: Bool {
    didSet {
      imageView.tintColor = isHighlighted ? .white : .gray
    }
  }
  
  override var isSelected: Bool {
    didSet {
      imageView.tintColor = isSelected ? .white : .gray
    }
  }
  
  override func setupView() {
    super.setupView()
    backgroundColor = .red
    addSubview(imageView)
    imageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 10, leftConstant: 40, bottomConstant: 10, rightConstant: 40)
  }
  
}
