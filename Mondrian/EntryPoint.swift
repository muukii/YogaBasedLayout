//
//  TargetSpec.swift
//  Mondrian
//
//  Created by muukii on 3/11/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

public struct EntryPoint : LayoutSpec {

  let rootView: UIView

  let child: LayoutElement

  public init(rootView: UIView, child: LayoutElement) {
    self.rootView = rootView
    self.child = child
  }

  public func defineLayout() {
    _ = child.defineLayout(target: rootView)
  }

  public func defineLayout(target: Node) -> Node {

    let node = child.defineLayout(target: rootView)

    if rootView.isDescendant(of: target) == false {
      target.addSubview(rootView)
    }

    return node
  }
}
