//
//  RelativeLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public struct RelativeLayoutSpec : LayoutSpec {

  public enum Position {
    case start
    case center
    case end
  }

  public enum Sizing {
    case minimumWidth(horizontalPosition: Position)
    case minimumHeight(verticalPosition: Position)
    case minimumSize(verticalPosition: Position, horizontalPosition: Position)
  }

  public let sizing: Sizing

  public let child: LayoutElement

  public init(
    sizing: Sizing,
    child: LayoutElement
    ) {

    self.sizing = sizing
    self.child = child

  }

  public func layout(target: Node) -> Node {

    target.yoga.isEnabled = true

    let node = child.layout(target: target)

    target.configureLayout { (layout) in
      layout.flexDirection = .column

      node.style.flexGrow = 1
      layout.alignItems = .stretch

      switch self.sizing {
      case .minimumHeight(let verticalPosition):

        node.style.flexGrow = 0

        switch verticalPosition {
        case .center:
          layout.justifyContent = .center
        case .end:
          layout.justifyContent = .flexEnd
        case .start:
          layout.justifyContent = .flexStart
        }

      case .minimumWidth(let horizontalPosition):

        switch horizontalPosition {
        case .center:
          layout.alignItems = .center
        case .end:
          layout.alignItems = .flexEnd
        case .start:
          layout.alignItems = .flexStart
        }

      case .minimumSize(let verticalPosition, let horizontalPosition):

        node.style.flexGrow = 0

        switch verticalPosition {
        case .center:
          layout.justifyContent = .center
        case .end:
          layout.justifyContent = .flexEnd
        case .start:
          layout.justifyContent = .flexStart
        }

        switch horizontalPosition {
        case .center:
          layout.alignItems = .center
        case .end:
          layout.alignItems = .flexEnd
        case .start:
          layout.alignItems = .flexStart
        }
      }
    }

    target.addSubview(node)

    return target
  }
}
