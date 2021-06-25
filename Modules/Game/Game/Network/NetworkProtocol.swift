//
//  NetworkProtocol.swift
//  Game
//
//  Created by Najib Abdillah on 24/06/21.
//
import Foundation

public protocol NetworkProtocol: AnyObject {
    var url: URL? {get set}
    func getRequest<T: Decodable>(completion: @escaping (Result<T, NSError>) -> ())
}
