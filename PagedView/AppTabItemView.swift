import UIKit

class AppTabItemView: UIView {

  private let title: String

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.font = .systemFont(ofSize: 18)
    label.textColor = .white
    label.text = title
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()

  lazy var borderView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemOrange
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()

  init(title: String) {
    self.title = title
    super.init(frame: .zero)

    translatesAutoresizingMaskIntoConstraints = false
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    backgroundColor = .systemBlue
    addSubview(titleLabel)

    NSLayoutConstraint.activate([
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
      titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }
}

extension AppTabItemView: TabItemProtocol {

  func onSelected() {

    titleLabel.font = .systemFont(ofSize: 18, weight: .bold)

    if borderView.superview == nil {
      addSubview(borderView)

      NSLayoutConstraint.activate([
        borderView.leftAnchor.constraint(equalTo: leftAnchor),
        borderView.rightAnchor.constraint(equalTo: rightAnchor),
        borderView.heightAnchor.constraint(equalToConstant: 5),
        borderView.bottomAnchor.constraint(equalTo: bottomAnchor)
      ])
    }
  }

  func onNotSelected() {
    titleLabel.font = .systemFont(ofSize: 18)
    layer.shadowOpacity = 0
    borderView.removeFromSuperview()
  }
}
