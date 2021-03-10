//
//  CompetitionCenterVC.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/2.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class CompetitionCenterVC: BaseViewController {
    
    let viewModel = CompetitionCenterVM()
    
    var tableView:UITableView!
    
    let locationImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = false
        view.clipsToBounds = true
        view.image = UIImage(named: "locate_img")
        return view
    }()
    
    let univercityLabel: UILabel = {
        let view =  UILabel()
        view.textColor = .black
        view.font = UIFont.pf_regular(16)
        view.text = DataManager.shared.user?.college.university.universityName
        return view
    }()
    
    let chatButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "communicate"), for: .normal)
        view.imageView?.contentMode = .center
        view.imageView?.clipsToBounds = true
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        tableView = BaseTableView.init(frame: self.view.frame,style: .plain)
        tableView.backgroundColor = UIColor.backgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets.init(top: App.naviStatusHeight, left: 0, bottom: App.tabBarHeight + App.safeAreaBottom, right: 0)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.register(CompetitionsView.self, forCellReuseIdentifier: "CompetitionsView")
        tableView.register(BannerViewCell.self, forCellReuseIdentifier: "BannerViewCell")
        tableView.register(AnnouncementTableView.self, forCellReuseIdentifier: "AnnouncementTableView")
        
        self.view.addSubview(tableView)
        self.navigationView.addSubview(locationImage)
        self.navigationView.addSubview(univercityLabel)
        
        headerRefresh()
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        locationImage.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(15)
            make.centerY.equalTo(self.navigationView.titleLabel)
            make.width.equalTo(14)
            make.height.equalTo(40)
        }
        
        univercityLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(locationImage.snp.trailing).offset(5)
            make.centerY.equalTo(self.navigationView.titleLabel)
            make.width.lessThanOrEqualTo(250)
            make.height.equalTo(40)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.backgroundColor
        self.navigationView.rightView = chatButton
        self.navigationView.backgroundColor = UIColor.backgroundColor
        
        tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(headerRefresh))
    }
    
    override func bindViewModel() {
        super.bindViewModel()
    }
    
    @objc func headerRefresh() {
        viewModel.competitionsVM.getCompetitionTypes {(error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
        }
        
        viewModel.getBanner { (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
        }
        
        viewModel.getCompAnnouncement {[weak self] (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            self?.tableView.reloadData()
        }

        viewModel.getSysAnnouncement {[weak self] (error) in
            if let error = error {
                ErrorAlertView.show(error: error, style: .topError)
                return
            }
            self?.tableView.reloadData()
        }
        
        (tableView.mj_header as? MJRefreshNormalHeader)?.endRefreshing()
    }
}

extension CompetitionCenterVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        if indexPath.row == 0 {
            height = BannerViewCell.itemSize.height + 15
        } else if indexPath.row == 1 {
            height = 340
        } else if indexPath.row == 2 {
            height = viewModel.compAnnouncementTableVM.height
        } else if indexPath.row == 3 {
            height = viewModel.sysAnnouncementTableVM.height
        }
        
        return height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension CompetitionCenterVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == 0 {
            let bannerViewCell = tableView.dequeueReusableCell(withIdentifier: "BannerViewCell", for: indexPath) as! BannerViewCell
            bannerViewCell.bindViewModel(viewModel: viewModel.bannerViewModel)
            cell = bannerViewCell
        } else if indexPath.row == 1 {
            let competitionsView = tableView.dequeueReusableCell(withIdentifier: "CompetitionsView", for: indexPath) as! CompetitionsView
            competitionsView.bindViewModel(viewModel: viewModel.competitionsVM)
            cell = competitionsView
        } else if indexPath.row == 2 {
            let compAnnouncementTableView = tableView.dequeueReusableCell(withIdentifier: "AnnouncementTableView", for: indexPath) as! AnnouncementTableView
            compAnnouncementTableView.bindViewModel(viewModel: viewModel.compAnnouncementTableVM)
            cell = compAnnouncementTableView
        } else {
            let sysAnnouncementTableView = tableView.dequeueReusableCell(withIdentifier: "AnnouncementTableView", for: indexPath) as! AnnouncementTableView
            sysAnnouncementTableView.bindViewModel(viewModel: viewModel.sysAnnouncementTableVM)
            cell = sysAnnouncementTableView
        }
        
        return cell
    }
}
