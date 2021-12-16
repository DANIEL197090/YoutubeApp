//
//  ApiService.swift
//  YoutubeApp
//
//  Created by Decagon on 15/12/2021.
//

import UIKit

class ApiService: NSObject {
  
  static let sharedInstance = ApiService()
  
  let baseUrl =  "https://s3-us-west-2.amazonaws.com/youtubeassets"
  
  func fetchVideos(completion: @escaping  ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/home.json") { videos in
      completion(videos)
    }
  }
  

  // fetch trending videos
  func fetchTrendingVideos(completion: @escaping  ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json") { videos in
      completion(videos)
    }
  }
  
  // fetch subscriptions
  func fetchSubscriptionsVideos(completion: @escaping  ([Video]) -> ()) {
    fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json") { Video in
      completion(Video)
    }
  }
  
  
  func fetchFeedForUrlString(urlString: String, completion: @escaping  ([Video]) -> ()) {
    let url = NSURL(string: urlString)
    
    URLSession.shared.dataTask(with: url! as URL) { data, response, error in
      if error != nil  {
        print(error as Any)
      }
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
         var videos = [Video]()
        
        for dictionary in json as! [[String : AnyObject]] {
          let video =  Video()
          let channel = Channel()
          let channelDictionary = dictionary["channel"] as? [String: AnyObject]
          video.title = dictionary["title"] as? String
          video.numberOfView = dictionary["number_of_views"] as? NSNumber
          video.thumbNailImageName = dictionary["thumbnail_image_name"] as? String
          channel.profileImageName = channelDictionary?["profile_image_name"] as? String
          channel.name = channelDictionary?["name"] as? String
          video.channel = channel
          videos.append(video)
        }
        
        DispatchQueue.main.async {
             completion(videos)
        }
        
        print(json)
      }catch  let jsonError {
        print(jsonError)
      }
      
    }.resume()
    
  }
  
}
