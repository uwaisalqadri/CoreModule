//
//  GetItemPresenter.swift
//  
//
//  Created by Uwais Alqadri on 10/17/21.
//

import SwiftUI
import Combine
import ComposableArchitecture

public struct Presenter<Request, Response, Interactor: UseCase>: Reducer where Interactor.Request == Request, Interactor.Response == Response {
  
  private let _useCase: Interactor
  
  public init(useCase: Interactor) {
    _useCase = useCase
  }
  
  public struct State: Equatable {
    public static func == (lhs: Presenter<Request, Response, Interactor>.State, rhs: Presenter<Request, Response, Interactor>.State) -> Bool {
      return true
    }
    
    var item: Response?
    var errorMessage: String = ""
    var isLoading: Bool = false
    var isError: Bool = false
  }
  
  public enum Action: Equatable {
    public static func == (lhs: Presenter<Request, Response, Interactor>.Action, rhs: Presenter<Request, Response, Interactor>.Action) -> Bool {
      return true
    }
    
    case fetch(request: Request)
    case success(response: Response)
    case failed(error: Error)
  }
  
  public var body: some ReducerOf<Self> {
    Reduce<State, Action> { state, action in
      switch action {
      case .fetch(let request):
        state.isLoading = true
        return .run { send in
          await fetchData(request: request, send: send)
        }
      case .success(let data):
        state.item = data
        state.isLoading = false
        return .none
      case .failed:
        state.isError = true
        state.isLoading = false
        return .none
      }
    }
  }
  
  private func fetchData(request: Request, send: Send<Action>) async {
    do {
      let response = try await self._useCase.execute(request: request)
      await send(.success(response: response))
    } catch {
      await send(.failed(error: error))
    }
  }
}

public class GetItemPresenter<Request, Response, Interactor: UseCase>: ObservableObject where Interactor.Request == Request, Interactor.Response == Response {

  private var cancellables: Set<AnyCancellable> = []

  private let _useCase: Interactor

  @Published public var item: Response?
  @Published public var errorMessage: String = ""
  @Published public var isLoading: Bool = false
  @Published public var isError: Bool = false

  public init(useCase: Interactor) {
    _useCase = useCase
  }

  public func execute(request: Request?) {
    isLoading = true
//    _useCase.execute(request: request)
//      .receive(on: RunLoop.main)
//      .sink(receiveCompletion: { completion in
//        switch completion {
//        case .failure(let error):
//          self.errorMessage = error.localizedDescription
//          self.isError = true
//          self.isLoading = false
//        case .finished:
//          self.isLoading = false
//        }
//      }, receiveValue: { item in
//        self.item = item
//        self.isLoading = false
//      })
//      .store(in: &cancellables)
  }
}
