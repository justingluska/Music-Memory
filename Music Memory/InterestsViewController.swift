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
import GoogleMobileAds
import StoreKit

class InterestsViewController: UIViewController
{
    var interstitial: GADInterstitial!
    @IBOutlet weak var shareOutlet: UIButton!
    @IBOutlet weak var backOutlet: UIButton!
    
    
    @IBAction func shareSongs(_ sender: Any) {
        var songName = [String]()
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
        if songName.count == 0 {
            let alert = UIAlertController(title: "No Songs Today", message: "You didn't add any new music on this day. Check back again tomorrow to share your music!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if songName.count != 1{
            for element in songName.indices.dropLast() {
                songString = songName[element] + ", " + songString
            }
            songString = songString + "and " + songName[(songName.count-1)]
        }
        else if songName.count == 1{
            songString = songName[0]
        }
        
        let items: [Any] = ["I discovered the music \(songString) on this day of the year. See your throwback songs by downloading musicHop!", URL(string: "https://apps.apple.com/us/app/music-hop-daily-throwbacks/id1494063897")!]
        // , URL(string: "https://apps.apple.com/us/app/music-hop-daily-throwbacks/id1494063897")!
        /// To add the album artwork, use the code below
        // , imageViewOutlet.image!
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
    }
    
    @IBOutlet weak var todaysDate: UILabel!
    

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
    
    @IBOutlet weak var pauseOutlet: UIButton!
    override func viewDidLoad(){
        if UIDevice.current.userInterfaceIdiom == .pad {
            shareOutlet.isHidden = true
        }
        super.viewDidLoad()
        try? VideoBackground.shared.play(view: view, videoName: "starstrip", videoType: "mp4")
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "LLL"
        let cal = Calendar.current
        let mon = cal.component(.month, from: date)
        let monthName = DateFormatter().monthSymbols[mon - 1]
        let day = cal.component(.day, from: date)
        todaysDate.text = "\(monthName) \(day)"
        collectionView.dataSource = self
        shareOutlet.layer.cornerRadius = 12
        backOutlet.layer.cornerRadius = 12
        collectionView.reloadData()
        if self.dataSource.music == []{
            noSongLabel.text = "You haven't added any songs on this day today! Check back tomorrow!"
            noSongLabel.isHidden = false
        }
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-9134328104554845/9661741527")
        let request = GADRequest()
        interstitial.load(request)
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            self.interstitial.present(fromRootViewController: self)
        }
        let temp = Int.random(in: 0 ..< 10)
        if temp == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                SKStoreReviewController.requestReview()
            }
        }
        
    }
    
    @IBOutlet weak var noSongLabel: UITextView!
    
    
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


/// Not really sure what this does. I found it on YouTube
extension InterestsViewController : UIScrollViewDelegate, UICollectionViewDelegate
{
//    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
//        var offset = targetContentOffset.pointee
//        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
//        let roundedIndex = round(index)
//        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
//        targetContentOffset.pointee = offset
//    }
}
