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

public struct StackLayoutSpec : LayoutSpecInternal {

  let view = LayoutNode()

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
    flexWrap: FlexWrap,
    children: [LayoutElement]
    ) {

    self.direction = direction
    self.spacing = spacing
    self.justifyContent = justifyContent
    self.alignItems = alignItems
    self.flexWrap = flexWrap
    self.children = children

  }

  public func layout(target: Node) -> Node {

    target.yoga.isEnabled = true

    target.addSubview(view)

    view.configureLayout { (layout) in
      self.style.apply(to: layout)
      layout.flexDirection = self.direction.yogaValue
      layout.justifyContent = self.justifyContent.yogaValue
      layout.alignItems = self.alignItems.yogaValue
      layout.flexWrap = self.flexWrap.yogaValue
    }

    let nodes = children.map {
      $0.layout(target: view)
    }

    nodes.dropLast().forEach {
      $0.style.margin.bottom = spacing
    }

    nodes.forEach(view.addSubview)

    return view

  }

}
