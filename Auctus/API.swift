// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class DiagnoseCarQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query DiagnoseCar($carInfo: [String!]!) {
      diagnoseCar(carInfo: $carInfo) {
        __typename
        diagnosis
        part
        expl
        estimate
      }
    }
    """

  public let operationName: String = "DiagnoseCar"

  public var carInfo: [String]

  public init(carInfo: [String]) {
    self.carInfo = carInfo
  }

  public var variables: GraphQLMap? {
    return ["carInfo": carInfo]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("diagnoseCar", arguments: ["carInfo": GraphQLVariable("carInfo")], type: .object(DiagnoseCar.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(diagnoseCar: DiagnoseCar? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "diagnoseCar": diagnoseCar.flatMap { (value: DiagnoseCar) -> ResultMap in value.resultMap }])
    }

    public var diagnoseCar: DiagnoseCar? {
      get {
        return (resultMap["diagnoseCar"] as? ResultMap).flatMap { DiagnoseCar(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "diagnoseCar")
      }
    }

    public struct DiagnoseCar: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["DiagnosisType"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("diagnosis", type: .scalar(String.self)),
          GraphQLField("part", type: .scalar(String.self)),
          GraphQLField("expl", type: .scalar(String.self)),
          GraphQLField("estimate", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(diagnosis: String? = nil, part: String? = nil, expl: String? = nil, estimate: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "DiagnosisType", "diagnosis": diagnosis, "part": part, "expl": expl, "estimate": estimate])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var diagnosis: String? {
        get {
          return resultMap["diagnosis"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "diagnosis")
        }
      }

      public var part: String? {
        get {
          return resultMap["part"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "part")
        }
      }

      public var expl: String? {
        get {
          return resultMap["expl"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "expl")
        }
      }

      public var estimate: String? {
        get {
          return resultMap["estimate"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "estimate")
        }
      }
    }
  }
}
