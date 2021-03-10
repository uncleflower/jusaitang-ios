//
//  BannerViewCell.swift
//  jusaitang
//
//  Created by Jiehao Zhang on 2021/3/9.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift
import CHIPageControl

class BannerViewCell: UITableViewCell {
    
    static var itemSize: CGSize{
        return CGSize.init(width: App.screenWidth, height: (App.screenWidth - 10.0 * 2) * (1.0/3.0) + 20)
    }
    
    private let disposeBag = DisposeBag()
    
    let bannerView: CycleScrollView = {
        let view = CycleScrollView(frame: CGRect.init(
            origin: .zero,
            size: BannerViewCell.itemSize))
        view.backgroundColor = .clear
        return view
    }()
    
    let pageControl: CHIPageControlAji = {
        let view = CHIPageControlAji()
        view.radius = 2.5
        view.tintColor = UIColor(hexString: "#FFFFFF", alpha: 0.5)
        view.currentPageTintColor = UIColor.white
        view.padding = 4
        view.progress = 0.5
        return view
    }()
    
    var viewModel:BannerViewModel?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        bannerView.delegate = self
        bannerView.dataSource = self
        bannerView.register(BannerScrollViewCell.self, forCellWithReuseIdentifier: "BannerScrollViewCell")
        bannerView.autoScroll()
        contentView.addSubview(bannerView)
        contentView.addSubview(pageControl)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindViewModel(viewModel:BannerViewModel){
        self.viewModel = viewModel
        viewModel.bannerItemViewModels.subscribe {[weak self] (viewModels)in
            if let count =  try? viewModel.bannerItemViewModels.value().count{
                self?.pageControl.numberOfPages = count
                self?.pageControl.set(progress: 0, animated: true)
            }
            self?.bannerView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    func makeConstraints() {
        bannerView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(bannerView.snp.bottom).offset(-12)
            make.centerX.equalToSuperview()
            make.width.equalTo(bannerView.snp.width)
            make.height.equalTo(7)
        }
    }
}

extension BannerViewCell:CycleScrollViewDelegate{
    func cycleScrollView(_ cycleScrollView: CycleScrollView, cellForItemAt item: Int) -> CycleScrollViewCell{
        let cell = cycleScrollView.dequeueReusableCell(withReuseIdentifier: "BannerScrollViewCell", for: item) as! BannerScrollViewCell
        if let value = try? viewModel?.bannerItemViewModels.value(){
            cell.bindViewModel(viewModel:value[item])
        }
        return cell
    }
    
    func cycleScrollView(_ collectionView: CycleScrollView, didSelectItemAt item: Int) {
        guard let id = try? viewModel?.bannerItemViewModels.value()[item].model.id else {return}
        Router.openCompetitionDetail(id: id)
    }
    
    
    func cycleScrollViewDidScroll(_ cycleScrollView: CycleScrollView){
        if cycleScrollView.page != pageControl.currentPage {
            self.pageControl.set(progress: cycleScrollView.page, animated: true)
        }
    }
}

extension BannerViewCell: CycleScrollViewDataSource{
    func numberOfItems(_ collectionView: CycleScrollView) -> Int {
        if let count =  try? viewModel?.bannerItemViewModels.value().count{
            return count
        }
        return 0
    }
}

