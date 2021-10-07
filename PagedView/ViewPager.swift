import UIKit

class ViewPager: UIView {

  let sizeConfiguration: TabbedView.SizeConfiguration
  let pagedView = PagedView()

  lazy var tabbedView: TabbedView = {
    let tabbedView = TabbedView(sizeConfiguration: sizeConfiguration)
    return tabbedView
  }()

  init(tabSizeConfiguration: TabbedView.SizeConfiguration) {
    sizeConfiguration = tabSizeConfiguration
    super.init(frame: .zero)

    setupUI()

    tabbedView.delegate = self
    pagedView.delegate = self
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupUI() {
    translatesAutoresizingMaskIntoConstraints = false

    addSubview(tabbedView)
    addSubview(pagedView)

    NSLayoutConstraint.activate([
      tabbedView.leftAnchor.constraint(equalTo: leftAnchor),
      tabbedView.topAnchor.constraint(equalTo: topAnchor),
      tabbedView.rightAnchor.constraint(equalTo: rightAnchor),
      tabbedView.heightAnchor.constraint(equalTo: heightAnchor)
    ])

    NSLayoutConstraint.activate([
      pagedView.leftAnchor.constraint(equalTo: leftAnchor),
      pagedView.topAnchor.constraint(equalTo: tabbedView.bottomAnchor),
      pagedView.rightAnchor.constraint(equalTo: rightAnchor),
      pagedView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
}

extension ViewPager: TabbedViewDelegate {
  func didMoveToTab(at index: Int) {
    pagedView.moveToPage(as: index)
  }
}

extension ViewPager: PagedViewDelegate {
  func didMoveToPage(index: Int) {
    tabbedView.moveToTab(at: index)
  }
}
