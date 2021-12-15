//
//  settingsLauncher.swift
//  YoutubeApp
//
//  Created by Decagon on 13/12/2021.
//

import UIKit

class Settings : NSObject {
  let name: SettingsName
  let imageIcon : String
  init(name: SettingsName, imageIcon:String) {
    self.name = name
    self.imageIcon = imageIcon
  }
}

enum SettingsName: String {
  case Cancel = "Cancel"
  case  Settings = "Settings"
  case TermsAndPrivacy = "Terms & privacy policy"
  case SendFeedback = "Send Feedback"
  case Help = "Help"
  case SwitchAccount = "Switch Account"
}


class SettingsLauncher : NSObject, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource, UICollectionViewDelegate {
  
  let blackView = UIView()
  lazy var collectionView: UICollectionView =  {
    let layout = UICollectionViewFlowLayout()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.layer.cornerRadius = 20
    return collectionView
  }()
  
  let setting : [Settings] = {
    
    let cancelSettings =   Settings(name: .Cancel, imageIcon: "clear.fill")
    let swicthAccountSettings = Settings(name: .SwitchAccount, imageIcon: "person.fill")
    let helpSettings = Settings(name: .Help, imageIcon: "message.fill")
    let sendFeedBackSettings = Settings(name: .SendFeedback, imageIcon: "message.fill")
    let settingsSettings = Settings(name: .Settings, imageIcon: "gearshape.fill")
    let TermsPrivacyPolicySettings = Settings(name: .TermsAndPrivacy, imageIcon:"lock.fill" )
    return [settingsSettings, swicthAccountSettings, helpSettings, sendFeedBackSettings, TermsPrivacyPolicySettings,cancelSettings]
    
  }()
  
  let cellHeight: CGFloat = 50
  var homeController : HomeController?
  @objc func showSettings() {
    // show menu bar
    if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first{
      blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
      blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
      
      window.addSubview(blackView)
      window.addSubview(collectionView)
      
      let height : CGFloat =  CGFloat(CGFloat(setting.count) * cellHeight)
      let y = window.frame.height - height
      collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
      
      blackView.frame = window.frame
      blackView.alpha = 0
      
      UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
        self.blackView.alpha = 1
        self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
      }, completion: nil)
    }
  }
  
  // dismiss collection view and background color
  @objc func  handleDismiss(settings: Settings) {
    UICollectionView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
      self.blackView.alpha = 0
      UICollectionView.animate(withDuration: 0.5, animations: {
        if let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
          self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }
      },completion: { [self] (completion:  Bool) in
        // move to next screen
       
        if settings.name != .Cancel {
        homeController?.showSettingController(setting: settings)
        }
      }
      )
    }
  }
  
  override init() {
    super.init()
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(settingsCell.self, forCellWithReuseIdentifier: "cellId")
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return setting.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! settingsCell
    let settings = setting[indexPath.item]
    cell.settingsdetails = settings
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //  let height = (view.frame.width - 16 - 16) * 9 / 16
    return CGSize(width: collectionView.frame.width, height: cellHeight)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let settings = setting[indexPath.item]
    handleDismiss(settings: settings)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}
