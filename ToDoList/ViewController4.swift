//
//  ViewController4.swift
//  ToDoList31
//
//  Created by Taizo Kishimoto on 2022/09/16.
//

import UIKit

class ViewController4: UIViewController {

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
    
    @IBOutlet weak var Label01: UILabel!
    @IBOutlet weak var Label02: UILabel!
    @IBOutlet weak var Label03: UILabel!
    @IBOutlet weak var Label04: UILabel!
    @IBOutlet weak var Label05: UILabel!
    @IBOutlet weak var Label06: UILabel!
    @IBOutlet weak var Label07: UILabel!
    @IBOutlet weak var Label08: UILabel!
    @IBOutlet weak var Label09: UILabel!
    @IBOutlet weak var Label10: UILabel!
    @IBOutlet weak var Label11: UILabel!
    @IBOutlet weak var Label12: UILabel!
    @IBOutlet weak var Label13: UILabel!
    @IBOutlet weak var Label14: UILabel!
    @IBOutlet weak var Label15: UILabel!
    @IBOutlet weak var Label16: UILabel!
    @IBOutlet weak var Label17: UILabel!
    
    //Stepperの使用方法
   //https://hajihaji-lemon.com/swift/stepper/
    @IBAction func Stepper01(_ sender01: UIStepper) {
        Label01.text = "値：\(sender01.value)"
    }
    
    @IBAction func Stepper02(_ sender02: UIStepper) {
        Label02.text = "値：\(sender02.value)"
    }
    
    
    @IBAction func Stepper03(_ sender03: UIStepper) {
        Label03.text = "値：\(sender03.value)"
    }
    
    
    @IBAction func Stepper04(_ sender04: UIStepper) {
        Label04.text = "値：\(sender04.value)"
    }
    
    @IBAction func Stepper05(_ sender05: UIStepper) {
        Label05.text = "値：\(sender05.value)"
    }
    
    @IBAction func Stepper06(_ sender06: UIStepper) {
        Label06.text = "値：\(sender06.value)"
    }
    
    @IBAction func Stepper07(_ sender07: UIStepper) {
        Label07.text = "値：\(sender07.value)"
    }
    
    @IBAction func Stepper08(_ sender08: UIStepper) {
        Label08.text = "値：\(sender08.value)"
    }
    
    
    @IBAction func Stepper09(_ sender09: UIStepper) {
        Label09.text = "値：\(sender09.value)"
    }
    
    @IBAction func Stepper10(_ sender10: UIStepper) {
        Label10.text = "値：\(sender10.value)"
    }
    
    
    @IBAction func Stepper11(_ sender11: UIStepper) {
        Label11.text = "値：\(sender11.value)"
    }
    
    
    @IBAction func Stepper12(_ sender12: UIStepper) {
        Label12.text = "値：\(sender12.value)"
    }
    
    
    @IBAction func Stepper13(_ sender13: UIStepper) {
        Label13.text = "値：\(sender13.value)"
    }
    
    @IBAction func Stepper14(_ sender14: UIStepper) {
        Label14.text = "値：\(sender14.value)"
    }
    
    
    @IBAction func Stepper15(_ sender15: UIStepper) {
        Label15.text = "値：\(sender15.value)"
    }
    
