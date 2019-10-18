//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: recommendation.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Dispatch
import Foundation
import SwiftGRPC
import SwiftProtobuf

internal protocol Apisvr_RecommendationServiceGetRecommendedRecipeCall: ClientCallUnary {}

fileprivate final class Apisvr_RecommendationServiceGetRecommendedRecipeCallBase: ClientCallUnaryBase<Apisvr_GetRecommendedRecipeReq, Apisvr_GetRecommendedRecipeResp>, Apisvr_RecommendationServiceGetRecommendedRecipeCall {
  override class var method: String { return "/apisvr.RecommendationService/GetRecommendedRecipe" }
}

internal protocol Apisvr_RecommendationServiceGetRecommendedMealPlanCall: ClientCallUnary {}

fileprivate final class Apisvr_RecommendationServiceGetRecommendedMealPlanCallBase: ClientCallUnaryBase<Apisvr_GetRecommendedMealPlanReq, Apisvr_GetRecommendedMealPlanResp>, Apisvr_RecommendationServiceGetRecommendedMealPlanCall {
  override class var method: String { return "/apisvr.RecommendationService/GetRecommendedMealPlan" }
}

internal protocol Apisvr_RecommendationServiceAddCheckListItemCall: ClientCallUnary {}

fileprivate final class Apisvr_RecommendationServiceAddCheckListItemCallBase: ClientCallUnaryBase<Apisvr_AddCheckListItemReq, Apisvr_AddCheckListItemResp>, Apisvr_RecommendationServiceAddCheckListItemCall {
  override class var method: String { return "/apisvr.RecommendationService/AddCheckListItem" }
}

internal protocol Apisvr_RecommendationServiceGetCheckListItemCall: ClientCallUnary {}

fileprivate final class Apisvr_RecommendationServiceGetCheckListItemCallBase: ClientCallUnaryBase<Apisvr_GetCheckListItemReq, Apisvr_GetCheckListItemResp>, Apisvr_RecommendationServiceGetCheckListItemCall {
  override class var method: String { return "/apisvr.RecommendationService/GetCheckListItem" }
}

internal protocol Apisvr_RecommendationServiceIngredientCheckCall: ClientCallUnary {}

fileprivate final class Apisvr_RecommendationServiceIngredientCheckCallBase: ClientCallUnaryBase<Apisvr_IngredientCheckReq, Apisvr_IngredientCheckResp>, Apisvr_RecommendationServiceIngredientCheckCall {
  override class var method: String { return "/apisvr.RecommendationService/IngredientCheck" }
}

internal protocol Apisvr_RecommendationServiceIngredientUncheckCall: ClientCallUnary {}

fileprivate final class Apisvr_RecommendationServiceIngredientUncheckCallBase: ClientCallUnaryBase<Apisvr_IngredientUncheckReq, Apisvr_IngredientUncheckResp>, Apisvr_RecommendationServiceIngredientUncheckCall {
  override class var method: String { return "/apisvr.RecommendationService/IngredientUncheck" }
}

internal protocol Apisvr_RecommendationServiceGetAllIngredientsCall: ClientCallUnary {}

fileprivate final class Apisvr_RecommendationServiceGetAllIngredientsCallBase: ClientCallUnaryBase<Apisvr_GetAllIngredientsReq, Apisvr_GetAllIngredientsResp>, Apisvr_RecommendationServiceGetAllIngredientsCall {
  override class var method: String { return "/apisvr.RecommendationService/GetAllIngredients" }
}


