//
//  ViewController5.swift
//  ToDoList31
//
//  Created by Taizo Kishimoto on 2022/09/16.
//

import UIKit

class ViewController5: UIViewController {
    
    // UserDefaultsのインスタンスの生成
    let userDefaults = UserDefaults.standard
    // テーブルに表示するデータの箱（件名）
    var todoList = [String]()
    // 詳細を保存するデータの箱
    var DetailList = [String]()
    // 期限を保存するデータの箱
    var DeadlineList = [String]()
    // 登録日時を保存するデータの箱
    var RegistrationDateList = [String]()
    // 完了フラグの状態を保存するデータの箱
    var CompleteFlagList = [Bool]()
    // 完了フラグをTrueにした日付
    var CompleteFlagTrueDateList = [String]()
    //todoListの添字
    var num:Int = 0
    
    //完了データ管理用
    // テーブルに表示するデータの箱（件名）
    var todoList2 = [String]()
    // 詳細を保存するデータの箱
    var DetailList2 = [String]()
    // 期限を保存するデータの箱
    var DeadlineList2 = [String]()
    // 登録日時を保存するデータの箱
    var RegistrationDateList2 = [String]()
    // 完了フラグの状態を保存するデータの箱
    var CompleteFlagList2 = [Bool]()
    // 完了フラグをTrueにした日付
    var CompleteFlagTrueDateList2 = [String]()
    
    // Top画面を開いた回数を記録
    var OpenAppCounter : Int = 0
    
    // 不便益モードのON・OFF Switch
    @IBOutlet weak var selectSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // データ読み込み
        if let storedTodoList = userDefaults.array(forKey: "todoList") as? [String] {
            todoList.append(contentsOf: storedTodoList)
        }
        if let storedDetailList = userDefaults.array(forKey: "DetailList") as? [String] {
            DetailList.append(contentsOf: storedDetailList)
        }
        if let storedDeadlineList = userDefaults.array(forKey: "DeadlineList") as? [String] {
            DeadlineList.append(contentsOf: storedDeadlineList)
        }
        if let storedRegistrationDateList = userDefaults.array(forKey: "RegistrationDateList") as? [String] {
            RegistrationDateList.append(contentsOf: storedRegistrationDateList)
        }
        if let storedCompleteFlagList = userDefaults.array(forKey: "CompleteFlagList") as? [Bool] {
            CompleteFlagList.append(contentsOf: storedCompleteFlagList)
        }
        if let storedCompleteFlagTrueDateList = userDefaults.array(forKey: "CompleteFlagTrueDateList") as? [String] {
            CompleteFlagTrueDateList.append(contentsOf: storedCompleteFlagTrueDateList)
        }
        
        //完了データ管理用
        if let storedTodoList2 = userDefaults.array(forKey: "todoList2") as? [String] {
            todoList2.append(contentsOf: storedTodoList2)
        }
        if let storedDetailList2 = userDefaults.array(forKey: "DetailList2") as? [String] {
            DetailList2.append(contentsOf: storedDetailList2)
        }
        if let storedDeadlineList2 = userDefaults.array(forKey: "DeadlineList2") as? [String] {
            DeadlineList2.append(contentsOf: storedDeadlineList2)
        }
        if let storedRegistrationDateList2 = userDefaults.array(forKey: "RegistrationDateList2") as? [String] {
            RegistrationDateList2.append(contentsOf: storedRegistrationDateList2)
        }
        if let storedCompleteFlagList2 = userDefaults.array(forKey: "CompleteFlagList2") as? [Bool] {
            CompleteFlagList2.append(contentsOf: storedCompleteFlagList2)
        }
        if let storedCompleteFlagTrueDateList2 = userDefaults.array(forKey: "CompleteFlagTrueDateList2") as? [String] {
            CompleteFlagTrueDateList2.append(contentsOf: storedCompleteFlagTrueDateList2)
        }
        
        // 不便益モード
        let switchBool = userDefaults.bool(forKey: "Inconvenience")
        selectSwitch.isOn = switchBool
        if switchBool {
            print("不便益モードはONです.")
        }else{
            print("不便益モードはOFFです.")
        }
        
    }
    
    @IBAction func Reset(_ sender: Any) {
        print("初期化します.")
        
        let alert = UIAlertController(title: "システムを初期化します.", message: "初期化後の復元は不可能です.\n初期化しても問題ないでしょうか.", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { [self] (action) in
            self.dismiss(animated: true, completion: nil)
            
            print("OKが選択されました.")
            
            // Top画面の表示回数をリセット
            OpenAppCounter = 0
            UserDefaults.standard.set(OpenAppCounter, forKey: "OpenAppCounter")
            
            todoList.removeAll()
            DetailList.removeAll()
            DeadlineList.removeAll()
            RegistrationDateList.removeAll()
            CompleteFlagList.removeAll()
            CompleteFlagTrueDateList.removeAll()
            
            todoList2.removeAll()
            DetailList2.removeAll()
            DeadlineList2.removeAll()
            RegistrationDateList2.removeAll()
            CompleteFlagList2.removeAll()
            CompleteFlagTrueDateList2.removeAll()
            
            // 削除した内容を保存
            userDefaults.set(todoList, forKey: "todoList")
            userDefaults.set(DetailList, forKey: "DetailList")
            userDefaults.set(DeadlineList, forKey: "DeadlineList")
            userDefaults.set(RegistrationDateList, forKey: "RegistrationDateList")
            userDefaults.set(CompleteFlagList, forKey: "CompleteFlagList")
            userDefaults.set(CompleteFlagTrueDateList, forKey: "CompleteFlagTrueDateList")
            
            // 削除した内容を保存
            userDefaults.set(todoList2, forKey: "todoList2")
            userDefaults.set(DetailList2, forKey: "DetailList2")
            userDefaults.set(DeadlineList2, forKey: "DeadlineList2")
            userDefaults.set(RegistrationDateList2, forKey: "RegistrationDateList2")
            userDefaults.set(CompleteFlagList2, forKey: "CompleteFlagList2")
            userDefaults.set(CompleteFlagTrueDateList2, forKey: "CompleteFlagTrueDateList2")
            
            self.loadView()
            print("初期化完了.")
            
            let nextView = self.storyboard?.instantiateViewController(withIdentifier: "top") as! ViewController
            self.navigationController?.pushViewController(nextView, animated: true)
            
        }
        //ここから追加
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
            
            print("キャンセルが選択されました.")
        }
        alert.addAction(cancel)
        //ここまで追加
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    // 不便益モードのON・OFF
    @IBAction func PushUISwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("不便益モードがONに変更されました.")
        } else {
            print("不便益モードがOFFに変更されました.")
        }
        userDefaults.set(sender.isOn, forKey: "Inconvenience")
        //遷移https://satoriku.com/value-passing/
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "top") as! ViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    @objc private func back(_ sender: Any) {
            print("戻るボタン押下")
            navigationController?.popViewController(animated: true)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
