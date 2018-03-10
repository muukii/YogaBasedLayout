//
//  WrapperLayoutSpec.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit

public struct WrapperLayoutSpec : LayoutSpecInternal {

  let view = LayoutNode()

  public let children: [LayoutElement]

  public init(child: LayoutElement) {
    self.children = [child]
  }

  public init(children: [LayoutElement]) {
    self.children = children
  }

  public func layout(target: Node) -> Node {

    target.yoga.isEnabled = true

    target.addSubview(view)

    view.configureLayout { (layout) in
      self.style.apply(to: layout)
    }

    let nodes = children.map {
      $0.layout(target: view)
    }

    nodes.forEach {
      $0.configureLayout { (layout) in
        layout.position = .absolute
        layout.bottom = YGValue(CGFloat(0))
        layout.top = YGValue(CGFloat(0))
        layout.right = YGValue(CGFloat(0))
        layout.left = YGValue(CGFloat(0))
      }
    }

    nodes.forEach(view.addSubview)

    return view
  }

}
