//
//  ViewControllerArchive.swift
//  ToDoList
//
//  Created by Taizo Kishimoto on 2023/02/11.
//

import UIKit

class Archive: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
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
        

    }
    
    // セルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList2.count
    }
    
    // セルの中身を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let todoTitle = todoList2[indexPath.row]

        cell.textLabel?.text = todoTitle

        // tableViewのswitchのindex.rowをtagに保存（1/2）
        // https://swiswiswift.com/2018-04-05/
        /********************************/
        if cell.accessoryView == nil{
            let switchView = UISwitch()
            
            //Switchの初期値を設定
            switchView.isOn = CompleteFlagList2[indexPath.row]
            // tagに保存
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(switchTriggered), for: .valueChanged)
            cell.accessoryView = switchView
        }
        /********************************/
        
        return cell
    }
    
    
    // tableViewのswitchのindex.rowをtagに保存（2/2）
    // https://swiswiswift.com/2018-04-05/
    // cellのアクセサリービューに追加したUISwitchを操作すると呼び出される
    @objc func switchTriggered(sender: UISwitch){
        print(sender.tag,"番目のタスクの完了フラグが",sender.isOn,"になりました")
        CompleteFlagList2[sender.tag] = sender.isOn
        
        // 完了フラグをTrueにした日時を保存
        //let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))
        if CompleteFlagList2[sender.tag] == false{
            //完了フラグfalse時のアラート設定
            //https://tech.playground.style/未分類/alert/
            let alert = UIAlertController(title: "タスクを未完了にしますか？", message: "未完了にしたタスクは\nToDoListに移行されます.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { [self] (action) in
                self.dismiss(animated: true, completion: nil)
                print("OKが選択されました.")
                //print("sender.tag：", sender.tag)
                
                //CompleteFlagTrueDateList[sender.tag] = dateFormatter.string(from: now)
                
                // 完了フラグリストに状態を保存
                //userDefaults.set(CompleteFlagList2, forKey: "CompleteFlagList2")
                
                // 未完了データ保存用の配列にコピー
                todoList.append(todoList2[sender.tag])
                DetailList.append(DetailList2[sender.tag])
                DeadlineList.append(DeadlineList2[sender.tag])
                RegistrationDateList.append(RegistrationDateList2[sender.tag])
                CompleteFlagList.append(CompleteFlagList2[sender.tag])
                CompleteFlagTrueDateList.append(CompleteFlagTrueDateList2[sender.tag])

                
                // 未完了データ保存用の配列を保存
                userDefaults.set(todoList, forKey: "todoList")
                userDefaults.set(DetailList, forKey: "DetailList")
                userDefaults.set(DeadlineList, forKey: "DeadlineList")
                userDefaults.set(RegistrationDateList, forKey: "RegistrationDateList")
                userDefaults.set(CompleteFlagList, forKey: "CompleteFlagList")
                userDefaults.set(CompleteFlagTrueDateList, forKey: "CompleteFlagTrueDateList")
                
                
                // アーカイブのデータを削除
                todoList2.remove(at: sender.tag)
                DetailList2.remove(at: sender.tag)
                DeadlineList2.remove(at: sender.tag)
                RegistrationDateList2.remove(at: sender.tag)
                CompleteFlagList2.remove(at: sender.tag)
                CompleteFlagTrueDateList2.remove(at: sender.tag)
                
        
                // 削除した内容を保存
                userDefaults.set(todoList2, forKey: "todoList2")
                userDefaults.set(DetailList2, forKey: "DetailList2")
                userDefaults.set(DeadlineList2, forKey: "DeadlineList2")
                userDefaults.set(RegistrationDateList2, forKey: "RegistrationDateList2")
                userDefaults.set(CompleteFlagList2, forKey: "CompleteFlagList2")
                userDefaults.set(CompleteFlagTrueDateList2, forKey: "CompleteFlagTrueDateList2")
             
                
                // 画面をリロード
                // https://tsukader.hatenablog.com/entry/2018/08/20/093414
                self.loadView()
                
                
                let nextView = self.storyboard?.instantiateViewController(withIdentifier: "top") as! ViewController
                self.navigationController?.pushViewController(nextView, animated: true)

            }
            let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
                self.dismiss(animated: true, completion: nil)
                print("キャンセルが選択されました.")
                self.CompleteFlagList2[sender.tag] = true
                sender.isOn = true
            }
            alert.addAction(cancel)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            
        } else if CompleteFlagList2[sender.tag] == true {
            CompleteFlagTrueDateList2[sender.tag] = "完了"
        }
        
        userDefaults.set(CompleteFlagTrueDateList2, forKey: "CompleteFlagTrueDateList2")
        
    }
    
    
    

    // セルの削除機能
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //タスクスワイプし「delete」を押下した際の確認アラート設定
        //https://tech.playground.style/未分類/alert/
        let alert = UIAlertController(title: "タスクを削除しますか？", message: "削除したタスクは\n復元することができません.", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { [self] (action) in
            self.dismiss(animated: true, completion: nil)
            // OK押下時の動作を記載
            print("OKが選択されました.")
            
            // 実際に削除を行う場所
            if editingStyle == UITableViewCell.EditingStyle.delete {
                todoList.remove(at: indexPath.row)
                DetailList.remove(at: indexPath.row)
                DeadlineList.remove(at: indexPath.row)
                RegistrationDateList.remove(at: indexPath.row)
                CompleteFlagList.remove(at: indexPath.row)
                CompleteFlagTrueDateList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
                
                // 削除した内容を保存
                userDefaults.set(todoList, forKey: "todoList")
                userDefaults.set(DetailList, forKey: "DetailList")
                userDefaults.set(DeadlineList, forKey: "DeadlineList")
                userDefaults.set(RegistrationDateList, forKey: "RegistrationDateList")
                userDefaults.set(CompleteFlagList, forKey: "CompleteFlagList")
                userDefaults.set(CompleteFlagTrueDateList, forKey: "CompleteFlagTrueDateList")
                
                // 削除する内容を表示
                print("---削除対象---")
                print("件名 : ",todoList[indexPath.row])
                print("詳細 : ",DetailList[indexPath.row])
                print("期日 : ",DeadlineList[indexPath.row])
                print("登録日 : ",RegistrationDateList[indexPath.row])
                print("完了フラグ : ",CompleteFlagList[indexPath.row])
                print("完了日 : ",CompleteFlagTrueDateList[indexPath.row])
                print("削除実行日 : ",Date())
                
                print("削除完了！！")
            }
        }
        
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
            self.dismiss(animated: true, completion: nil)
            // キャンセル押下時の動作を記載
            print("キャンセルが選択されました.")
            }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    
}






