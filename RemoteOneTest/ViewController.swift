//
//  ViewController.swift
//  RemoteOneTest
//
//  Created by Nikola Drndarevic
//  Copyright © 2018. Nikola Drndarevic. All rights reserved.
//

import UIKit

protocol keypadActionDelegate {
    func key1()
    func key2()
    func key3()
    func key4()
    func key5()
    func key6()
    func key7()
    func key8()
    func key9()
    func key0()
}

class Glavni: UIViewController, keypadActionDelegate {
    @IBOutlet weak var Commands: UIView!
    @IBOutlet weak var revox: UIView!
    
    @IBOutlet weak var ATVo: UIButton!
    @IBOutlet weak var TVo: UIButton!
    @IBOutlet weak var KALo: UIButton!
    @IBOutlet weak var REVo: UIButton!
    
    @IBOutlet weak var Playo: UIButton!
    @IBOutlet weak var Stopo: UIButton!
    @IBOutlet weak var Pauseo: UIButton!
    @IBOutlet weak var Righto: UIButton!
    @IBOutlet weak var Lefto: UIButton!
    @IBOutlet weak var Vupo: UIButton!
    @IBOutlet weak var Muteo: UIButton!
    @IBOutlet weak var Vdno: UIButton!
    @IBOutlet weak var Listo: UIButton!
    @IBOutlet weak var Chupo: UIButton!
    @IBOutlet weak var Chdno: UIButton!
    @IBOutlet weak var Infoo: UIButton!
    @IBOutlet weak var Revo: UIButton!
    @IBOutlet weak var Foro: UIButton!
    @IBOutlet weak var Settingso: UIButton!
    @IBOutlet weak var Backo: UIButton!
    @IBOutlet weak var Offo: UIButton!
    
    @IBOutlet weak var ATVBo: UIImageView!
    @IBOutlet weak var TVBo: UIImageView!
    @IBOutlet weak var KALBo: UIImageView!
    @IBOutlet weak var REVBo: UIImageView!
    
    @IBOutlet weak var intro: UIImageView!
    @IBOutlet weak var NazivProstorije: UILabel!
    @IBOutlet weak var reVox_A_Frame: UIView!
    @IBOutlet weak var reVox_B_Frame: UIView!
    
    
    let defaults = UserDefaults.standard
    var pos = -1
    var selectedRoom = 0
    var Comm: comm!
    var selectedLight = 0
    var light1_old = false
    var light2_old = false
    var light3_old = false
    var light4_old = false
    var dispatch: DispatchWorkItem!
    var keypad = false
    var present_devices: Strukture.Prisutni_Uredjaji!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        Comm = comm(selectRoom: selectedRoom)
        
