//
//  InterestsViewController.swift
//  Music Memory
//
//  Created by Justin Gluska on 12/25/19.
//  Copyright © 2019 Justin Gluska. All rights reserved.
//

import UIKit
import SwiftVideoBackground

class InterestsViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var contentView: UIView!
    var interests = Interest.fetchInterests()
    
    @IBOutlet weak var songsFromTodayLabel: UILabel!
    override func viewDidLoad(){
        super.viewDidLoad()
        try? VideoBackground.shared.play(view: view, videoName: "stats", videoType: "mp4")
        collectionView.dataSource = self
        
    }
}

extension InterestsViewController: UICollectionViewDataSource
{
    func numberOfSection(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        let interest = interests[indexPath.item]
        
        cell.interest = interest
        
        return cell
    }
}
