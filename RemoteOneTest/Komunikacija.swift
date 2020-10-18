//
//  Comm.swift
//  RemoteOneTest
//
//  Created by Nikola Drndarevic
//  Copyright © 2018. Nikola Drndarevic. All rights reserved.
//

import Foundation
import SwiftSocket

var timeout:Int!

public enum Tag: String {
    case TV = "$%TV%&"
    case AppleTV = "$%ATV%&"
    case Kaleidescape = "$%KAL%&"
    case reVox = "$%REV%&"
    case KNX = "$%KNX%&"
}

//enum Tag {
//    case TV(String)
//    case AppleTV(String)
//    case Kaleidescape(String)
//    case reVox(String)
//
//}

public enum Kartica {
    case TV, AppleTV, Kaleidescape, reVox_KNX
}

class comm {
    let addr = Adrese()
    var clientTV: TCPClient? = nil
    var clientATV: TCPClient? = nil
    var clientKAL: TCPClient? = nil
    var clientREV: TCPClient? = nil
    var clientKNX: TCPClient? = nil
    var clientTMP: TCPClient? = nil
    var tvc: Strukture.TV_struktura
    var atvc: Strukture.ATV_struktura
    var kalc: Strukture.KAL_struktura
    var revc: Strukture.REV_struktura
    var knxc: Strukture.KNX_Struktura
    var akcije: [Strukture.Akcije] = []
    var akcijeOff: [Strukture.Akcije] = []
    var room: Strukture.Sobe
    var config: Strukture.Konfiguracija
    var present_devices: Strukture.Prisutni_Uredjaji
    var TMPIP = ""
    var TMPP = ""
    
    init(selectRoom: Int) {
        tvc = addr.return_tvk(select: selectRoom)
        atvc = addr.return_atvk(select: selectRoom)
        kalc = addr.return_kalk(select: selectRoom)
        revc = addr.return_revk(select: selectRoom)
        knxc = addr.return_knxk(select: selectRoom)
        room = addr.return_room(select: selectRoom)
        config = addr.return_settings()
        akcije = addr.return_akcije(select: selectRoom)
        akcijeOff = addr.return_akcijeOff(select: selectRoom)
        present_devices = addr.return_pu(select: selectRoom)
    }
    
    func updateCommands(selectRoom: Int) {
        tvc = addr.return_tvk(select: selectRoom)
        atvc = addr.return_atvk(select: selectRoom)
        kalc = addr.return_kalk(select: selectRoom)
        revc = addr.return_revk(select: selectRoom)
        knxc = addr.return_knxk(select: selectRoom)
        room = addr.return_room(select: selectRoom)
        config = addr.return_settings()
        akcije = addr.return_akcije(select: selectRoom)
        akcijeOff = addr.return_akcijeOff(select: selectRoom)
        present_devices = addr.return_pu(select: selectRoom)
    }
    
    func check_settings() -> Bool {
        return addr.verify()
    }
    
    func room_name() -> String {
        return room.ime_sobe
    }
    
    public enum btn_name {
        case play, stop, pause, rev, fore, right, left, up, down, ok, volup, voldn, mute, chup, chdown, list, info, settings, back, off, alloff, key1, key2, key3, key4, key5, key6, key7, key8, key9, key0
    }
    
    public enum btn_revox {
        case mediaA, ambientA, radioA, playlistA, previousA, nextA, volume_downA, volume_upA, muteA, offA, mediaB, ambientB, radioB, playlistB, previousB, nextB, volume_downB, volume_upB, muteB, offB
    }
    
    public enum btn_knx {
        case allon, alloff, scene1, scene2
    }
    
    func test(state: Int) {
        print(tvc.info + " State: \(state)")
    }
    
    func return_present_devices() -> Strukture.Prisutni_Uredjaji {
        return present_devices
    }
    
