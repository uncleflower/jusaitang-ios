//
//  TeamPagingViewController.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/5.
//

import UIKit
import JXSegmentedView
import RxSwift
import RxCocoa

class TeamPagingViewController: BaseViewController {
    
    public let disposeBag = DisposeBag()
    
    var titles = ["组队", "我的队伍", "队伍申请"]
    let dataSource: JXSegmentedTitleDataSource = JXSegmentedTitleDataSource()
    var hotReloadModel : Bool = false
    
    var categoryView: JXSegmentedView = JXSegmentedView()
    
    lazy var segmentedListContainerView: JXSegmentedListContainerView = preferredSegmentedListContainerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.titles = titles
        dataSource.titleSelectedColor = UIColor(hexString: "#333333")!
        dataSource.titleSelectedFont = UIFont.pf_semibold(18)
        dataSource.titleNormalColor = UIColor(hexString: "#999999")!
        dataSource.titleNormalFont  = UIFont.pf_semibold(14)
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isTitleZoomEnabled = true
        
        self.categoryView.backgroundColor = UIColor.backgroundColor
        self.categoryView.delegate = self
        self.categoryView.isContentScrollViewClickTransitionAnimationEnabled = false
        self.categoryView.dataSource = dataSource
        self.categoryView.listContainer = self.segmentedListContainerView
        
        self.navigationView.backgroundColor = .backgroundColor
        self.navigationView.titleLabel.text = "组队"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (self.categoryView.selectedIndex == 0);
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = UIColor.backgroundColor
        self.view.addSubview(categoryView)
        self.view.addSubview(self.segmentedListContainerView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        self.categoryView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(App.naviStatusHeight)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(App.navigationBarHeight)
        }
        
        self.segmentedListContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(categoryView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func preferredSegmentedListContainerView() -> JXSegmentedListContainerView {
        return JXSegmentedListContainerView(dataSource: self)
    }
}

extension TeamPagingViewController: JXSegmentedViewDelegate {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = (index == 0)
    }
}

extension TeamPagingViewController: JXPagingMainTableViewGestureDelegate {
    func mainTableViewGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //禁止segmentedView左右滑动的时候，上下和左右都可以滚动
        if otherGestureRecognizer == self.categoryView.collectionView.panGestureRecognizer { return false }
        return gestureRecognizer.isKind(of: UIPanGestureRecognizer.self) && otherGestureRecognizer.isKind(of: UIPanGestureRecognizer.self)
    }
}


extension TeamPagingViewController: JXSegmentedListContainerViewDataSource {
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        return 5
    }
    
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        if index == 0 {
            return OrganizeTeamVC()
        } else if index == 1 {
            return MyTeamViewController()
        } else  {
            return TeamApplyViewController()
        }
    }
}
