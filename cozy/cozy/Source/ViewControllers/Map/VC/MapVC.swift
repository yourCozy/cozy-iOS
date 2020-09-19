//
//  MapVC.swift
//  cozy
//
//  Created by 최은지 on 2020/08/18.
//  Copyright © 2020 최은지. All rights reserved.
//

import UIKit

class MapVC: UIViewController {

    private let mapIdentifier1: String = "mapSelectCell"
    private let mapIdentifier2: String = "bookListCell"

    @IBOutlet weak var mapTableView: UITableView!

    private var selectIdx: Int = 1
    private var backView = UIView()
    @IBOutlet weak var readyLabel: UILabel!

    private var mapList: [MapListData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addObserver()
        setMapTableView()
        getMapData()
    }

    private func getMapData() {
        if isUserLoggedIN() == true {
            getMapListDataWithLogin()
        } else {
            getMapListData()
        }
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(selectEvent(_:)), name: .dismissSlideView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(getRefreshData), name: .dismissDetailVC, object: nil)
    }

    @objc func selectEvent(_ notification: NSNotification) {
        let getIdx = notification.object as! Int
        self.selectIdx = getIdx
        self.backView.isHidden = true
        getMapData()
    }

    @objc func getRefreshData() {
        getMapData()
    }

    func setMapTableView() {
        readyLabel.isHidden = true
        let nibName = UINib(nibName: "BookListCell", bundle: nil)
        mapTableView.register(nibName, forCellReuseIdentifier: mapIdentifier2)
        mapTableView.delegate = self
        mapTableView.dataSource = self
    }

    func isUserLoggedIN() -> Bool {
        let str = UserDefaults.standard.object(forKey: "token") as! String
        if str.count > 0 {
            return true
        } else {
            return false
        }
    }

    @objc func selectButton() {
        let storybaord = UIStoryboard(name: "Map", bundle: nil)
        let pvc = storybaord.instantiateViewController(identifier: "MapSelectVC") as! MapSelectVC

        pvc.transitioningDelegate = self
        pvc.modalPresentationStyle = .custom

        self.backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)

        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.addSubview(backView)
        self.backView.isHidden = false
        present(pvc, animated: true, completion: nil)
    }

    private func getMapListData() {
        MapListService.shared.getMapListData(mapIdx: self.selectIdx+1) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [MapListData] else { return }
                self.mapList.removeAll()
                for data in data {
                    self.mapList.append(MapListData(bookstoreIdx: data.bookstoreIdx ?? 0, bookstoreName: data.bookstoreName ?? "", location: data.location ?? "", hashtag1: data.hashtag1 ?? "코지와", hashtag2: data.hashtag2 ?? "함께하는", hashtag3: data.hashtag3 ?? "책방", mainImg: data.mainImg ?? "", checked: data.checked ?? 0))
                }
                self.mapTableView.reloadData()
                self.readyLabel.isHidden = true
            case .requestErr:
                self.mapList.removeAll()
                self.mapTableView.reloadData()
                self.readyLabel.isHidden = false
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

    private func getMapListDataWithLogin() {
        MapListService.shared.getMapListDataWithLogin(mapIdx: self.selectIdx+1) { NetworkResult in
            switch NetworkResult {
            case .success(let data):
                guard let data = data as? [MapListData] else { return }
                self.mapList.removeAll()
                for data in data {
                    self.mapList.append(MapListData(bookstoreIdx: data.bookstoreIdx ?? 0, bookstoreName: data.bookstoreName ?? "", location: data.location ?? "", hashtag1: data.hashtag1 ?? "코지와", hashtag2: data.hashtag2 ?? "함께하는", hashtag3: data.hashtag3 ?? "책방", mainImg: data.mainImg ?? "", checked: data.checked ?? 0))
                }
                self.mapTableView.reloadData()
                self.readyLabel.isHidden = true
            case .requestErr:
                self.mapList.removeAll()
                self.mapTableView.reloadData()
                self.readyLabel.isHidden = false
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }

    private func updateInterest(bookstoreIdx: Int) {
        UpdateInterestService.shared.getMapListData(bookstoreIdx: bookstoreIdx) { NetworkResult in
            switch NetworkResult {
            case.success(let data):
                guard let data = data as? UpdateInterestData else { return }
                print(data)
            case .requestErr:
                print("Request error")
            case .pathErr:
                print("path error")
            case .serverErr:
                print("server error")
            case .networkFail:
                print("network error")
            }
        }
    }
}

extension MapVC: UITableViewDelegate, UITableViewDataSource, UIViewControllerTransitioningDelegate, MapSelectCellDelegate, BookListCellDelegate {

    func addBookmark(index: Int) {
        let indexPath = IndexPath(row: index, section: 1)
        let cell = self.mapTableView.cellForRow(at: indexPath) as! BookListCell
        let bookstoreIdx = self.mapList[index].bookstoreIdx

        let token = UserDefaults.standard.object(forKey: "token") as! String
        if token.count > 0 {
            if cell.bookMarkButton.hasImage(named: "iconsavewhite", for: .normal) {
                cell.bookMarkButton.setImage(UIImage(named: "iconsavefull"), for: .normal)
                let alert = UIAlertController(title: "콕!", message: "관심 책방에 등록되었습니다.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.updateInterest(bookstoreIdx: bookstoreIdx!)
            } else {
                let cancelAlert = UIAlertController(title: "관심 책방에서 삭제하시겠어요?", message: "관심책방 등록을 삭제하시면, 관심책방에서 다시 볼 수 없어요.", preferredStyle: UIAlertController.Style.alert)
                cancelAlert.addAction(UIAlertAction(title: "네", style: .default, handler: { (_: UIAlertAction!) in
                    cell.bookMarkButton.setImage(UIImage(named: "iconsavewhite"), for: .normal)
                    self.updateInterest(bookstoreIdx: bookstoreIdx!)
                }))
                cancelAlert.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: { (_: UIAlertAction!) in
                    cancelAlert.dismiss(animated: true, completion: nil)
                }))
                self.present(cancelAlert, animated: true, completion: nil)
            }
        } else {
            let needLoginAlert = UIAlertController(title: "로그인 한 회원만 이용할 수 있어요!", message: "내 정보 탭에 들어가서 로그인을 해주세요.", preferredStyle: UIAlertController.Style.alert)
            needLoginAlert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(needLoginAlert, animated: true, completion: nil)
        }
    }

    func selectRegionButton() {
        let storybaord = UIStoryboard(name: "Map", bundle: nil)
        let pvc = storybaord.instantiateViewController(identifier: "MapSelectVC") as! MapSelectVC

        pvc.transitioningDelegate = self
        pvc.modalPresentationStyle = .custom

        self.backView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)

        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        window?.addSubview(backView)
        self.backView.isHidden = false
        present(pvc, animated: true, completion: nil)
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfSizePresentationController(presentedViewController: presented, presenting: presenting)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "BookDetail", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "BookDetailVC") as! BookDetailVC
        vc.bookstoreIdx = self.mapList[indexPath.row].bookstoreIdx!
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.mapList.count
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 106
        } else {
            return 370
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: mapIdentifier1) as! MapSelectCell
            cell.selectionStyle = .none
            cell.delegate = self

            switch self.selectIdx {
            case 0:
                cell.selectRegionButton1.setTitle("용산구", for: .normal)
            case 1:
                cell.selectRegionButton1.setTitle("마포구", for: .normal)
            case 2 :
                cell.selectRegionButton1.setTitle("관악구, 영등포구, 강서구", for: .normal)
            case 3 :
                cell.selectRegionButton1.setTitle("광진구, 노원구, 성북구", for: .normal)
            case 4:
                cell.selectRegionButton1.setTitle("서초구, 강남구, 송파구", for: .normal)
            case 5:
                cell.selectRegionButton1.setTitle("서대문구, 종로구", for: .normal)
            default:
                cell.selectRegionButton1.setTitle("마포구", for: .normal)
            }

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: mapIdentifier2) as! BookListCell
            cell.selectionStyle = .none
            cell.index = indexPath.row
            cell.delegate = self

            if self.mapList[indexPath.row].mainImg?.count != 0 {
                let imgurl = URL(string: self.mapList[indexPath.row].mainImg ?? "")
                cell.bookStoreImageView.kf.setImage(with: imgurl)
                cell.readyLabel.isHidden = true
            }

            cell.nameLabel.text = self.mapList[indexPath.row].bookstoreName
            cell.addressLabel.text = self.mapList[indexPath.row].location

            cell.tag1.setTitle("    #\(self.mapList[indexPath.row].hashtag1  ?? "")    ", for: .normal)
            cell.tag2.setTitle("    #\(self.mapList[indexPath.row].hashtag2 ?? "")    ", for: .normal)
            cell.tag3.setTitle("    #\(self.mapList[indexPath.row].hashtag3 ?? "")    ", for: .normal)

            if self.mapList[indexPath.row].checked == 0 {
                cell.bookMarkButton.setImage(UIImage(named: "iconsavewhite"), for: .normal)
            } else {
                cell.bookMarkButton.setImage(UIImage(named: "iconsavefull"), for: .normal)
            }

            return cell
        }
    }
}

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else {
                return CGRect.zero
            }
            return CGRect(x: 0, y: theView.bounds.height-563, width: theView.bounds.width, height: 563)
        }
    }
}