    func connect_all(select: Int) {
        let room = select
        disconnect()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.04) {
            self.clientTV = TCPClient(address: self.self.tvc.ip, port: Int32(self.tvc.port)!)
            switch self.clientTV?.connect(timeout: self.config.TV_timeout) {
            case .success?:
                print("%TV Uspešno povezan na server \(self.tvc.ip):\(self.tvc.port)!")
            case .failure(let error)?:
                print("%TV Greška pri povezivanju \(error)")
            case .none:
                break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            self.clientATV = TCPClient(address: self.atvc.ip, port: Int32(self.atvc.port)!)
            switch self.clientATV?.connect(timeout: self.config.AppleTV_timeout) {
            case .success?:
                print("%AppleTV Uspešno povezan na server \(self.atvc.ip):\(self.atvc.port)!")
            case .failure(let error)?:
                print("%AppleTV Greška pri povezivanju \(error)")
            case .none:
                break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
            self.clientKAL = TCPClient(address: self.kalc.ip, port: Int32(self.self.kalc.port)!)
            switch self.clientKAL?.connect(timeout: self.config.Kaleidescape_timeout) {
            case .success?:
                print("%Kaleidescape Uspešno povezan na server \(self.self.kalc.ip):\(self.kalc.port)!")
            case .failure(let error)?:
                print("%Kaleidescape Greška pri povezivanju \(error)")
            case .none:
                break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            self.clientREV = TCPClient(address: self.revc.ip, port: Int32(self.self.revc.port)!)
            switch self.clientREV?.connect(timeout: self.config.reVox_timeout) {
            case .success?:
                print("%reVox Uspešno povezan na server \(self.revc.ip):\(self.revc.port)!")
            case .failure(let error)?:
                print("%reVox Greška pri povezivanju \(error)")
            case .none:
                break
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.20) {
            self.clientKNX = TCPClient(address: self.knxc.ip, port: Int32(self.knxc.port)!)
            switch self.clientKNX?.connect(timeout: self.config.KNX_timeout) {
            case .success?:
                print("%KNX Uspešno povezan na server \(self.self.knxc.ip):\(self.knxc.port)!")
            case .failure(let error)?:
                print("%KNX Greška pri povezivanju \(error)")
            case .none:
                break
            }
        }
        if room > -1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                switch room {
                case 0:
                    self.TV_Action()
                    break
                case 1:
                    self.AppleTV_Action()
                    break
                case 2:
                    self.Kaleidescape_Action()
                    break
                case 3:
                    self.reVoxKNX_Action()
                    break
                default:
                    break
                }
            }
        }
        if room == -2 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self.button(select: .alloff, state: 0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.45) {
                self.disconnect()
            }
        }
    }
    
    func disconnect() {
        clientTV?.close()
        clientATV?.close()
        clientKAL?.close()
        clientREV?.close()
        clientKNX?.close()
        clientTMP?.close()
        print("%Konekcija zatvorena")
    }
    
