//: [Previous](@previous)

import Mondrian
import PlaygroundSupport

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

let view = MyView()
view.sizeToFit()

print(view.subviews[0].subviews[0].subviews)

PlaygroundPage.current.liveView = view

//: [Next](@next)
