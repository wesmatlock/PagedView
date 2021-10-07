import UIKit

class PageCollectionViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var view: UIView? {
    didSet {
      setupUI()
    }
  }

  private func setupUI() {
    guard let view = view else { return }

    contentView.addSubview(view)
    view.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      view.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      view.topAnchor.constraint(equalTo: contentView.topAnchor),
      view.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }

}