    func TV_Action() {
        for akcija in akcije {
            if (akcija.Kartica == Kartica.TV) {
                if (akcija.Kasnjenje > 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + akcija.Kasnjenje) {
                        self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                    }
                } else {
                    self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                }
            }
        }
    }
    
    func AppleTV_Action() {
        for akcija in akcije {
            if (akcija.Kartica == Kartica.AppleTV) {
                if (akcija.Kasnjenje > 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + akcija.Kasnjenje) {
                        self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                    }
                } else {
                    self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                }
            }
        }
    }
    
    func Kaleidescape_Action() {
        for akcija in akcije {
            if (akcija.Kartica == Kartica.Kaleidescape) {
                if (akcija.Kasnjenje > 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + akcija.Kasnjenje) {
                        self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                    }
                } else {
                    self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                }
            }
        }
    }
    
    func reVoxKNX_Action() {
        for akcija in akcije {
            if (akcija.Kartica == Kartica.reVox_KNX) {
                if (akcija.Kasnjenje > 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + akcija.Kasnjenje) {
                        self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                    }
                } else {
                    self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                }
            }
        }
    }
    
    func sendDirect(command: String, tag: Tag) {
        var outbuf = command
        var device = tag
        if outbuf.contains(Tag.TV.rawValue) {
            outbuf = outbuf.replacingOccurrences(of: Tag.TV.rawValue, with: "")
            device = .TV
        }
        if outbuf.contains(Tag.AppleTV.rawValue) {
            outbuf = outbuf.replacingOccurrences(of: Tag.AppleTV.rawValue, with: "")
            device = .AppleTV
        }
        if outbuf.contains(Tag.Kaleidescape.rawValue) {
            outbuf = outbuf.replacingOccurrences(of: Tag.Kaleidescape.rawValue, with: "")
            device = .Kaleidescape
        }
        if outbuf.contains(Tag.reVox.rawValue) {
            outbuf = outbuf.replacingOccurrences(of: Tag.reVox.rawValue, with: "")
            device = .reVox
        }
        if outbuf.contains(Tag.KNX.rawValue) {
            outbuf = outbuf.replacingOccurrences(of: Tag.KNX.rawValue, with: "")
            device = .KNX
        }
        if outbuf.contains("%IP%") {
            outbuf = outbuf.replacingOccurrences(of: "%IP%", with: "")
            TMPP = String(outbuf[outbuf.firstIndex(of: "~")!..<outbuf.firstIndex(of: "^")!])
            TMPP = TMPP.replacingOccurrences(of: "~", with: "")
            TMPIP = String(outbuf[outbuf.startIndex..<outbuf.firstIndex(of: "~")!])
            outbuf = String(outbuf[outbuf.firstIndex(of: "^")!..<outbuf.endIndex])
            outbuf = outbuf.replacingOccurrences(of: "^", with: "")
            
            if tvc.ip == TMPIP && tvc.port == TMPP {device = .TV} else
            if atvc.ip == TMPIP && atvc.port == TMPP {device = .AppleTV} else
            if revc.ip == TMPIP && revc.port == TMPP {device = .reVox} else
            if kalc.ip == TMPIP && kalc.port == TMPP {device = .Kaleidescape} else
            if knxc.ip == TMPIP && knxc.port == TMPP {device = .KNX} else
            {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.00) {
                    self.clientTMP = TCPClient(address: self.TMPIP, port: Int32(self.TMPP)!)
                    switch self.clientTMP?.connect(timeout: self.config.TV_timeout) {
                    case .success?:
                        print("%directIP Uspešno povezan na server \(self.TMPIP):\(self.TMPP)!")
                    case .failure(let error)?:
                        print("%directIP Greška pri povezivanju \(error)")
                    case .none:
                        break
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
                    switch self.clientTMP?.send(string: outbuf) {
                    case .success?:
                        print("#directIP Uspešno poslato \(outbuf)")
                        break
                    case .failure(let error)?:
                        print("#directIP Greška pri slanju \(outbuf) -> \(error)")
                        break
                    case .none:
                        break
                    }
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
                    self.clientTMP?.close()
                }
            }
        }
        else {
            switch device {
            case .TV:
                if present_devices.TV {
                    if (config.TV_newline) {
                        outbuf.append("\r")
                    }
                    if (config.TV_return) {
                        outbuf.append("\n")
                    }
                    outbuf = outbuf.replacingOccurrences(of: "TV_IR_PORT", with: tvc.tv_ir_port)
                    outbuf = outbuf.replacingOccurrences(of: "STB_IR_PORT", with: tvc.stb_ir_port)
                    switch clientTV?.send(string: outbuf) {
                    case .success?:
                        print("#TV Uspešno poslato \(outbuf)")
                        break
                    case .failure(let error)?:
                        print("#TV Greška pri slanju \(outbuf) -> \(error)")
                        break
                    case .none:
                        break
                    }
                    break
                } else {
                    print("#TV Nije prisutan u prostoriji")
                }
            case .AppleTV:
                if present_devices.AppleTV {
                    if (config.AppleTV_newline) {
                        outbuf.append("\r")
                    }
                    if (config.AppleTV_return) {
                        outbuf.append("\n")
                    }
                    outbuf = outbuf.replacingOccurrences(of: "ATV_IR_PORT", with: atvc.atv_ir_port)
                    switch clientATV?.send(string: outbuf) {
                    case .success?:
                        print("#AppleTV Uspešno poslato \(outbuf)")
                        break
                    case .failure(let error)?:
                        print("#AppleTV Greška pri slanju \(outbuf) -> \(error)")
                        break
                    case .none:
                        break
                    }
                } else {
                    print("#AppleTV Nije prisutan u prostoriji")
                }
                break
            case .Kaleidescape:
                if present_devices.Kaleidescape {
                    if (config.Kaleidescape_newline) {
                        outbuf.append("\n")
                    }
                    if (config.Kaleidescape_return) {
                        outbuf.append("\r")
                    }
                    outbuf = kalc.device + "/" + kalc.server + "/" + outbuf
                    switch clientKAL?.send(string: outbuf) {
                    case .success?:
                        print("#Kaleidescape Uspešno poslato \(outbuf)")
                        break
                    case .failure(let error)?:
                        print("#Kaleidescape Greška pri slanju \(outbuf) -> \(error)")
                        break
                    case .none:
                        break
                    }
                } else {
                    print("#Kaleidescape Nije prisutan u prostoriji")
                }
                break
            case .reVox:
                outbuf = outbuf.replacingOccurrences(of: "u_userA", with: revc.u_userA)
                outbuf = outbuf.replacingOccurrences(of: "r_roomA", with: revc.r_roomA)
                outbuf = outbuf.replacingOccurrences(of: "s_userA", with: revc.s_userA)
                outbuf = outbuf.replacingOccurrences(of: "s_roomA", with: revc.s_roomA)
                outbuf = outbuf.replacingOccurrences(of: "u_userB", with: revc.u_userB)
                outbuf = outbuf.replacingOccurrences(of: "r_roomB", with: revc.r_roomB)
                outbuf = outbuf.replacingOccurrences(of: "s_userB", with: revc.s_userB)
                outbuf = outbuf.replacingOccurrences(of: "s_roomB", with: revc.s_roomB)
                if (config.reVox_newline) {
                    outbuf.append("\n")
                }
                if (config.reVox_return) {
                    outbuf.append("\r")
                }
                switch clientREV?.send(string: outbuf) {
                case .success?:
                    print("#reVox Uspešno poslato \(outbuf)")
                    break
                case .failure(let error)?:
                    print("#reVox Greška pri slanju \(outbuf) -> \(error)")
                    break
                case .none:
                    break
                }
                break
            case .KNX:
                if (config.KNX_newline) {
                    outbuf.append("\n")
                }
                if (config.KNX_return) {
                    outbuf.append("\r")
                }
                switch clientKNX?.send(string: outbuf) {
                case .success?:
                    print("#KNX Uspešno poslato \(outbuf)")
                    break
                case .failure(let error)?:
                    print("#KNX Greška pri slanju \(outbuf) -> \(error)")
                    break
                case .none:
                    break
                }
                break
            }
        }

        
    }
    
    func button(select: btn_name, state: Int) -> Void {
        switch select {
        case .play:
            if (state == 0) {
                print("@TV play Komanda: \(tvc.play)")
                sendDirect(command: tvc.play, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV play Komanda: \(atvc.play)")
                sendDirect(command: atvc.play, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape play Komanda: \(kalc.play)")
                sendDirect(command: kalc.play, tag: .Kaleidescape)
            }
            break
        case .pause:
            if (state == 0) {
                print("TV pause Komanda: \(tvc.pause)")
                sendDirect(command: tvc.pause, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV pause Komanda: \(atvc.pause)")
                sendDirect(command: atvc.pause, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape pause Komanda: \(kalc.pause)")
                sendDirect(command: kalc.pause, tag: .Kaleidescape)
            }
            break
        case .stop:
            if (state == 0) {
                print("TV nema stop komandu!")
            } else if (state == 1) {
                print("@AppleTV stop Komanda: \(atvc.stop)")
                sendDirect(command: atvc.stop, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape stop Komanda: \(kalc.stop)")
                sendDirect(command: kalc.stop, tag: .Kaleidescape)
            }
        case .rev:
            if (state == 0) {
                print("TV rev Komanda: \(tvc.reverse)")
                sendDirect(command: tvc.reverse, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV rev Komanda: \(atvc.reverse)")
                sendDirect(command: atvc.reverse, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape rev Komanda: \(kalc.reverse)")
                sendDirect(command: kalc.reverse, tag: .Kaleidescape)
            }
        case .fore:
            if (state == 0) {
                print("TV forward Komanda: \(tvc.forward)")
                sendDirect(command: tvc.forward, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV forward Komanda: \(atvc.forward)")
                sendDirect(command: atvc.forward, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape forward Komanda: \(kalc.forward)")
                sendDirect(command: kalc.forward, tag: .Kaleidescape)
            }
            break
        case .up:
            if (state == 0) {
                print("@TV up Komanda: \(tvc.cursor_up)")
                sendDirect(command: tvc.cursor_up, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV up Komanda: \(atvc.cursor_up)")
                sendDirect(command: atvc.cursor_up, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape up Komanda: \(kalc.cursor_up)")
                sendDirect(command: kalc.cursor_up, tag: .Kaleidescape)
            }
            break
        case .down:
            if (state == 0) {
                print("@TV down Komanda: \(tvc.cursor_down)")
                sendDirect(command: tvc.cursor_down, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV down Komanda: \(atvc.cursor_down)")
                sendDirect(command: atvc.cursor_down, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape down Komanda: \(kalc.cursor_down)")
                sendDirect(command: kalc.cursor_down, tag: .Kaleidescape)
            }
            break
        case .left:
            if (state == 0) {
                print("@TV left Komanda: \(tvc.cursor_left)")
                sendDirect(command: tvc.cursor_left, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV left Komanda: \(atvc.cursor_left)")
                sendDirect(command: atvc.cursor_left, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape left Komanda: \(kalc.cursor_left)")
                sendDirect(command: kalc.cursor_left, tag: .Kaleidescape)
            }
            break
        case .right:
            if (state == 0) {
                print("@TV right Komanda: \(tvc.cursor_right)")
                sendDirect(command: tvc.cursor_right, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV right Komanda: \(atvc.cursor_right)")
                sendDirect(command: atvc.cursor_right, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape right Komanda: \(kalc.cursor_right)")
                sendDirect(command: kalc.cursor_right, tag: .Kaleidescape)
            }
            break
        case .ok:
            if (state == 0) {
                print("@TV ok Komanda: \(tvc.cursor_enter)")
                sendDirect(command: tvc.cursor_enter, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV ok Komanda: \(atvc.cursor_enter)")
                sendDirect(command: atvc.cursor_enter, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape ok Komanda: \(kalc.cursor_enter)")
                sendDirect(command: kalc.cursor_enter, tag: .Kaleidescape)
            }
            break
        case .volup:
            if (state == 0) {
                print("@TV volup Komanda: \(tvc.volume_up)")
                sendDirect(command: tvc.volume_up, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV volup Komanda: \(atvc.volume_up)")
                sendDirect(command: atvc.volume_up, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape volup Komanda: \(kalc.volume_up)")
                sendDirect(command: kalc.volume_up, tag: .Kaleidescape)
            }
            break
        case .voldn:
            if (state == 0) {
                print("@TV voldn Komanda: \(tvc.volume_down)")
                sendDirect(command: tvc.volume_down, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV voldn Komanda: \(atvc.volume_down)")
                sendDirect(command: atvc.volume_down, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape voldn Komanda: \(kalc.volume_down)")
                sendDirect(command: kalc.volume_down, tag: .Kaleidescape)
            }
            break
        case .mute:
            if (state == 0) {
                print("@TV mute Komanda: \(tvc.mute)")
                sendDirect(command: tvc.mute, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV mute Komanda: \(atvc.mute)")
                sendDirect(command: atvc.mute, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape mute Komanda: \(kalc.mute)")
                sendDirect(command: kalc.mute, tag: .Kaleidescape)
            }
            break
        case .chup:
            if (state == 0) {
                print("@TV chup Komanda: \(tvc.channel_up)")
                sendDirect(command: tvc.channel_up, tag: .TV)
            } else if (state == 1) {
                print("AppleTV nema chup komandu!")
            } else if (state == 2) {
                //print("Kaleidescape nema chup komandu!")
                print("@Kaleidescape lista_muzike Komanda: \(kalc.music_covers)")
                sendDirect(command: kalc.music_covers, tag: .Kaleidescape)
            }
            break
        case .chdown:
            if (state == 0) {
                print("@TV chdown Komanda: \(tvc.channel_down)")
                sendDirect(command: tvc.channel_down, tag: .TV)
            } else if (state == 1) {
                print("AppleTV nema chdown komandu!")
            } else if (state == 2) {
                //print("Kaleidescape nema chdown komandu!")
                print("@Kaleidescape titlovi Komanda: \(kalc.subtitle)")
                sendDirect(command: kalc.subtitle, tag: .Kaleidescape)
            }
            break
        case .list:
            if (state == 0) {
                print("@TV list Komanda: \(tvc.channel_list)")
                sendDirect(command: tvc.channel_list, tag: .TV)
            } else if (state == 1) {
                print("AppleTV nema list komandu!")
            } else if (state == 2) {
                print("@Kaleidescape list Komanda: \(kalc.movie_covers)")
                sendDirect(command: kalc.movie_covers, tag: .Kaleidescape)
            }
            break
        case .settings:
            if (state == 0) {
                print("@TV settings Komanda: \(tvc.menu)")
                sendDirect(command: tvc.menu, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV settings Komanda: \(atvc.menu)")
                sendDirect(command: atvc.menu, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape settings Komanda: \(kalc.menu)")
                sendDirect(command: kalc.menu, tag: .Kaleidescape)
            }
            break
        case .back:
            if (state == 0) {
                print("@TV back Komanda: \(tvc.exit)")
                sendDirect(command: tvc.exit, tag: .TV)
            } else if (state == 1) {
                //print("@AppleTV back Komanda: \(atvc.izlaz)")
                //sendDirect(command: atvc.izlaz, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape back Komanda: \(kalc.exit)")
                sendDirect(command: kalc.exit, tag: .Kaleidescape)
            }
            break
        case .info:
            if (state == 0) {
                print("@TV info Komanda: \(tvc.info)")
                sendDirect(command: tvc.info, tag: .TV)
            } else if (state == 1) {
                //print("@AppleTV info Komanda: \(atvc.info)")
                //sendDirect(command: atvc.info, tag: .AppleTV)
            } else if (state == 2) {
                //print("@Kaleidescape info Komanda: \(kalc.info)")
                //sendDirect(command: kalc.info, tag: .Kaleidescape)
            }
            break
        case .off:
            if (state == 0) {
                print("@TV off Komanda: \(tvc.power_off)")
                sendDirect(command: tvc.power_off, tag: .TV)
            } else if (state == 1) {
                print("@AppleTV podesavanja Komanda: \(atvc.menu)")
                sendDirect(command: atvc.menu, tag: .AppleTV)
            } else if (state == 2) {
                print("@Kaleidescape off Komanda: \(kalc.power_off)")
                sendDirect(command: kalc.power_off, tag: .Kaleidescape)
            }
            break
        case .key1:
            if (state == 0) {
                print("@TV key1 Komanda: \(tvc.key1)")
                sendDirect(command: tvc.key1, tag: .TV)
            }
        case .key2:
            if (state == 0) {
                print("@TV key2 Komanda: \(tvc.key2)")
                sendDirect(command: tvc.key2, tag: .TV)
            }
        case .key3:
            if (state == 0) {
                print("@TV key3 Komanda: \(tvc.key3)")
                sendDirect(command: tvc.key3, tag: .TV)
            }
        case .key4:
            if (state == 0) {
                print("@TV key4 Komanda: \(tvc.key4)")
                sendDirect(command: tvc.key4, tag: .TV)
            }
        case .key5:
            if (state == 0) {
                print("@TV key5 Komanda: \(tvc.key5)")
                sendDirect(command: tvc.key5, tag: .TV)
            }
        case .key6:
            if (state == 0) {
                print("@TV key6 Komanda: \(tvc.key6)")
                sendDirect(command: tvc.key6, tag: .TV)
            }
        case .key7:
            if (state == 0) {
                print("@TV key7 Komanda: \(tvc.key7)")
                sendDirect(command: tvc.key7, tag: .TV)
            }
        case .key8:
            if (state == 0) {
                print("@TV key8 Komanda: \(tvc.key8)")
                sendDirect(command: tvc.key8, tag: .TV)
            }
        case .key9:
            if (state == 0) {
                print("@TV key9 Komanda: \(tvc.key9)")
                sendDirect(command: tvc.key9, tag: .TV)
            }
        case .key0:
            if (state == 0) {
                print("@TV key0 Komanda: \(tvc.key0)")
                sendDirect(command: tvc.key0, tag: .TV)
            }
        case .alloff:
            print("*AllOff Komanda")
//            if present_devices.TV { sendDirect(command: tvc.power_off, tag: .TV) }
//            if present_devices.AppleTV { sendDirect(command: atvc.stop, tag: .AppleTV) }
//            if present_devices.Kaleidescape { sendDirect(command: kalc.power_off, tag: .Kaleidescape) }
//            sendDirect(command: revc.offA, tag: .reVox)
//            if present_devices.reVox { sendDirect(command: revc.offB, tag: .reVox) }
            for akcija in akcijeOff {
                if (akcija.Kasnjenje > 0) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + akcija.Kasnjenje) {
                        self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                    }
                } else {
                    self.sendDirect(command: akcija.Komanda, tag: akcija.Uredjaj)
                }
            }
        }
    }
    
    func button_revox(select: btn_revox) -> Void {
        switch select {
        case .mediaA:
            print("@reVox mediaA Komanda: \(revc.mediaA)")
            sendDirect(command: revc.mediaA, tag: .reVox)
            break
        case .ambientA:
            print("@reVox ambientA Komanda: \(revc.ambientA)")
            sendDirect(command: revc.ambientA, tag: .reVox)
            break
        case .radioA:
            print("@reVox radioA Komanda: \(revc.radioA)")
            sendDirect(command: revc.radioA, tag: .reVox)
            break
        case .playlistA:
            print("@reVox playlistA Komanda: \(revc.playlistA)")
            sendDirect(command: revc.playlistA, tag: .reVox)
            break
        case .previousA:
            print("@reVox previousA Komanda: \(revc.previousA)")
            sendDirect(command: revc.previousA, tag: .reVox)
            break
        case .nextA:
            print("@reVox nextA Komanda: \(revc.nextA)")
            sendDirect(command: revc.nextA, tag: .reVox)
            break
        case .volume_downA:
            print("@reVox volume_downA Komanda: \(revc.volume_downA)")
            sendDirect(command: revc.volume_downA, tag: .reVox)
            break
        case .volume_upA:
            print("@reVox volume_upA Komanda: \(revc.volume_upA)")
            sendDirect(command: revc.volume_upA, tag: .reVox)
            break
        case .muteA:
            print("@reVox muteA Komanda: \(revc.muteA)")
            sendDirect(command: revc.muteA, tag: .reVox)
            break
        case .offA:
            print("@reVox offA Komanda: \(revc.offA)")
            sendDirect(command: revc.offA, tag: .reVox)
            break
        case .mediaB:
            print("@reVox mediaB Komanda: \(revc.mediaB)")
            sendDirect(command: revc.mediaB, tag: .reVox)
            break
        case .ambientB:
            print("@reVox ambientB Komanda: \(revc.ambientB)")
            sendDirect(command: revc.ambientB, tag: .reVox)
            break
        case .radioB:
            print("@reVox radioB Komanda: \(revc.radioB)")
            sendDirect(command: revc.radioB, tag: .reVox)
            break
        case .playlistB:
            print("@reVox playlistB Komanda: \(revc.playlistB)")
            sendDirect(command: revc.playlistB, tag: .reVox)
            break
        case .previousB:
            print("@reVox previousB Komanda: \(revc.previousB)")
            sendDirect(command: revc.previousB, tag: .reVox)
            break
        case .nextB:
            print("@reVox nextB Komanda: \(revc.nextB)")
            sendDirect(command: revc.nextB, tag: .reVox)
            break
        case .volume_downB:
            print("@reVox volume_downB Komanda: \(revc.volume_downB)")
            sendDirect(command: revc.volume_downB, tag: .reVox)
            break
        case .volume_upB:
            print("@reVox volume_upB Komanda: \(revc.volume_upB)")
            sendDirect(command: revc.volume_upB, tag: .reVox)
            break
        case .muteB:
            print("@reVox muteB Komanda: \(revc.muteB)")
            sendDirect(command: revc.muteB, tag: .reVox)
            break
        case .offB:
            print("@reVox offB Komanda: \(revc.offB)")
            sendDirect(command: revc.offB, tag: .reVox)
            break
        }
    }
    
    func button_knx(select: btn_knx, value: Int) -> Void {
        var time = 0.0
        if knxc.reconnect {
            clientKNX?.close()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                self.clientKNX = TCPClient(address: self.knxc.ip, port: Int32(self.knxc.port)!)
                switch self.clientKNX?.connect(timeout: self.config.KNX_timeout) {
                case .success?:
                    print("%KNX Uspešno povezan na server \(self.self.knxc.ip):\(self.knxc.port)!")
                case .failure(let error)?:
                    print("%KNX Greška pri povezivanju \(error)")
                case .none:
                    break
                }
            }
            time = 0.15
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            switch select {
            case .allon:
    //            print("@KNX allon Komanda: tds (\(knxc.group_address)) \(knxc.scene_ON)")
    //            sendDirect(command: "tds (\(knxc.group_address) 1) \(knxc.scene_ON)", tag: .KNX)
                print("@KNX allon Komanda: \(self.knxc.group_address)\(self.knxc.scene_ON)")
                self.sendDirect(command: "\(self.knxc.group_address)\(self.knxc.scene_ON)", tag: .KNX)  // izbacen prazan prostor TAPKO
                break
            case .scene1:
    //            print("@KNX alloff Komanda: tds (\(knxc.group_address)) \(knxc.scene_1)")
    //            sendDirect(command: "tds (\(knxc.group_address) 1) \(knxc.scene_1)", tag: .KNX)
                print("@KNX scene_1 Komanda: \(self.knxc.group_address)\(self.self.knxc.scene_1)")
                self.sendDirect(command: "\(self.knxc.group_address)\(self.knxc.scene_1)", tag: .KNX) // izbacen prazan prostor TAPKO
                break
            case .scene2:
    //            print("@KNX scene1 Komanda: tds (\(knxc.group_address)) \(knxc.scene_2)")
    //            sendDirect(command: "tds (\(knxc.group_address) 1) \(knxc.scene_2)", tag: .KNX)
                print("@KNX scene2 Komanda: \(self.self.knxc.group_address)\(self.knxc.scene_2)")
                self.sendDirect(command: "\(self.knxc.group_address)\(self.knxc.scene_2)", tag: .KNX) // izbacen prazan prostor TAPKO
                break
            case .alloff:
    //            print("@KNX scene2 Komanda: tds (\(knxc.group_address)) \(knxc.scene_OFF)")
    //            sendDirect(command: "tds (\(knxc.group_address) 1)\(knxc.scene_OFF)", tag: .KNX)
                print("@KNX alloff Komanda: \(self.self.knxc.group_address)\(self.knxc.scene_OFF)")
                self.sendDirect(command: "\(self.self.knxc.group_address)\(self.knxc.scene_OFF)", tag: .KNX) // izbacen prazan prostor TAPKO
                break
            }
        }
    }
}
