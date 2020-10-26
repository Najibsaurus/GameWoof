//
//  Gaming+CoreDataClass.swift
//  Gaming
//
//  Created by Najib on 17/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation
import CoreData


@objc(Gaming)
public class Gaming: NSManagedObject{
    
    convenience init(id: Int, background_image: String? = nil, name:String, released: String, rating: Double, context: NSManagedObjectContext) {
        self.init(entity: Gaming.entity(), insertInto: context)
        self.id = Int64(id)
        self.background_image = background_image
        self.name = name
        self.released = released
        self.rating = rating
    }
    
}

