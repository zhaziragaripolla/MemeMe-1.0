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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sent memes"
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBarButtonItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupBarButtonItems() {
        if MemeStorage.shared.count > 0 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(startTableViewEditor))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(startMemeEditor))
    }
    
    @objc func startMemeEditor() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as? MemeEditorViewController else {
            print("Unable to instantiate MemeEditorVC")
            return
        }
        present(vc, animated: true)
    }
    
    @objc func startTableViewEditor() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Done" : "Edit"
    }

}

extension SentMemesTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeStorage.shared.count
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MemeTableViewCell
        let image = MemeStorage.shared.memedImage(indexPath.row)
        cell.memeImageView.image = image
        cell.titleLabel.text = MemeStorage.shared.name(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            print("Unable to instantiate DetailVC")
            return
        }
        vc.id = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MemeStorage.shared.delete(indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
