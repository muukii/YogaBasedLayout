//
//  LayoutElementStyle.swift
//  Mondrian
//
//  Created by muukii on 3/8/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation

import YogaKit
import yoga

public enum AutoDimension {
  case auto  // for Xcode auto-completion
  case points(CGFloat)
  case fraction(CGFloat)

  var yogaValue: YGValue {
    switch self {
    case .auto:
      return YGValue.init(value: 0, unit: .auto)
    case .fraction(let fraction):
      return YGValue(value: Float(fraction * 100), unit: .percent)
    case .points(let points):
      return YGValue(value: Float(points), unit: .point)
    }
  }
}

public protocol UndefinedBehavior {}

public enum Max : UndefinedBehavior {}
public enum Min : UndefinedBehavior {}

public enum ConstraintDimension<T : UndefinedBehavior> {
  case undefined  // for Xcode auto-completion
  case points(CGFloat)
  case fraction(CGFloat)
}

extension ConstraintDimension where T == Max {
  var yogaValue: YGValue {
    switch self {
    case .undefined:
      return YGValue.init(value: .greatestFiniteMagnitude, unit: .undefined)
    case .fraction(let fraction):
      return YGValue(value: Float(fraction * 100), unit: .percent)
    case .points(let points):
      return YGValue(value: Float(points), unit: .point)
    }
  }
}

extension ConstraintDimension where T == Min {
  var yogaValue: YGValue {
    switch self {
    case .undefined:
      return YGValue.init(value: 0, unit: .undefined)
    case .fraction(let fraction):
      return YGValue(value: Float(fraction * 100), unit: .percent)
    case .points(let points):
      return YGValue(value: Float(points), unit: .point)
    }
  }
}

public struct LayoutElementStyle {

  public var width: AutoDimension = .auto

  public var height: AutoDimension = .auto

  public var minHeight: ConstraintDimension<Min> = .undefined

  public var maxHeight: ConstraintDimension<Max> = .undefined

  public var minWidth: ConstraintDimension<Min> = .undefined

  public var maxWidth: ConstraintDimension<Max> = .undefined

  public var alignSelf: AlignSelf = .auto

  public var flexGrow: CGFloat = 0

  public var flexShrink: CGFloat = 0

  func apply(to layout: YGLayout) {

    layout.width = width.yogaValue
    layout.height = height.yogaValue
    layout.minWidth = minWidth.yogaValue
    layout.minHeight = minHeight.yogaValue
    layout.maxWidth = maxWidth.yogaValue
    layout.maxHeight = maxHeight.yogaValue
    layout.alignSelf = alignSelf.yogaValue

    layout.flexGrow = flexGrow
    layout.flexShrink = flexShrink
    
  }

}