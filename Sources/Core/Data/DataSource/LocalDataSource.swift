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

  func list(request: String?) async throws -> [Response]
  func add(entity: Response) async throws -> Bool
  func delete(id: String) async throws -> Bool
  func isFavorited(id: String) async throws -> Bool
}