    @IBAction func Stepper16(_ sender16: UIStepper) {
        Label16.text = "値：\(sender16.value)"
    }
    
    
    @IBAction func Stepper17(_ sender17: UIStepper) {
        Label17.text = "値：\(sender17.value)"
    }
    
    
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
    }
    

    @IBAction func completeButoon(_ sender: Any) {
        
        print("1:",Label01.text as Any)
        print("2:",Label02.text as Any)
        print("3:",Label03.text as Any)
        print("4:",Label04.text as Any)
        print("5:",Label05.text as Any)
        print("6:",Label06.text as Any)
        print("7:",Label07.text as Any)
        print("8:",Label08.text as Any)
        print("9:",Label09.text as Any)
        print("10:",Label10.text as Any)
        print("11:",Label11.text as Any)
        print("12:",Label12.text as Any)
        print("13:",Label13.text as Any)
        print("14:",Label14.text as Any)
        print("15:",Label15.text as Any)
        print("16:",Label16.text as Any)
        print("17:",Label17.text as Any)
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))
        
        //appendText(string: "\n")
        appendText(string: "\n--------UWES--------\n")
        appendText(string: "実行日")
        appendText(string: dateFormatter.string(from: now) + "\n")
        appendText(string: "1:" + Label01.text!)
        appendText(string: "2:" + Label02.text!)
        appendText(string: "3:" + Label03.text!)
        appendText(string: "4:" + Label04.text!)
        appendText(string: "5:" + Label05.text!)
        appendText(string: "6:" + Label06.text!)
        appendText(string: "7:" + Label07.text!)
        appendText(string: "8:" + Label08.text!)
        appendText(string: "9:" + Label09.text!)
        appendText(string: "10:" + Label10.text!)
        appendText(string: "11:" + Label11.text!)
        appendText(string: "12:" + Label12.text!)
        appendText(string: "13:" + Label13.text!)
        appendText(string: "14:" + Label14.text!)
        appendText(string: "15:" + Label15.text!)
        appendText(string: "16:" + Label16.text!)
        appendText(string: "17:" + Label17.text!)
        appendText(string: "\n----------------------------\n")
        
        //let OpenAppCounterString = String(OpenAppCounter)
        //print("tap to log")
        
        //appendText(string: "\n【アプリを開いた回数】")
        //appendText(string: OpenAppCounterString + "\n\n")
        appendText(string: "--------ToDoリスト:未完了--------\n")
        
        appendText(string: "【期日】")
        var i = 1
        for num in DeadlineList {
            appendText(string: String(i) + ". " + num)
            i = i + 1
        }
        
        appendText(string: "\n")
        i = 1
        
        appendText(string: "【登録日】")
        for num in RegistrationDateList {
            appendText(string: String(i) + ". " + num)
            i = i + 1
        }
        
        appendText(string: "\n")
        i = 1
        
        appendText(string: "【完了日】")
        for num in CompleteFlagTrueDateList {
            appendText(string: String(i) + ". " + num)
            i = i + 1
        }
        
        
        appendText(string: "\n----------------------------\n")
        appendText(string: "--------ToDoリスト:完了済--------\n")
        
        i = 1
        appendText(string: "【期日】")
        for num in DeadlineList2 {
            appendText(string: String(i) + ". " + num)
            i = i + 1
        }
        
        appendText(string: "\n")
        i = 1
        
        appendText(string: "【登録日】")
        for num in RegistrationDateList2 {
            appendText(string:  String(i) + ". " + num)
            i = i + 1
        }
        
        i = 1
        appendText(string: "\n")
        
        appendText(string: "【完了日】")
        for num in CompleteFlagTrueDateList2 {
            appendText(string:  String(i) + ". " + num)
            i = i + 1
        }
        
        appendText(string: "\n----------------------------\n")
        
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "top") as! ViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    
    func writingToFile(text: String) {
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        let fileURL = dirURL.appendingPathComponent("Logfile.txt")
        print(fileURL)
        do {
            try text.write(to: fileURL, atomically: true, encoding: .utf8)
        } catch {
            print("failed to write: \(error)")
        }
    }
    
    func appendText(string: String) {
        guard let dirURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            fatalError("フォルダURL取得エラー")
        }
        let fileURL = dirURL.appendingPathComponent("Logfile.txt")
        print(fileURL)
        do {
            let fileHandle = try FileHandle(forWritingTo: fileURL)
            let stringToWrite = "\n" + string
            fileHandle.seekToEndOfFile()
            fileHandle.write(stringToWrite.data(using: String.Encoding.utf8)!)
            
        } catch let error as NSError {
            writingToFile(text: "新規ファイル\n\n")
            print("Error: \(error)")
        }
    }
    
  
    
    // スクロールビューの使い方
    // https://utro-develop.com/xcode-scrollview/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
