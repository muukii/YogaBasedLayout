//
//  CenterLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public struct CenterLayoutSpec : LayoutSpec {

  public enum Centering {
    case centerX
    case centerY
    case centerXY
  }

  public var child: LayoutElement {
    return relativeLayout.child
  }

  private let relativeLayout: RelativeLayoutSpec

  public init(centering: Centering, child: LayoutElement) {

    self.relativeLayout = .init(
      sizing: { centering -> RelativeLayoutSpec.Sizing in
        switch centering {
        case .centerX:
          return .minimumHeight(verticalPosition: .center)
        case .centerY:
          return .minimumWidth(horizontalPosition: .center)
        case .centerXY:
          return .minimumSize(verticalPosition: .center, horizontalPosition: .center)
        }
    }(centering),
      child: child
    )
  }

  public func layout(target: Node) -> Node {

    return relativeLayout.layout(target: target)
  }
}