/// Instantiate Apisvr_RecommendationServiceServiceClient, then call methods of this protocol to make API calls.
internal protocol Apisvr_RecommendationServiceService: ServiceClient {
  /// Synchronous. Unary.
  func getRecommendedRecipe(_ request: Apisvr_GetRecommendedRecipeReq, metadata customMetadata: Metadata) throws -> Apisvr_GetRecommendedRecipeResp
  /// Asynchronous. Unary.
  @discardableResult
  func getRecommendedRecipe(_ request: Apisvr_GetRecommendedRecipeReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetRecommendedRecipeResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetRecommendedRecipeCall

  /// Synchronous. Unary.
  func getRecommendedMealPlan(_ request: Apisvr_GetRecommendedMealPlanReq, metadata customMetadata: Metadata) throws -> Apisvr_GetRecommendedMealPlanResp
  /// Asynchronous. Unary.
  @discardableResult
  func getRecommendedMealPlan(_ request: Apisvr_GetRecommendedMealPlanReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetRecommendedMealPlanResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetRecommendedMealPlanCall

  /// Synchronous. Unary.
  func addCheckListItem(_ request: Apisvr_AddCheckListItemReq, metadata customMetadata: Metadata) throws -> Apisvr_AddCheckListItemResp
  /// Asynchronous. Unary.
  @discardableResult
  func addCheckListItem(_ request: Apisvr_AddCheckListItemReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_AddCheckListItemResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceAddCheckListItemCall

  /// Synchronous. Unary.
  func getCheckListItem(_ request: Apisvr_GetCheckListItemReq, metadata customMetadata: Metadata) throws -> Apisvr_GetCheckListItemResp
  /// Asynchronous. Unary.
  @discardableResult
  func getCheckListItem(_ request: Apisvr_GetCheckListItemReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetCheckListItemResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetCheckListItemCall

  /// Synchronous. Unary.
  func ingredientCheck(_ request: Apisvr_IngredientCheckReq, metadata customMetadata: Metadata) throws -> Apisvr_IngredientCheckResp
  /// Asynchronous. Unary.
  @discardableResult
  func ingredientCheck(_ request: Apisvr_IngredientCheckReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_IngredientCheckResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceIngredientCheckCall

  /// Synchronous. Unary.
  func ingredientUncheck(_ request: Apisvr_IngredientUncheckReq, metadata customMetadata: Metadata) throws -> Apisvr_IngredientUncheckResp
  /// Asynchronous. Unary.
  @discardableResult
  func ingredientUncheck(_ request: Apisvr_IngredientUncheckReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_IngredientUncheckResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceIngredientUncheckCall

  /// Synchronous. Unary.
  func getAllIngredients(_ request: Apisvr_GetAllIngredientsReq, metadata customMetadata: Metadata) throws -> Apisvr_GetAllIngredientsResp
  /// Asynchronous. Unary.
  @discardableResult
  func getAllIngredients(_ request: Apisvr_GetAllIngredientsReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetAllIngredientsResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetAllIngredientsCall

}

internal extension Apisvr_RecommendationServiceService {
  /// Synchronous. Unary.
  func getRecommendedRecipe(_ request: Apisvr_GetRecommendedRecipeReq) throws -> Apisvr_GetRecommendedRecipeResp {
    return try self.getRecommendedRecipe(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func getRecommendedRecipe(_ request: Apisvr_GetRecommendedRecipeReq, completion: @escaping (Apisvr_GetRecommendedRecipeResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetRecommendedRecipeCall {
    return try self.getRecommendedRecipe(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func getRecommendedMealPlan(_ request: Apisvr_GetRecommendedMealPlanReq) throws -> Apisvr_GetRecommendedMealPlanResp {
    return try self.getRecommendedMealPlan(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func getRecommendedMealPlan(_ request: Apisvr_GetRecommendedMealPlanReq, completion: @escaping (Apisvr_GetRecommendedMealPlanResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetRecommendedMealPlanCall {
    return try self.getRecommendedMealPlan(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func addCheckListItem(_ request: Apisvr_AddCheckListItemReq) throws -> Apisvr_AddCheckListItemResp {
    return try self.addCheckListItem(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func addCheckListItem(_ request: Apisvr_AddCheckListItemReq, completion: @escaping (Apisvr_AddCheckListItemResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceAddCheckListItemCall {
    return try self.addCheckListItem(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func getCheckListItem(_ request: Apisvr_GetCheckListItemReq) throws -> Apisvr_GetCheckListItemResp {
    return try self.getCheckListItem(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func getCheckListItem(_ request: Apisvr_GetCheckListItemReq, completion: @escaping (Apisvr_GetCheckListItemResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetCheckListItemCall {
    return try self.getCheckListItem(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func ingredientCheck(_ request: Apisvr_IngredientCheckReq) throws -> Apisvr_IngredientCheckResp {
    return try self.ingredientCheck(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func ingredientCheck(_ request: Apisvr_IngredientCheckReq, completion: @escaping (Apisvr_IngredientCheckResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceIngredientCheckCall {
    return try self.ingredientCheck(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func ingredientUncheck(_ request: Apisvr_IngredientUncheckReq) throws -> Apisvr_IngredientUncheckResp {
    return try self.ingredientUncheck(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func ingredientUncheck(_ request: Apisvr_IngredientUncheckReq, completion: @escaping (Apisvr_IngredientUncheckResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceIngredientUncheckCall {
    return try self.ingredientUncheck(request, metadata: self.metadata, completion: completion)
  }

  /// Synchronous. Unary.
  func getAllIngredients(_ request: Apisvr_GetAllIngredientsReq) throws -> Apisvr_GetAllIngredientsResp {
    return try self.getAllIngredients(request, metadata: self.metadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  func getAllIngredients(_ request: Apisvr_GetAllIngredientsReq, completion: @escaping (Apisvr_GetAllIngredientsResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetAllIngredientsCall {
    return try self.getAllIngredients(request, metadata: self.metadata, completion: completion)
  }

}

internal final class Apisvr_RecommendationServiceServiceClient: ServiceClientBase, Apisvr_RecommendationServiceService {
  /// Synchronous. Unary.
  internal func getRecommendedRecipe(_ request: Apisvr_GetRecommendedRecipeReq, metadata customMetadata: Metadata) throws -> Apisvr_GetRecommendedRecipeResp {
    return try Apisvr_RecommendationServiceGetRecommendedRecipeCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func getRecommendedRecipe(_ request: Apisvr_GetRecommendedRecipeReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetRecommendedRecipeResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetRecommendedRecipeCall {
    return try Apisvr_RecommendationServiceGetRecommendedRecipeCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func getRecommendedMealPlan(_ request: Apisvr_GetRecommendedMealPlanReq, metadata customMetadata: Metadata) throws -> Apisvr_GetRecommendedMealPlanResp {
    return try Apisvr_RecommendationServiceGetRecommendedMealPlanCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func getRecommendedMealPlan(_ request: Apisvr_GetRecommendedMealPlanReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetRecommendedMealPlanResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetRecommendedMealPlanCall {
    return try Apisvr_RecommendationServiceGetRecommendedMealPlanCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func addCheckListItem(_ request: Apisvr_AddCheckListItemReq, metadata customMetadata: Metadata) throws -> Apisvr_AddCheckListItemResp {
    return try Apisvr_RecommendationServiceAddCheckListItemCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func addCheckListItem(_ request: Apisvr_AddCheckListItemReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_AddCheckListItemResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceAddCheckListItemCall {
    return try Apisvr_RecommendationServiceAddCheckListItemCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func getCheckListItem(_ request: Apisvr_GetCheckListItemReq, metadata customMetadata: Metadata) throws -> Apisvr_GetCheckListItemResp {
    return try Apisvr_RecommendationServiceGetCheckListItemCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func getCheckListItem(_ request: Apisvr_GetCheckListItemReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetCheckListItemResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetCheckListItemCall {
    return try Apisvr_RecommendationServiceGetCheckListItemCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func ingredientCheck(_ request: Apisvr_IngredientCheckReq, metadata customMetadata: Metadata) throws -> Apisvr_IngredientCheckResp {
    return try Apisvr_RecommendationServiceIngredientCheckCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func ingredientCheck(_ request: Apisvr_IngredientCheckReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_IngredientCheckResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceIngredientCheckCall {
    return try Apisvr_RecommendationServiceIngredientCheckCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func ingredientUncheck(_ request: Apisvr_IngredientUncheckReq, metadata customMetadata: Metadata) throws -> Apisvr_IngredientUncheckResp {
    return try Apisvr_RecommendationServiceIngredientUncheckCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func ingredientUncheck(_ request: Apisvr_IngredientUncheckReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_IngredientUncheckResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceIngredientUncheckCall {
    return try Apisvr_RecommendationServiceIngredientUncheckCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

  /// Synchronous. Unary.
  internal func getAllIngredients(_ request: Apisvr_GetAllIngredientsReq, metadata customMetadata: Metadata) throws -> Apisvr_GetAllIngredientsResp {
    return try Apisvr_RecommendationServiceGetAllIngredientsCallBase(channel)
      .run(request: request, metadata: customMetadata)
  }
  /// Asynchronous. Unary.
  @discardableResult
  internal func getAllIngredients(_ request: Apisvr_GetAllIngredientsReq, metadata customMetadata: Metadata, completion: @escaping (Apisvr_GetAllIngredientsResp?, CallResult) -> Void) throws -> Apisvr_RecommendationServiceGetAllIngredientsCall {
    return try Apisvr_RecommendationServiceGetAllIngredientsCallBase(channel)
      .start(request: request, metadata: customMetadata, completion: completion)
  }

}

/// To build a server, implement a class that conforms to this protocol.
/// If one of the methods returning `ServerStatus?` returns nil,
/// it is expected that you have already returned a status to the client by means of `session.close`.
internal protocol Apisvr_RecommendationServiceProvider: ServiceProvider {
  func getRecommendedRecipe(request: Apisvr_GetRecommendedRecipeReq, session: Apisvr_RecommendationServiceGetRecommendedRecipeSession) throws -> Apisvr_GetRecommendedRecipeResp
  func getRecommendedMealPlan(request: Apisvr_GetRecommendedMealPlanReq, session: Apisvr_RecommendationServiceGetRecommendedMealPlanSession) throws -> Apisvr_GetRecommendedMealPlanResp
  func addCheckListItem(request: Apisvr_AddCheckListItemReq, session: Apisvr_RecommendationServiceAddCheckListItemSession) throws -> Apisvr_AddCheckListItemResp
  func getCheckListItem(request: Apisvr_GetCheckListItemReq, session: Apisvr_RecommendationServiceGetCheckListItemSession) throws -> Apisvr_GetCheckListItemResp
  func ingredientCheck(request: Apisvr_IngredientCheckReq, session: Apisvr_RecommendationServiceIngredientCheckSession) throws -> Apisvr_IngredientCheckResp
  func ingredientUncheck(request: Apisvr_IngredientUncheckReq, session: Apisvr_RecommendationServiceIngredientUncheckSession) throws -> Apisvr_IngredientUncheckResp
  func getAllIngredients(request: Apisvr_GetAllIngredientsReq, session: Apisvr_RecommendationServiceGetAllIngredientsSession) throws -> Apisvr_GetAllIngredientsResp
}

extension Apisvr_RecommendationServiceProvider {
  internal var serviceName: String { return "apisvr.RecommendationService" }

  /// Determines and calls the appropriate request handler, depending on the request's method.
  /// Throws `HandleMethodError.unknownMethod` for methods not handled by this service.
  internal func handleMethod(_ method: String, handler: Handler) throws -> ServerStatus? {
    switch method {
    case "/apisvr.RecommendationService/GetRecommendedRecipe":
      return try Apisvr_RecommendationServiceGetRecommendedRecipeSessionBase(
        handler: handler,
        providerBlock: { try self.getRecommendedRecipe(request: $0, session: $1 as! Apisvr_RecommendationServiceGetRecommendedRecipeSessionBase) })
          .run()
    case "/apisvr.RecommendationService/GetRecommendedMealPlan":
      return try Apisvr_RecommendationServiceGetRecommendedMealPlanSessionBase(
        handler: handler,
        providerBlock: { try self.getRecommendedMealPlan(request: $0, session: $1 as! Apisvr_RecommendationServiceGetRecommendedMealPlanSessionBase) })
          .run()
    case "/apisvr.RecommendationService/AddCheckListItem":
      return try Apisvr_RecommendationServiceAddCheckListItemSessionBase(
        handler: handler,
        providerBlock: { try self.addCheckListItem(request: $0, session: $1 as! Apisvr_RecommendationServiceAddCheckListItemSessionBase) })
          .run()
    case "/apisvr.RecommendationService/GetCheckListItem":
      return try Apisvr_RecommendationServiceGetCheckListItemSessionBase(
        handler: handler,
        providerBlock: { try self.getCheckListItem(request: $0, session: $1 as! Apisvr_RecommendationServiceGetCheckListItemSessionBase) })
          .run()
    case "/apisvr.RecommendationService/IngredientCheck":
      return try Apisvr_RecommendationServiceIngredientCheckSessionBase(
        handler: handler,
        providerBlock: { try self.ingredientCheck(request: $0, session: $1 as! Apisvr_RecommendationServiceIngredientCheckSessionBase) })
          .run()
    case "/apisvr.RecommendationService/IngredientUncheck":
      return try Apisvr_RecommendationServiceIngredientUncheckSessionBase(
        handler: handler,
        providerBlock: { try self.ingredientUncheck(request: $0, session: $1 as! Apisvr_RecommendationServiceIngredientUncheckSessionBase) })
          .run()
    case "/apisvr.RecommendationService/GetAllIngredients":
      return try Apisvr_RecommendationServiceGetAllIngredientsSessionBase(
        handler: handler,
        providerBlock: { try self.getAllIngredients(request: $0, session: $1 as! Apisvr_RecommendationServiceGetAllIngredientsSessionBase) })
          .run()
    default:
      throw HandleMethodError.unknownMethod
    }
  }
}

internal protocol Apisvr_RecommendationServiceGetRecommendedRecipeSession: ServerSessionUnary {}

fileprivate final class Apisvr_RecommendationServiceGetRecommendedRecipeSessionBase: ServerSessionUnaryBase<Apisvr_GetRecommendedRecipeReq, Apisvr_GetRecommendedRecipeResp>, Apisvr_RecommendationServiceGetRecommendedRecipeSession {}

internal protocol Apisvr_RecommendationServiceGetRecommendedMealPlanSession: ServerSessionUnary {}

fileprivate final class Apisvr_RecommendationServiceGetRecommendedMealPlanSessionBase: ServerSessionUnaryBase<Apisvr_GetRecommendedMealPlanReq, Apisvr_GetRecommendedMealPlanResp>, Apisvr_RecommendationServiceGetRecommendedMealPlanSession {}

internal protocol Apisvr_RecommendationServiceAddCheckListItemSession: ServerSessionUnary {}

fileprivate final class Apisvr_RecommendationServiceAddCheckListItemSessionBase: ServerSessionUnaryBase<Apisvr_AddCheckListItemReq, Apisvr_AddCheckListItemResp>, Apisvr_RecommendationServiceAddCheckListItemSession {}

internal protocol Apisvr_RecommendationServiceGetCheckListItemSession: ServerSessionUnary {}

fileprivate final class Apisvr_RecommendationServiceGetCheckListItemSessionBase: ServerSessionUnaryBase<Apisvr_GetCheckListItemReq, Apisvr_GetCheckListItemResp>, Apisvr_RecommendationServiceGetCheckListItemSession {}

internal protocol Apisvr_RecommendationServiceIngredientCheckSession: ServerSessionUnary {}

fileprivate final class Apisvr_RecommendationServiceIngredientCheckSessionBase: ServerSessionUnaryBase<Apisvr_IngredientCheckReq, Apisvr_IngredientCheckResp>, Apisvr_RecommendationServiceIngredientCheckSession {}

internal protocol Apisvr_RecommendationServiceIngredientUncheckSession: ServerSessionUnary {}

fileprivate final class Apisvr_RecommendationServiceIngredientUncheckSessionBase: ServerSessionUnaryBase<Apisvr_IngredientUncheckReq, Apisvr_IngredientUncheckResp>, Apisvr_RecommendationServiceIngredientUncheckSession {}

internal protocol Apisvr_RecommendationServiceGetAllIngredientsSession: ServerSessionUnary {}

fileprivate final class Apisvr_RecommendationServiceGetAllIngredientsSessionBase: ServerSessionUnaryBase<Apisvr_GetAllIngredientsReq, Apisvr_GetAllIngredientsResp>, Apisvr_RecommendationServiceGetAllIngredientsSession {}

