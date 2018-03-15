//
//  UIView+LayoutElement.swift
//  Mondrian
//
//  Created by muukii on 3/10/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import ObjectiveC

import YogaKit

private var _style: Void

public enum LayoutMode {
  case currentSize
  case flexibleHeight
  case flexibleWidth
}

extension MondrianNamespace where Base : UIView {

  public func styled(_ apply:(inout LayoutElementStyle) -> Void) -> Base {
    apply(&style)
    return base
  }

  public var style: LayoutElementStyle {
    get {
      return base.style
    }
    set {
      base.style = newValue
    }
  }

  public func markDirty() {
    base.yoga.markDirty()
  }

}

extension Node {

  fileprivate var style: LayoutElementStyle {
    get {
      if let style = objc_getAssociatedObject(self, &_style) as? LayoutElementStyle {
        return style
      }
      let style = LayoutElementStyle()
      objc_setAssociatedObject(self, &_style, style, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      return style
    }
    set {
      objc_setAssociatedObject(self, &_style, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
      configureLayout { layout in
        newValue.apply(to: layout)
      }
    }
  }

  func makeLayoutNode<T: LayoutNode>(for type: T.Type) -> T {
    let view = T.init()
    self.addSubview(view)
    return view
  }

  func set(children: [UIView]) {

    subviews.forEach {
      $0.removeFromSuperview()
    }

    children.forEach {
      addSubview($0)
    }

  }

}

extension Node : LayoutElement {

  public final func defineLayout(target: Node) -> Node {

    yoga.isEnabled = true

    configureLayout { layout in
      self.style.apply(to: layout)
    }

    if let spec = (self as? UIView & MondrianViewType)?.layoutSpec() {

      return spec.defineLayout(target: target)

    } else {
      return self
    }
  }
  
}

class LayoutNode : UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.yoga.isEnabled = true
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

    let view = super.hitTest(point, with: event)

    if view == self {

      return nil
    }
    return view
  }
}

class StackLayoutNode : LayoutNode {

}
