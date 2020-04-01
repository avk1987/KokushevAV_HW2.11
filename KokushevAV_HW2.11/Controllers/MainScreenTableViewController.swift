//
//  MainScreenTableViewController.swift
//  KokushevAV_HW2.11
//
//  Created by Александр Кокушев on 01.04.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit


class MainScreenTableViewController: UITableViewController {
    
    private var photos: [Photo] = [] {
        didSet {
            tableView.reloadData()
            spinner.stopAnimating()
        }
    }
    
    
    private let spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 75
        
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.backgroundView = spinner
        
        NetworkManager.shared.fetchData(completionHandler: { loadedPhotos in
            DispatchQueue.main.async {
                self.photos = loadedPhotos
            }
        })
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! PhotoCell
        
        let photo = photos[indexPath.row]
        
        cell.id.text   = String(photo.id ?? 0)
        cell.sol.text  = String(photo.sol ?? 0)
        cell.date.text = photo.earthDate ?? "0000-00-00"
        
        guard let imgSrc = photo.imgSrc else { return cell }
        
        NetworkManager.shared.loadPhoto(url: imgSrc, completionHandler: { loadedphoto in
            DispatchQueue.main.async {
                cell.photo.image = UIImage(data: loadedphoto)
            }
        })
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let destVC = segue.destination as! PhotoViewController
        let photo = photos[indexPath.row]
        
        destVC.imgURL  = photo.imgSrc ?? ""
        destVC.inId    = String(photo.id ?? 0)
        destVC.inSol   = String(photo.sol ?? 0)
        destVC.inDate  = photo.earthDate ?? "0000-00-00"
        destVC.inRover = photo.rover?.name ?? ""
        
    }
    
}
