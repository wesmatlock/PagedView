import UIKit

protocol TabItemProtocol: UIView {
  func onSelected()
  func onNotSelected()
}

class TabCollectionViewCell: UICollectionViewCell {

  override init(frame: CGRect) {
    super.init(frame: frame)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  var view: TabItemProtocol? {
    didSet {
      setupUI()
    }
  }

  private func setupUI() {
    
  }
}
