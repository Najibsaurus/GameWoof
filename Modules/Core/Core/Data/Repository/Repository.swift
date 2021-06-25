//
//  Repository.swift
//  Core
//
//  Created by Najib Abdillah on 24/06/21.
//

import RxSwift

public protocol Repository {
    associatedtype Request
    associatedtype Response
    
    func execute(request: Request) -> Observable<Response>
    
}
