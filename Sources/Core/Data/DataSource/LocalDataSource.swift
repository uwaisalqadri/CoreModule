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

  func list(request: String?) -> AnyPublisher<[Response], Error>
  func add(entity: Response) -> AnyPublisher<Bool, Error>
  func delete(id: String) -> AnyPublisher<Bool, Error>
  func isFavorited(id: String) -> AnyPublisher<Bool, Error>
}
