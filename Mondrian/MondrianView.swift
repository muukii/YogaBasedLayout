//
//  MondrianView.swift
//  Mondrian
//
//  Created by muukii on 3/11/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

public protocol MondrianViewType {

  var targetView: UIView { get }
  func layoutSpec() -> LayoutSpec
}

extension MondrianViewType where Self : UIView {

  public var targetView: UIView { return self }

}

public enum CalculateRule {
  case none
  case fixedWidth(CGFloat)
  case fixedHeight(CGFloat)
}

extension MondrianNamespace where Base : UIView & MondrianViewType {

  func applyLayoutSpec() {
    _ = base.defineLayout(target: base.targetView)
  }

  public func invalidateLayoutSpec() {
    // TODO: Optimize
    destroyCurrentLayoutSpec()
    applyLayoutSpec()
  }

  public func relayout(layoutMode: LayoutMode = .currentSize) {

    base.targetView.yoga.isEnabled = true

    switch layoutMode {
    case .currentSize:
      base.targetView.yoga.applyLayout(
        preservingOrigin: true
      )
    case .flexibleHeight:
      base.targetView.yoga.applyLayout(
        preservingOrigin: true,
        dimensionFlexibility: .flexibleHeight
      )
    case .flexibleWidth:
      base.targetView.yoga.applyLayout(
        preservingOrigin: true,
        dimensionFlexibility: .flexibleWidth
      )
    }
  }

  public func calculateSize(with rule: CalculateRule) -> CGSize {

    let _width = base.targetView.mond.style.width
    let _height = base.targetView.mond.style.height

    defer {
      base.targetView.mond.style.width = _width
      base.targetView.mond.style.height = _height
    }

    switch rule {
    case .fixedHeight(let height):
      base.targetView.mond.style.width = .auto
      base.targetView.mond.style.height = .points(height)
    case .fixedWidth(let width):
      base.targetView.mond.style.height = .auto
      base.targetView.mond.style.width = .points(width)
    case .none:
      base.targetView.mond.style.width = .auto
      base.targetView.mond.style.height = .auto
    }

    return base.targetView.yoga.intrinsicSize

  }

  private func destroyCurrentLayoutSpec() {

    var nodes: [UIView] = []

    func recursive(root: UIView) {
      for child in root.subviews {
        if child is LayoutNode {
          nodes.append(child)
        }
        recursive(root: child)
      }
    }

    recursive(root: base)

    for node in nodes {
      node.subviews.forEach {
        $0.removeFromSuperview()
      }
      node.yoga.calculateLayout(with: .zero) // To remove child node
      node.removeFromSuperview()
    }

  }

}

open class MondrianView : UIView, MondrianViewType {

  open override func didMoveToSuperview() {
    super.didMoveToSuperview()
  }

  open override func layoutSubviews() {
    super.layoutSubviews()    
  }

  open func layoutSpec() -> LayoutSpec {
    return WrapperLayoutSpec(child: self)
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    yoga.isEnabled = true
  }

  @available(*, unavailable)
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  open override func sizeToFit() {
    mond.invalidateLayoutSpec()
    bounds.size = yoga.intrinsicSize
    mond.relayout()
  }

}

open class MondrianCollectionViewCell : UICollectionViewCell, MondrianViewType {
  
  open func layoutSpec() -> LayoutSpec {
    return WrapperLayoutSpec(child: self)
  }
}
