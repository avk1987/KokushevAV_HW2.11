//
//  Photo.swift
//  KokushevAV_HW2.11
//
//  Created by Александр Кокушев on 31.03.2020.
//  Copyright © 2020 Александр Кокушев. All rights reserved.
//

struct Photo {
    var id: Int?
    var sol: Int?
    var imgSrc: String?
    var earthDate: String?
    var rover: Rover?
    
    init(dict: [String: Any]) {
        id = dict["id"] as? Int
        sol = dict["sol"] as? Int
        imgSrc = dict["img_src"] as? String
        earthDate = dict["earth_date"] as? String
        rover = Rover(roverDict: dict["rover"] as? [String: Any] ?? ["":""])
    }
}

struct Rover {
    var name: String?

    init(roverDict: [String: Any]) {
        name = roverDict["name"] as? String
    }
    
}
