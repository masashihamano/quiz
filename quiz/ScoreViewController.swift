//
//  ScoreViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/23.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit


class ScoreViewController: UIViewController {

    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var myImageView: UIImageView!
    
    
    var scoreNum: Int = 0
    
//QuizControllerより引き渡される値を格納する
    var correctProblemNumber: Int!
    var totalSeconds: String!
    
    //ランクを表示するメソッド
    func showRank(num: Int) {
        var text: String
        switch num {
        case 0...1:
            text = "まだまだです"
        case 2...3:
            text = "もっとがんばりましょう"
        case 4...5:
            text = "あと少しがんばりましょう"
        case 6...7:
            text = "素晴らしい"
        case 8...9:
            text = "おめでとう"
        default:
            text = "神です"
        }
        rankLabel.text = text
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景画像
        myImageView.image = UIImage(named: "background.jpg")
        myImageView.alpha = 0.1
        
        // Do any additional setup after loading the view.
        self.scoreLabel.text = String(scoreNum)
        showRank(num: scoreNum)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
