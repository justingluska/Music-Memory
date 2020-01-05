//
//  InterestsViewController.swift
//  Music Memory
//
//  Created by Justin Gluska on 12/25/19.
//  Copyright © 2019 Justin Gluska. All rights reserved.
//

import UIKit
import SwiftVideoBackground
import MediaPlayer

class InterestsViewController: UIViewController
{
    
    @IBOutlet weak var shareOutlet: UIButton!
    @IBOutlet weak var backOutlet: UIButton!
    
    var songName = [String]()
    @IBAction func shareSongs(_ sender: Any) {
        guard let songs = MPMediaQuery.songs().items
                   else {
                   return
               }
        var songString:String = ""
        
                for song in songs {
                    
                let today = Date()
                    let then = song.dateAdded
                    let calendar = Calendar.current
                    let day = calendar.component(.day, from: then)
                    let month = calendar.component(.month, from:then)
                    
                    if (month == calendar.component(.month, from: today)){
                        if (day == calendar.component(.day, from: today)){
                            songName.append(song.title!)
                            }
                        }
                }
       
        for element in songName.indices.dropLast() {
            songString = songName[element] + ", " + songString
        }
        songString = songString + "and " + songName[(songName.count-1)]
        let items: [Any] = ["I discovered the music \(songString) on this day of the year. See your throwback songs by downloading musicHop on the App Store!"]
        // , URL(string: "https://www.justingluska.com")!
        /// To add the album artwork, use the code below
        // , imageViewOutlet.image!
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(ac, animated: true)
    }
    
    

    @IBAction func goBackButton(_ sender: UIButton) {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let resultVC = main.instantiateViewController(withIdentifier: "main") as? ViewController
        resultVC?.modalPresentationStyle = UIModalPresentationStyle.fullScreen
        self.present(resultVC!, animated: true, completion: nil)
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    //var interests = Interest.fetchInterests()
    let cellScale: CGFloat = 0.6
    
    @IBOutlet weak var songsFromTodayLabel: UILabel!
    
    @IBOutlet weak var imageCollect: UIImageView!
    var dataSource : MusicWithDate = MusicWithDate()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        try? VideoBackground.shared.play(view: view, videoName: "blue", videoType: "mp4")
        collectionView.dataSource = self
        let today = Date()
        let cal = Calendar.current
        shareOutlet.layer.cornerRadius = 12
        backOutlet.layer.cornerRadius = 12
        collectionView.reloadData()
    }
    
    
}

extension InterestsViewController: UICollectionViewDataSource
{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return interests.count
        return self.dataSource.music.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        /*let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        let interest = interests[indexPath.item]
        
        cell.interest = interest
        
        return cell*/
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "InterestCollectionViewCell", for: indexPath) as! InterestCollectionViewCell
        let interest = self.dataSource.music[indexPath.item]
        
        //cell.interest = interest
        cell.dataSource = interest
        
        return cell
    }
    
}

/*extension InterestsViewController : UIScrollViewDelegate, UICollectionViewDelegate
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
}*/
