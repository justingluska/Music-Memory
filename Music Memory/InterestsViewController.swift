//
//  InterestsViewController.swift
//  Music Memory
//
//  Created by Justin Gluska on 12/25/19.
//  Copyright © 2019 Justin Gluska. All rights reserved.
//

import UIKit

class InterestsViewController: UIViewController
{
    @IBOutlet weak var collectionView: UICollectionView!
    var interests = Interest.fetchInterests()
    
    override func viewDidLoad(){
        super.viewDidLoad()
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
