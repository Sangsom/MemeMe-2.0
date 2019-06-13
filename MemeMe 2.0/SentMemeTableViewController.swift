//
//  MemeTableViewController.swift
//  MemeMe 2.0
//
//  Created by Rinalds Domanovs on 13/06/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UITableViewController {

    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addMeme))
    }

    // MARK: Table methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentMeme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Meme", for: indexPath)
        cell.imageView?.image = currentMeme.updatedImage
        cell.textLabel?.text = "\(currentMeme.topString) \(currentMeme.bottomString)"
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
    // MARK: Custom methods

    @objc func addMeme() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MemeEditor") as? MemeEditorViewController {
            present(vc, animated: true)
        }

    }
}
