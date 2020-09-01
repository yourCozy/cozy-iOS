//
//  PageVC.swift
//  cozy
//
//  Created by 양재욱 on 2020/09/01.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    lazy var VCArray: [UIViewController] = {

        return [self.VCInstance(name: "vc0"),
                self.VCInstance(name: "vc1"),
                self.VCInstance(name: "vc2"),
                self.VCInstance(name: "vc3")]
    }()

    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "SlideOnboarding", bundle: nil).instantiateViewController(withIdentifier: name)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        if previousIndex < 0 {
            return nil
        }

        guard previousIndex >= 0 else {
            return VCArray.last
        }

        guard VCArray.count > previousIndex else {
            return nil
        }

        return VCArray[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArray.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1

        if nextIndex == 4 {
            return nil
        }

        guard nextIndex < VCArray.count else {
            return VCArray.first
        }

        guard VCArray.count > nextIndex else {
            return nil
        }

        return VCArray[nextIndex]
    }

    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = VCArray.firstIndex(of: firstViewController) else {
            return 0
        }

        return firstViewControllerIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self

        if let firstVC = VCArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

}
