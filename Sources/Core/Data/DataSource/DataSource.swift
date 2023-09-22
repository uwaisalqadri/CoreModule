//
//  DataSource.swift
//  
//
//  Created by Uwais Alqadri on 10/17/21.
//

import Foundation
import Combine

public protocol DataSource {
  associatedtype Request
  associatedtype Response

  func execute(request: Request?) async throws -> Response
}
