//
//  ViewController.swift
//  SYGalleryPicker
//
//  Created by IrvingHuang on 2019/11/5.
//  Copyright © 2019 Sinyi Realty Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func TA(_ sender: Any) {
        
        let vc = SYGalleryPickerViewController()
        vc.modalPresentationStyle = .fullScreen
        sy_presentGalleryPickerController(vc, animated: true, completion: nil)
    }
    
    @IBAction func IM(_ sender: Any) {
    }
    
    @IBAction func `default`(_ sender: Any) {
    }
    
    
    
}

