//
//  ViewController.swift
//  Sample
//
//  Created by 李二狗 on 2018/2/28.
//  Copyright © 2018年 Meniny Lab. All rights reserved.
//

import UIKit
import Eventer

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Eventer.post(EventName.didLoad.rawValue, on: .main)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Eventer.post(EventName.didAppear.rawValue, on: .main)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        Eventer.post(EventName.didDisAppear.rawValue, on: .main)
    }

}

