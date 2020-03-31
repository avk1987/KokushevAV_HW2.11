//
//  NetworkManager.swift
//  KokushevAV_HW2.11
//
//  Created by Александр Кокушев on 31.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init () {}
    
    func fetchData(completionHandler: @escaping ([Photo]) -> Void) {
        
        let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=300&camera=MAST&api_key=egev1nxQLGhjiiZplbTwUFkDzRNhyMqMJr2ek1b3"
        var loadedPhotos: [Photo] = []
        
        AF.request(url)
            .validate()
            .responseJSON { responseData in
                
                switch responseData.result {
                    
                case .success(let value):
                    guard let jsonData = value as? [String: [Any]] else { return }
                    guard let photos = jsonData["photos"] as? [[String: Any]] else { return }
                    
                    for photo in photos {
                        let rover = photo["rover"] as! [String: Any]
                        loadedPhotos.append(Photo(id: photo["id"] as! Int,
                                                  sol: photo["sol"] as! Int,
                                                  imgSrc: photo["img_src"] as! String,
                                                  earthDate: photo["earth_date"] as! String,
                                                  rover: rover["name"] as! String))
                    }
                    
                    completionHandler(loadedPhotos)
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    func loadPhoto(url: String, completionHandler: @escaping (UIImage) -> Void) {
        AF.request(url)
            .validate()
            .response { response in
                
                switch response.result {
                case.success(let responseData):
                    guard let imgData = responseData else { return }
                    guard let img = UIImage(data: imgData) else { return }
                    completionHandler(img)
                    
                case.failure(let error):
                    print(error)
                }         
        }
    }
}

