//
//  ViewController.swift
//  ToDoList
//
//  Created by Taizo Kishimoto on 2022/08/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
    //起動時１回目だけ即実行される関数
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
    
    // +ボタンをタップしたときの動作
    @IBAction func addBtnAction(_ sender: Any) {
        //todoの件数= num + 1
        num = todoList.count
        UserDefaults.standard.set(num, forKey: "todoNumber")
        
        // 画面をリロード
        // https://tsukader.hatenablog.com/entry/2018/08/20/093414
        self.loadView()
        
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "edit") as! ViewController3
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    // セルの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    // セルの中身を設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        let todoTitle = todoList[indexPath.row]
        
        
        /*****************不便益モード*********************/
        let switchBool = userDefaults.bool(forKey: "Inconvenience")
        
        if switchBool == true{
            //文字列を1文字ずつの配列に変換する
            //https://qiita.com/Satochaaan/items/63812ce8ccb030ad9574
            var todoCharArray : [Character] = Array(todoTitle)
            //件名の文字数を取得
            var todoLength = todoCharArray.count
            
            print("---削除前---")
            print("todoCharArray : ",todoCharArray)
            print("todoCharArrayCount : ",todoLength,"\n")
            
            //関数の書き方
            //https://rakusui.org/swift_function/
            //戻り値を配列にする方法
            //https://www.okadalabo.com/swiftで配列arrayを戻り値に指定した関数の書き方/
            //引数の書き方
            //https://tea-leaves.jp/swift/content/関数
            
            func DeleteCharacter(Character: [Character],randomInt : Int) -> Array<Character> {
                var AfterDeleteCharacter : [Character] = Character
                AfterDeleteCharacter.remove(at: randomInt)
                AfterDeleteCharacter.insert("＊", at: randomInt)
                print(randomInt + 1,"文字目を削除します.")
                return AfterDeleteCharacter
            }
            
            //何文字を消すか決定
            var randomIntCount = 0
            
            if todoLength == 0 || todoLength == 1{
                cell.textLabel?.text = todoTitle
            } else if todoLength != 0 || todoLength != 1{
                randomIntCount = Int.random(in: 0..<todoLength/2)
                print(randomIntCount,"文字削除します.\n")
                
                for var i in 0..<randomIntCount {
                    i = i + 1
                    todoLength = todoCharArray.count
                    //ランダム数生成
                    //https://capibara1969.com/2033/
                    //何文字目を消すか決定
                    let randomInt = Int.random(in: 0..<todoLength)   // 0からtodoLength 1の範囲で整数（Int型）乱数を生成
                    //関数呼び出し
                    todoCharArray = DeleteCharacter(Character: todoCharArray,randomInt : randomInt)
                }
                
                //配列操作
                //https://qiita.com/REON/items/1f33886d90b4f758e715
                
                print("\n---削除後---")
                print("todoCharArray : ",todoCharArray)
                print("todoCharArrayCount : ",todoCharArray.count,"\n")
                
                //配列を結合してstringに変換
                //https://qiita.com/135yshr/items/2a976c2950d350ee34d2
                let str = "" + todoCharArray
                
                //セルの文字の透過度を設定
                cell.textLabel?.alpha = CGFloat(Float.random(in:0.1...0.7))
                cell.textLabel?.text = str
                //print(str)
            }
        } else if switchBool == false{
            cell.textLabel?.text = todoTitle
            
            
            /******************ここまで不便益モード********************/
            
        }
        
        
        
        // tableViewのswitchのindex.rowをtagに保存（1/2）
        // https://swiswiswift.com/2018-04-05/
        /********************************/
        if cell.accessoryView == nil{
            let switchView = UISwitch()
            
            //Switchの初期値を設定
            switchView.isOn = CompleteFlagList[indexPath.row]
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
        CompleteFlagList[sender.tag] = sender.isOn
        
        // 完了フラグをTrueにした日時を保存
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))
        if CompleteFlagList[sender.tag] == true{
            //完了フラグTrue時のアラート設定
            //https://tech.playground.style/未分類/alert/
            let alert = UIAlertController(title: "タスクを完了しますか？", message: "完了したタスクは\nArchiveListに移行されます.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default) { [self] (action) in
                self.dismiss(animated: true, completion: nil)
                print("OKが選択されました.")
                
                CompleteFlagTrueDateList[sender.tag] = dateFormatter.string(from: now)
                
                // 完了フラグリストに状態を保存
                userDefaults.set(CompleteFlagList, forKey: "CompleteFlagList")
                
                // 完了データ保存用の配列にコピー
                todoList2.append(todoList[sender.tag])
                DetailList2.append(DetailList[sender.tag])
                DeadlineList2.append(DeadlineList[sender.tag])
                RegistrationDateList2.append(RegistrationDateList[sender.tag])
                CompleteFlagList2.append(CompleteFlagList[sender.tag])
                CompleteFlagTrueDateList2.append(CompleteFlagTrueDateList[sender.tag])
                
                // 削除
                todoList.remove(at: sender.tag)
                DetailList.remove(at: sender.tag)
                DeadlineList.remove(at: sender.tag)
                RegistrationDateList.remove(at: sender.tag)
                CompleteFlagList.remove(at: sender.tag)
                CompleteFlagTrueDateList.remove(at: sender.tag)
                
                // 削除した内容を保存
                userDefaults.set(todoList, forKey: "todoList")
                userDefaults.set(DetailList, forKey: "DetailList")
                userDefaults.set(DeadlineList, forKey: "DeadlineList")
                userDefaults.set(RegistrationDateList, forKey: "RegistrationDateList")
                userDefaults.set(CompleteFlagList, forKey: "CompleteFlagList")
                userDefaults.set(CompleteFlagTrueDateList, forKey: "CompleteFlagTrueDateList")
                
                // 完了データ保存用の配列を保存
                userDefaults.set(todoList2, forKey: "todoList2")
                userDefaults.set(DetailList2, forKey: "DetailList2")
                userDefaults.set(DeadlineList2, forKey: "DeadlineList2")
                userDefaults.set(RegistrationDateList2, forKey: "RegistrationDateList2")
                userDefaults.set(CompleteFlagList2, forKey: "CompleteFlagList2")
                userDefaults.set(CompleteFlagTrueDateList2, forKey: "CompleteFlagTrueDateList2")
                
                // 画面をリロード
                // https://tsukader.hatenablog.com/entry/2018/08/20/093414
                self.loadView()
            }
            let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { (acrion) in
                self.dismiss(animated: true, completion: nil)
                print("キャンセルが選択されました.")
                self.CompleteFlagList[sender.tag] = false
                sender.isOn = false
            }
            alert.addAction(cancel)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            
        } else if CompleteFlagList[sender.tag] == false {
            CompleteFlagTrueDateList[sender.tag] = "未完了"
        }
        
        userDefaults.set(CompleteFlagTrueDateList, forKey: "CompleteFlagTrueDateList")
        
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
    
    
    //セルをタップしたときの動作
    //https://tech.playground.style/swift/tableview-didselectroeat-beginner-alert/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        num = indexPath.row
        
        //todoListの添字をtodoNumberに保存
        UserDefaults.standard.set(num, forKey: "todoNumber")
        
        // 画面をリロード
        // https://tsukader.hatenablog.com/entry/2018/08/20/093414
        self.loadView()
        
        //遷移https://satoriku.com/value-passing/
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "Next") as! ViewController2
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    
    @IBAction func devButton(_ sender: Any) {
        print("---現在の配列---")
        print("todoList(件名)：",todoList)
        print("DetailList(詳細)：",DetailList)
        print("DeadlineList(期日)：",DeadlineList)
        print("RegistrationDateList(登録日)：",RegistrationDateList)
        print("CompleteFlagList(完了フラグ)：",CompleteFlagList)
        print("CompleteFlagTrueDateList(完了日)：",CompleteFlagTrueDateList)
       
        print("---完了済の配列---")
        print("todoList(件名)：",todoList2)
        print("DetailList(詳細)：",DetailList2)
        print("DeadlineList(期日)：",DeadlineList2)
        print("RegistrationDateList(登録日)：",RegistrationDateList2)
        print("CompleteFlagList(完了フラグ)：",CompleteFlagList2)
        print("CompleteFlagTrueDateList(完了日)：",CompleteFlagTrueDateList2)
        
        // 画面をリロード
        // https://tsukader.hatenablog.com/entry/2018/08/20/093414
        self.loadView()
        
    }
}






