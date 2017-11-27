//
//  questionViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/16.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

//ゲームに関係する定数
struct QuizStruct {
    static let timerDuration: Double = 10
    static let dataMaxCount: Int = 10
    static let defaultCounter: Int = 10
}

class questionViewController: UIViewController, UINavigationBarDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var QuestionImage: UIImageView!
    
    @IBOutlet weak var answerBtn1: UIButton!
    @IBOutlet weak var answerBtn2: UIButton!
    @IBOutlet weak var answerBtn3: UIButton!
    @IBOutlet weak var answerBtn4: UIButton!
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var Next: UIButton!
    
    @IBOutlet weak var timerDisplayLabel: UILabel!
    @IBOutlet weak var problemCountLabel: UILabel!
    
    
    //プロパティリストから読み込んだデータを格納する配列、問題の内容を入れておくメンバ変数
    var GodList:[NSDictionary] = []
    //選択されたエリア名を保存するメンバ変数
    var godName = ""
    var quiznum = 1
    var myCount = 1
    
    var CorrectAnswer = String()
    var inCorrectAnswer = String()
    var myButtonAry: [UIButton] = []

    
//////時間制限バーここから////////
    
    // 時間計測用の変数.
    var count : Float = 0
    // 時間表示用のラベル.
    var myLabel : UILabel!
    // 停止/再開ボタン
    var stopBtn:UIButton!
    var startBtn:UIButton!
    // タイマー
    var timer : Timer!
    // 一時停止の際の時間を格納する
    var pauseTime:Float = 0
    // スクリーン画面のサイズを取得
    let scWid: CGFloat = UIScreen.main.bounds.width     //画面の幅
    let scHei: CGFloat = UIScreen.main.bounds.height    //画面の高さ
    
    var barImageView:UIImageView!
    
//////時間制限バーここまで////////
//////タイマーここから///////////
    //タイマー関連のメンバ変数
    var pastCounter: Int = 10
    var perSecTimer: Timer? = nil
    var doneTimer: Timer? = nil
    
    //正解数
    var correctProblemNumber: Int = 0
    
    //画面出現しきったタイミングに読み込まれる処理
    override func viewDidAppear(_ animated: Bool) {
        
        //ラベルを表示を「TIME:10」という表記へ変更
        timerDisplayLabel.text = "TIME:" + String(self.pastCounter)
        
        //ボタンを全て活性状態にする
        allAnswerBtnEnabled()
        
        //タイマーをセットする
        setTimer()
    }
    
    //画面が消えるタイミングに読み込まれる処理
    override func viewWillDisappear(_ animated: Bool) {
        
        //タイマーをリセットしておく
        resetTimer()
    }
/////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
/////////////////////
//////時間制限バーここから////////
        // 制限時間バーの高さ・幅
        let barHeight = scHei*0.015
        let barWidth = scWid*0.8
        
        // 制限時間バーのX座標・Y座標・終端のX座標
        let barXPosition = scWid*0.1
        let barYPosition = scHei*0.1
        let barXPositionEnd = barXPosition + barWidth
        
        // UIImageViewを初期化
        barImageView = UIImageView()
        
        // 画像の表示する座標を指定する
        barImageView.frame = CGRect(x: barXPosition ,y: barYPosition ,width: barWidth ,height: barHeight)
        
        // バーに色を付ける
        barImageView.backgroundColor = .orange
        
        //　ラベル枠の枠線太さと色
        barImageView.layer.borderColor = UIColor.white.cgColor
        barImageView.layer.borderWidth = 2
        
        // barImageViewをViewに追加する
        self.view.addSubview(barImageView)
        
        // バーをアニメーションさせる
        // 10秒かけてバーを左側から等速で減少させる
        UIView.animate(withDuration: 30, delay: 0.0, options : UIViewAnimationOptions.curveLinear, animations: {() -> Void  in
            
            // アニメーション終了後の座標とサイズを指定
            self.barImageView.frame = CGRect(x: barXPositionEnd, y: barYPosition, width: 0, height: barHeight)
        },
                       completion: {(finished: Bool) -> Void in
                        // アニメーション終了後の処理
//                        //次のコントローラーへ遷移する
//                        self.performSegue(withIdentifier: "showScore", sender: nil)
                        //10秒経過時は不正解として次の問題を読み込む
                        self.pastCounter = QuizStruct.defaultCounter
                        //タイマーを再設定する
                        self.reloadTimer()
                        
        })
