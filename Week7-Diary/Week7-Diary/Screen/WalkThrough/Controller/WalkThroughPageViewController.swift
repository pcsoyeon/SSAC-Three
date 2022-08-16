//
//  WalkThroughPageViewController.swift
//  Week7-Diary
//
//  Created by 소연 on 2022/08/16.
//

import UIKit

class WalkThroughPageViewController: UIPageViewController {
    
    // MARK: - Property
    
    // 1. 배열 형태로 뷰컨트롤러 추가
    var pageViewControllerList: [UIViewController] = []

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // create -> configure 순서로
        createPageViewController()
        configurePageViewController()
    }
    
    // MARK: - Custom Method
    
    // 2. 배열에 뷰컨트롤러 추가
    private func createPageViewController() {
        let sb = UIStoryboard(name: "WalkThrough", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: FirstViewController.reuseIdentifier) as! FirstViewController
        let vc2 = sb.instantiateViewController(withIdentifier: SecondViewController.reuseIdentifier) as! SecondViewController
        let vc3 = sb.instantiateViewController(withIdentifier: ThirdViewController.reuseIdentifier) as! ThirdViewController
        
        pageViewControllerList = [vc1, vc2, vc3]
    }
    
    // 3.
    private func configurePageViewController() {
        delegate = self
        dataSource = self
        
        // 4. display
        guard let first = pageViewControllerList.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
}

// MARK: - UIPageViewController Protocol

// 5. protocol
extension WalkThroughPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 현재 페이지뷰컨트롤러에 보이는 뷰컨의 인덱스 가져오기
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        // 이전 인덱스
        let previousIndex = viewControllerIndex - 1
        
        return previousIndex < 0 ? nil : pageViewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 현재 페이지뷰컨트롤러에 보이는 뷰컨의 인덱스 가져오기
        guard let viewControllerIndex = pageViewControllerList.firstIndex(of: viewController) else { return nil }
        
        // 이후 인덱스
        let nextIndex = viewControllerIndex + 1
        
        return nextIndex >= pageViewControllerList.count ? nil : pageViewControllerList[nextIndex]
    }
}
