//
//  Extensions.swift
//  YoutubeApp
//
//  Created by Decagon on 12/12/2021.
//

import UIKit

extension UIView {
    func anchorToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        anchorWithConstantsToTop(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    func anchorWithConstantsToTop(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil,
                                  bottom: NSLayoutYAxisAnchor? = nil,
                                  right: NSLayoutXAxisAnchor? = nil,
                                  topConstant: CGFloat = 0,
                                  leftConstant: CGFloat = 0,
                                  bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true
        }
    }
}


let imageCache = NSCache<AnyObject, AnyObject> ()
var imageUrlString : String?
class customImageView:  UIImageView {
  var imageUrlString : String?
  func  loadImageUsingUrlString(urlString: String){
    imageUrlString = urlString
    guard let url = URL(string: urlString) else {
      return
    }
    image = nil
    if let imageFromCache  = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
      self.image = imageFromCache
      return
    }
    
    URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
      guard let data = data , error == nil else {
        return
      }
      
      DispatchQueue.main.async {
        let imageToCache  = UIImage(data: data)
        if self?.imageUrlString == urlString {
          self?.image = imageToCache
        }
        imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
     
      }
    }.resume()
  }
  
  
}
