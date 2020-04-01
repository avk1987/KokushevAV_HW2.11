//
//  PhotoViewController.swift
//  KokushevAV_HW2.11
//
//  Created by Александр Кокушев on 01.04.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    
    @IBOutlet var photoImg: UIImageView!
    @IBOutlet var id: UILabel!
    @IBOutlet var sol: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var rover: UILabel!
    
    var imgURL: String!
    var inId: String!
    var inSol: String! 
    var inDate: String!
    var inRover: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        id.text    = inId
        sol.text   = inSol
        date.text  = inDate
        rover.text = inRover
        
        NetworkManager.shared.loadPhoto(url: imgURL, completionHandler: { loadedphoto in
             DispatchQueue.main.async {
                self.photoImg.image = UIImage(data: loadedphoto)
             }
         })
    }
}
