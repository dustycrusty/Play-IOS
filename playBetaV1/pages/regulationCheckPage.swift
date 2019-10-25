//
//  regulationCheckPage.swift
//  playBetaV1
//
//  Created by 이승윤 on 2018. 5. 6..
//  Copyright © 2018년 Dustin Lee. All rights reserved.
//

import UIKit
import M13Checkbox

class regulationCheckPage: UIViewController {
    let userAgreementText = "제1조(목적)\n \n이 약관은 즐거운생활이 운영하는 오락문화매장 플랫폼에서 제공하는 서비스를 이용함에 있어 \"즐거운생활\"과 \"이용자\"의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.\n \n\n제2조(정의)\n \n①\"플랫폼\"이란 \"이용자\"가 컴퓨터, 스마트폰 등 정보통신설비를 이용하여 \"서비스\"를 이용할 수 있도록 즐거운생활이 제공하는 가상의 영업장을 말하며 아울러 \"플랫폼\"을 운영하는 사업자의 의미로도 사용합니다.\n②\"이용자\"란 \"플랫폼\"을 통하여 이 약관에 따라 제공하는 서비스를 받는 회원 및 비회원을 말합니다.\n③\"회원\"이란 \"플랫폼\"에 회원등록을 한 자로서, 계속적으로 \"플랫폼\"이 제공하는 서비스를 이용할 수 있는 자를 말합니다.\n④\"비회원\"이란 회원에 가입하지 않고 \"플랫폼\"이 제공하는 서비스를 이용하는 자를 말합니다.\n \n \n제3조(회원가입)\n \n①\"이용자\"는 \"플랫폼\"이 정한 절차에 따라 이 약관에 동의한다는 의사표시를 함으로서 회원가입을 신청합니다.\n②회원가입계약의 성립 시기는 \"즐거운생활\"의 승낙이 회원에게 도달한 시점으로 합니다.\n③회원은 회원가입 시 등록한 사항에 변경이 있는 경우, 상당한 기간 이내에 \"플랫폼\"에 대하여 회원정보 수정하거나 E-mail등의 방법으로 그 변경사항을 알려야 합니다.\n④즐거운생활은 관련법령에 따라 필요한 경우 별도의 성인인증 절차를 실시할 수 있습니다.\n \n \n제4조(회원 탈퇴)\n \n회원은 \"즐거운생활\"에 언제든지 탈퇴를 요청할 수 있으며, \"즐거운생활\"은 신속하게 회원탈퇴를 처리합니다.\n \n \n제5조(개인정보보호)\n \n①\"즐거운생활\"은 \"이용자\"의 개인정보 수집 시 서비스 제공을 위하여 필요한 범위에서 최소한의 개인정보를 수집합니다.\n②\"즐거운생활\"은 회원가입 시 서비스에 필요한 정보를 미리 수집하지 않습니다. 다만, 관련 법령상 의무이행을 위하여 서비스 이용 이전에 본인확인이 필요한 경우로서 최소한의 특정 개인정보를 수집하는 경우에는 그러하지 아니합니다.\n③\"즐거운생활\"은 \"이용자\"의 개인정보를 수집, 이용하는 때에는 당해 \"이용자\"에게 그 목적을 고지하고 동의를 받습니다.\n④\"즐거운생활\"은  수집된 개인정보를 목적 외의 용도로 이용할 수 없으며, 새로운 이용목적이 발생한 경우 또는 제3자에게 제공하는 경우에는 이용•제공단계에서 당해 “이용자”에게 그 목적을 고지하고 동의를 받습니다.\n⑤“이용자”는 언제든지 “플랫폼”이 가지고 있는 자신의 개인정보에 대해 열람 및 오류정정을 요구할 수 있으며 “플랫폼”은 이에 대해 지체 없이 필요한 조치를 취할 의무를 집니다. “이용자”가 오류의 정정을 요구한 경우에는 “플랫폼”은 그 오류를 정정할 때까지 당해 개인정보를 이용하지 않습니다.\n⑥“플랫폼” 또는 그로부터 개인정보를 제공받은 제3자는 개인정보의 수집목적 또는 제공받은 목적을 달성한 때에는 당해 개인정보를 지체 없이 파기합니다.\n \n ● 서비스 제공을 위하여 수집/이용되는 이용자 개인정보\n \n -회원가입 : 회원가입시 본인인증과 휴대전화번호 및 가입 계정, 닉네임을 수집하며, 회원 탈퇴시 즉시 삭제합니다. \n -이용자대상 : 서비스 이용 및 고객센터 상담시 이용컨텐츠, 접속정보, 브라우저 정보, 휴대전화번호 등 최종 로그인으로부터 1년 저장합니다.\n *다만, 다음의 경우는 예외로 하고 법령에 따라 동의 없이 개인정보를 수집/이용할 수 있습니다.\n - 정보통신서비스의 제공에 관한 계약을 이행을 위하여 필요한 개인정보로서 경제적·기술적인 사유로 통상적인 동의를 받는 것이 뚜렷하게 곤란한 경우\n - 정보통신서비스의 제공에 따른 요금정산을 위하여 필요한 경우\n - 그 밖에 법률에 특별한 규정이 있는 경우\n \n ● 개인정보 파기\n\n - 즐거운생활과 이용자간 민원, 소송 등 분쟁 과정 중 법률로 정한 보유기간이 경과한 경우 : 분쟁 해결시까지 보관 후 파기\n - 즐거운생활이 개별적으로 이용자의 동의를 받은 경우 : 해당 동의 받은 기간까지 보관 후 파기\n - \"개인정보 유효기간제\"에 따라 1년간 서비스를 이용하지 않은 회원 : 별도 분리 보관 후 파기\n - 기타 관련 법령에 따라 보유하는 경우\n \n 보유정보                                           /  보유기간\n -----------------------------------------------------------------    \n 이메일, 기기고유번호, 부정거래 등     /  최종 로그인 일로부터 1년 (즐거운생활 내부정책)\n 소비자의 불만 및 분쟁처리 기록         /  3년  (전자상거래 등에서의 소비자 보호에 관한 법률)\n 표시/광고에 관한 기록                      /  6개월  (전자상거래 등에서의 소비자보호에 관한 법)\n 본인 확인에 관한 기록                      /  6개월  (정보통신방 이용촉진 및 정보보호에 관한 법률)\n 사이트 방문에 관한 기록                  /  3개월  (통신비밀보호법)\n \n ● 개인정보 제공\n\n - 즐거운생활은 원칙적으로 이용자 동의 없이 개인정보를 외부에 제공하지 않습니다.\n - 다양한 서비스 제공 및 품질 향상 등의 목적으로 최소한의 개인정보만 제공할 수 있으며, 개인정보를 제3자에게 제공해야 하는 경우에는 반드시 사전에 이용자에게 해당 사실을 알리고 동의를 받은 내용만을 제공하겠습니다.\n - 다음의 경우는 예외로 이용자의 사전 동의없이 이용자 정보를 제공할 수 있습니다.\n  ①관계법령에 의하여 수사상의 목적으로 공공기관으로부터의 요구가 있을 경우\n  ②통계작성, 학술연구나 시장조사를 위하여 특정 개인을 식별할 수 없는 형태로 연구단체 등에 제공하는 경우\n  ③기타 관계법령에서 정한 절차에 따른 요청이 있는 경우\n \n \n제6조(\"즐거운생활\"의 의무)\n \n①\"즐거운생활\"은 법령과 이 약관이 금지하거나 공서양속에 반하는 행위를 하지 않으며 이 약관이 정하는 바에 따라 지속적이고, 안정적으로 서비스를 제공하는데 최선을 다하여야 합니다.\n②\"즐거운생활\"은 “이용자”가 안전하게 서비스를 이용할 수 있도록 “이용자”의 개인정보(신용정보 포함)보호를 위한 보안 시스템을 갖추어야 합니다.\n③\"즐거운생활\"은 이외에 관계 법령이 정한 의무사항을 준수합니다.\n \n \n제7조(회원의 ID 및 비밀번호에 대한 의무)\n \n① ID와 비밀번호에 관한 관리책임은 회원에게 있습니다.\n② “회원”은 자신의 ID 및 비밀번호를 제3자에게 이용하게 해서는 안됩니다.\n③ “회원”이 자신의 ID 및 비밀번호를 도난당하거나 제3자가 사용하고 있음을 인지한 경우에는 바로 “회사”에 통보하고 “회사”의 안내가 있는 경우에는 그에 따라야 합니다.\n④ “회원”이 제3항에 따른 통지를 하지 않거나 “회사”의 조치에 따르지 않아 발생하는 모든 불이익에 대한 책임은 “회원”에게 있습니다\n \n\n제8조(\"이용자:의 의무)\n \n\"이용자\"는 다음 행위를 하여서는 안되며, 적발시 \"회원탈퇴\" 등의 조치를 받을 수 있습니다.\n1. 신청 또는 변경시 허위 내용의 등록\n2. 타인의 정보 도용\n3. “플랫폼”에 게시된 정보의 변경\n4. “플랫폼”이 정한 정보 이외의 정보(컴퓨터 프로그램 등) 등의 송신 또는 게시\n5. “플랫폼” 기타 제3자의 저작권 등 지적재산권에 대한 침해\n6. “플랫폼” 기타 제3자의 명예를 손상시키거나 업무를 방해하는 행위\n7. 외설 또는 폭력적인 메시지, 화상, 음성, 기타 공서양속에 반하는 정보를 “플랫폼”에 공개 또는 게시하는 행위\n8. 고객행복센터 상담 내용이 욕설, 폭언, 성희롱 등에 해당하는 행위\n9. 확인되지 않은 허위의 게시물을 작성하는 행위\n10. 정당한 사유 없이 “즐거운생활”의 영업을 방해하는 내용을 기재하는 행위\n11. 리버스엔지니어링, 디컴파일, 디스어셈블 및 기타 일체의 가공행위를 통하여 서비스를 복제, 분해 또 모방 기타 변형하는 행위\n12. 자동 접속 프로그램 등을 사용하는 등 정상적인 용법과 다른 방법으로 서비스를 이용하여 “회사”의 서버에 부하를 일으켜 “회사”의 정상적인 서비스를 방해하는 행위\n13. 기타 관계법령에 위반된다고 판단되는 행위\n \n \n제9조(저작권의 귀속 및 이용제한)\n \n①\"즐거운생활\"이 작성한 저작물에 대한 저작권 기타 지적재산권은 \"즐거운생활\"에 귀속합니다.\n② “이용자”는 “플랫폼”을 이용함으로써 얻은 정보 중 \"즐거운생활\"에게 지적재산권이 귀속된 정보를 \"즐거운생활\"의 사전 승낙 없이 복제, 송신, 출판, 배포, 방송 기타 방법에 의하여 영리목적으로 이용하거나 제3자에게 이용하게 하여서는 안됩니다.\n③ \"즐거운생활\"는 약정에 따라 “이용자”에게 귀속된 저작권을 사용하는 경우 당해 “이용자”에게 통보하여야 합니다.\n \n \n제10조(면책)\n \n①\"즐거운생활\"은 \"오락문화매장\"과 \"이용자\" 간의 상품거래를 중개하는 플랫폼 서비스만을 제공할 뿐, “재화”를 판매하는 당사자가 아니며, “재화”에 대한 정보 및 배송, 하자 등에 대한 책임은 “오락문화매장업주”에게 있습니다. \n②\"즐거운생활\"은 천재지변 또는 이에 준하는 불가항력으로 인하여 “서비스”를 제공할 수 없는 경우에는 서비스 제공에 관한 책임이 면제됩니다.\n③\"즐거운생활\"은 \"이용자\"의 귀책사유로 인한 “서비스”이용의 장애에 대하여는 책임을 지지 않습니다. \n④\"즐거운생활\"은 \"이용자\"가 게재한 이용후기 등 정보/자료/사실의 신뢰도, 정확성에 대해서는 책임을 지지 않습니다. \n⑤\"즐거운생활\"은 \"이용자\"가 서비스를 이용하여 기대하는 수익을 상실한 것에 대하여 책임을 지지 않으며, 그 밖의 서비스를 통하여 얻은 자료로 인한 손해에 관하여 책임을 지지 않습니다.\n⑥\"즐거운생활\"는 \"이용자\"간 또는 \"이용자\"와 제3자 상호간에 서비스를 매개로 하여 거래 등을 한 경우에는 책임이 면제됩니다.\n \n \n제11조(재판권 및 준거법)\n \n①\"즐거운생활\"과 “이용자”간에 발생한 분쟁에 관한 소송은 \"즐거운생활\"의 주소지를 관할하는 법원을 관할법원으로 정합니다. \n②\"플랫폼\"과 \"이용자\"간에 제기된 전자상거래 소송에는 한국법을 적용합니다.\n \n \n부칙(시행일)\n본 약관은 2018년 6월 23일부터 적용합니다."
    
