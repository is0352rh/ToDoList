//
//  ViewController6.swift
//  ToDoList31
//
//  Created by Taizo Kishimoto on 2022/09/16.
//

import UIKit

class ViewController6: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var SexField: UITextField!
    @IBOutlet weak var AgeField: UITextField!
    @IBOutlet weak var OccupationField: UITextField!
    @IBOutlet weak var IndustryField: UITextField!
    @IBOutlet weak var OneText: UITextField!
    @IBOutlet weak var TwoText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //キーボード格納機能（1/2）https://softmoco.com/basics/how-to-dismiss-keyboard-by-tapping-outside.php
        let tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGR.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGR)

    }
    
    //キーボード格納機能（2/2）
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        print("名前：",NameField.text as Any)
        print("性別：",SexField.text as Any)
        print("年齢：",AgeField.text as Any)
        print("職種：",OccupationField.text as Any)
        print("業種：",IndustryField.text as Any)
        print("問1：",OneText.text as Any)
        print("問2：",TwoText.text as Any)
        
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMdkHm", options: 0, locale: Locale(identifier: "ja_JP"))
        
        appendText(string: "\n")
        appendText(string: "--------事前アンケート--------\n")
        appendText(string: "実行日")
        appendText(string: dateFormatter.string(from: now) + "\n")
        appendText(string: "名前:" + NameField.text!)
        appendText(string: "性別:" + SexField.text!)
        appendText(string: "年齢:" + AgeField.text!)
        appendText(string: "職種:" + OccupationField.text!)
        appendText(string: "業種:" + IndustryField.text!)
        appendText(string: "問1:" + OneText.text!)
        appendText(string: "問2:" + TwoText.text!)
        appendText(string: "\n----------------------------")
        
        
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
            writingToFile(text: "Logファイル\n\n")
            print("Error: \(error)")
        }
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