//////時間制限バーここまで////////
//////タイマーここまで///////////
        
    //非表示にする
        Hide()
    //問題表示する
        RandomQuestions()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 /////////ここから/////////////
    //タイマーをセットするメソッド
    func setTimer() {
        
        //毎秒ごとにperSecTimerDoneメソッドを実行するタイマーを作成する
        self.perSecTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(questionViewController.perSecTimerDone), userInfo: nil, repeats: true)
        
        //指定秒数後にtimerDoneメソッドを実行するタイマーを作成する（問題の時間制限に到達した場合の実行）
        self.doneTimer = Timer.scheduledTimer(timeInterval: QuizStruct.timerDuration, target: self, selector: #selector(questionViewController.timerDone), userInfo: nil, repeats: true)
    }
    
    //毎秒ごとのタイマーで呼び出されるメソッド
    @objc func perSecTimerDone() {
        pastCounter -= 1
        timerDisplayLabel.text = "TIME:" + String(self.pastCounter)
       
    }
    
    //問題の時間制限に到達した場合に実行されるメソッド
    @objc func timerDone() {

    }
    
    //タイマーを破棄して再起動を行うメソッド
    func reloadTimer() {
        
        //タイマーを破棄する
        resetTimer()
        
        //結果表示ページへ遷移するか次の問題を表示する
        compareNextProblemOrResultView()
    }
    
/////////ここまで/////////////
    
    
    //画面が表示される時、常に発動
    override func viewWillAppear(_ animated: Bool) {

        RandomQuestions()
        //AppDelegateにアクセス
        let question = UIApplication.shared.delegate as! AppDelegate

    }
    
/////////ここから問題出題/////////////
    
    //4択問題を出題
    func RandomQuestions(){
        var RandomNumber:Int = Int(arc4random() % 31)
        RandomNumber += 1
        allAnswerBtnEnabled()
        QuestionLabel.text = "What is my name?"
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //画像ファイル名を格納する配列を作成
        for(key,data) in dic!{
                        print(data)
                        print(key)
            
            var goddic:NSDictionary = data as! NSDictionary
            var godinfo:NSDictionary = ["name":key,"image":goddic["image"]]
            
                        GodList.append(godinfo)
        }
        
        
        //今画面に表示したいデータの取得
        let detailInfo = GodList[RandomNumber] 
        
        //Dictionaryからキー指定で取り出すと必ずAny型になるのでダウンキャスト変換が必要
        print(detailInfo["image"] as! String)
        print(detailInfo["name"] as! String)
       
        for(key,data) in dic!{
            print(data)
            print(key)
            
            var _:NSDictionary = data as! NSDictionary
        
        }
        //正解を表示
        for _ in (detailInfo["name"] as! String) {
            let num = arc4random_uniform(31)
            print(num)
            QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
            answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
            CorrectAnswer = "1"
            
            
            
//            if QuestionImage.image == UIImage(named:detailInfo["image"] as! String) {
//                answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                CorrectAnswer = "1"
//                else if answerBtn2.setTitle(detailInfo["name"] as? String, for: UIControlState()) {
//                CorrectAnswer = "2"
//                else if{ answerBtn3.setTitle(detailInfo["name"] as? String, for: UIControlState()) {
//                CorrectAnswer = "3"
//            }else{
//
//            }
//            }
//
            
            
        }
        
            //正解以外の問題を表示
        func inCorrectNum(){
            var answerBtns = [answerBtn2,answerBtn3,answerBtn4]
            for i in 0...2{
                RandomNumber = Int(arc4random() % 31)
                RandomNumber += 1
                
                let detailInfo = GodList[RandomNumber]
                
                print(detailInfo["name"] as! String)
                answerBtns[i]?.setTitle(detailInfo["name"] as? String, for: UIControlState())
            }
        }
                
//                switch(RandomNumber){
//                case 1:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "1"
//                    break
//                case 2:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn2.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "2"
//                    break
//                case 3:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn3.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "3"
//                    break
//                case 4:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn4.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "4"
//                    break
//                case 5:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "1"
//                    break
//                case 6:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn2.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "2"
//                    break
//                case 7:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn3.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "3"
//                    break
//                case 8:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn4.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "4"
//                    break
//                case 9:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn1.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "1"
//                    break
//                case 10:
//                    QuestionImage.image = UIImage(named:detailInfo["image"] as! String)
//                    answerBtn2.setTitle(detailInfo["name"] as? String, for: UIControlState())
//                    CorrectAnswer = "2"
//                    break
//                default:
//                    break
//                }
            
    
            
            
            
        //重複を避ける
//            var _ : Set = [(detailInfo["name"] as! String)]  //←避けられてない
            
//            let values = [CorrectAnswer, answerBtns] as [Any]
//            let orderedSet = NSOrderedSet(array: values)
//            let uniqueValues = orderedSet.array as! [String]
            
//            let strArray:[String] = [GodList[RandomNumber] as! String]
//            let orderedSet = NSOrderedSet(array: strArray)
//            let uniqueValues = orderedSet.array as! [String]
            
        
        
   }
  
    