    let locationAgreement = "제1조 (목적)\n\n \n\n본 약관은 회원(즐거운생활 서비스 약관에 동의한 자를 말합니다. 이하 \"회원\"이라고 합니다.)이 즐거운생활이 제공하는 즐거운생활 서비스를 이용함에 있어 \"즐거운생활\"과 회원의 권리•의무 및 책임사항을 규정함을 목적으로 합니다.\n\n \n\n \n\n제2조 (이용약관의 효력 및 변경)\n\n \n\n① 본 약관은 서비스를 신청한 고객 또는 개인위치정보주체가 본 약관에 동의하고 \"즐거운생활\"이 정한 소정의 절차에 따라 서비스의 이용자로 등록함으로써 효력이 발생합니다.\n\n② 회원이 온라인에서 본 약관 \"동의하기\" 버튼을 클릭하였을 경우 또는 오프라인 업체에서 서비스 이용 시 즐거운생활 앱 내 본 약관의 \"동의하기\" 버튼을 클릭하여 서비스를 이용한 경우, 본 약관의 내용을 모두 읽고 이를 충분히 이해하였으며, 그 적용에 동의한 것으로 간주합니다.\n\n③ \"즐거운생활\"은 위치정보의 보호 및 이용 등에 관한 법률, 콘텐츠산업 진흥법, 전자상거래 등에서의 소비자보호에 관한 법률, 소비자기본법 약관의 규제에 관한 법률 등 관련법령을 위배하지 않는 범위에서 본 약관을 개정할 수 있습니다.\n\n④ \"즐거운생활\"이 약관을 개정할 경우에는 기존약관과 개정약관 및 개정약관의 적용일자와 개정사유를 명시하여 현행약관과 함께 그 적용일자 10일 전부터 적용일 이후 상당한 기간 동안 공지만을 하고, 개정 내용이 회원에게 불리한 경우에는 그 적용일자 30일 전부터 적용일 이후 상당한 기간 동안 각각 이를 서비스 홈페이지에 게시하거나 회원에게 전자적 형태(전자우편, SMS 등)로 약관 개정 사실을 발송하여 고지합니다. \n\n⑤ \"즐거운생활\"은 전항에 따라 회원에게 통지하면서 공지 또는 공지∙고지일로부터 개정약관 시행일 7일 후까지 거부의사를 표시하지 아니하면 이용약관에 승인한 것으로 봅니다. 회원이 개정약관에 동의하지 않을 경우 회원은 이용계약을 해지할 수 있습니다.\n\n \n\n \n\n제3조 (관계법령의 적용) \n\n \n\n본 약관은 신의성실의 원칙에 따라 공정하게 적용하며, 본 약관에 명시되지 아니한 사항에 대하여는 관계법령 또는 상관례에 따릅니다.\n\n \n\n \n\n제4조 (서비스의 내용)\n\n \n\n ① 위치정보 수집 대상의 실시간 위치확인\n\n ②  이용자의 위치에서 근접한 매장정보 제공 \n\n \n\n \n\n제5조 (서비스 이용요금)\n\n \n\n① \"즐거운생활\"이 제공하는 서비스는 기본적으로 무료입니다. 단, 별도의 유료 서비스의 경우 해당 서비스에 명시된 요금을 지불하여야 사용 가능합니다.\n\n② \"즐거운생활\"은 유료 서비스 이용요금을 회사와 계약한 전자지불업체에서 정한 방법에 의하거나 회사가 정한 청구서에 합산하여 청구할 수 있습니다.\n\n③ 유료서비스 이용을 통하여 결제된 대금에 대한 취소 및 환불은 \"즐거운생활\" 결제 이용약관 등 관계법에 따릅니다.\n\n④ 회원의 개인정보도용 및 결제사기로 인한 환불요청 또는 결제자의 개인정보 요구는 법률이 정한 경우 외에는 거절될 수 있습니다.\n\n⑤ 무선 서비스 이용 시 발생하는 데이터 통신료는 별도이며 가입한 각 이동통신사의 정책에 따릅니다.\n\n \n\n \n\n제6조 (서비스내용변경 통지 등)\n\n \n\n① \"즐거운생활\"은 서비스 내용을 변경하거나 종료하는 경우 회원의 등록된 전자우편 주소로 이메일을 통하여 서비스 내용의 변경 사항 또는 종료를 통지할 수 있습니다.\n\n② ①항의 경우 불특정 다수인을 상대로 통지를 함에 있어서는 웹사이트 등 기타 공지사항을 통하여 회원들에게 통지할 수 있습니다.\n\n \n\n \n\n제7조 (개인위치정보의 이용 또는 제공)\n\n \n\n① \"즐거운생활\"은 개인위치정보를 이용하여 서비스를 제공하고자 하는 경우에는 미리 이용약관에 명시한 후 개인위치정보주체의 동의를 얻어야 합니다.\n\n② 회원 및 법정대리인의 권리와 그 행사방법은 제소 당시의 이용자의 주소에 의하며, 주소가 없는 경우에는 거소를 관할하는 지방법원의 전속관할로 합니다. 다만, 제소 당시 이용자의 주소 또는 거소가 분명하지 않거나 외국 거주자의 경우에는 민사소송법상의 관할법원에 제기합니다.\n\n③ \"즐거운생활\"은 타사업자 또는 이용 고객과의 요금정산 및 민원처리를 위해 위치정보 이용•제공․사실 확인자료를 자동 기록•보존하며, 해당 자료는 1년간 보관합니다.\n\n④ \"즐거운생활\"은 개인위치정보를 회원이 지정하는 제3자에게 제공하는 경우에는 개인위치정보를 수집한 당해 통신 단말장치로 매회 회원에게 제공받는 자, 제공일시 및 제공목적을 즉시 통보합니다. 단, 아래 각 호의 1에 해당하는 경우에는 회원이 미리 특정하여 지정한 통신 단말장치 또는 전자우편주소로 통보합니다. 1. 개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우\n\n1. 개인위치정보를 수집한 당해 통신단말장치가 문자, 음성 또는 영상의 수신기능을 갖추지 아니한 경우\n\n2. 회원이 온라인 게시 등의 방법으로 통보할 것을 미리 요청한 경우\n\n \n\n \n\n제8조 (개인위치정보주체의 권리)\n\n \n\n① 회원은 \"즐거운생활\"에 대하여 언제든지 개인위치정보를 이용한 위치기반서비스 제공 및 개인위치정보의 제3자 제공에 대한 동의의 전부 또는 일부를 철회할 수 있습니다. 이 경우 수집한 개인위치정보 및 위치정보 이용, 제공사실 확인자료를 파기합니다.\n\n② 회원은 \"즐거운생활\"에 대하여 언제든지 개인위치정보의 수집, 이용 또는 제공의 일시적인 중지를 요구할 수 있으며, \"즐거운생활\"은 이를 거절할 수 없고 이를 위한 기술적 수단을 갖추고 있습니다.\n\n③ 회원은 \"즐거운생활\"에 대하여 아래 각 호의 자료에 대한 열람 또는 고지를 요구할 수 있고, 당해 자료에 오류가 있는 경우에는 그 정정을 요구할 수 있습니다. 이 경우  \"즐거운생활\"은 정당한 사유 없이 회원의 요구를 거절할 수 없습니다.\n\n1. 본인에 대한 위치정보 수집, 이용, 제공사실 확인자료\n\n2. 본인의 개인위치정보가 위치정보의 보호 및 이용 등에 관한 법률 또는 다른 법률 규정에 의하여 제3자에게 제공된 이유 및 내용\n\n④ 회원은 제1항 내지 제3항의 권리행사를 위해  \"즐거운생활\"의 소정에 절차를 통해 요구할 수 있습니다.\n\n \n\n \n\n제9조 (위치정보관리책임자의 지정)\n\n \n\n① \"즐거운생활\"은 위치정보를 적절히 관리․보호하고 개인위치정보주체의 불만을 원활히 처리할 수 있도록 실질적인 책임을 질 수 있는 지위에 있는 자를 위치정보관리책임자로 지정해 운영합니다. \n\n② 위치정보관리책임자는 위치기반서비스를 제공하는 부서의 부서장으로서 구체적인 사항은 본 약관의 부칙에 따릅니다.\n\n \n\n \n\n제10조 (손해배상) \n\n \n\n① \"즐거운생활\"이 위치정보의 보호 및 이용 등에 관한 법률 제15조 내지 제26조의 규정을 위반한 행위로 회원에게 손해가 발생한 경우 회원은 \"즐거운생활\"에 대하여 손해배상 청구를 할 수 있습니다. 이 경우 \"즐거운생활\"은 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.\n\n회원이 서비스 및 혜택받기를 이용하면서 불법행위 또는 고의나 과실로 이 약관을 위한하여 회사가 해당 고객 이외의 제 3자로부터 손해배상청구 또는 소송을 비롯한 각종이의제기를 받는다면 해당 고객은 그 때문에 회사에 발생한 손해를 배상해야 합니다.\n\n② 회원이 본 약관의 규정을 위반하여 \"즐거운생활\"에 손해가 발생한 경우 회사는 회원에 대하여 손해배상을 청구할 수 있습니다. 이 경우 회원은 고의, 과실이 없음을 입증하지 못하는 경우 책임을 면할 수 없습니다.\n\n \n\n \n\n제11조 (면책) \n\n \n\n① \"즐거운생활\"은 다음 각 호의 경우로 서비스를 제공할 수 없는 경우 이로 인하여 회원에게 발생한 손해에 대해서는 책임을 부담하지 않습니다. \n\n1. 천재지변 또는 이에 준하는 불가항력의 상태가 있는 경우\n\n2. 서비스 제공을 위하여 \"즐거운생활\"과 서비스 제휴계약을 체결한 제3자의 고의적인 서비스 방해가 있는 경우\n\n3. 회원의 귀책사유로 서비스 이용에 장애가 있는 경우\n\n4. 제1호 내지 제3호를 제외한 기타 \"즐거운생활\"의 고의∙과실이 없는 사유로 인한 경우\n\n②  \"즐거운생활\"은 서비스 및 서비스에 게재된 정보, 자료, 사실의 신뢰도, 정확성 등에 대해서는 보증을 하지 않으며 이로 인해 발생한 회원의 손해에 대하여는 책임을 부담하지 아니합니다.\n\n \n\n \n\n제12조 (규정의 준용) \n\n \n\n① 본 약관은 대한민국법령에 의하여 규정되고 이행됩니다.\n\n② 본 약관에 규정되지 않은 사항에 대해서는 관련법령 및 상관습에 의합니다.\n\n \n\n부칙(시행일)\n\n본 약관은 2018년 6월 23일부터 적용합니다.\n\n"
    
    
    
    
    @IBOutlet weak var personalInfoRegLabel: UILabel!
    @IBOutlet weak var usageAgreementRegLabel: UILabel!
    
    
    @IBOutlet weak var usageAgreementCB: M13Checkbox!
    @IBOutlet weak var personalInfoRegCB: M13Checkbox!
    @IBOutlet weak var ageRegCB: M13Checkbox!
    @IBOutlet weak var checkAllCB: M13Checkbox!
    
