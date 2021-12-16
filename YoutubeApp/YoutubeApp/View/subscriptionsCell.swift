//
//  subscriptionsCell.swift
//  YoutubeApp
//
//  Created by Decagon on 16/12/2021.
//

import UIKit

class SubscriptionCell: FeedCell {
  override func fetchData() {
      print("nice")
      ApiService.sharedInstance.fetchSubscriptionsVideos{  (video: [Video]) in
        self.videos = video
        self.collectionView.reloadData()
      }
  }
}

