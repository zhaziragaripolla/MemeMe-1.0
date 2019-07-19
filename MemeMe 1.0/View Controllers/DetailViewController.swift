//
//  DetailViewController.swift
//  MemeMe 1.0
//
//  Created by Zhazira Garipolla on 7/17/19.
//  Copyright © 2019 Zhazira Garipolla. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    var id: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    func setupView() {
        guard let id = id else {
            print ("ID of meme is not set to DetailVC")
            return
        }
        memeImageView.image = MemeStorage.shared.memedImage(id)
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(startEditingMeme))
    }
    
    @objc func startEditingMeme() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as? MemeEditorViewController else {
            print("Unable to instantiate MemeEditorVC")
            return
        }
        // Need to send to MemeEditor an original image
        if let id = id {
            vc.image = MemeStorage.shared.getOriginalImage(id)
        }
        present(vc, animated: true)
        
    }
}
