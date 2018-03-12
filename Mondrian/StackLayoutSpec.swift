//
//  StackLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit
import yoga

public enum FlexDirection {
  case vertical
  case verticalReverse
  case horizontal
  case horizontalReverse
}

public enum JustifyContent {
  case start
  case center
  case end
  case spaceBetween
  case spaceAround
}

public enum AlignItems {
  case auto
  case start
  case end
  case center
  case stretch
  case baseline
}

public enum AlignSelf {
  case auto
  case start
  case end
  case center
  case stretch
  case baseline
}

public enum AlignContent {
  case start
  case center
  case end
  case spaceBetween
  case spaceAround
  case stretch
}

public enum FlexWrap {
  case noWrap
  case wrap
  case wrapReverse
}

extension FlexDirection {
  var yogaValue: YGFlexDirection {

    switch self {
    case .horizontal:        return .row
    case .horizontalReverse: return .rowReverse
    case .vertical:          return .column
    case .verticalReverse:   return .columnReverse
    }
  }
}

extension JustifyContent {
  var yogaValue: YGJustify {
    switch self {
    case .start:        return .flexStart
    case .center:       return .center
    case .end:          return .flexEnd
    case .spaceBetween: return .spaceBetween
    case .spaceAround:  return .spaceAround
    }
  }
}

extension AlignContent {
  var yogaValue: YGAlign {
    switch self {
    case .stretch:      return .stretch
    case .start:        return .flexStart
    case .center:       return .center
    case .end:          return .flexEnd
    case .spaceBetween: return .spaceBetween
    case .spaceAround:  return .spaceAround
    }
  }
}

extension AlignItems {
  var yogaValue: YGAlign {
    switch self {
    case .auto:         return .auto
    case .stretch:      return .stretch
    case .start:        return .flexStart
    case .center:       return .center
    case .end:          return .flexEnd
    case .baseline:     return .baseline
    }
  }
}

extension AlignSelf {
  var yogaValue: YGAlign {
    switch self {
    case .auto:         return .auto
    case .stretch:      return .stretch
    case .start:        return .flexStart
    case .center:       return .center
    case .end:          return .flexEnd
    case .baseline:     return .baseline
    }
  }
}

extension FlexWrap {
  var yogaValue: YGWrap {
    switch self {
    case .noWrap:      return .noWrap
    case .wrap:        return .wrap
    case .wrapReverse: return .wrapReverse
    }
  }
}

//extension Flex.Position {
//  var yogaValue: YGPositionType {
//    switch self {
//    case .relative: return YGPositionType.relative
//    case .absolute: return YGPositionType.absolute
//    }
//  }
//}

//extension Flex.LayoutDirection {
//  var yogaValue: YGDirection {
//    switch self {
//    case .ltr: return YGDirection.LTR
//    case .rtl: return YGDirection.RTL
//    default:   return YGDirection.inherit
//    }
//  }
//}

public struct StackLayoutSpec : LayoutSpec {

  public var style: LayoutElementStyle = .init()

  public let direction: FlexDirection

  public let spacing: CGFloat

  public let justifyContent: JustifyContent

  public let alignItems: AlignItems

  public let flexWrap: FlexWrap

  public var children: [LayoutElement]

  public init(
    direction: FlexDirection,
    spacing: CGFloat,
    justifyContent: JustifyContent,
    alignItems: AlignItems,
    flexWrap: FlexWrap = .noWrap,
    styled: (inout LayoutElementStyle) -> Void = { _ in },
    children: [LayoutElement]
    ) {

    self.direction = direction
    self.spacing = spacing
    self.justifyContent = justifyContent
    self.alignItems = alignItems
    self.flexWrap = flexWrap
    self.children = children

    styled(&self.style)
  }

  public func defineLayout(target: Node) -> Node {

    // Can optimize
    // Should reduce useless UIView

    let view = LayoutNode()

    view.mond.style = style

    target.addSubview(view)

    target.yoga.isEnabled = true

    view.configureLayout { (layout) in
      layout.flexDirection = self.direction.yogaValue
      layout.justifyContent = self.justifyContent.yogaValue
      layout.alignItems = self.alignItems.yogaValue
      layout.flexWrap = self.flexWrap.yogaValue
    }

    let nodes = children.map {
      $0.defineLayout(target: target)
    }

    nodes.dropLast().forEach {
      switch direction {
      case .horizontal, .horizontalReverse:
        $0.mond.style.margin.right = spacing
      case .vertical, .verticalReverse:
        $0.mond.style.margin.bottom = spacing
      }
    }

    nodes.forEach(view.addSubview)

    return view

  }

}
