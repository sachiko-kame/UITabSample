//
//  ViewController.swift
//  UITabSample
//
//  Created by 水野祥子 on 2018/01/28.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UICollectionViewDelegateFlowLayout{
    
    let viewframewidth:CGFloat = UIScreen.main.bounds.size.width
    var statusBarHeight:CGFloat = UIApplication.shared.statusBarFrame.height
    
    let pagelist = ["PAGE0", "PAGE1", "PAGE2", "PAGE3", "PAGE4"]
    var pageControllergrop = [UIViewController]()
    
    var collectionView:UICollectionView!
    let labeheight:CGFloat = 60
    

    required init?(coder aDecoder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makeViewcontoller()
        self.setViewControllers([pageControllergrop.first!], direction: .forward, animated: false, completion: nil)
        
        
        // collectionViewレイアウト作成
        CollectionViewLayoutSet()
        
        // collectionViewその他設定
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delaysContentTouches = false
        
        //デリゲートの設定(PageViewControllerとUICollectionView)
        dataSource = self
        delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func CollectionViewLayoutSet(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width:viewframewidth / 3 ,  height:CGFloat(labeheight))
        let rec = CGRect(x: 0.0, y:statusBarHeight , width:viewframewidth , height: labeheight)
        collectionView = UICollectionView(frame: rec, collectionViewLayout: flowLayout)
    }
    
    func makeViewcontoller(){
        for i in 0...(pagelist.count - 1){
            let viewController:SampleViewController = SampleViewController()
            let Label = UILabel(frame:CGRect.zero)
            Label.frame.size = CGSize(width:viewframewidth, height:100)
            Label.center = viewController.view.center
            Label.text = pagelist[i]
            Label.textAlignment = .center
            Label.layer.borderColor = UIColor.blue.cgColor
            Label.layer.borderWidth = 1
            viewController.view.backgroundColor = .white
            viewController.view.addSubview(Label)
            self.pageControllergrop.append(viewController)
        }
    }
    


}

extension ViewController{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index:Int = pageControllergrop.index(of: viewController)!
    
        view.viewWithTag(index + 1)?.backgroundColor = UIColor.gray
        //1ページ何もしない
        switch index {
        case 0:
            return nil
        default:
            //2だったら1に、　3だったら2に
            return pageControllergrop[index-1]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index:Int = pageControllergrop.index(of: viewController)!
        
        view.viewWithTag(index + 1)?.backgroundColor = UIColor.gray
        switch index {
        //最終ページ何もしない
        case pageControllergrop.count-1:
            return nil
        default:
            //最終ページでない場合進める
            return pageControllergrop[index+1]
        }
        
    }
}


extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagelist.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(cellType: SampleCollectionViewCell.self)
        let cell:SampleCollectionViewCell = collectionView.dequeueReusableCell(with: SampleCollectionViewCell.self, for: indexPath)
        cell.CategoryNameLabel.text = pagelist[indexPath.row]
        cell.Set()
        return cell
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        //選択された所に遷移
        self.setViewControllers([pageControllergrop[indexPath.row]], direction: .forward, animated: false, completion: nil)
    }
    
}

