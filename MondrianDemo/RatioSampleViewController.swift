//
//  RatioSampleViewController.swift
//  MondrianDemo
//
//  Created by muukii on 3/16/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import Foundation
import UIKit

import Mondrian

final class RatioSampleViewController : UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let _view = MyView()
    _view.mond.style.width = .points(100)
    _view.sizeToFit()
    _view.center = view.center

    view.addSubview(_view)
  }

  class MyView : MondrianView {

    let box = UIView()

    init() {

      super.init(frame: .zero)

      backgroundColor = .white
      box.backgroundColor = .red

    }

    override func layoutSpec() -> LayoutSpec {

      return
        InsetLayoutSpec(
          insets: .init(top: 8, left: 8, bottom: 8, right: 8),
          child: RatioLayoutSpec(ratio: 1, child: box)
      )
    }
  }
}

