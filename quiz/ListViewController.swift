//
//  ListViewController.swift
//  quiz
//
//  Created by 濱野将士 on 2017/11/17.
//  Copyright © 2017年 Masashi Hamano. All rights reserved.
//

import UIKit

//プロトコルの設定
class ListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    //プロパティリストから読み込んだデータを格納する配列
    var GodList:[NSDictionary] = []
     //選択されたエリア名を保存するメンバ変数
    var godName = ""
    
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //ファイルパスを取得(エリア名が格納されているプロパティリスト)
        let filePath = Bundle.main.path(forResource:"GodList", ofType:"plist")
        // プロパティリストからデータを取得（Dictionary型）
        let dic = NSDictionary(contentsOfFile: filePath!)
        // TableViewで扱いやすい配列（エリア名の入ってる配列）を作成
        for(key,data) in dic!{
            print(data)
            print(key)

        }
    }
    
    //2行数の決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GodList.count
    }
    
    //3表示する文字列を決定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //文字列を表示するセルの取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell"
            , for: indexPath)
        
        //表示したい文字の設定
        cell.textLabel?.text = GodList[indexPath.row] as! String
        
        //文字色、矢印
        cell.textLabel?.textColor = UIColor.orange
        cell.accessoryType = .disclosureIndicator
        
        //文字を設定したセルを返す
        cell.textLabel!.text = GodList[(indexPath as NSIndexPath).row] as! String
        
        return cell

    }
    
    //セルがタップされたとき
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
            //タップされた行のエリア名を保存
            godName = GodList[(indexPath.row)]  as! String
    
            //セグエのidentifierを指定して、画面移動
            performSegue(withIdentifier: "showDetail",sender: nil)
        }
    
    // Segueで画面遷移する時
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //次の画面のインスタンスを取得
//        var dvc = segue.destination as! DetailViewController

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
