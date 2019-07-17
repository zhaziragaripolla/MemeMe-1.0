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
    var memeToShow: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memeImageView.image = memeToShow
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit, target: self, action: #selector(startEditing))
        //self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func startEditing() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        vc.image = memeToShow
        present(vc, animated: true)
    }
}
