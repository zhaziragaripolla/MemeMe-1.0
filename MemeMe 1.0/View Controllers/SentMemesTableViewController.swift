//
//  MemeTableViewController.swift
//  MemeMe 1.0
//
//  Created by Zhazira Garipolla on 7/16/19.
//  Copyright © 2019 Zhazira Garipolla. All rights reserved.
//

import UIKit

class SentMemesTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var img: UIImage?
    var path: IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sent memes"
        tableView.rowHeight = 240
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(MemeTableViewCell.self, forCellReuseIdentifier: "cell")
    }

}

extension SentMemesTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(MemeStorage.sharedInstance.count)
        return MemeStorage.sharedInstance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemeTableViewCell
        let image = MemeStorage.sharedInstance.memedImage(indexPath.row)
        cell.memeImageView.image = image
        cell.titleLabel.text = MemeStorage.sharedInstance.name(indexPath.row)
        path = indexPath
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let image = MemeStorage.sharedInstance.memedImage(indexPath.row)
        vc.memeToShow = image
        navigationController?.pushViewController(vc, animated: true)
    }
}
