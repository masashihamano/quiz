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
    
    @IBAction func startBtn(_ sender: UIButton) {
    }
    
    
//QuizControllerより引き渡される値を格納する
    var correctProblemNumber: Int!
    var totalSeconds: String!
    
    //ランクを表示するメソッド
    func showRank(num: Int) {
        var text: String
        switch num {
        case 0:
            text = "問題外です"
        case 10:
            text = "修行が足りない"
        case 20:
            text = "ざんねんでした！"
        case 30:
            text = "まだまだです"
        case 40:
            text = "もっとがんばりましょう"
        case 50:
            text = "もう少し頑張りましょう"
        case 60:
            text = "及第点です"
        case 70:
            text = "おめでとう！"
        case 80:
            text = "素晴らしい！"
        case 90:
            text = "満点まであとすこし！"
        default:
            text = "神レベル！"
        }
        rankLabel.text = text
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //背景画像
        myImageView.image = UIImage(named: "background.jpg")
        myImageView.alpha = 0.1
        
   
        self.scoreLabel.text = String(correctProblemNumber*10)
        showRank(num: correctProblemNumber*10)
        
        
        scoreLabel.layer.masksToBounds = true
        scoreLabel.layer.cornerRadius = scoreLabel.bounds.width / 2
        
        
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
