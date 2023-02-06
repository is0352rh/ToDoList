//
//  ViewController2.swift
//  ToDoList
//
//  Created by Taizo Kishimoto on 2022/08/21.
//

import UIKit


class ViewController2: UIViewController {
    
    @IBOutlet weak var lavel01: UILabel!
    @IBOutlet weak var lavel02: UILabel!
    @IBOutlet weak var lavel03: UILabel!
    
    let userDefaults = UserDefaults.standard
    
    //ViewControllerでtodoNumberに保存したtodoListの添字
    var Number = UserDefaults.standard.integer(forKey:"todoNumber")
    
    // テーブルに表示するデータの箱
    var todoList = [String]()
    // 詳細を保存するデータの箱
    var DetailList = [String]()
    // 期限を保存するデータの箱
    var DeadlineList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print("添字 : ",Number)
        
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
        
        
        // Do any additional setup after loading the view.
        
        /**************不便益モード*********************/
        // 不便益モード
        let switchBool = userDefaults.bool(forKey: "Inconvenience")
        
        if switchBool == true{
            //文字列を1文字ずつの配列に変換する
            //https://qiita.com/Satochaaan/items/63812ce8ccb030ad9574
            var todoCharArray : [Character] = Array(todoList[Number])
            //件名の文字数を取得
            var todoLength = todoCharArray.count
            
            print("---削除前---")
            print("todoCharArray : ",todoCharArray)
            print("todoCharArrayCount : ",todoLength,"\n")
            
            /************************/
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
            /**************************/
            
            //何文字を消すか決定
            var randomIntCount = 0
            if todoLength == 0  || todoLength == 1{
                lavel01.text = todoList[Number]
                lavel02.text = DetailList[Number]
                lavel03.text = DeadlineList[Number]
            } else if todoLength != 0 || todoLength != 1{
                
                randomIntCount = Int.random(in: 0..<todoLength/2)
                print(randomIntCount,"文字削除します.\n")
                
                for var i in 0..<randomIntCount {
                    i = i + 1
                    todoLength = todoCharArray.count
                    //ランダム数生成
                    //https://capibara1969.com/2033/
                    //何文字目を消すか決定
                    let randomInt = Int.random(in: 0..<todoLength)   // 0からtodoLength - 1の範囲で整数（Int型）乱数を生成
                    //関数呼び出し
                    todoCharArray = DeleteCharacter(Character: todoCharArray,randomInt : randomInt)
                }
                //配列操作
                //https://qiita.com/REON/items/1f33886d90b4f758e715
                //todoCharArray.remove(at: randomInt)
                
                print("\n---削除後---")
                print("todoCharArray : ",todoCharArray)
                print("todoCharArrayCount : ",todoCharArray.count,"\n")
                
                //配列を結合してstringに変換
                //https://qiita.com/135yshr/items/2a976c2950d350ee34d2
                let str = "" + todoCharArray
                //print("str : ",str)
                
                lavel01.text = str
                lavel02.text = DetailList[Number]
                lavel03.text = DeadlineList[Number]
                
                /*
                 lavel01.text = todoList[Number]
                 lavel02.text = DetailList[Number]
                 lavel03.text = DeadlineList[Number]
                 */
                //透過度の変更
                lavel01.alpha = CGFloat(Float.random(in:0.1...0.7))
            }
        } else if switchBool == false{
            lavel01.text = todoList[Number]
            lavel02.text = DetailList[Number]
            lavel03.text = DeadlineList[Number]
            
        }
    }
    
    //編集ボタンをタップしたときの処理
    @IBAction func Edit(_ sender: Any) {
        print("編集ボタンがタップされました.\n")
        
        //件名をUserDefaultsのtodoSubjectに保存
        UserDefaults.standard.set(lavel01.text, forKey: "todoSubject")
        //詳細をUserDefaultsのtodoDetailに保存
        UserDefaults.standard.set(lavel02.text, forKey: "todoDetail")
        //期日をUserDefaultsのtodoDeadlineに保存
        UserDefaults.standard.set(lavel03.text, forKey: "todoDeadline")
        
        let nextView = self.storyboard?.instantiateViewController(withIdentifier: "edit") as! ViewController3
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
