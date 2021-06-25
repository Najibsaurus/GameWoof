//
//  DataSource.swift
//  Core
//
//  Created by Najib Abdillah on 24/06/21.
//

import RxSwift


public protocol DataSource {
    
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) -> Observable<Response>
    
}
