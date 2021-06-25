//
//  Mapper.swift
//  Core
//
//  Created by Najib Abdillah on 24/06/21.
//

import Foundation

public protocol Mapper {
    
    associatedtype Request
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(request: Request?, response: Response) -> Entity
    func transformResponseToDomain(response: Response) -> Domain
    func transformEntityToDomain(entity: Entity) -> Domain
    func transformDomainToEntity(domain: Request) -> Entity
    
}
