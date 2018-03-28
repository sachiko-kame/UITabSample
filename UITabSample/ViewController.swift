//
//  ViewController.swift
//  UITabSample
//
//  Created by 水野祥子 on 2018/01/28.
//  Copyright © 2018年 sachiko. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController,UIPageViewControllerDataSource,UIPageViewControllerDelegate,UICollectionViewDelegateFlowLayout{
    
    let pagelist = ["PAGE0", "PAGE1", "PAGE2", "PAGE3", "PAGE4", "PAGE5", "PAGE6", "PAGE7", "PAGE8", "PAGE9"]
    var pageControllergrop = [UIViewController]()
    
    var collectionView:UICollectionView!
    let labeheight:CGFloat = 60
    var page:Int = 0
    

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
        
        self.view.subviews
            .filter{ $0.isKind(of: UIScrollView.self) }
            .forEach{($0 as! UIScrollView).delegate = self }
        
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
            viewController.view.tag = i
            viewController.Set(Text:pagelist[i])
            self.pageControllergrop.append(viewController)
        }
    }
    


}

extension ViewController{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index:Int = pageControllergrop.index(of: viewController)!
        page = index
    
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
        page = index
        
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
    
    
    //実装に関係ありません
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]){
        if let viewController = pendingViewControllers[0] as? SampleViewController {
            // 2
            print("🦁\(viewController.view.tag)")
        }
    }
    
    
    //実装に関係ありません
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool){
        let a = pageViewController.viewControllers!.first!.view.tag
        print("🐢\(a)")
    }

}


extension ViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pagelist.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(cellType: SampleCollectionViewCell.self)
        let cell:SampleCollectionViewCell = collectionView.dequeueReusableCell(with: SampleCollectionViewCell.self, for: indexPath)
        cell.Set(Text:pagelist[indexPath.row])
        return cell
    }
    
    // Cell が選択された場合
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        //選択された所に遷移
        self.setViewControllers([pageControllergrop[indexPath.row]], direction: .forward, animated: false, completion: nil)
    }
    
}

extension ViewController{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.className ==  "UICollectionView"){
            return
        }
        let LeftRightJug = viewframewidth - scrollView.contentOffset.x
        if(LeftRightJug == 0){
            return
        }
        let Move = scrollView.contentOffset.x / 3
        let first:Int = LeftRightJug > 0 ? 1 : 0
        let End:Int = LeftRightJug > 0 ? (pagelist.count - 1) : (pagelist.count - 2)
        if(first < page && page < End){
            let pageWidth = CGFloat(page - 2) * viewframewidth //タブ真ん中に
            let TabPageWidth = pageWidth / 3
            
            collectionView.contentOffset = CGPoint(x:Move + TabPageWidth, y:0)
        }
    }
}

