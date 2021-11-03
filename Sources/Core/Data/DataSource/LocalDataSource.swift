//
//  LocaleDataSource.swift
//  
//
//  Created by Uwais Alqadri on 10/17/21.
//

import Foundation
import Combine

public protocol LocalDataSource {
  associatedtype Request
  associatedtype Response

  func list(request: Request?) -> AnyPublisher<[Response], Error>
  func add(entity: Response) -> AnyPublisher<Response, Error>
  func delete(entity: Response) -> AnyPublisher<Response, Error>
  func get(entityId: String) -> Response?
}
