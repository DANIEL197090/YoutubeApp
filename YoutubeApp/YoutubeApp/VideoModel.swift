//
//  VideoModel.swift
//  YoutubeApp
//
//  Created by Decagon on 12/12/2021.
//

import UIKit

class Video : NSObject {
  var title : String?
  var number_of_views : NSNumber?
  var thumbnail_image_name : String?
  var channel : Channel?
  var uploadDate : NSDate?
  var duration :  NSNumber?
 // var num_likes: NSNumber?

  }



class Channel:  NSObject {
  var name: String?
  var profileImageName: String?
}