        notification.addObserver(self, selector: #selector(wakeUp), name: Notification.Name("leavingSleep"), object: nil)
        notification.addObserver(self, selector: #selector(enterSleep), name: Notification.Name("enteringSleep"), object: nil)
        
        let tapGestureRecognizerTV = UITapGestureRecognizer(target: self, action: #selector(TV_Tapped(tapGestureRecognizer:)))
        TVBo.isUserInteractionEnabled = true
        TVBo.addGestureRecognizer(tapGestureRecognizerTV)
        
        let tapGestureRecognizerATV = UITapGestureRecognizer(target: self, action: #selector(ATV_Tapped(tapGestureRecognizer:)))
        ATVBo.isUserInteractionEnabled = true
        ATVBo.addGestureRecognizer(tapGestureRecognizerATV)
        
        let tapGestureRecognizerKAL = UITapGestureRecognizer(target: self, action: #selector(KAL_Tapped(tapGestureRecognizer:)))
        KALBo.isUserInteractionEnabled = true
        KALBo.addGestureRecognizer(tapGestureRecognizerKAL)
        
        let tapGestureRecognizerREV = UITapGestureRecognizer(target: self, action: #selector(REV_Tapped(tapGestureRecognizer:)))
        REVBo.isUserInteractionEnabled = true
        REVBo.addGestureRecognizer(tapGestureRecognizerREV)
    }
    
    @objc func TV_Tapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        selectTV()
    }
    
    @objc func ATV_Tapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        selectATV()
    }
    
    @objc func KAL_Tapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        selectKAL()
    }
    
    @objc func REV_Tapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        selectREV()
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizer.Direction.left {
            if (pos == -1) {
                selectTV()
            } else if (pos < 3) {
                pos+=1
                if (pos == 1) {
                    selectATV()
                } else if (pos == 2) {
                    if present_devices.Kaleidescape {
                        selectKAL()
                    } else {
                        selectREV()
                    }
                } else if (pos == 3) {
                    selectREV()
                }
            }
        }
        else if gesture.direction == UISwipeGestureRecognizer.Direction.right {
            if (pos == -1) {
                selectTV()
            } else if (pos > 0) {
                pos-=1
                if (pos == 0) {
                    selectTV()
                } else if (pos == 1) {
                    selectATV()
                } else if (pos == 2) {
                    if present_devices.Kaleidescape {
                        selectKAL()
                    } else {
                        selectATV()
                    }
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let sr = defaults.string(forKey: "IzabranaSoba")
        if (sr != nil) {
            selectedRoom = Int(sr!)!
        }
        print("Izabrana soba je \(selectedRoom+1)")
        Comm.updateCommands(selectRoom: selectedRoom)
        if (Comm.check_settings() == false) {
            let alert = UIAlertController(title: "Фатальная ошибка!", message: "Неверные настройки неверны. Количество членов всех строк не совпадает. Необходимо исправить эту ошибку!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "У реду", style: UIAlertAction.Style.default, handler: {action in exit(0)}))
            self.present(alert, animated: true, completion: nil)
        }
        NazivProstorije.text = Comm.room_name()
        present_devices = Comm.return_present_devices()
        TVo.isEnabled = present_devices.TV
        ATVo.isEnabled = present_devices.AppleTV
        KALo.isEnabled = present_devices.Kaleidescape
        reVox_A_Frame.isHidden = !present_devices.reVoxA
        reVox_B_Frame.isHidden = !present_devices.reVoxB
        closeView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func enterSleep() {
        Comm.disconnect()
    }
    
    @objc func wakeUp() {
        closeView()
    }
    
    func test() {
        print("appWake!")
    }
    
    func closeView() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options:[], animations: {self.TVBo.alpha = 1; self.ATVBo.alpha = 1; self.KALBo.alpha = 1; self.REVBo.alpha = 1; self.revox.alpha = 0; self.revox.isUserInteractionEnabled = false; self.intro.alpha = 1; self.intro.isUserInteractionEnabled = false}, completion: nil)
    }
    
    @IBAction func ATV(_ sender: Any) {
        selectATV()
    }
    
    @IBAction func TV(_ sender: Any) {
        selectTV()
    }
    
    @IBAction func KAL(_ sender: Any) {
        selectKAL()
    }
    
    @IBAction func REV(_ sender: Any) {
        selectREV()
    }
    
    func selectTV() {
        pos = 0
        Comm.connect_all(select: pos)
        UIView.animate(withDuration: 0.25, delay: 0.0, options:[], animations: {self.ATVBo.alpha = 0; self.KALBo.alpha = 0; self.REVBo.alpha = 0; self.revox.alpha = 0; self.revox.isUserInteractionEnabled = false; self.intro.alpha = 0; self.intro.isUserInteractionEnabled = false}, completion: nil)
        UIView.animate(withDuration: 0.25, delay: 0.1, options:[], animations: {
            self.TVBo.alpha = 1;
            self.Commands.alpha = 1;
            self.Commands.isUserInteractionEnabled = true;
//            self.Playo.alpha = 0;
//            self.Playo.isUserInteractionEnabled = false;
//            self.Stopo.alpha = 0;
//            self.Stopo.isUserInteractionEnabled = false;
//            self.Pauseo.alpha = 0;
//            self.Pauseo.isUserInteractionEnabled = false
            self.Offo.setImage(#imageLiteral(resourceName: "Shutdown"), for: UIControl.State.normal);
            self.Chupo.setImage(#imageLiteral(resourceName: "MediaChUp"), for: UIControl.State.normal);
            self.Listo.setImage(#imageLiteral(resourceName: "MediaList"), for: UIControl.State.normal);
            self.Chdno.setImage(#imageLiteral(resourceName: "MediaChDn"), for: UIControl.State.normal);
            self.Stopo.setImage(#imageLiteral(resourceName: "KeyIcon"), for: UIControl.State.normal);
            self.keypad = true
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.0, options:[], animations: {
            self.Chupo.alpha = 1;
            self.Chupo.isUserInteractionEnabled = true;
            self.Chdno.alpha = 1;
            self.Chdno.isUserInteractionEnabled = true;
            self.Listo.alpha = 1;
            self.Listo.isUserInteractionEnabled = true
            self.Infoo.alpha = 1;
            self.Infoo.isUserInteractionEnabled = true;
            self.Settingso.alpha = 1;
            self.Settingso.isUserInteractionEnabled = true;
            self.Backo.alpha = 1;
            self.Backo.isUserInteractionEnabled = true;
            self.Stopo.alpha = 1;
            self.Stopo.isUserInteractionEnabled = true;
        }, completion:nil)
    }
    
    func selectATV() {
        pos = 1
        Comm.connect_all(select: pos)
        UIView.animate(withDuration: 0.25, delay: 0.0, options:[], animations: {self.TVBo.alpha = 0; self.KALBo.alpha = 0; self.REVBo.alpha = 0; self.revox.alpha = 0; self.revox.isUserInteractionEnabled = false; self.intro.alpha = 0; self.intro.isUserInteractionEnabled = false}, completion: nil)
        UIView.animate(withDuration: 0.25, delay: 0.1, options:[], animations: {
            self.ATVBo.alpha = 1;
            self.Commands.alpha = 1;
            self.Commands.isUserInteractionEnabled = true;
            self.Chupo.alpha = 0;
            self.Chupo.isUserInteractionEnabled = false;
            self.Chdno.alpha = 0;
            self.Chdno.isUserInteractionEnabled = false;
            self.Listo.alpha = 0;
            self.Listo.isUserInteractionEnabled = false
            self.Infoo.alpha = 0;
            self.Infoo.isUserInteractionEnabled = false;
            self.Settingso.alpha = 0;
            self.Settingso.isUserInteractionEnabled = false;
            self.Backo.alpha = 0;
            self.Backo.isUserInteractionEnabled = false;
            self.keypad = false
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.25, options:[], animations: {
//            self.Playo.alpha = 1;
//            self.Playo.isUserInteractionEnabled = true;
            self.Stopo.alpha = 1;
            self.Stopo.isUserInteractionEnabled = true;
//            self.Pauseo.alpha = 1;
//            self.Pauseo.isUserInteractionEnabled = true
            self.Offo.setImage(#imageLiteral(resourceName: "MediaMenu"), for: UIControl.State.normal);
            self.Stopo.setImage(#imageLiteral(resourceName: "MediaStop"), for: UIControl.State.normal)
            }, completion:nil)
    }
    
    func selectKAL() {
        pos = 2
        Comm.connect_all(select: pos)
        UIView.animate(withDuration: 0.25, delay: 0.0, options:[], animations: {self.ATVBo.alpha = 0; self.TVBo.alpha = 0; self.REVBo.alpha = 0; self.revox.alpha = 0; self.revox.isUserInteractionEnabled = false; self.intro.alpha = 0; self.intro.isUserInteractionEnabled = false}, completion: nil)
        UIView.animate(withDuration: 0.25, delay: 0.1, options:[], animations: {
            self.KALBo.alpha = 1;
            self.Commands.alpha = 1;
            self.Commands.isUserInteractionEnabled = true;
//            self.Chupo.alpha = 0;
//            self.Chupo.isUserInteractionEnabled = false;
//            self.Chdno.alpha = 0;
//            self.Chdno.isUserInteractionEnabled = false;
//            self.Listo.alpha = 0;
//            self.Listo.isUserInteractionEnabled = false
            self.Infoo.alpha = 0;
            self.Infoo.isUserInteractionEnabled = false;
            self.Chupo.setImage(#imageLiteral(resourceName: "MediaMusic"), for: UIControl.State.normal);
            self.Listo.setImage(#imageLiteral(resourceName: "MediaMovie"), for: UIControl.State.normal);
            self.Chdno.setImage(#imageLiteral(resourceName: "MediaSubtitles"), for: UIControl.State.normal);
            self.keypad = false
        }, completion: nil)
        UIView.animate(withDuration: 0.4, delay: 0.0, options:[], animations: {
//            self.Playo.alpha = 1;
//            self.Playo.isUserInteractionEnabled = true;
            self.Stopo.alpha = 1;
            self.Stopo.isUserInteractionEnabled = true;
//            self.Pauseo.alpha = 1;
//            self.Pauseo.isUserInteractionEnabled = true
            self.Listo.alpha = 1;
            self.Listo.isUserInteractionEnabled = true
            self.Settingso.alpha = 1;
            self.Settingso.isUserInteractionEnabled = true;
            self.Backo.alpha = 1;
            self.Backo.isUserInteractionEnabled = true;
            self.Chupo.alpha = 1;
            self.Chupo.isUserInteractionEnabled = true;
            self.Chdno.alpha = 1;
            self.Chdno.isUserInteractionEnabled = true;
            self.Offo.setImage(#imageLiteral(resourceName: "Shutdown"), for: UIControl.State.normal);
            self.Stopo.setImage(#imageLiteral(resourceName: "MediaStop"), for: UIControl.State.normal)
        }, completion:nil)
    }
    
    func selectREV() {
        pos = 3
        Comm.connect_all(select: pos)
        UIView.animate(withDuration: 0.25, delay: 0.0, options:[], animations: {self.ATVBo.alpha = 0; self.TVBo.alpha = 0; self.KALBo.alpha = 0; self.Commands.alpha = 0; self.Commands.isUserInteractionEnabled = false; self.revox.alpha = 1; self.intro.isUserInteractionEnabled = false}, completion: nil)
        UIView.animate(withDuration: 0.25, delay: 0.1, options:[], animations: {self.REVBo.alpha = 1; self.intro.alpha = 0; self.revox.isUserInteractionEnabled = true}, completion: nil)
    }
    
    // Daljinski
    
    @IBAction func Playa(_ sender: Any) {
        Comm.button(select: comm.btn_name.play, state: pos)
    }
    @IBAction func Pausea(_ sender: Any) {
        Comm.button(select: comm.btn_name.pause, state: pos)
    }
    @IBAction func Stopa(_ sender: Any) {
        if (keypad) {
            let keypadScreen = storyboard?.instantiateViewController(withIdentifier: "tastaturaId") as! Tastatura
            keypadScreen.keypadDelegate = self as keypadActionDelegate
            keypadScreen.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            keypadScreen.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            self.present(keypadScreen, animated: true, completion: nil)
        } else {
            Comm.button(select: comm.btn_name.stop, state: pos)
        }
    }
    @IBAction func Reva(_ sender: Any) {
        Comm.button(select: comm.btn_name.rev, state: pos)
    }
    @IBAction func Fora(_ sender: Any) {
        Comm.button(select: comm.btn_name.fore, state: pos)
    }
    @IBAction func OKa(_ sender: Any) {
        Comm.button(select: comm.btn_name.ok, state: pos)
    }
    @IBAction func Upa(_ sender: Any) {
        Comm.button(select: comm.btn_name.up, state: pos)
    }
    @IBAction func Downa(_ sender: Any) {
        Comm.button(select: comm.btn_name.down, state: pos)
    }
    @IBAction func Righta(_ sender: Any) {
        Comm.button(select: comm.btn_name.right, state: pos)
    }
    @IBAction func Lefta(_ sender: Any) {
        Comm.button(select: comm.btn_name.left, state: pos)
    }
    @IBAction func Vupa(_ sender: Any) {
        Comm.button(select: comm.btn_name.volup, state: pos)
    }
    @IBAction func Vdna(_ sender: Any) {
        Comm.button(select: comm.btn_name.voldn, state: pos)
    }
    @IBAction func Mutea(_ sender: Any) {
        Comm.button(select: comm.btn_name.mute, state: pos)
    }
    @IBAction func Chupa(_ sender: Any) {
        Comm.button(select: comm.btn_name.chup, state: pos)
    }
    @IBAction func Chdna(_ sender: Any) {
        Comm.button(select: comm.btn_name.chdown, state: pos)
    }
    @IBAction func Lista(_ sender: Any) {
        Comm.button(select: comm.btn_name.list, state: pos)
    }
    @IBAction func Infoa(_ sender: Any) {
        Comm.button(select: comm.btn_name.info, state: pos)
    }
    @IBAction func Settingsa(_ sender: Any) {
        Comm.button(select: comm.btn_name.settings, state: pos)
    }
    @IBAction func Exita(_ sender: Any) {
        Comm.button(select: comm.btn_name.back, state: pos)
    }
    @IBAction func Offa(_ sender: Any) {
        Comm.button(select: comm.btn_name.off, state: pos)
    }
    @IBAction func Alloffa(_ sender: Any) {
        print("*All Off Komanda")
        // Connect all present devices and turn them off, avoids turning them on via actions
        Comm.connect_all(select: -2)
        // Reset UI
        closeView()
    }
    func key1() {
        Comm.button(select: comm.btn_name.key1, state: pos)
    }
    func key2() {
        Comm.button(select: comm.btn_name.key2, state: pos)
    }
    func key3() {
        Comm.button(select: comm.btn_name.key3, state: pos)
    }
    func key4() {
        Comm.button(select: comm.btn_name.key4, state: pos)
    }
    func key5() {
        Comm.button(select: comm.btn_name.key5, state: pos)
    }
    func key6() {
        Comm.button(select: comm.btn_name.key6, state: pos)
    }
    func key7() {
        Comm.button(select: comm.btn_name.key7, state: pos)
    }
    func key8() {
        Comm.button(select: comm.btn_name.key8, state: pos)
    }
    func key9() {
        Comm.button(select: comm.btn_name.key9, state: pos)
    }
    func key0() {
        Comm.button(select: comm.btn_name.key0, state: pos)
    }
    
    // reVox
    @IBAction func MediaAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.mediaA)
    }
    @IBAction func MediaBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.mediaB)
    }
    @IBAction func AmbientAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.ambientA)
    }
    @IBAction func AmbientBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.ambientB)
    }
    @IBAction func RadioAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.radioA)
    }
    @IBAction func RadioBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.radioB)
    }
    @IBAction func PlaylistAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.playlistA)
    }
    @IBAction func PlaylistBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.playlistB)
    }
    @IBAction func BackAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.previousA)
    }
    @IBAction func BackBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.previousB)
    }
    @IBAction func ForeAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.nextA)
    }
    @IBAction func ForeBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.nextB)
    }
    @IBAction func VolumeDnAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.volume_downA)
    }
    @IBAction func VolumeDnBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.volume_downB)
    }
    @IBAction func VolumeUpAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.volume_upA)
    }
    @IBAction func VolumeUpBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.volume_upB)
    }
    @IBAction func MuteAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.muteA)
    }
    @IBAction func MuteBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.muteB)
    }
    @IBAction func OffAa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.offA)
    }
    @IBAction func OffBa(_ sender: Any) {
        Comm.button_revox(select: comm.btn_revox.offB)
    }
    
    // KNX
    @IBAction func AllOna(_ sender: Any) {
        Comm.button_knx(select: comm.btn_knx.allon, value: 0)
    }
    @IBAction func AllOffa(_ sender: Any) {
        Comm.button_knx(select: comm.btn_knx.alloff, value: 0)
    }
    @IBAction func Scene1a(_ sender: Any) {
        Comm.button_knx(select: comm.btn_knx.scene1, value: 0)
    }
    @IBAction func Scene2a(_ sender: Any) {
        Comm.button_knx(select: comm.btn_knx.scene2, value: 0)
    }
}

