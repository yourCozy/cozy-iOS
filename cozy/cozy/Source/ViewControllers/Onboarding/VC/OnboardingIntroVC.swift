//
//  OnboardingIntroVC.swift
//  cozy
//
//  Created by 최은지 on 2020/09/04.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class OnboardingIntroVC: UIViewController {

    @IBOutlet weak var introCollectionView: UICollectionView!
    @IBOutlet weak var onboardingSlider: OnboardingSlider!

    private let identifier1: String = "onboardcell1"
    private let identifier2: String = "onboardcell2"
    private let identifier3: String = "onboardcell3"
    private let identifier4: String = "onboardcell4"

    private var mysliderVal: Float = 25

    override func viewDidLoad() {
        super.viewDidLoad()
        setSlider()
        setNib()
        introCollectionView.delegate = self
        introCollectionView.dataSource = self
    }

    func setSlider() {
        onboardingSlider.setThumbImage(UIImage(), for: .normal)
        onboardingSlider.tintColor = .mango
        UIView.animate( withDuration: 0.1, animations: {
            self.onboardingSlider.setValue(0, animated: true)
        }, completion: { _ in
            UIView.animate(withDuration: 1.0, animations: {
                self.mysliderVal = 25
                self.onboardingSlider.setValue(self.mysliderVal, animated: true)
            })
        })
    }

    func setNib() {
        let introNib1 = UINib(nibName: "onboardcell1", bundle: nil)
        let introNib2 = UINib(nibName: "onboardcell2", bundle: nil)
        let introNib3 = UINib(nibName: "onboardcell3", bundle: nil)
        let introNib4 = UINib(nibName: "onboardcell4", bundle: nil)

        introCollectionView.register(introNib1, forCellWithReuseIdentifier: identifier1)
        introCollectionView.register(introNib2, forCellWithReuseIdentifier: identifier2)
        introCollectionView.register(introNib3, forCellWithReuseIdentifier: identifier3)
        introCollectionView.register(introNib4, forCellWithReuseIdentifier: identifier4)
    }
}

extension OnboardingIntroVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = introCollectionView.contentOffset.x
        let w = introCollectionView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        print(currentPage)

        if currentPage == 0 {
            UIView.animate( withDuration: 0.1, animations: {
                self.onboardingSlider.setValue(self.mysliderVal, animated: true)
            }, completion: { _ in
                UIView.animate(withDuration: 1.0, animations: {
                    self.mysliderVal = 25
                    self.onboardingSlider.setValue(self.mysliderVal, animated: true)
                })
            })
        } else if currentPage == 1 {
            UIView.animate( withDuration: 0.1, animations: {
                self.onboardingSlider.setValue(self.mysliderVal, animated: true)
            }, completion: { _ in
                UIView.animate(withDuration: 1.0, animations: {
                    self.mysliderVal = 50
                    self.onboardingSlider.setValue(self.mysliderVal, animated: true)
                })
            })
        } else if currentPage == 2 {
            UIView.animate( withDuration: 0.1, animations: {
                self.onboardingSlider.setValue(self.mysliderVal, animated: true)
            }, completion: { _ in
                UIView.animate(withDuration: 1.0, animations: {
                    self.mysliderVal = 75
                    self.onboardingSlider.setValue(self.mysliderVal, animated: true)
                })
            })
        } else if currentPage == 3 {
            UIView.animate( withDuration: 0.1, animations: {
                self.onboardingSlider.setValue(self.mysliderVal, animated: true)
            }, completion: { _ in
                UIView.animate(withDuration: 1.0, animations: {
                    self.mysliderVal = 100
                    self.onboardingSlider.setValue(self.mysliderVal, animated: true)
                })
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = introCollectionView.dequeueReusableCell(withReuseIdentifier: identifier1, for: indexPath) as! onboardcell1

            return cell
        } else if indexPath.row == 1 {
            let cell = introCollectionView.dequeueReusableCell(withReuseIdentifier: identifier2, for: indexPath) as! onboardcell2
            return cell
        } else if indexPath.row == 2 {
            let cell = introCollectionView.dequeueReusableCell(withReuseIdentifier: identifier3, for: indexPath) as! onboardcell3
            return cell
        } else {
            let cell = introCollectionView.dequeueReusableCell(withReuseIdentifier: identifier4, for: indexPath) as! onboardcell4
            return cell
        }
    }
}