    @IBAction func nextTapped(_ sender: Any) {
        if (ageRegCB.checkState == .checked && checkAllCB.checkState == .checked && usageAgreementCB.checkState == .checked && ageRegCB.checkState == .checked) == true{
            
            navigateToNextPage()
        }
        else{
            let alert = UIAlertController(title: "약관 동의가 필요합니다.", message: "모든 약관에 동의가 필요합니다.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        let uATap = UITapGestureRecognizer(target: self, action:  #selector(showUserAgreementReg))
        let pITap = UITapGestureRecognizer(target: self, action:  #selector(showpersonalInfoReg))
        
        personalInfoRegLabel.addGestureRecognizer(pITap)
        usageAgreementRegLabel.addGestureRecognizer(uATap)
        // Do any additional setup after loading the view.
    }
    
    @objc func showUserAgreementReg(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let regPage = storyboard.instantiateViewController(withIdentifier: "regulationPage") as! regulationPage
        regPage.text = userAgreementText
        setupNav(page: regPage, title: "즐거운생활 이용약관")
        self.navigationController?.pushViewController(regPage, animated: true)
    }
    
    @objc func showpersonalInfoReg(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let regPage = storyboard.instantiateViewController(withIdentifier: "regulationPage") as! regulationPage
                regPage.text = locationAgreement
        setupNav(page: regPage, title: "위치기반 서비스 이용약관")
        self.navigationController?.pushViewController(regPage, animated: true)
    }
    
   
    
    @IBAction func checkAllTapped(_ sender: M13Checkbox) {
        if sender.checkState == .checked{
            checkAll()
        }
        else{
            uncheckAll()
        }
    }
    
    func checkRegState() -> Bool{
        if usageAgreementCB.checkState == .checked && personalInfoRegCB.checkState == .checked && ageRegCB.checkState == .checked{
            return true
        }
        else{
            return false
        }
    }
    

    @IBAction func checkAgeReg(_ sender: Any){
        if checkRegState(){
            print("regstatestrue")
            checkAllCB.setCheckState(.checked, animated: true)
        }
        else{
            checkAllCB.setCheckState(.unchecked, animated: true)
            print("regstatesfalse")
        }
    }
    
    @IBAction func usageReg(_ sender: M13Checkbox){
        if checkRegState(){
            checkAllCB.setCheckState(.checked, animated: true)
        }
        else{
            checkAllCB.setCheckState(.unchecked, animated: true)
        }
    }
    
    @IBAction func infoReg(_ sender: M13Checkbox){
        if checkRegState(){
            checkAllCB.setCheckState(.checked, animated: true)
        }
        else{
            checkAllCB.setCheckState(.unchecked, animated: true)
        }
    }
    
    
    
    func checkAll(){
        if usageAgreementCB.checkState == .unchecked{
            usageAgreementCB.toggleCheckState(true)
        }
        
        if personalInfoRegCB.checkState == .unchecked{
            personalInfoRegCB.toggleCheckState(true)
        }
        
        if ageRegCB.checkState == .unchecked{
            ageRegCB.toggleCheckState(true)
        }
    }
    
    func uncheckAll(){
        if usageAgreementCB.checkState == .checked{
            usageAgreementCB.toggleCheckState(true)
        }
        
        if personalInfoRegCB.checkState == .checked{
            personalInfoRegCB.toggleCheckState(true)
        }
        
        if ageRegCB.checkState == .checked{
            ageRegCB.toggleCheckState(true)
        }
    }
    
    func setupNav(page: UIViewController, title: String){
        page.navigationItem.title = title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func navigateToNextPage(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "createUserInfoPage") as! createUserInfoPage
        vc.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.pushViewController(vc, animated: true)
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

