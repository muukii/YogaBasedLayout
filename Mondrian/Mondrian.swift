//
//  Mondrian.swift
//  Mondrian
//
//  Created by muukii on 3/10/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public typealias Node = UIView

func mprint(_ items: Any...) {
  #if DEBUG
    print(items.map { "\($0)" }.joined(separator: " "))
  #endif
}

public final class MondrianNamespace<Base> {
  public let base: Base
  public init(_ base: Base) {
    self.base = base
  }
}

public protocol MondrianCompatible {
  associatedtype CompatibleType
  var mond: CompatibleType { get }
}

public extension MondrianCompatible {
  public var mond: MondrianNamespace<Self> {
    get { return MondrianNamespace(self) }
  }
}

extension UIView : MondrianCompatible {}
