//
//  Converter.swift
//  Gaming
//
//  Created by Najib Abdillah on 24/06/21.
//  Copyright © 2021 Najib. All rights reserved.
//

import Foundation

class Converter {
    
    static func getBoolFromAny(paramAny: Any) -> Bool {
        let result = "\(paramAny)"
        return result == "1"
    }
}
