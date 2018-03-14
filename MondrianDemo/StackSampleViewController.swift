//
//  StackSampleViewController.swift
//  MondrianDemo
//
//  Created by muukii on 3/15/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

import Mondrian

final class StackSampleViewController : UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    let _view = MyView()
    _view.sizeToFit()

    view.addSubview(_view)
  }

  class MyView : MondrianView {

    let titleLabel = UILabel()
    let detailLabel = UILabel()

    init() {

      super.init(frame: .zero)

      backgroundColor = .white
      titleLabel.text = "Book Title"
      detailLabel.text = "Boot detail"

    }

    override func layoutSpec() -> LayoutSpec {

      let body = StackLayoutSpec(
        direction: .vertical,
        spacing: 8,
        justifyContent: .end,
        alignItems: .start,
        flexWrap: .noWrap,
        children: [
          titleLabel,
          detailLabel,
          ]
      )

      let inset = InsetLayoutSpec(
        insets: .init(top: 16, left: 16, bottom: 16, right: 16),
        child: body
      )

      return inset
    }
  }
}
