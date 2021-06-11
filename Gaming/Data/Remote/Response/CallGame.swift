//
//  CallGame.swift
//  Gaming
//
//  Created by Najib on 13/08/20.
//  Copyright © 2020 Najib. All rights reserved.
//

import Foundation

struct CallGame: Decodable {
    let count: Int
    let results: [ResultGame]
}
