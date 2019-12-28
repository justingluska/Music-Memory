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
    let cellScale: CGFloat = 0.6
    
    @IBOutlet weak var songsFromTodayLabel: UILabel!

    
    override func viewDidLoad(){
        super.viewDidLoad()
        try? VideoBackground.shared.play(view: view, videoName: "statsNew", videoType: "mp4")
        collectionView.dataSource = self
        collectionView.layer.cornerRadius = 10
        let today = Date()
        let cal = Calendar.current
        let day = cal.ordinality(of: .day, in: .year, for: today)
        songsFromTodayLabel.text = "Songs Added On Day \(day!)"
//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScale)
//        let cellHeight = floor(screenSize.height * cellScale)
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.width - cellHeight) / 2.0
//        
//        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        collectionView.contentInset = UIEdgeInsets(top: insetY, left:insetX, bottom:insetY, right:insetX)
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

extension InterestsViewController : UIScrollViewDelegate, UICollectionViewDelegate
{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}
