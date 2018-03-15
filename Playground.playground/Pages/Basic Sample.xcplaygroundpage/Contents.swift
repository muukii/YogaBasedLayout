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
    titleLabel.numberOfLines = 0
    detailLabel.numberOfLines = 0

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

view.sizeToFit()

//view.mond.style.width = .points(50)
//view.mond.style.height = .points(2000)

view.yoga.intrinsicSize
view.mond.calculateSize(with: .fixedWidth(60))

PlaygroundPage.current.liveView = view

//: [Next](@next)
