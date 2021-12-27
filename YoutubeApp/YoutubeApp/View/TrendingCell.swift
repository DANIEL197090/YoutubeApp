//
//  TrendingCell.swift
//  YoutubeApp
//
//  Created by Decagon on 16/12/2021.
//

import UIKit

class TrendingCell: FeedCell {
  override func fetchData() {
      ApiService.sharedInstance.fetchTrendingVideos {  (video: [Video]) in
        self.videos = video
        self.collectionView.reloadData()
      }
  }
}
