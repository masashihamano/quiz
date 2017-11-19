//
//  questionViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/16.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

class questionViewController: UIViewController {
    
    //Quiz画面の作成
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var QuestionImage: UIImageView!
    
    @IBOutlet weak var answerBtn1: UIButton!
    @IBOutlet weak var answerBtn2: UIButton!
    @IBOutlet weak var answerBtn3: UIButton!
    @IBOutlet weak var answerBtn4: UIButton!
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var Next: UIButton!
    
    var CorrectAnswer = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        
    //非表示にする関数
        Hide()
    //問題の関数
        RandomQuestions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //4択問題を出題
    func RandomQuestions(){
        var RandomNumber = arc4random() % 5
        RandomNumber += 1
    
    switch(RandomNumber){
    case 1:
        QuestionLabel.text = "What is my name?"
        QuestionImage.image = UIImage(named: "Ganesa.jpg")
        answerBtn1.setTitle("Krsna", for: UIControlState())
        answerBtn2.setTitle("Ganesa", for: UIControlState())
        answerBtn3.setTitle("Agni", for: UIControlState())
        answerBtn4.setTitle("Naga", for: UIControlState())
        CorrectAnswer = "2"
        break
    case 2:
        QuestionLabel.text = "What is my name?"
        QuestionImage.image = UIImage(named: "Brahma.jpg")
        answerBtn1.setTitle("Brahma", for: UIControlState())
        answerBtn2.setTitle("Vishnu", for: UIControlState())
        answerBtn3.setTitle("Parvathi", for: UIControlState())
        answerBtn4.setTitle("Rama", for: UIControlState())
        CorrectAnswer = "1"
        break
    case 3:
        QuestionLabel.text = "What is my name?"
        QuestionImage.image = UIImage(named: "Shiva.jpg")
        answerBtn1.setTitle("Naga", for: UIControlState())
        answerBtn2.setTitle("Jagannatha", for: UIControlState())
        answerBtn3.setTitle("Shiva", for: UIControlState())
        answerBtn4.setTitle("Dakini", for: UIControlState())
        CorrectAnswer = "3"
        break
    case 4:
        QuestionLabel.text = "What is my name?"
        QuestionImage.image = UIImage(named: "Lakshmi.jpg")
        answerBtn1.setTitle("Kali", for: UIControlState())
        answerBtn2.setTitle("Hanuman", for: UIControlState())
        answerBtn3.setTitle("Minakshi", for: UIControlState())
        answerBtn4.setTitle("Lakshmi", for: UIControlState())
        CorrectAnswer = "4"
        break
    default:
        QuestionLabel.text = "What is my name?"
        QuestionImage.image = UIImage(named: "Jagannatha.gif")
        answerBtn1.setTitle("Jagannatha", for: UIControlState())
        answerBtn2.setTitle("Agni", for: UIControlState())
        answerBtn3.setTitle("krsna", for: UIControlState())
        answerBtn4.setTitle("Indra", for: UIControlState())
        CorrectAnswer = "1"
        break
        }
    }
    
    //回答するまで非表示
    func Hide(){
        resultImage.isHidden = true
        Next.isHidden = true
    }
    func UnHide(){
        resultImage.isHidden = false
        Next.isHidden = false
    }
    
    //correct,noの画像表示
    @IBAction func answerBtn1Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "1"){
            resultImage.image = UIImage(named: "correct.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn2Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "2"){
            resultImage.image = UIImage(named: "correct.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn3Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "3"){
            resultImage.image = UIImage(named: "correct.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn4Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "4"){
            resultImage.image = UIImage(named: "correct.png")
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    
    //回答後に表示
    @IBAction func Next(_ sender: Any) {
        RandomQuestions()
        Hide()
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
