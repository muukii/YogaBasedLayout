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

  let view = LayoutNode()

  public var style: LayoutElementStyle {
    get {
      return view.style
    }
    set {
      view.style = newValue
    }
  }

  public let insets: UIEdgeInsets

  public let child: LayoutElement

  public init(insets: UIEdgeInsets, child: LayoutElement) {
    self.insets = insets
    self.child = child
  }

  public func layout(target: Node) -> Node {

    target.yoga.isEnabled = true

    view.configureLayout { (layout) in
      self.style.apply(to: layout)
      layout.marginTop = YGValue(self.insets.top)
      layout.marginRight = YGValue(self.insets.right)
      layout.marginBottom = YGValue(self.insets.bottom)
      layout.marginLeft = YGValue(self.insets.left)
    }

    target.addSubview(view)

    let node = child.layout(target: view)

    view.addSubview(node)

    return view
  }

}
