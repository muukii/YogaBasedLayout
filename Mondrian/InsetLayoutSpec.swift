//
//  InsetLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct InsetLayoutSpec : LayoutSpec {

  public let insets: UIEdgeInsets

  public let child: LayoutElement

  public init(insets: UIEdgeInsets, child: LayoutElement) {
    self.insets = insets
    self.child = child
  }

  public func defineLayout(target: Node) -> Node {

    let view = target.makeLayoutNode(for: LayoutNode.self)

    target.yoga.isEnabled = true

    let childNode = child.defineLayout(target: view)

    view.configureLayout { (layout) in

      layout.paddingBottom = self.insets.yogaBottom
      layout.paddingTop = self.insets.yogaTop
      layout.paddingRight = self.insets.yogaRight
      layout.paddingLeft = self.insets.yogaLeft

      if layout.paddingLeft.value != YGValueAuto.value, layout.paddingRight.value != YGValueAuto.value {
        childNode.mond.style.flexGrow = 1
        layout.justifyContent = .center
      } else if layout.paddingRight.value != YGValueAuto.value {
        childNode.mond.style.flexGrow = 0
        layout.justifyContent = .flexStart
      } else {
        childNode.mond.style.flexGrow = 0
        layout.justifyContent = .flexStart
      }

      if layout.paddingTop.value != YGValueAuto.value, layout.paddingBottom.value != YGValueAuto.value {
        layout.alignItems = .stretch
      } else if layout.paddingBottom.value != YGValueAuto.value {
        layout.justifyContent = .flexEnd
      } else {
        layout.justifyContent = .flexStart
      }
    }

    view.addSubview(childNode)

    return view
  }

}

