//
//  GameUtility.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation

public class GameUtility {
    static func unwrapAny(any:Any) -> Any {
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .optional {
            return any
        }
        if mi.children.isEmpty { return NSNull() }
        let (_, some) = mi.children.first!
        return some
    }
}
