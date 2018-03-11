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

extension MondrianViewType where Self : UIView {

  public func applyLayoutSpec() {
    _ = defineLayout(target: self)
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
