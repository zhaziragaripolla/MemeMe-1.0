//
//  MemeCollectionViewController.swift
//  MemeMe 1.0
//
//  Created by Zhazira Garipolla on 7/16/19.
//  Copyright © 2019 Zhazira Garipolla. All rights reserved.
//

import UIKit

class SentMemesCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sent memes"
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        collectionView.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    

}
extension SentMemesCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeStorage.sharedInstance.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemeCollectionViewCell
        cell.imageView.image = MemeStorage.sharedInstance.memedImage(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let space: CGFloat = 3.0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 5
        let width = (view.frame.size.width - (2 * space)) / 3.0
        let height = (view.frame.size.height) / 3.0
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let image = MemeStorage.sharedInstance.memedImage(indexPath.row)
        detailVC.memeImageView.image = image
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
