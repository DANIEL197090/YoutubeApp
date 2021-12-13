//
//  VideoCell.swift
//  YoutubeApp
//
//  Created by Decagon on 10/12/2021.
//

import UIKit

class VideoCell : BaseCell {
  
  var video : Video? {
    didSet {
      titleLabel.text = video?.title
      setupThumbNailImage()
     // thumbnailImageView.image = UIImage(named: (video?.thumbNailImageName)!)
       setupProfileImage()
//      if let profileImageName =  video?.channel?.profileImageName {
//        profileImageView.image = UIImage(named: (profileImageName))
//      }
      
      if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfView {
      let numberFormatter  =  NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let subtitleText = "\(String(describing: channelName)) · \(numberFormatter.string(from: numberOfViews)!) views · 2 years ago  "
      subTitleLabel.text = subtitleText
    }
    }
  }
  
  //  set up profile Image
  func  setupProfileImage(){
    if let profileImageUrl = video?.channel?.profileImageName {
      profileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
    }
  }
  
  
  //  set up Thumb Nail Image
  func  setupThumbNailImage(){
    if let thumbNailImageUrl = video?.thumbNailImageName {
      thumbnailImageView.loadImageUsingUrlString(urlString: thumbNailImageUrl)
    }
  }
  var identifier = "cellId"
  
  lazy var thumbnailImageView : customImageView  = {
    let imageView =  customImageView()
    imageView.layer.cornerRadius = 10
    imageView.layer.masksToBounds =  true
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
  
  lazy var seperatorView : UIView  = {
    let seperatorView = UIView()
    seperatorView .backgroundColor = .gray
    seperatorView.translatesAutoresizingMaskIntoConstraints = false
    seperatorView.frame.size.height = 1
    return seperatorView
  }()
  
  lazy var profileImageView :  customImageView  = {
    let profileImageView =  customImageView()
    profileImageView.backgroundColor = .green
    profileImageView.image = UIImage(named: "pix")
    profileImageView.layer.cornerRadius = 18
    profileImageView.layer.masksToBounds =  true
    profileImageView.contentMode = .scaleAspectFill
    profileImageView.translatesAutoresizingMaskIntoConstraints = false
    return profileImageView
  }()
  
  lazy var titleLabel : UILabel = {
    let titleLabel = UILabel()
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.numberOfLines = 2
    return titleLabel
  }()
  
  lazy var subTitleLabel : UITextView = {
    let subtitleLabel = UITextView()
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    subtitleLabel.text = "Mbata Ifeanyi - 1,635,323 views - 2 years"
    subtitleLabel.textColor = .lightGray
    return subtitleLabel
  }()
  
  override func setupView() {
    backgroundColor = UIColor.green
    addSubview(thumbnailImageView)
    addSubview(seperatorView )
    addSubview(profileImageView)
    addSubview(titleLabel)
    addSubview(subTitleLabel)
      thumbnailImageView.anchorWithConstantsToTop(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 50, leftConstant: 16, bottomConstant: 80, rightConstant: 16)
  
    seperatorView .anchorWithConstantsToTop(top:  thumbnailImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 65, leftConstant: 0, bottomConstant: 10, rightConstant: 0)
    
    profileImageView.anchorWithConstantsToTop(top: thumbnailImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right:  titleLabel.leftAnchor, topConstant: 10, leftConstant: 16, bottomConstant: 20, rightConstant: 10)
    
    titleLabel.anchorWithConstantsToTop(top: thumbnailImageView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 5, leftConstant: 60, bottomConstant: 40, rightConstant: 16)
    
    subTitleLabel.anchorWithConstantsToTop(top: thumbnailImageView.bottomAnchor, left: leftAnchor, bottom:  bottomAnchor, right: rightAnchor, topConstant: 30, leftConstant: 60, bottomConstant: 20, rightConstant: 16)
  }

}



