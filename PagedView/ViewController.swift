import UIKit

class ViewController: UIViewController {


  lazy var viewPager: ViewPager = {
    let viewPager = ViewPager(tabSizeConfiguration: .fillEqually(height: 60, spacing: 0))

    let view1 = UIView()
    view1.backgroundColor = .red

    let view2 = UIView()
    view2.backgroundColor = .blue

    let view3 = UIView()
    view3.backgroundColor = .green

    viewPager.tabbedView.tabs = []

    return viewPager
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    overrideUserInterfaceStyle = .light
    view.backgroundColor = .white
    view.addSubview(viewPager)
  }


}

