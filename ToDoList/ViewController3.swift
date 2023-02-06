//
//  ViewController3.swift
//  ToDoList02
//
//  Created by Taizo Kishimoto on 2022/08/22.
//

import UIKit

class ViewController3: UIViewController {
    
    @IBOutlet weak var Subject: UITextField!
    @IBOutlet weak var Detail: UITextField!
    @IBOutlet var Tap: UITapGestureRecognizer!
    @IBOutlet weak var Picker: UIDatePicker!
    
    let userDefaults = UserDefaults.standard
    //var strArray = [String]()
    
    // テーブルに表示するデータの箱
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
    //ViewControllerでtodoNumberに保存したtodoListの添字
    var Number = UserDefaults.standard.integer(forKey:"todoNumber")
    
    
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
        
        //キーボード格納機能（1/2）https://softmoco.com/basics/how-to-dismiss-keyboard-by-tapping-outside.php
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)
        
        //テキストフィールドの初期値を設定
        if todoList.count == Number {
            //print("---新規登録---")
        } else {
            //print("---更新---")
            Subject.text = todoList[Number]
            Detail.text = DetailList[Number]
  
            //Pickerの初期値を設定
            let dateString = DeadlineList[Number]
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))
            
            //print(dateString,"String型")
            //print(dateFormatter.date(from: dateString) as Any,"Date型\n")
            
            let DefaultDate = dateFormatter.date(from: dateString)
            //let bbb = DefaultDate! + 32400
            //print("bbb : ",bbb)
            Picker.date = DefaultDate!
        }
    }
    
    
    
    //キーボード格納機能（2/2）
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    // 文字列保存用の変数
    var SubjectTextField = ""
    var DetailTextField = ""
    var DeadLineTextField = ""
    
    //保存ボタンをタップしたときの処理
    @IBAction func Save(_ sender: Any) {
        print("保存がタップされました.")
        
        //print("Piker.date : ",Picker.date)
        
        let DayTime = Picker.date
        
        //DayTime = DayTime - 1000000
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))
        //print(dateFormatter.string(from: DayTime),"\n\n") // 2018/10/28 18:17:38
    
        //TextFieldから文字を取得
        //https://teratail.com/questions/53620
        SubjectTextField = Subject.text!
        DetailTextField = Detail.text!
       
        
        // print文でbool型を出力する方法
        //https://capibara1969.com/1351/
        if todoList.count != Number {
            print("---更新前---")
            print("件名 : " + todoList[Number])
            print("詳細 : " + DetailList[Number])
            print("期日 : " + DeadlineList[Number])
            print("登録日 : " + RegistrationDateList[Number])
            print("完了フラグ : \(CompleteFlagList[Number])")
            print("完了日 : " + CompleteFlagTrueDateList[Number])
        }
        
        let now = Date()
        //配列に追加
        //https://qiita.com/REON/items/1f33886d90b4f758e715
        if todoList.count == Number {
            print("---新規登録---")
            todoList.append(SubjectTextField)
            DetailList.append(DetailTextField)
            DeadlineList.append(dateFormatter.string(from: DayTime))
            RegistrationDateList.append(dateFormatter.string(from: now))
            CompleteFlagList.append(false)
            CompleteFlagTrueDateList.append("未完了")
        } else {
           print("---更新後---")
            todoList[Number] = SubjectTextField
            DetailList[Number] = DetailTextField
            DeadlineList[Number] = dateFormatter.string(from: DayTime)
        }

        print("件名 : " + SubjectTextField)
        print("詳細 : " + DetailTextField)
        print("期日 : " + dateFormatter.string(from: DayTime))
        print("登録日 : " + dateFormatter.string(from: now))
        print("完了フラグ : \(CompleteFlagList[Number])")
        print("完了日 : " + CompleteFlagTrueDateList[Number])

        
        UserDefaults.standard.set(todoList, forKey: "todoList")
        UserDefaults.standard.set(DetailList, forKey: "DetailList")
        UserDefaults.standard.set(DeadlineList, forKey: "DeadlineList")
        UserDefaults.standard.set(RegistrationDateList, forKey: "RegistrationDateList")
        UserDefaults.standard.set(CompleteFlagList, forKey: "CompleteFlagList")
        UserDefaults.standard.set(CompleteFlagTrueDateList, forKey: "CompleteFlagTrueDateList")
        
        
        
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "top") as! ViewController
        self.navigationController?.pushViewController(nextView, animated: true)
        
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
