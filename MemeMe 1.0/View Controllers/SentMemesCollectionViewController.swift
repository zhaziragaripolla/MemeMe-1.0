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
        
        setupCollectionView()
        setupBarButtonItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupCollectionView() {
        let space: CGFloat = 2.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        let orientation = UIDevice.current.orientation
        let dimension = UIDeviceOrientation.portrait == orientation ? ((view.frame.size.width - (space)) / 2.0) : ((view.frame.size.height - (space)) / 2.0)
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(startMemeEditor))
    }
    
    @objc func startMemeEditor() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as? MemeEditorViewController else {
            print("Unable to instantiate MemeEditorVC")
            return
        }
        present(vc, animated: true)
    }
    
}
extension SentMemesCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeStorage.shared.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MemeCollectionViewCell
        cell.imageView.image = MemeStorage.shared.memedImage(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            print("Unable to instantiate DetailVC")
            return
        }
        vc.id = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
