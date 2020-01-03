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
    
    
    var interest: Interest! {
        didSet {
            self.updateUI()
        }
    }
    
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
            self.featuredImageView.image = UIImage.init(named: "image")
        }

        var title = self.dataSource.title ?? "Unknown Name"
        var artist = "By \(self.dataSource.artist ?? "Unknown Artist")"
        var time = (Double(self.dataSource.playCount)/3600) * self.dataSource.playbackDuration
        var listened = "Hours Listened: \(Double(round(100*time)/100)))"
        var final = "\(title)\n\n\(artist)\n\n\(listened)"
        interestTitleLabel.text = final
        
    }
    
}
