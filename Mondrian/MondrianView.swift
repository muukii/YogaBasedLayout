//
//  MondrianView.swift
//  Mondrian
//
//  Created by muukii on 3/11/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

public protocol MondrianViewType {

  func layoutSpec() -> LayoutSpec
}

extension MondrianNamespace where Base : UIView & MondrianViewType {

  public func applyLayoutSpec() {
    _ = base.defineLayout(target: base)
  }

  public func setNeedsRefreshLayoutSpec() {
    // TODO: Optimize
    destroyCurrentLayoutSpec()
    applyLayoutSpec()
  }

  public func relayout(layoutMode: LayoutMode = .currentSize) {

    base.yoga.isEnabled = true

    switch layoutMode {
    case .currentSize:
      base.yoga.applyLayout(
        preservingOrigin: true
      )
    case .flexibleHeight:
      base.yoga.applyLayout(
        preservingOrigin: true,
        dimensionFlexibility: .flexibleHeight
      )
    case .flexibleWidth:
      base.yoga.applyLayout(
        preservingOrigin: true,
        dimensionFlexibility: .flexibleWidth
      )
    }
  }

  private func destroyCurrentLayoutSpec() {

    base.subviews.forEach {
      $0.removeFromSuperview()
    }
  }

}

open class MondrianView : UIView, MondrianViewType {

  open override func layoutSubviews() {
    super.layoutSubviews()    
  }

  open func layoutSpec() -> LayoutSpec {
    return WrapperLayoutSpec(child: self)
  }

}

open class MondrianCollectionViewCell : UICollectionViewCell, MondrianViewType {
  
  open func layoutSpec() -> LayoutSpec {
    return WrapperLayoutSpec(child: self)
  }
}
