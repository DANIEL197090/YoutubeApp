//
//  settingsCell.swift
//  YoutubeApp
//
//  Created by Decagon on 14/12/2021.
//

import UIKit

class settingsCell: BaseCell {
  
  override var isHighlighted: Bool {
    didSet {
      backgroundColor = isHighlighted ? .lightGray : .white
      nameLabel.textColor  = isHighlighted ? .white : .black
      imageIcon.tintColor = isHighlighted ?.white : .black
    }
  }
  
  var settingsdetails : Settings? {
    didSet {
      nameLabel.text = settingsdetails?.name
      if let imageName =  settingsdetails?.imageIcon{
        imageIcon.image = UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate)
        imageIcon.tintColor = .black
      }
     
    }
  }
 
  lazy var nameLabel: UILabel = {
      let nameLabel = UILabel()
    nameLabel.text = "Settings"
    nameLabel.font =  UIFont.boldSystemFont(ofSize: 15)
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    return nameLabel
  }()

  let imageIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "gearshape.fill")
    imageView.sizeToFit()
    imageView.tintColor = .black
    return imageView
  }()
  
  
  override func setupView() {
    super.setupView()
 
    addSubview(nameLabel)
    addSubview(imageIcon)
    nameLabel.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 2, leftConstant: 45, bottomConstant: 2, rightConstant: 0)
    
    imageIcon.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nameLabel.leftAnchor, topConstant: 12, leftConstant: 5, bottomConstant: 12, rightConstant: 20)
  }
  
}
