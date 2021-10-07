import UIKit

protocol PagedViewDelegate: AnyObject {
  func didMoveToPage(index: Int)
}

class PagedView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

  weak var delegate: PagedViewDelegate?
  var pages: [UIView] {
    didSet {
      self.collectionView.reloadData()
    }
  }

  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.isPagingEnabled = true
    collectionView.register(PageCollectionViewCell.self, forCellWithReuseIdentifier: "PageCollectionViewCell")
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()


  init(pages: [UIView] = []) {
    self.pages = pages
    super.init(frame: .zero)
    setupUI()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - SetupUI

  private func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(collectionView)
    collectionView.backgroundColor = .white

    NSLayoutConstraint.activate([
      collectionView.widthAnchor.constraint(equalTo: widthAnchor),
      collectionView.heightAnchor.constraint(equalTo: heightAnchor),
      collectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
      collectionView.centerYAnchor.constraint(equalTo: centerYAnchor)
    ])
  }


  // MARK: - Data Source

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return pages.count
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PageCollectionViewCell", for: indexPath) as? PageCollectionViewCell else {
      return UICollectionViewCell()
    }

    cell.view = pages[indexPath.item]
    return cell
  }

  func moveToPage(as index: Int) {
    collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
  }

  // MARK: - Delegate

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return  CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  
}