class Podesavanja: UIViewController, UITextFieldDelegate {
    var selectedRoom = 0
    var rooms: [Strukture.Sobe]!
    let data = Adrese()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        rooms = data.return_rooms()
        self.text.delegate = self
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        text.resignFirstResponder()
        Primeni(Void.self)
        return true
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var Slika: UIImageView!
    
    @IBAction func Primeni(_ sender: Any) {
        let num = rooms.count
        var good = false
        for i in 0..<num {
            if (rooms[i].sifra_sobe == text.text) {
                selectedRoom = i
                defaults.set(selectedRoom, forKey: "IzabranaSoba")
                good = true
                break
            }
        }
        if (good == true) {
            let alert = UIAlertController(title: "Успешно сменил номер!", message: "Выбранный номер <<\(rooms[selectedRoom].ime_sobe)>>", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Все в порядке", style: UIAlertAction.Style.default, handler: {action in self.Podesavanja(Void.self)}))
            self.present(alert, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Номер не изменен!", message: "Введен неверный пароль. Обратитесь к стойке прием.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Все в порядке", style: UIAlertAction.Style.default, handler: {action in self.Podesavanja(Void.self)}))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func Podesavanja(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

class Tastatura: UIViewController {
    var keypadDelegate: keypadActionDelegate!
    @IBOutlet weak var Pogled: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        view.isOpaque = true
        Pogled.layer.cornerRadius = 30.0
        notification.addObserver(self, selector: #selector(Closea(_:)), name: Notification.Name("enteringSleep"), object: nil)
    }
    @IBAction func Closea(_ sender: Any) {
        print("Zatvaranje Tastature")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func Key1a(_ sender: Any) {
        keypadDelegate.key1()
    }
    @IBAction func Key2a(_ sender: Any) {
        keypadDelegate.key2()
    }
    @IBAction func Key3a(_ sender: Any) {
        keypadDelegate.key3()
    }
    @IBAction func Key4a(_ sender: Any) {
        keypadDelegate.key4()
    }
    @IBAction func Key5a(_ sender: Any) {
        keypadDelegate.key5()
    }
    @IBAction func Key6a(_ sender: Any) {
        keypadDelegate.key6()
    }
    @IBAction func Key7a(_ sender: Any) {
        keypadDelegate.key7()
    }
    @IBAction func Key8a(_ sender: Any) {
        keypadDelegate.key8()
    }
    @IBAction func Key9a(_ sender: Any) {
        keypadDelegate.key9()
    }
    @IBAction func Key0a(_ sender: Any) {
        keypadDelegate.key0()
    }
    @IBAction func Backgrounda(_ sender: Any) {
        print("Zatvaranje Tastature")
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
