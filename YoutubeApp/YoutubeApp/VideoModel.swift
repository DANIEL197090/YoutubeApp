//
//  VideoModel.swift
//  YoutubeApp
//
//  Created by Decagon on 12/12/2021.
//

import UIKit

class Video : NSObject {
  var thumbNailImageName : String?
  var title: String?
  var numberOfView: NSNumber?
  var uploadDate: NSDate?
  var channel : Channel?
}


class Channel:  NSObject {
  var name: String?
  var profileImageName: String?
}
