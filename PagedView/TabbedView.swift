import UIKit

protocol TabbedViewDelegate: AnyObject {
  func didMoveToTab(at index: Int)
}

class TabbedView: UIView {

  enum SizeConfiguration {
    case fillEqually(height: CGFloat, spacing: CGFloat = 0)
    case fixed(width: CGFloat, height: CGFloat, spacing: CGFloat = 0)

    var height: CGFloat {
      switch self {
      case .fillEqually(let height, _):
        return height
      case .fixed(_, let height, _):
        return height
      }
    }
  }

  var delegate: TabbedViewDelegate?
  let sizeConfiguration: SizeConfiguration
  var tabs: [TabItemProtocol] {
    didSet {
      collectionView.reloadData()
      self.tabs[currentlySelectedIndex].onSelected()
    }
  }

  private var currentlySelectedIndex: Int = 0

  private lazy var collectionView: UICollectionView = {

    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.estimatedItemSize = .zero

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.backgroundColor = .white
    collectionView.register(TabCollectionViewCell.self, forCellWithReuseIdentifier: "TabCollectionViewCell")
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView

  }()

  init(sizeConfiguration: SizeConfiguration, tabs: [TabItemProtocol] = []) {
    self.sizeConfiguration = sizeConfiguration
    self.tabs = tabs
    super.init(frame: .zero)

    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {

    translatesAutoresizingMaskIntoConstraints = false
    addSubview(collectionView)

    NSLayoutConstraint.activate([
      collectionView.leftAnchor.constraint(equalTo: leftAnchor),
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.rightAnchor.constraint(equalTo: rightAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  // MARK: - Actions

  func moveToTab(at index: Int) {
    collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
    tabs[currentlySelectedIndex].onNotSelected()
    tabs[index].onSelected()
    currentlySelectedIndex = index
  }
}
// MARK: - UICollectionViewDelegateFlowLayout

extension TabbedView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {

    switch sizeConfiguration {

    case .fillEqually(height: let height, spacing: let spacing):
      let totalWidth = frame.width
      let widthPerItem = (totalWidth - (spacing * CGFloat(tabs.count + 1)) / CGFloat(tabs.count))
      return CGSize(width: widthPerItem, height: height)

    case .fixed(width: let width, height: let height, spacing: let spacing):
      return CGSize(width: width - (spacing * 2), height: height)
    }
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    switch sizeConfiguration {
    case let .fillEqually(_, spacing), let .fixed(_, _, spacing):
      return spacing
    }
  }
}

// MARK: - UICollectionViewDelegate

extension TabbedView: UICollectionViewDelegate {

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    moveToTab(at: indexPath.item)
    self.delegate?.didMoveToTab(at: indexPath.item)
  }

}

// MARK: - UICollectionViewDataSource

extension TabbedView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return tabs.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TabCollectionViewCell", for: indexPath) as? TabCollectionViewCell else { return UICollectionViewCell() }

    cell.view = tabs[indexPath.row]
    return cell
  }
}
