//
//  ViewController.swift
//  MondrianDemo
//
//  Created by muukii on 3/10/18.
//  Copyright © 2018 muukii. All rights reserved.
//

import UIKit

import Mondrian

class ProfileCardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  private lazy var sizingCell = ProfileCell(frame: .zero)

  private let collectionView: UICollectionView = {

    let layout = UICollectionViewFlowLayout()

    layout.sectionInset = .zero
    layout.minimumLineSpacing = 0
    layout.minimumInteritemSpacing = 0

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white

    collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: "ProfileCell")

    return collectionView
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(collectionView)

    collectionView.frame = view.bounds
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    collectionView.delegate = self
    collectionView.dataSource = self
  }

  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 100
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    let size = sizingCell.size(maxWidth: collectionView.bounds.width)

    return size

  }
}

extension ProfileCardViewController {

  private final class ProfileCell : UICollectionViewCell, MondrianViewType {

    private let imageView: UIView = .init()

    private let postsLabel: UILabel = .init()

    private let postsCaptionLabel: UILabel = .init()

    private let followersLabel: UILabel = .init()

    private let followersCaptionLabel: UILabel = .init()

    private let followingLabel: UILabel = .init()

    private let followingCaptionLabel: UILabel = .init()

    private let promoteButton: UIButton = .init(type: .system)

    private let editProfileButton: UIButton = .init(type: .system)

    private let settingsButton: UIButton = .init(type: .system)

    private let nicknameLabel: UILabel = .init()

    private let categoryLabel: UILabel = .init()

    private let introduceLabel: UILabel = .init()

    private let urlLabel: UILabel = .init()

    override init(frame: CGRect) {
      super.init(frame: .zero)

      postsLabel.text = "668"
      postsCaptionLabel.text = "posts"

      followersLabel.text = "292"
      followersCaptionLabel.text = "followers"

      followingLabel.text = "750"
      followingCaptionLabel.text = "following"

      nicknameLabel.text = "muukii"
      categoryLabel.text = "iOS Engineer"

      introduceLabel.text = "🚀🚀🚀🚀"

      urlLabel.text = "https://muukii.design"

      promoteButton.setTitle("Promote", for: .normal)
      editProfileButton.setTitle("Edit Profile", for: .normal)
      settingsButton.setTitle("Settings", for: .normal)

      imageView.backgroundColor = UIColor.init(white: 0.9, alpha: 1)

      mond.applyLayoutSpec()
    }

    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
      super.layoutSubviews()

      mond.relayout()

      imageView.layer.cornerRadius = imageView.bounds.width / 2
      imageView.layer.masksToBounds = true
    }

    func size(maxWidth: CGFloat?) -> CGSize {

      if let maxWidth = maxWidth {
        mond.style.width = .points(maxWidth)
      }

      mond.relayout(layoutMode: .flexibleHeight)

      let size = self.bounds.size
      return size
    }

    func layoutSpec() -> LayoutSpec {

      let wrapper = StackLayoutSpec(
        direction: .vertical,
        spacing: 4,
        justifyContent: .start,
        alignItems: .stretch,
        children: [

          StackLayoutSpec(
            direction: .horizontal,
            spacing: 16,
            justifyContent: .start,
            alignItems: .start,
            children: [

              // image

              imageView.mond.styled { (style) in
                style.width = .points(60)
                style.height = .points(60)
              },

              // buttons

              StackLayoutSpec(
                direction: .vertical,
                spacing: 4,
                justifyContent: .start,
                alignItems: .stretch,
                styled: {
                  $0.flexGrow = 1
              },
                children: [

                  StackLayoutSpec(
                    direction: .horizontal,
                    spacing: 4,
                    justifyContent: .spaceBetween,
                    alignItems: .start,
                    styled: {
                      $0.flexGrow = 1
                  },
                    children: [

                      StackLayoutSpec(
                        direction: .vertical,
                        spacing: 4,
                        justifyContent: .start,
                        alignItems: .center,
                        children: [
                          postsLabel,
                          postsCaptionLabel,
                        ]
                      ),

                      StackLayoutSpec(
                        direction: .vertical,
                        spacing: 4,
                        justifyContent: .start,
                        alignItems: .center,
                        children: [
                          followersLabel,
                          followersCaptionLabel,
                          ]
                      ),

                      StackLayoutSpec(
                        direction: .vertical,
                        spacing: 4,
                        justifyContent: .start,
                        alignItems: .center,
                        children: [
                          followingLabel,
                          followingCaptionLabel,
                          ]
                      ),

                    ]
                  ),

                  StackLayoutSpec(
                    direction: .horizontal,
                    spacing: 4,
                    justifyContent: .start,
                    alignItems: .start,
                    styled: {
                      $0.flexGrow = 1
                  },
                    children: [

                      promoteButton,

                      editProfileButton,

                      settingsButton,

                    ]
                  )

                ]
              )

            ]
          ),

          StackLayoutSpec(
            direction: .vertical,
            spacing: 4,
            justifyContent: .start,
            alignItems: .start,
            children: [

              nicknameLabel,

              categoryLabel,

              introduceLabel,

              urlLabel,
            ]
          )

        ]
      )


      return EntryPoint(
        rootView: contentView,
        child: InsetLayoutSpec.init(insets: .init(top: 16, left: 16, bottom: 16, right: 16), child: wrapper)
      )
    }

  }
}
