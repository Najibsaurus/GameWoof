//
//  CustomResults+Ext.swift
//  Core
//
//  Created by Najib Abdillah on 24/06/21.
//

import RealmSwift

public extension Results {
    
    func toArray() -> [Element] {
        return compactMap { $0 }
    }
}
