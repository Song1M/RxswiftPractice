//
//  ScrollExampleViewController.swift
//  RxSwift+MVVM
//
//  Created by 송황호 on 2021/05/17.
//  Copyright © 2021 iamchiwon. All rights reserved.
//

import UIKit

class ScrollExampleViewController: BaseViewController, Storyboard, UITableViewDataSource, UITableViewDelegate {
    
    weak var coordinator: AppCoordinator?
    
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var greenViewHeight: NSLayoutConstraint!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var tableViewHeight: NSLayoutConstraint!
    
 
    /* Pan Gesture */

    
    @objc func panAction (_ sender : UIPanGestureRecognizer){
        
        let maxScrOffY = maxContentOffsetY(scrollView)
        let scrOffY = scrollView.contentOffset.y
        
        let maxTabOffY = maxContentOffsetY(tableView)
        let tabOffY = tableView.contentOffset.y
        
        let velocityY = sender.velocity(in: scrollView).y / 50
        
        print(velocityY)
        
        /// 밑으로 스크롤 할 때
        if scrOffY - velocityY < 0 {
            // ------- scrollView 윗쪽 바운스
            scrollView.contentOffset.y = 0
            
        }
        else if scrOffY - velocityY > maxScrOffY {
            // ------- scrollView 아랫쪽 바운스
            scrollView.contentOffset.y = maxScrOffY
            tableView.contentOffset.y = (tabOffY - velocityY > maxTabOffY) ? maxTabOffY : tabOffY - velocityY
        }
        /// 위로 스크롤 할 때
        else { // ------- scrollView 바운스 없음
            if velocityY < 0 {
                scrollView.contentOffset.y = scrOffY - velocityY
            } else {
                if(tabOffY - velocityY < 0) {
                    tableView.contentOffset.y = 0
                    scrollView.contentOffset.y = scrOffY - velocityY
                } else {
                    tableView.contentOffset.y = tabOffY - velocityY
                }
            }
        }
        

    }
    
    /* Private Function */
    private func maxContentOffsetY(_ scrollView: UIScrollView) -> CGFloat {
        // 특정 UIScrollView 의 최대 offset 값 반환
        return scrollView.contentSize.height - scrollView.bounds.height
    }
    
    /* Life Cycle */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.isNavigationBarHidden = true
        // scroll view
        scrollView.isScrollEnabled = false
        
        let panGestureRecongnizer = UIPanGestureRecognizer(target: self, action: #selector(panAction(_:)))
        self.scrollView.addGestureRecognizer(panGestureRecongnizer)
        
        // table view
        tableView.isScrollEnabled = false
        tableViewHeight.constant = scrollView.bounds.height - greenViewHeight.constant - 40
    }
    
    /* Table View Delegate */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 40;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel!.text = "index \(indexPath.row + 1)"
        cell.backgroundColor = .clear
        return cell
    }
}

