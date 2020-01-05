//
//  InterestCollectionViewCell.swift
//  Music Memory
//
//  Created by Justin Gluska on 12/25/19.
//  Copyright © 2019 Justin Gluska. All rights reserved.
//

import UIKit
import MediaPlayer

class InterestCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    
    @IBOutlet weak var playSongOutlet: UIButton!
    @IBAction func playSong(_ sender: Any) {
        var temp:[String] = []
        temp.append(dataSource.playbackStoreID)
        let musicPlayer = MPMusicPlayerApplicationController.applicationQueuePlayer
        musicPlayer.setQueue(with: temp)
        musicPlayer.play()
    }
    
//    var interest: Interest! {
//        didSet {
//            self.updateUI()
//        }
//    }
    
    var dataSource: MPMediaItem! {
        didSet {
            self.updateUI()
        }
    }
    
    /*func updateUI(){
        
        if let interest = interest {
            featuredImageView.image = interest.featuredImage
            interestTitleLabel.text = interest.title
        }
        else {
            featuredImageView.image = nil
            interestTitleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
        backgroundColorView.layer.cornerRadius = 30.0
        backgroundColorView.clipsToBounds = true
        featuredImageView.layer.cornerRadius = 30.0
        featuredImageView.clipsToBounds = true
    }*/
    
    func updateUI(){
        
        if let image = self.dataSource.artwork?.image(at: featuredImageView.frame.size) {
            self.featuredImageView.image = image
        } else {
            self.featuredImageView.image = UIImage.init(named: "unknownArtwork")
        }
        
        if (self.dataSource.playbackStoreID == "0"){
            playSongOutlet.isEnabled = false
            playSongOutlet.isHidden = true
        }
        
        // Song Added Properties
        
        let date = Date()
        let calendar = Calendar.current
        let year = calendar.component(.year, from: self.dataSource.dateAdded)
        let timeLastPlayed = self.dataSource.lastPlayedDate ?? date
        let format = DateFormatter()
        format.dateFormat = "MM/dd/yyyy"
        let lastPlayedFormatted = format.string(from: timeLastPlayed)
        
        let title = self.dataSource.title ?? "Unknown Name"
        let artist = "By \(self.dataSource.artist ?? "Unknown Artist")"
        let time = (Double(self.dataSource.playCount)/3600) * self.dataSource.playbackDuration
        let listened = "Hours Listened: \(Double(round(100*time)/100))"
        let plays = self.dataSource.playCount
        var final = "From \(year):\n\n\(title)\n\n\(artist)\n\n\(plays) Plays\n\nLast Played on \(lastPlayedFormatted)"
        interestTitleLabel.text = final
        
    }
    
}
