//
//  questionViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/16.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

class questionViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate {
    
    //プロパティリストから読み込んだデータを格納する配列
    var GodList:[NSDictionary] = []
    //選択されたエリア名を保存するメンバ変数
    var godName = ""
    
    
    
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
        

    //非表示にする
        Hide()
    //問題表示する
        RandomQuestions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
//    //画面が表示される時、常に発動
//    override func viewWillAppear(_ animated: Bool) {
//
//        //AppDelegateにアクセス
//        let question = UIApplication.shared.delegate as! AppDelegate
//
//        //グローバル変数(AppDelegateのプロパティ)の値を書き換える(カウントアップ)
//        question.myCount += 1
//
//        //カウントアップした数字をラベルに表示
//        QuestionLabel.text = "\(question.myCount)"
//    }
    
    
    
    //4択問題を出題
    func RandomQuestions(){
        var RandomNumber:Int = Int(arc4random() % 31)
        RandomNumber += 1
        QuestionLabel.text = "What is my name?"
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
//        画像ファイル名を格納する配列を作成
        for(key,data) in dic!{
                        print(data)
                        print(key)
            
            var gooddic:NSDictionary = data as! NSDictionary
            var godinfo:NSDictionary = ["name":key,"image":gooddic["image"]]
            
                        GodList.append(godinfo)
        }
        
        //今画面に表示したいデータの取得
        let detailInfo = GodList[RandomNumber] as! NSDictionary

        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["image"] as! String)
        
       //画像の表示
        QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
        
        
        //問題を10問だす1...10
        
        //画像と名前を合わせる
     
        
        
        switch(RandomNumber){
        case 1:
            answerBtn1.setTitle("Ganesa", for: UIControlState())
            answerBtn2.setTitle("Krsna", for: UIControlState())
            answerBtn3.setTitle("Agni", for: UIControlState())
            answerBtn4.setTitle("Naga", for: UIControlState())
            CorrectAnswer = "1"
            break
            default:
            break
        }
        
//    switch(RandomNumber){
//    case 1:
//        QuestionImage.image = UIImage(named: "Ganesa.jpg")
//        answerBtn1.setTitle("Ganesa", for: UIControlState())
//        answerBtn2.setTitle("Krsna", for: UIControlState())
//        answerBtn3.setTitle("Agni", for: UIControlState())
//        answerBtn4.setTitle("Naga", for: UIControlState())
//        CorrectAnswer = "1"
//        break
//    case 2:
//        QuestionImage.image = UIImage(named: "Brahma.jpg")
//        answerBtn1.setTitle("Vishnu", for: UIControlState())
//        answerBtn2.setTitle("Brahma", for: UIControlState())
//        answerBtn3.setTitle("Parvathi", for: UIControlState())
//        answerBtn4.setTitle("Rama", for: UIControlState())
//        CorrectAnswer = "2"
//        break
//    case 3:
//        QuestionImage.image = UIImage(named: "Shiva.jpg")
//        answerBtn1.setTitle("Naga", for: UIControlState())
//        answerBtn2.setTitle("Jagannatha", for: UIControlState())
//        answerBtn3.setTitle("Shiva", for: UIControlState())
//        answerBtn4.setTitle("Dakini", for: UIControlState())
//        CorrectAnswer = "3"
//        break
//    case 4:
//        QuestionImage.image = UIImage(named: "Lakshmi.jpg")
//        answerBtn1.setTitle("Kali", for: UIControlState())
//        answerBtn2.setTitle("Hanuman", for: UIControlState())
//        answerBtn3.setTitle("Minakshi", for: UIControlState())
//        answerBtn4.setTitle("Lakshmi", for: UIControlState())
//        CorrectAnswer = "4"
//        break
//    default:
//        QuestionImage.image = UIImage(named: "Jagannatha.gif")
//        answerBtn1.setTitle("Jagannatha", for: UIControlState())
//        answerBtn2.setTitle("Agni", for: UIControlState())
//        answerBtn3.setTitle("krsna", for: UIControlState())
//        answerBtn4.setTitle("Indra", for: UIControlState())
//        CorrectAnswer = "1"
//        break
//        }
        
        

        
   }
    
    //非表示にする関数
    func Hide(){
        resultImage.isHidden = true
        Next.isHidden = true
    }
    func UnHide(){
        resultImage.isHidden = false
        Next.isHidden = false
    }
    
    //全ボタンを非活性にする
    func allAnswerBtnDisabled() {
        answerBtn1.isEnabled = false
        answerBtn2.isEnabled = false
        answerBtn3.isEnabled = false
        answerBtn4.isEnabled = false
    }
    
    //全ボタンを活性にする
    func allAnswerBtnEnabled() {
        answerBtn1.isEnabled = true
        answerBtn2.isEnabled = true
        answerBtn3.isEnabled = true
        answerBtn4.isEnabled = true
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
