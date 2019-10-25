//
//  tellUsPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 20..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class tellUsPage: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    let userAgreementText = "제1조(목적)\n \n이 약관은 즐거운생활이 운영하는 오락문화매장 플랫폼에서 제공하는 서비스를 이용함에 있어 \"즐거운생활\"과 \"이용자\"의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.\n \n\n제2조(정의)\n \n①\"플랫폼\"이란 \"이용자\"가 컴퓨터, 스마트폰 등 정보통신설비를 이용하여 \"서비스\"를 이용할 수 있도록 즐거운생활이 제공하는 가상의 영업장을 말하며 아울러 \"플랫폼\"을 운영하는 사업자의 의미로도 사용합니다.\n②\"이용자\"란 \"플랫폼\"을 통하여 이 약관에 따라 제공하는 서비스를 받는 회원 및 비회원을 말합니다.\n③\"회원\"이란 \"플랫폼\"에 회원등록을 한 자로서, 계속적으로 \"플랫폼\"이 제공하는 서비스를 이용할 수 있는 자를 말합니다.\n④\"비회원\"이란 회원에 가입하지 않고 \"플랫폼\"이 제공하는 서비스를 이용하는 자를 말합니다.\n \n \n제3조(회원가입)\n \n①\"이용자\"는 \"플랫폼\"이 정한 절차에 따라 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.\n②회원가입계약의 성립 시기는 \"즐거운생활\"의 승낙이 회원에게 도달한 시점으로 합니다.\n③회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 \"플랫폼\"에 대하여 회원정보 수정하거나 E-mail등의 방법으로 그 변경사항을 알려야 합니다.\n④즐거운생활은 관련법령에 따라 필요한 경우 별도의 성인인증 절차를 실시할 수 있습니다.\n \n \n제4조(회원 탈퇴)\n \n회원은 \"즐거운생활\"에 언제든지 탈퇴를 요청할 수 있으며, \"즐거운생활\"은 신속하게 회원탈퇴를 처리합니다.\n \n \n제5조(개인정보보호)\n \n①\"즐거운생활\"은 \"이용자\"의 개인정보 수집 시 서비스 제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.\n②\"즐거운생활\"은 회원가입 시 서비스에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 서비스 이용 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.\n③\"즐거운생활\"은 \"이용자\"의 개인정보를 수집, 이용하는 때에는 당해 \"이용자\"에게 그 목적을 고지하고 동의를 받습니다.\n④\"즐거운생활\"은  수집된 개인정보를 목적 외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용•제공단계에서 당해 “이용자”에게 그 목적을 고지하고 동의를 받습니다.\n⑤“이용자”는 언제든지 “플랫폼”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “플랫폼”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. “이용자”가 오류의 정정을 요구한 경우에는 “플랫폼”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.\n⑥“플랫폼” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.\n \n ● 서비스 제공을 위하여 수집/이용되는 이용자 개인정보\n \n -회원가입 : 회원가입시 본인인증과 휴대전화번호 및 가입 계정, 닉네임을 수집하며, 회원 탈퇴시 즉시 삭제합니다. \n -이용자대상 : 서비스 이용 및 고객센터 상담시 이용컨텐츠, 접속정보, 브라우저 정보, 휴대전화번호 등 최종 로그인으로부터 1년 저장합니다.\n *다만, 다음의 경우는 예외로 하고 법령에 따라 동의 없이 개인정보를 수집/이용할 수 있습니다.\n - 정보통신서비스의 제공에 관한 계약을 이행을 위하여 필요한 개인정보로서 경제적·기술적인 사유로 통상적인 동의를 받는 것이 뚜렷하게 곤란한 경우\n - 정보통신서비스의 제공에 따른 요금정산을 위하여 필요한 경우\n - 그 밖에 법률에 특별한 규정이 있는 경우\n \n ● 개인정보 파기\n\n - 즐거운생활과 이용자간 민원, 소송 등 분쟁 과정 중 법률로 정한 보유기간이 경과한 경우 : 분쟁 해결시까지 보관 후 파기\n - 즐거운생활이 개별적으로 이용자의 동의를 받은 경우 : 해당 동의 받은 기간까지 보관 후 파기\n - \"개인정보 유효기간제\"에 따라 1년간 서비스를 이용하지 않은 회원 : 별도 분리 보관 후 파기\n - 기타 관련 법령에 따라 보유하는 경우\n \n 보유정보                                           /  보유기간\n -----------------------------------------------------------------    \n 이메일, 기기고유번호, 부정거래 등     /  최종 로그인 일로부터 1년 (즐거운생활 내부정책)\n 소비자의 불만 및 분쟁처리 기록         /  3년  (전자상거래 등에서의 소비자 보호에 관한 법률)\n 표시/광고에 관한 기록                      /  6개월  (전자상거래 등에서의 소비자보호에 관한 법)\n 본인 확인에 관한 기록                      /  6개월  (정보통신방 이용촉진 및 정보보호에 관한 법률)\n 사이트 방문에 관한 기록                  /  3개월  (통신비밀보호법)\n \n ● 개인정보 제공\n\n - 즐거운생활은 원칙적으로 이용자 동의 없이 개인정보를 외부에 제공하지 않습니다.\n - 다양한 서비스 제공 및 품질 향상 등의 목적으로 최소한의 개인정보만 제공할 수 있으며, 개인정보를 제3자에게 제공해야 하는 경우에는 반드시 사전에 이용자에게 해당 사실을 알리고 동의를 받은 내용만을 제공하겠습니다.\n - 다음의 경우는 예외로 이용자의 사전 동의없이 이용자 정보를 제공할 수 있습니다.\n  ①관계법령에 의하여 수사상의 목적으로 공공기관으로부터의 요구가 있을 경우\n  ②통계작성, 학술연구나 시장조사를 위하여 특정 개인을 식별할 수 없는 형태로 연구단체 등에 제공하는 경우\n  ③기타 관계법령에서 정한 절차에 따른 요청이 있는 경우\n \n \n제6조(\"즐거운생활\"의 의무)\n \n①\"즐거운생활\"은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하는데 최선을 다하여야 합니다.\n②\"즐거운생활\"은 “이용자”가 안전하게 서비스를 이용할 수 있도록 “이용자”의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.\n③\"즐거운생활\"은 이외에 관계 법령이 정한 의무사항을 준수합니다.\n \n \n제7조(회원의 ID 및 비밀번호에 대한 의무)\n \n① ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.\n② “회원”은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.\n③ “회원”이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “회사”에 통보하고 “회사”의 안내가 있는 경우에는 그에 따라야 합니다.\n④ “회원”이 제3항에 따른 통지를 하지 않거나 “회사”의 조치에 따르지 않아 발생하는 모든 불이익에 대한 책임은 “회원”에게 있습니다\n \n\n제8조(\"이용자:의 의무)\n \n\"이용자\"는 다음 행위를 하여서는 안되며, 적발시 \"회원탈퇴\" 등의 조치를 받을 수 있습니다.\n1. 신청 또는 변경시 허위 내용의 등록\n2. 타인의 정보 도용\n3. “플랫폼”에 게시된 정보의 변경\n4. “플랫폼”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시\n5. “플랫폼” 기타 제3자의 저작권 등 지적재산권에 대한 침해\n6. “플랫폼” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위\n7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 “플랫폼”에 공개 또는 게시하는 행위\n8. 고객행복센터 상담 내용이 욕설, 폭언, 성희롱 등에 해당하는 행위\n9. 확인되지 않은 허위의 게시물을 작성하는 행위\n10. 정당한 사유 없이 “즐거운생활”의 영업을 방해하는 내용을 기재하는 행위\n11. 리버스엔지니어링, 디컴파일, 디스어셈블 및 기타 일체의 가공행위를 통하여 서비스를 복제, 분해 또 모방 기타 변형하는 행위\n12. 자동 접속 프로그램 등을 사용하는 등 정상적인 용법과 다른 방법으로 서비스를 이용하여 “회사”의 서버에 부하를 일으켜 “회사”의 정상적인 서비스를 방해하는 행위\n13. 기타 관계법령에 위반된다고 판단되는 행위\n \n \n제9조(저작권의 귀속 및 이용제한)\n \n①\"즐거운생활\"이 작성한 저작물에 대한 저작권 기타 지적재산권은 \"즐거운생활\"에 귀속합니다.\n② “이용자”는 “플랫폼”을 이용함으로써 얻은 정보 중 \"즐거운생활\"에게 지적재산권이 귀속된 정보를 \"즐거운생활\"의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.\n③ \"즐거운생활\"는 약정에 따라 “이용자”에게 귀속된 저작권을 사용하는 경우 당해 “이용자”에게 통보하여야 합니다.\n \n \n제10조(면책)\n \n①\"즐거운생활\"은 \"오락문화매장\"과 \"이용자\" 간의 상품거래를 중개하는 플랫폼 서비스만을 제공할 뿐, “재화”를 판매하는 당사자가 아니며, “재화”에 대한 정보 및 배송, 하자 등에 대한 책임은 “오락문화매장업주”에게 있습니다. \n②\"즐거운생활\"은 천재지변 또는 이에 준하는 불가항력으로 인하여 “서비스”를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.\n③\"즐거운생활\"은 \"이용자\"의 귀책사유로 인한 “서비스”이용의 장애에 대하여는 책임을 지지 않습니다. \n④\"즐거운생활\"은 \"이용자\"가 게재한 이용후기 등 정보/자료/사실의 신뢰도, 정확성에 대해서는 책임을 지지 않습니다. \n⑤\"즐거운생활\"은 \"이용자\"가 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며, 그 밖의 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않습니다.\n⑥\"즐거운생활\"는 \"이용자\"간 또는 \"이용자\"와 제3자 상호간에 서비스를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다.\n \n \n제11조(재판권 및 준거법)\n \n①\"즐거운생활\"과 “이용자”간에 발생한 분쟁에 관한 소송은 \"즐거운생활\"의 주소지를 관할하는 법원을 관할법원으로 정합니다. \n②\"플랫폼\"과 \"이용자\"간에 제기된 전자상거래 소송에는 한국법을 적용합니다.\n \n \n부칙(시행일)\n본 약관은 2018년 6월 23일부터 적용합니다."
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var pickerTextField: UITextField!
    
    @IBOutlet weak var tellUsTitle: UITextField!
    
    @IBOutlet weak var messge: UITextView!
    
    var checkedRegulation:Bool = false
    var pickOption = ["이용 문의", "이벤트", "개인 정보", "리뷰", "기타"]
    override func viewDidLoad() {
        super.viewDidLoad()
        messge.layer.cornerRadius = 5
        messge.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        messge.layer.borderWidth = 0.5
        messge.clipsToBounds = true
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        self.hideKeyboardWhenTappedAround()
        
        username.text = Auth.auth().currentUser?.displayName
        if Auth.auth().currentUser?.email != nil{
        email.text = Auth.auth().currentUser?.email
        email.isUserInteractionEnabled = false
        }
    
        
       
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        pickerTextField.delegate = self
        
        pickerTextField.inputView = pickerView
        // Do any additional setup after loading the view.
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40))
        
        
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        
        let defaultButton = UIBarButtonItem(title: "Default", style: UIBarButtonItemStyle.plain, target: self, action: #selector(tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Godo M", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "분류를 선택해주세요"

        label.textAlignment = NSTextAlignment.center
        
        toolBar.setItems([flexSpace,doneButton], animated: true)
        
        pickerTextField.inputAccessoryView = toolBar
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        
        pickerTextField.resignFirstResponder()
        
    }
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        pickerTextField.text = "분류 선택"

        pickerTextField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func acceptButtonTapped(_ sender: Any) {
        let button = sender as! UIButton
        if button.backgroundColor == UIColor.orange{
            button.backgroundColor = UIColor.groupTableViewBackground
            checkedRegulation = false
        }
        else{
        button.backgroundColor = UIColor.orange
            checkedRegulation = true
        }
    }
    @IBAction func viewRegulationTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "regulationPage") as! regulationPage
        vc.navigationItem.title = "개인 정보 수집 이용 약관"
        vc.text = userAgreementText
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func submitTapped(_ sender: Any) {
        if checkedRegulation == false{
            let alert = UIAlertController(title: "약관 동의", message: "개인 정보 수집 이용 약관 동의를 해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else if self.messge.text! == "" || self.tellUsTitle.text! == "" || self.email.text! == "" || self.pickerTextField.text == ""{
            let alert = UIAlertController(title: "폼 완성", message: "모든 정보를 기입했는지 확인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else{
            let model:submittedError = submittedError(errorMessage: self.messge.text!, title: self.tellUsTitle.text!, type: self.pickerTextField.text!, uid: (Auth.auth().currentUser?.uid)!, username: (Auth.auth().currentUser?.displayName)!, email: self.email.text!)
            let submitError = try! FirebaseEncoder().encode(model)
            let newPostRef = Database.database().reference().child("user").child((Auth.auth().currentUser?.uid)!).child("submittedError")
            let errorId = newPostRef.childByAutoId().key
            let updatedData = ["user/\((Auth.auth().currentUser?.uid)!)/submittedError/\(errorId)":submitError, "submittedError/\(errorId)":submitError]
            Database.database().reference().updateChildValues(updatedData) { (error, ref) in
                if (error != nil){
                    errorPopup(vc: self, error: error!, errorName: "신고 오류")
                }
                else{
                    let alert = UIAlertController(title: "오류 접수!", message: "감사합니다ㅠ 더 열심히 하겠습니다! :D", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.navigationController?.popViewController(animated: true)
                    }))
                    
                    self.present(alert, animated: true, completion: nil)
                }
            }

        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickOption[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