/////////問題終了後ここから/////////////
    
    
    //結果表示ページへ遷移するか次の問題を表示するかを決めるメソッド
    func compareNextProblemOrResultView() {
        
        if quiznum == QuizStruct.dataMaxCount {
            
//           （※処理）規定回数まで到達した場合は次の画面へ遷移する
            
            //タイマーを破棄する
            resetTimer()
            
            //次のコントローラーへ遷移する
            self.performSegue(withIdentifier: "showScore", sender: nil)
            
        } else {
            
//          （※処理）規定回数に達していない場合はカウントをリセットして次の問題を表示する
 
            //ボタンを全て活性にする
            allAnswerBtnEnabled()
            
            //ラベルの値を再セットする
            timerDisplayLabel.text = "TIME:" + String(pastCounter)
            
            //タイマーをセットする
            setTimer()
        }
    }
    
    //セグエを呼び出したときに呼ばれるメソッド
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //セグエ名で判定を行う
        if segue.identifier == "showScore" {
            
            //遷移先のコントローラーの変数を用意する
            let ScoreViewController = segue.destination as! ScoreViewController
            
            //遷移先のコントローラーに渡したい変数を格納（型を合わせる）
            ScoreViewController.correctProblemNumber = correctProblemNumber
            
            //計算結果を入れる変数を初期化
            self.resetGameValues()
        }
    }
    
    //タイマー処理を全てリセットするメソッド
    func resetTimer() {
        perSecTimer!.invalidate()
        doneTimer!.invalidate()
    }
    
    //ゲームのカウントに関する数を初期化する
    func resetGameValues() {
        quiznum = 0
        correctProblemNumber = 0
        
    }
    
/////////ここまで/////////////
    
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
    
    
    //◯,×の画像表示
    @IBAction func answerBtn1Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "1"){
            resultImage.image = UIImage(named: "yes.png")
            
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn2Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "2"){
            resultImage.image = UIImage(named: "yes.png")
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn3Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "3"){
            resultImage.image = UIImage(named: "yes.png")
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }
    @IBAction func answerBtn4Act(_ sender: Any) {
        UnHide()
        if (CorrectAnswer == "4"){
            resultImage.image = UIImage(named: "yes.png")
            correctProblemNumber += 1
            allAnswerBtnDisabled()
        }else{
            resultImage.image = UIImage(named: "no.png")
        }
    }

    
    //10問終了後にスコア画面へ移動
    @IBAction func Next(_ sender: Any) {
        RandomQuestions()
        Hide()
        
        quiznum += 1
        print("今\(quiznum)問目")
        
        myCount += 1
        //カウントアップした数字をラベルに表示
        problemCountLabel.text = "Q\(myCount)."
        
        if quiznum == 11{
            print("正解数：\(correctProblemNumber)")
            self.performSegue(withIdentifier: "showScore", sender: nil)
            
    //ゲーム画面→結果表示画面のViewControllerにプロパティの値を渡す
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            let newVC = segue.destination as! ScoreViewController
            newVC.correctProblemNumber = self.correctProblemNumber
            }
        
        }
    }
    
    
    
    //↓の前に、正解不正解を一致させて正解をランダムに10問出題(現状答えが1のみ)
    
    //10秒経過した時に【不正解ボタン】を押された時と同じにする
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
