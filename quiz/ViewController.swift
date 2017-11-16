//
//  ViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/12.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBAction func startBtn(_ sender: UIButton) {
    }
    @IBAction func listBtn(_ sender: UIButton) {
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //背景イメージ画像
        myImageView.image = UIImage(named: "background.jpg")
        myImageView.alpha = 0.1
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

