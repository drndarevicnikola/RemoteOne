//
//  Adrese.swift
//  RemoteOneTest
//  Ova podešavanja pogoduju RemoteOne aplikaciji sa verzijom 1
//
//  Created by Nikola Drndarevic
//  Copyright © 2018. Nikola Drndarevic. All rights reserved.
//

import Foundation

class Adrese {
    var struktura = Strukture()
    var tvk: [Strukture.TV_struktura] = []
    var atvk: [Strukture.ATV_struktura] = []
    var kalk: [Strukture.KAL_struktura] = []
    var revk: [Strukture.REV_struktura] = []
    var knxk: [Strukture.KNX_Struktura] = []
    var sobe: [Strukture.Sobe] = []
    var akcijek: [Strukture.Akcije] = []
    var listaAkcija: [[Strukture.Akcije]] = [[]]
    var akcijeoff: [Strukture.Akcije] = []
    var listaAkcijaOff: [[Strukture.Akcije]] = [[]]
    var konfiguracija: Strukture.Konfiguracija!
    var puk: [Strukture.Prisutni_Uredjaji] = []
    
    /* KOMANDE ZA PREUSMERENJE */
    
    let To_TV = Tag.TV.rawValue
    let To_AppleTV = Tag.AppleTV.rawValue
    let To_Kaleidescape = Tag.Kaleidescape.rawValue
    let To_reVox = Tag.reVox.rawValue
    let To_KNX = Tag.KNX.rawValue
    
    func toTV (command: String) -> String {return command + To_TV}
    func toAppleTV (command: String) -> String {return command + To_AppleTV}
    func toKaleidescape (command: String) -> String {return command + To_Kaleidescape}
    func toreVox (command: String) -> String {return command + To_reVox}
    func toKNX (command: String) -> String {return command + To_KNX}
    
    func directIP(ip: String, port: String, command: String) -> String {return "%IP%\(ip)~\(port)^\(command)"}
    
    init() {
        
        /* Podešavanje komunikacije */
        
        // timeout: Maksimalno vreme za povezivanje u [s] - nakon ovog vremena se odustaje od povezivanja sa serverima - podesivo za svaki uređaj
        // ***_newline: Umetanje karaktera \n (ASCII LF 0x0A) na kraju svake poruke - podesivo za svaki uređaj
        // ***_return: Umetanje karaktera \r (ASCII CR 0x0D) na kraju svake poruke - podesivo za svaki uređaj
        // KNX_Light*_Dimmable: Otvaranje ili zatvarenje mogućnosti dimovanja pojedinačnih svetala
        
        konfiguracija = Strukture.Konfiguracija(
            TV_timeout: 1,
            TV_newline: true,
            TV_return: true,
            AppleTV_timeout: 1,
            AppleTV_newline: true,
            AppleTV_return: true,
            Kaleidescape_timeout: 1,
            Kaleidescape_newline: true,
            Kaleidescape_return: true,
            reVox_timeout: 1,
            reVox_newline: true,
            reVox_return: true,
            KNX_timeout: 1,
            KNX_newline: true,
            KNX_return: true
        )
        
        /* IZBOR SETA KOMANDI IZ "Komande.swift" */
        
        let TV_Philips          = Komande_TV_Philips()
        let TV_Loewe            = Komande_TV_Loewe()
        let TV_Sony             = Komande_TV_Sony()
        let TV_LG               = Komande_TV_LG()
        let SBB_D3i             = Komande_SBB_D3i()
        let SBB_D3              = Komande_SBB_D3()
        let AppleTV             = Komande_AppleTV()
        let Kaleidescape        = Komande_Kaleidescape()
        let ReVox               = Komande_reVox()
        let KNX                 = Komande_KNX()
        
        /* PODEŠAVANJE KOMANDI ZA POJEDINAČNE UREĐAJE */
        
        // Podeljeno u celine po uređajima i podceline po sobama
        
        // Da bi se dodao novi član niza sa komandama (postavka za novu sobu), koristeći copy/paste,
        // kopirati bilo koji član niza i nalepiti ga ispod poslednjeg (u ovom slučaju ispod polja "Soba 2"). Zatim, izmeniti njegove parametre.
        // OBAVEZNO je svakom nizu komanda dodati isti broj članova - svaka soba (član niza) mora imati isti set komandi.
        // Redosled dodavanja članova odgovara broju sobe (prvi član niza - onaj na vrhu) odgovara sobi 1, drugi član niza sobi 2 itd.
        
        
        /* => Dodavanje članova niza sa komandama za TV */
        /***********************************************************/
        // Soba 1 Кабинет
        tvk.append(Strukture.TV_struktura(ip: "192.168.50.111", port: "4998", tv_ir_port: "1", stb_ir_port: "3", channel_up: SBB_D3i.channel_up, channel_down: SBB_D3i.channel_down, channel_list: SBB_D3i.EPG, key1: SBB_D3i.digit_1, key2: SBB_D3i.digit_2, key3: SBB_D3i.digit_3, key4: SBB_D3i.digit_4, key5: SBB_D3i.digit_5, key6: SBB_D3i.digit_6, key7: SBB_D3i.digit_7, key8: SBB_D3i.digit_8, key9: SBB_D3i.digit_9, key0: SBB_D3i.digit_0, forward: SBB_D3i.forward, reverse: SBB_D3i.reverse, play: SBB_D3i.play_pause_toggle, pause: SBB_D3i.play_pause_toggle, mute: SBB_D3i.mute, volume_down: SBB_D3i.volume_down, volume_up: SBB_D3i.volume_up, cursor_up: SBB_D3i.cursor_up, cursor_down: SBB_D3i.cursor_down, cursor_left: SBB_D3i.cursor_left, cursor_right: SBB_D3i.cursor_right, cursor_enter: SBB_D3i.cursor_enter, menu: SBB_D3i.menu, exit: SBB_D3i.exit, info: SBB_D3i.info, power_off: SBB_D3i.power_toggle))
        
        // Soba 2 Илија
        tvk.append(Strukture.TV_struktura(ip: "192.168.20.111", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: SBB_D3.channel_up, channel_down: SBB_D3.channel_down, channel_list: SBB_D3.EPG, key1: SBB_D3.digit_1, key2: SBB_D3.digit_2, key3: SBB_D3.digit_3, key4: SBB_D3.digit_4, key5: SBB_D3.digit_5, key6: SBB_D3.digit_6, key7: SBB_D3.digit_7, key8: SBB_D3.digit_8, key9: SBB_D3.digit_9, key0: SBB_D3.digit_0, forward: SBB_D3.forward, reverse: SBB_D3.reverse, play: SBB_D3.play_pause_toggle, pause: SBB_D3.play_pause_toggle, mute: SBB_D3.mute, volume_down: SBB_D3.volume_down, volume_up: SBB_D3.volume_up, cursor_up: SBB_D3.cursor_up, cursor_down: SBB_D3.cursor_down, cursor_left: SBB_D3.cursor_left, cursor_right: SBB_D3.cursor_right, cursor_enter: SBB_D3.cursor_enter, menu: SBB_D3.menu, exit: SBB_D3.exit, info: SBB_D3.info, power_off: SBB_D3.power_toggle))
        
        // Soba 3 Павиљон Дневна
        tvk.append(Strukture.TV_struktura(ip: "192.168.1.95", port: "4998", tv_ir_port: "1", stb_ir_port: "3", channel_up: SBB_D3.channel_up, channel_down: SBB_D3.channel_down, channel_list: SBB_D3.EPG, key1: SBB_D3.digit_1, key2: SBB_D3.digit_2, key3: SBB_D3.digit_3, key4: SBB_D3.digit_4, key5: SBB_D3.digit_5, key6: SBB_D3.digit_6, key7: SBB_D3.digit_7, key8: SBB_D3.digit_8, key9: SBB_D3.digit_9, key0: SBB_D3.digit_0, forward: SBB_D3.forward, reverse: SBB_D3.reverse, play: SBB_D3.play_pause_toggle, pause: SBB_D3.play_pause_toggle, mute: SBB_D3.mute, volume_down: SBB_D3.volume_down, volume_up: SBB_D3.volume_up, cursor_up: SBB_D3.cursor_up, cursor_down: SBB_D3.cursor_down, cursor_left: SBB_D3.cursor_left, cursor_right: SBB_D3.cursor_right, cursor_enter: SBB_D3.cursor_enter, menu: SBB_D3.menu, exit: SBB_D3.exit, info: SBB_D3.info, power_off: SBB_D3.power_toggle))
        
        // Soba 4 Павиљон Спаваћа
        tvk.append(Strukture.TV_struktura(ip: "192.168.1.70", port: "4998", tv_ir_port: "3", stb_ir_port: "1", channel_up: SBB_D3.channel_up, channel_down: SBB_D3.channel_down, channel_list: SBB_D3.EPG, key1: SBB_D3.digit_1, key2: SBB_D3.digit_2, key3: SBB_D3.digit_3, key4: SBB_D3.digit_4, key5: SBB_D3.digit_5, key6: SBB_D3.digit_6, key7: SBB_D3.digit_7, key8: SBB_D3.digit_8, key9: SBB_D3.digit_9, key0: SBB_D3.digit_0, forward: SBB_D3.forward, reverse: SBB_D3.reverse, play: SBB_D3.play_pause_toggle, pause: SBB_D3.play_pause_toggle, mute: SBB_D3.mute, volume_down: SBB_D3.volume_down, volume_up: SBB_D3.volume_up, cursor_up: SBB_D3.cursor_up, cursor_down: SBB_D3.cursor_down, cursor_left: SBB_D3.cursor_left, cursor_right: SBB_D3.cursor_right, cursor_enter: SBB_D3.cursor_enter, menu: SBB_D3.menu, exit: SBB_D3.exit, info: SBB_D3.info, power_off: SBB_D3.power_toggle))
        
        // Soba 5 Павиљон Билијарда
        tvk.append(Strukture.TV_struktura(ip: "192.168.1.100", port: "4998", tv_ir_port: "3", stb_ir_port: "2", channel_up: SBB_D3.channel_up, channel_down: SBB_D3.channel_down, channel_list: SBB_D3.EPG, key1: SBB_D3.digit_1, key2: SBB_D3.digit_2, key3: SBB_D3.digit_3, key4: SBB_D3.digit_4, key5: SBB_D3.digit_5, key6: SBB_D3.digit_6, key7: SBB_D3.digit_7, key8: SBB_D3.digit_8, key9: SBB_D3.digit_9, key0: SBB_D3.digit_0, forward: SBB_D3.forward, reverse: SBB_D3.reverse, play: SBB_D3.play_pause_toggle, pause: SBB_D3.play_pause_toggle, mute: SBB_D3.mute, volume_down: SBB_D3.volume_down, volume_up: SBB_D3.volume_up, cursor_up: SBB_D3.cursor_up, cursor_down: SBB_D3.cursor_down, cursor_left: SBB_D3.cursor_left, cursor_right: SBB_D3.cursor_right, cursor_enter: SBB_D3.cursor_enter, menu: SBB_D3.menu, exit: SBB_D3.exit, info: SBB_D3.info, power_off: SBB_D3.power_toggle))

        // Soba 6 Никола пробе
        tvk.append(Strukture.TV_struktura(ip: "192.168.0.5", port: "1050", tv_ir_port: "2", stb_ir_port: "2", channel_up: SBB_D3i.channel_up, channel_down: SBB_D3i.channel_down, channel_list: SBB_D3i.EPG, key1: TV_Philips.digit_1, key2: TV_Philips.digit_2, key3: TV_Philips.digit_3, key4: TV_Philips.digit_4, key5: TV_Philips.digit_5, key6: TV_Philips.digit_6, key7: TV_Philips.digit_7, key8: TV_Philips.digit_8, key9: TV_Philips.digit_9, key0: TV_Philips.digit_0, forward: SBB_D3i.forward, reverse: SBB_D3i.reverse, play: SBB_D3i.play_pause_toggle, pause: SBB_D3i.play_pause_toggle, mute: SBB_D3i.mute, volume_down: SBB_D3i.volume_down, volume_up: SBB_D3i.volume_up, cursor_up: SBB_D3i.cursor_up, cursor_down: SBB_D3i.cursor_down, cursor_left: SBB_D3i.cursor_left, cursor_right: SBB_D3i.cursor_right, cursor_enter: SBB_D3i.cursor_enter, menu: SBB_D3i.menu, exit: SBB_D3i.exit, info: SBB_D3i.info, power_off: SBB_D3i.power_toggle))
        
        
        
        
        
        
        // Soba 101 Комната отдыха
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.31", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        
        // Soba 102 Кабинет
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.32", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        
        // Soba 103 Спальня 5
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.33", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        // Soba 104 Спальня 1 M100
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.34", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        // Soba 105 Спальня 1 V219
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.35", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        
        // Soba 106 Спальня 2
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.36", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        // Soba 107 Спальня 3
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.37", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        // Soba 108 Спальня 4
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.38", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        // Soba 109 Гостинная
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.39", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        // Soba 110 Фитнес зал
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.40", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        
        // Soba 111 Комната отдыха 2
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.41", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))
        
        
        // Soba 112 Спальня 6
        tvk.append(Strukture.TV_struktura(ip: "172.30.10.42", port: "4998", tv_ir_port: "3", stb_ir_port: "3", channel_up: TV_Loewe.channel_up, channel_down: TV_Loewe.channel_down, channel_list: TV_Loewe.EPG, key1: TV_Loewe.digit_1, key2: TV_Loewe.digit_2, key3: TV_Loewe.digit_3, key4: TV_Loewe.digit_4, key5: TV_Loewe.digit_5, key6: TV_Loewe.digit_6, key7: TV_Loewe.digit_7, key8: TV_Loewe.digit_8, key9: TV_Loewe.digit_9, key0: TV_Loewe.digit_0, forward: TV_Loewe.forward, reverse: TV_Loewe.reverse, play: TV_Loewe.play, pause: TV_Loewe.pause, mute: TV_Loewe.mute, volume_down: TV_Loewe.volume_down, volume_up: TV_Loewe.volume_up, cursor_up: TV_Loewe.cursor_up, cursor_down: TV_Loewe.cursor_down, cursor_left: TV_Loewe.cursor_left, cursor_right: TV_Loewe.cursor_right, cursor_enter: TV_Loewe.cursor_enter, menu: TV_Loewe.menu, exit: TV_Loewe.exit, info: TV_Loewe.info, power_off: TV_Loewe.power_off))


//         tvk.append(Strukture.TV_struktura(ip: "192.168.1.75", port: "4998", channel_up: TV_LG.channel_up, channel_down: TV_LG.channel_down, channel_list: TV_LG.channel_list, forward: TV_LG.forward, reverse: TV_LG.reverse, play: TV_LG.play, pause: TV_LG.pause, mute: TV_LG.mute, volume_down: TV_LG.volume_down, volume_up: TV_LG.volume_up, cursor_up: TV_LG.cursor_up, cursor_down: TV_LG.cursor_down, cursor_left: TV_LG.cursor_left, cursor_right: TV_LG.cursor_right, cursor_enter: TV_LG.cursor_enter, menu: TV_LG.menu, exit: TV_LG.exit, info: TV_LG.info, power_off: TV_LG.power_off))
// ==>  /* >>Mesto za narednu sobu (Soba 3)<< */
        
        /***********************************************************/
      
  
        
        
        
        
        
        
        
        
        /* => Dodavanje članova niza sa komandama za AppleTV */
        /***********************************************************/
        // Soba 1 Кабинет
        atvk.append(Strukture.ATV_struktura(ip: "192.168.50.111", port: "4998", atv_ir_port: "3", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 2 Илија
        atvk.append(Strukture.ATV_struktura(ip: "192.168.20.111", port: "4998", atv_ir_port: "3", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.M_51_100_mute), volume_down: toreVox(command: ReVox.M_51_100_volume_down), volume_up: toreVox(command: ReVox.M_51_100_volume_up), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 3 Павиљон Дневна
        atvk.append(Strukture.ATV_struktura(ip: "192.168.1.95", port: "4998", atv_ir_port: "3", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 4 Павиљон Спаваћа
        atvk.append(Strukture.ATV_struktura(ip: "192.168.1.70", port: "4998", atv_ir_port: "3", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 5 Павиљон Билијарда
        atvk.append(Strukture.ATV_struktura(ip: "192.168.1.100", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))

        
        // Soba 6 Никола пробе
        atvk.append(Strukture.ATV_struktura(ip: "192.168.0.5", port: "1051", atv_ir_port: "3", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.M_51_100_mute), volume_down: toreVox(command: ReVox.M_51_100_volume_down), volume_up: toreVox(command: ReVox.M_51_100_volume_up), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
    
        
        
        
        // Soba 101 Комната отдыха
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.31", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 102 Кабинет
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.32", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 103 Спальня 5
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.33", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 104 Спальня 1 M100
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.34", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 105 Спальня 1 V219
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.35", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 106 Спальня 2
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.36", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 107 Спальня 3
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.37", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 108 Спальня 4
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.38", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 109 Гостинная
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.39", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))
        
        // Soba 110 Фитнес зал
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.40", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toTV(command: TV_Loewe.mute), volume_down: toTV(command: TV_Loewe.volume_down), volume_up: toTV(command: TV_Loewe.volume_up), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))

        // Soba 111 Комната отдыха 2
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.41", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))

        // Soba 112 Спальня 6
        atvk.append(Strukture.ATV_struktura(ip: "172.30.10.42", port: "4998", atv_ir_port: "1", reverse: AppleTV.reverse, forward: AppleTV.forward, play: AppleTV.play, pause: AppleTV.pause, stop: AppleTV.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: AppleTV.cursor_up, cursor_down: AppleTV.cursor_down, cursor_left: AppleTV.cursor_left, cursor_right: AppleTV.cursor_right, cursor_enter: AppleTV.cursor_enter, menu: AppleTV.menu))


        
        
        
        
        
        
        /***********************************************************/
        
        
        /* => Dodavanje članova niza sa komandama za Kaleidescape */
        /***********************************************************/
        // Soba 1 - Кабинет
        kalk.append(Strukture.KAL_struktura(ip: "192.168.50.220", port: "10000", device: "01", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        
        // Soba 2 - Илија
        kalk.append(Strukture.KAL_struktura(ip: "192.168.20.220", port: "10000", device: "01", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 3 - Павиљон Дневна
        kalk.append(Strukture.KAL_struktura(ip: "192.168.1.220", port: "10000", device: "02", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 4 - Павиљон Спаваћа
        kalk.append(Strukture.KAL_struktura(ip: "192.168.1.220", port: "10000", device: "03", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 5 - Павиљон Билијарда
//        kalk.append(Strukture.KAL_struktura(ip: "192.168.1.220", port: "10000", device: "03", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
//        kalk.append(Strukture.KAL_struktura(ip: "192.168.1.61", port: "10000", device: "20", server: "1",
//         kalk.append(Strukture.KAL_struktura(ip: "192.168.1.52", port: "10000", device: "10", server: "1",
        
        kalk.append(Strukture.KAL_struktura(ip: "192.168.1.220", port: "10000", device: "03", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 6 - Никола пробе
        kalk.append(Strukture.KAL_struktura(ip: "192.168.0.5", port: "1052", device: "02", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        
        
        // Soba 101 Комната отдыха
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.21", port: "10000", device: "20", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))

        // Soba 102 Кабинет
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "03", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 103 Спальня 5
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "09", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 104 Спальня 1 M100
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "04", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 105 Спальня 1 V219
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "05", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 106 Спальня 2
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "06", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 107 Спальня 3
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "07", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 108 Спальня 4
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "08", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 109 Гостинная
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "10", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 110 Фитнес зал
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "10", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))
        
        // Soba 111 Комната отдыха 2
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "11", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))

        // Soba 108 Спальня 6
        kalk.append(Strukture.KAL_struktura(ip: "172.30.10.20", port: "10000", device: "12", server: "1", reverse: Kaleidescape.reverse, forward: Kaleidescape.forward, movie_covers: Kaleidescape.movie_covers, music_covers: Kaleidescape.music_covers, play: Kaleidescape.play, pause: Kaleidescape.pause, stop: Kaleidescape.stop, mute: toreVox(command: ReVox.muteA), volume_down: toreVox(command: ReVox.volume_downA), volume_up: toreVox(command: ReVox.volume_upA), cursor_up: Kaleidescape.cursor_up, cursor_down: Kaleidescape.cursor_down, cursor_left: Kaleidescape.cursor_left, cursor_right: Kaleidescape.cursor_right, cursor_enter: Kaleidescape.cursor_enter, menu: Kaleidescape.menu, subtitle: Kaleidescape.subtitle, exit: Kaleidescape.exit, power_off: Kaleidescape.power_off))

        
        
        
        
        
        
        
        
        
        /***********************************************************/
       
        
        /* => Dodavanje članova niza sa komandama za reVox */
        /***********************************************************/
        // Soba 1 Кабинет
        revk.append(Strukture.REV_struktura(ip: "192.168.50.90", port: "11244", u_userA: "u.user1", r_roomA: "r.tv", s_userA: "s.user1", s_roomA: "s.tv", u_userB: "u.user2", r_roomB: "r.plafon", s_userB: "s.user2", s_roomB: "s.plafon", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 2 Илија
        revk.append(Strukture.REV_struktura(ip: "192.168.20.230", port: "5524", u_userA: "u.user1", r_roomA: "r.room1", s_userA: "s.user1", s_roomA: "s.room1", u_userB: "u.user2", r_roomB: "r.room2", s_userB: "s.user2", s_roomB: "s.room2", mediaA: "", ambientA: "", radioA: ReVox.M_51_100_select_tuner, playlistA: ReVox.M_51_100_select_DVD, previousA: ReVox.M_51_100_previous, nextA: ReVox.M_51_100_next, volume_downA: ReVox.M_51_100_volume_down, volume_upA: ReVox.M_51_100_volume_up, muteA: ReVox.M_51_100_mute, offA: ReVox.M_51_100_power_off, mediaB: "<#T##String#>", ambientB: "<#T##String#>", radioB: "<#T##String#>", playlistB: "<#T##String#>", previousB: "<#T##String#>", nextB: "<#T##String#>", volume_downB: "<#T##String#>", volume_upB: "<#T##String#>", muteB: "<#T##String#>", offB: "<#T##String#>"))
        
        // Soba 3 Павиљон Дневна
        revk.append(Strukture.REV_struktura(ip: "192.168.1.90", port: "11244", u_userA: "u.user1", r_roomA: "r.room1", s_userA: "s.user1", s_roomA: "s.room1", u_userB: "u.user4", r_roomB: "r.room5", s_userB: "s.user4", s_roomB: "s.room5", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 4 Павиљон Спавћа
        revk.append(Strukture.REV_struktura(ip: "192.168.1.90", port: "11244", u_userA: "u.user2", r_roomA: "r.room2", s_userA: "s.user2", s_roomA: "s.room2", u_userB: "u.user1", r_roomB: "r.room1", s_userB: "s.user1", s_roomB: "s.room1", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 5 Павиљон Билијарда
        revk.append(Strukture.REV_struktura(ip: "192.168.1.90", port: "11244", u_userA: "u.user3", r_roomA: "r.room3", s_userA: "s.user3", s_roomA: "s.room3", u_userB: "u.user4", r_roomB: "r.room7", s_userB: "s.user4", s_roomB: "s.room7", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 4 Никола пробе
        revk.append(Strukture.REV_struktura(ip: "192.168.0.5", port: "1053", u_userA: "u.user1", r_roomA: "r.room1", s_userA: "s.user1", s_roomA: "s.room1", u_userB: "u.user2", r_roomB: "r.room2", s_userB: "s.user2", s_roomB: "s.room2", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        
        
        // Soba 101 Комната отдыха
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.relax", r_roomA: "r.relax", s_userA: "mymusic.relax", s_roomA: "s.relax", u_userB: "u.ambient", r_roomB: "r.Arelax", s_userB: "mymusic.ambient", s_roomB: "s.Arelax", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 102 Кабинет
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.office", r_roomA: "r.office", s_userA: "mymusic.office", s_roomA: "s.office", u_userB: "u.ambient", r_roomB: "r.Aoffice", s_userB: "mymusic.ambient", s_roomB: "s.Aoffice", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 103 Спальня 5
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.bed5", r_roomA: "r.bed5", s_userA: "mymusic.bed5", s_roomA: "s.bed5", u_userB: "u.ambient", r_roomB: "r.Abed5", s_userB: "mymusic.ambient", s_roomB: "s.Abed5", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 104 Спальня 1 M100
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.bed1_100", r_roomA: "r.bed1_100", s_userA: "mymusic.bed1_100", s_roomA: "s.bed1_100", u_userB: "u.ambient", r_roomB: "r.Abed1", s_userB: "mymusic.ambient", s_roomB: "s.Abed1", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 105 Спальня 1 V219
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.bed1_219", r_roomA: "r.bed1_219", s_userA: "mymusic.bed1_219", s_roomA: "s.bed1_219", u_userB: "u.ambient", r_roomB: "r.Abed1", s_userB: "mymusic.ambient", s_roomB: "s.Abed1", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 106 Спальня 2
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.bed2", r_roomA: "r.bed2", s_userA: "mymusic.bed2", s_roomA: "s.bed2", u_userB: "u.ambient", r_roomB: "r.Abed2", s_userB: "mymusic.ambient", s_roomB: "s.Abed2", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 107 Спальня 3
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.bed3", r_roomA: "r.bed3", s_userA: "mymusic.bed3", s_roomA: "s.bed3", u_userB: "u.ambient", r_roomB: "r.Abed3", s_userB: "mymusic.ambient", s_roomB: "s.Abed3", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 108 Спальня 4
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.bed4", r_roomA: "r.bed4", s_userA: "mymusic.bed4", s_roomA: "s.bed4", u_userB: "u.ambient", r_roomB: "r.Abed4", s_userB: "mymusic.ambient", s_roomB: "s.Abed4", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 109 Гостинная
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.guest", r_roomA: "r.guest", s_userA: "mymusic.guest", s_roomA: "s.guest", u_userB: "u.ambient", r_roomB: "r.Aguest", s_userB: "mymusic.ambient", s_roomB: "s.Aguest", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))
        
        // Soba 110 Фитнес зал
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.fitness", r_roomA: "r.fitness", s_userA: "mymusic.fitness", s_roomA: "s.fitness", u_userB: "u.ambient", r_roomB: "r.Aguest", s_userB: "mymusic.ambient", s_roomB: "s.Aguest", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))

        // Soba 111 Комната отдыха 2
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.relax2", r_roomA: "r.relax2", s_userA: "mymusic.relax2", s_roomA: "s.relax2", u_userB: "u.ambient", r_roomB: "r.Arelax2", s_userB: "mymusic.ambient", s_roomB: "s.Arelax2", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))

        // Soba 112 Спальня 6
        revk.append(Strukture.REV_struktura(ip: "172.30.10.11", port: "11244", u_userA: "u.bed6", r_roomA: "r.bed6", s_userA: "mymusic.bed6", s_roomA: "s.bed6", u_userB: "u.ambient", r_roomB: "r.Abed6", s_userB: "mymusic.ambient", s_roomB: "s.Abed6", mediaA: ReVox.roomА_userA, ambientA: ReVox.roomА_userB, radioA: ReVox.radioA, playlistA: ReVox.playlistA, previousA: ReVox.previousА, nextA: ReVox.nextА, volume_downA: ReVox.volume_downA, volume_upA: ReVox.volume_upA, muteA: ReVox.muteA, offA: ReVox.power_offA, mediaB: ReVox.roomB_userA, ambientB: ReVox.roomB_userB, radioB: ReVox.radioB, playlistB: ReVox.playlistB, previousB: ReVox.previousB, nextB: ReVox.nextB, volume_downB: ReVox.volume_downB, volume_upB: ReVox.volume_upB, muteB: ReVox.muteB, offB: ReVox.power_offB))

        
        
        
        
        
        
        
        
        
        /***********************************************************/
        
        
        /* => Dodavanje članova niza sa grupnim adresama za KNX*/
        /***********************************************************/
        // Soba 1 Кабинет
//        TAPKO toreVox(command: ReVox.volume_downA)
//        knxk.append(Strukture.KNX_Struktura(ip: "192.168.50.80", port: "12004", reconnect: false, group_address: "tds (1/4/1 1)", scene_ON: "1", scene_1: "2", scene_2: "3", scene_OFF: "0"))
        knxk.append(Strukture.KNX_Struktura(ip: "192.168.50.202", port: "20000", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.scena_ON), scene_1: toreVox(command: ReVox.scena_1), scene_2: toreVox(command: ReVox.scena_2), scene_OFF: toreVox(command: ReVox.scena_OFF)))

//        HomeServer
//         knxk.append(Strukture.KNX_Struktura(ip: "192.168.50.101", port: "20000", reconnect: true, group_address: "", scene_ON: "1", scene_1: "2", scene_2: "3", scene_OFF: "4"))
        
        
        // Soba 2 Илија
        knxk.append(Strukture.KNX_Struktura(ip: "192.168.20.202", port: "20000", reconnect: true, group_address: "", scene_ON: "6", scene_1: "3", scene_2: "4", scene_OFF: "5"))
        
        // Soba 3 Павиљон Дневна
        knxk.append(Strukture.KNX_Struktura(ip: "192.168.1.202", port: "20000", reconnect: true, group_address: "", scene_ON: "1", scene_1: "2", scene_2: "3", scene_OFF: "4"))
        
        // Soba 4 Павиљон Спаваћа
        knxk.append(Strukture.KNX_Struktura(ip: "192.168.1.202", port: "20000", reconnect: true, group_address: "", scene_ON: "11", scene_1: "12", scene_2: "13", scene_OFF: "14"))
        
        // Soba 5 Павиљон Билијарда
        knxk.append(Strukture.KNX_Struktura(ip: "192.168.1.202", port: "20000", reconnect: true, group_address: "", scene_ON: "21", scene_1: "22", scene_2: "23", scene_OFF: "24"))

        // Soba 6 Никола пробе
        knxk.append(Strukture.KNX_Struktura(ip: "192.168.0.5", port: "1054", reconnect: true, group_address: "1/2/33", scene_ON: KNX.scene_ON, scene_1: KNX.scene_1, scene_2: KNX.scene_2, scene_OFF: KNX.scene_OFF))
        
        // Soba 101 Комната отдыха
        // Soba 102 Кабинет
        // Soba 103 Спальня 5
        // Soba 104 Спальня 1 M100
        // Soba 105 Спальня 1 V219
        // Soba 106 Спальня 2
        // Soba 107 Спальня 3
        // Soba 108 Спальня 4
        // Soba 109 Гостинная
        // Soba 110 Фитнес зал
        // Soba 111 Комната отдыха 2
        // Soba 112 Спальня 6

        
        
        // Soba 101 Комната отдыха
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "11", scene_1: "12", scene_2: "13", scene_OFF: "14"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.relax_scena_ON), scene_1: toreVox(command: ReVox.relax_scena_1), scene_2: toreVox(command: ReVox.relax_scena_2), scene_OFF: toreVox(command: ReVox.relax_scena_OFF)))

        // Soba 102 Кабинет
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "21", scene_1: "22", scene_2: "23", scene_OFF: "24"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.office_scena_ON), scene_1: toreVox(command: ReVox.office_scena_1), scene_2: toreVox(command: ReVox.office_scena_2), scene_OFF: toreVox(command: ReVox.office_scena_OFF)))

        
//         Soba 103 Спальня 5
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "31", scene_1: "32", scene_2: "33", scene_OFF: "34"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.bed5_scena_ON), scene_1: toreVox(command: ReVox.bed5_scena_1), scene_2: toreVox(command: ReVox.bed5_scena_2), scene_OFF: toreVox(command: ReVox.bed5_scena_OFF)))

        
        // Soba 104 Спальня 1 M100
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "41", scene_1: "42", scene_2: "43", scene_OFF: "44"))
        
        
        // Soba 105 Спальня 1 V219
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "51", scene_1: "52", scene_2: "53", scene_OFF: "54"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.bed1_scena_ON), scene_1: toreVox(command: ReVox.bed1_scena_1), scene_2: toreVox(command: ReVox.bed1_scena_2), scene_OFF: toreVox(command: ReVox.bed1_scena_OFF)))

        
        // Soba 106 Спальня 2
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "61", scene_1: "62", scene_2: "63", scene_OFF: "64"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.bed2_scena_ON), scene_1: toreVox(command: ReVox.bed2_scena_1), scene_2: toreVox(command: ReVox.bed2_scena_2), scene_OFF: toreVox(command: ReVox.bed2_scena_OFF)))

        
        // Soba 107 Спальня 3
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "71", scene_1: "72", scene_2: "73", scene_OFF: "74"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.bed3_scena_ON), scene_1: toreVox(command: ReVox.bed3_scena_1), scene_2: toreVox(command: ReVox.bed3_scena_2), scene_OFF: toreVox(command: ReVox.bed3_scena_OFF)))

        
        // Soba 108 Спальня 4
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "81", scene_1: "82", scene_2: "83", scene_OFF: "84"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.bed4_scena_ON), scene_1: toreVox(command: ReVox.bed4_scena_1), scene_2: toreVox(command: ReVox.bed4_scena_2), scene_OFF: toreVox(command: ReVox.bed4_scena_OFF)))

        
        // Soba 109 Гостинная
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "91", scene_1: "92", scene_2: "93", scene_OFF: "94"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.guest_scena_ON), scene_1: toreVox(command: ReVox.guest_scena_1), scene_2: toreVox(command: ReVox.guest_scena_2), scene_OFF: toreVox(command: ReVox.guest_scena_OFF)))

        
        // Soba 110 Фитнес зал
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "101", scene_1: "102", scene_2: "103", scene_OFF: "104"))
        
        // Soba 111 Комната отдыха 2
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "111", scene_1: "112", scene_2: "113", scene_OFF: "114"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.relax2_scena_ON), scene_1: toreVox(command: ReVox.relax2_scena_1), scene_2: toreVox(command: ReVox.relax2_scena_2), scene_OFF: toreVox(command: ReVox.relax2_scena_OFF)))

        // Soba 112 Спальня 6
        knxk.append(Strukture.KNX_Struktura(ip: "172.30.40.50", port: "20000", reconnect: true, group_address: "", scene_ON: "121", scene_1: "122", scene_2: "123", scene_OFF: "124"))
//        knxk.append(Strukture.KNX_Struktura(ip: "172.30.10.180", port: "12004", reconnect: false, group_address: "", scene_ON: toreVox(command: ReVox.bed6_scena_ON), scene_1: toreVox(command: ReVox.bed6_scena_1), scene_2: toreVox(command: ReVox.bed6_scena_2), scene_OFF: toreVox(command: ReVox.bed6_scena_OFF)))


        
        
        
        
        
        
        
        
        
        /***********************************************************/
        
        
        /* => Dodavanje članova niza sa akcijama za promenu kartice */
        /***********************************************************/
        // Soba 1 Кабинет
            // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Philips.input_HDMI_SIDE, Kasnjenje: 1.9, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: TV_Philips.power_on, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))


            // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Philips.input_HDMI2, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
            // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Philips.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_coaxial, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))

            // Akcije za karticu >reVox i KNX<
//        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        // Soba 2 Илија
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: ReVox.M_51_100_input_optical_1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI3, Kasnjenje: 0.2, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.power_on, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))

        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI2, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.M_51_100_input_optical_1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI1, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.M_51_100_input_coaxial_1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        // Soba 3 Павиљон Дневна
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.1.86", port: "20060", command: "\(TV_Sony.input_HDMI1)"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.1.86", port: "20060", command: "\(TV_Sony.power_on)"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))

        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.1.86", port: "20060", command: "\(TV_Sony.input_HDMI2)"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.1.86", port: "20060", command: "\(TV_Sony.input_HDMI3)\n\r"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_coaxial_1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        akcijek.append(Strukture.Akcije(Komanda: "5", Kasnjenje: 0.0, Uredjaj: .KNX, Kartica: .reVox_KNX))
        akcijek.append(Strukture.Akcije(Komanda: "7", Kasnjenje: 0.0, Uredjaj: .KNX, Kartica: .reVox_KNX))


        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 4 Павиљон Спаваћа
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI1, Kasnjenje: 0.7, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.power_on, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        akcijek.append(Strukture.Akcije(Komanda: "15", Kasnjenje: 0.0, Uredjaj: .KNX, Kartica: .reVox_KNX))
        akcijek.append(Strukture.Akcije(Komanda: "17", Kasnjenje: 1.0, Uredjaj: .KNX, Kartica: .reVox_KNX))

        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        // Soba 5 Павиљон Билијарда
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_coaxial, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV)) // M100
//        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV)) //M51
//        akcijek.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.1.81", port: "905", command: "\(TV_Loewe.input_HDMI2)"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI2, Kasnjenje: 0.7, Uredjaj: .TV, Kartica: .TV))
//        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.power_on, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.1.81", port: "905", command: "\(TV_Loewe.power_on)"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))

        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_coaxial, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
//        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_coaxial, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))

        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
//        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.channel_up, Kasnjenje: 0.5, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_coaxial, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
//        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_coaxial, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))

        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        akcijek.append(Strukture.Akcije(Komanda: "25", Kasnjenje: 0.0, Uredjaj: .KNX, Kartica: .reVox_KNX))
        akcijek.append(Strukture.Akcije(Komanda: "27", Kasnjenje: 0.2, Uredjaj: .KNX, Kartica: .reVox_KNX))

        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */

        
        
        // Soba 6 Никола пробе
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.0.119", port: "1050", command: "\(TV_Sony.input_HDMI1)\n\r"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV)) // Parametar ~Uredjaj~ nije bitan kada se koristi directIP komanda!
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI2, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_LG.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        
        
        
        
        
        
        
        
        // Soba 101 Комната отдыха
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_coaxial_1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M51_optical, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 102 Кабинет M100
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 103 Спальня 5 M100
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 104 Спальня 1 M100
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 105 Спальня 1 V219
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 106 Спальня 2
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 107 Спальня 3
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 108 Спальня 4
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 109 Гостинная
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 110 Фитнес зал
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_analog, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */
        
        // Soba 111 Комната отдыха 2 M100
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 112 Спальня 6 M100
        // Akcije za karticu >TV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_TV, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .TV))
        
        // Akcije za karticu >AppleTV<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI4, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .AppleTV))
        
        // Akcije za karticu >Kaleidescape<
        akcijek.append(Strukture.Akcije(Komanda: TV_Loewe.input_HDMI3, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: ReVox.input_M_100_AUX1, Kasnjenje: 0, Uredjaj: .reVox, Kartica: .Kaleidescape))
        akcijek.append(Strukture.Akcije(Komanda: Kaleidescape.power_on, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije za karticu >reVox i KNX<
        //        akcijek.append(Strukture.Akcije(Komanda: "AkcijareVox_KNX1-1", Kasnjenje: 1.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcija.append(akcijek)
        akcijek.removeAll()
        /* NE MENJATI - Kraj */

        
        
        
        
        
        
        
        
        
        /***********************************************************/
        
        
        /* => Dodavanje članova niza sa akcijama za All Off komandu */
        /***********************************************************/
        // Soba 1 Кабинет
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Philips.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */
        
        // Soba 2 Илија
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_LG.power_off, Kasnjenje: 0.2, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >D3i<
        akcijeoff.append(Strukture.Akcije(Komanda: SBB_D3i.power_toggle, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))

        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
//        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.M_51_100_power_off, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */
        
        // Soba 3 Дневна Павиљон
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: directIP(ip: "192.168.1.86", port: "20060", command: "\(TV_Sony.power_off)"), Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
//      akcijeoff.append(Strukture.Akcije(Komanda: TV_LG.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 4 Павиљон Спаваћа
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_LG.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */
        
        
        // Soba 4 Павиљон Билијарда
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        
        // Soba 6 Никола пробе
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_LG.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */
        
        
        
        
        
        
        // Soba 101 Комната отдыха
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        
        // Soba 102 Кабинет
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 103 Спальня 5
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 104 Спальня 1 M100
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 105 Спальня 1 V219
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 106 Спальня 2
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 107 Спальня 3
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 108 Спальня 4
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 109 Гостинная
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 110 Фитнес зал
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 111 Комната отдыха 2
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        // Soba 112 Спальня 6
        // Akcije Off za >TV<
        akcijeoff.append(Strukture.Akcije(Komanda: TV_Loewe.power_off, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .TV))
        
        // Akcije Off za >AppleTV<
        akcijeoff.append(Strukture.Akcije(Komanda: AppleTV.stop, Kasnjenje: 0.0, Uredjaj: .TV, Kartica: .AppleTV))
        
        // Akcije Off za >Kaleidescape<
        akcijeoff.append(Strukture.Akcije(Komanda: Kaleidescape.power_off, Kasnjenje: 0.0, Uredjaj: .Kaleidescape, Kartica: .Kaleidescape))
        
        // Akcije Off za >reVox i KNX<
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offA, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        akcijeoff.append(Strukture.Akcije(Komanda: ReVox.power_offB, Kasnjenje: 0.0, Uredjaj: .reVox, Kartica: .reVox_KNX))
        
        /* NE MENJATI - Početak - Kopirati ovaj blok tako da zadrži svoje mesto ispod komandi! */
        listaAkcijaOff.append(akcijeoff)
        akcijeoff.removeAll()
        /* NE MENJATI - Kraj */

        
        
        
        
        
        
        
        
        /***********************************************************/
        
        
        /* => Dodavanje članova niza sa imenima i šiframa soba */
        /***********************************************************/
        // Soba 1 Кабинет
        sobe.append(Strukture.Sobe(ime_sobe: "Кабинет", sifra_sobe: "1"))
        
        // Soba 2 Илија
        sobe.append(Strukture.Sobe(ime_sobe: "Илија", sifra_sobe: "2"))
        
        // Soba 3 Павиљон Дневна
        sobe.append(Strukture.Sobe(ime_sobe: "Дневна Павиљон", sifra_sobe: "3"))
        
        // Soba 4 Павиљон Спаваћа
        sobe.append(Strukture.Sobe(ime_sobe: "Спаваћа Павиљон", sifra_sobe: "4"))
        
        // Soba 5 Павиљон Билијарда
        sobe.append(Strukture.Sobe(ime_sobe: "Билијарда Павиљон", sifra_sobe: "5"))

        // Soba 6 Никола пробе
        sobe.append(Strukture.Sobe(ime_sobe: "TEST", sifra_sobe: "6"))
        
        
        
        
        
        // Soba 101 Комната отдыха
        sobe.append(Strukture.Sobe(ime_sobe: "Living rooom - Комната отдыха", sifra_sobe: "18"))

        // Soba 102 Кабинет
        sobe.append(Strukture.Sobe(ime_sobe: "Office - Кабинет", sifra_sobe: "17"))

        // Soba 103 Спальня 5
        sobe.append(Strukture.Sobe(ime_sobe: "Bedroom - Спальня 1.11", sifra_sobe: "111"))

        // Soba 104 Спальня 1 M100
        sobe.append(Strukture.Sobe(ime_sobe: "Спальня 1 M100", sifra_sobe: "100"))

        // Soba 105 Спальня 1 V219
        sobe.append(Strukture.Sobe(ime_sobe: "Living - Гостинная", sifra_sobe: "22"))

        // Soba 106 Спальня 2
        sobe.append(Strukture.Sobe(ime_sobe: "Bedroom - Спальня 2.5", sifra_sobe: "25"))

        // Soba 107 Спальня 3
        sobe.append(Strukture.Sobe(ime_sobe: "Bedroom - Спальня 2.9", sifra_sobe: "29"))

        // Soba 108 Спальня 4
        sobe.append(Strukture.Sobe(ime_sobe: "Bedroom - Спальня 2.13", sifra_sobe: "213"))

        // Soba 109 Гостинная
        sobe.append(Strukture.Sobe(ime_sobe: "Fireplace - Каминная", sifra_sobe: "16"))

        // Soba 110 Фитнес зал
        sobe.append(Strukture.Sobe(ime_sobe: "Fitness - Фитнес", sifra_sobe: "148"))

        // Soba 111 Комната отдыха 2
        sobe.append(Strukture.Sobe(ime_sobe: "Living - Комната отдыха 2", sifra_sobe: "114"))

        // Soba 112 Спальня 6
        sobe.append(Strukture.Sobe(ime_sobe: "Bedroom - Спальня 1.15", sifra_sobe: "115"))


        
        
        
        
        
        
        
        /***********************************************************/
        
        
        /* => Dodavanje članova niza sa podešavanjima za prisutne uređaje */
        /***********************************************************/
        // Soba 1 Кабинет
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))
        
        // Soba 2 Илија
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: false, reVoxA: false, reVoxB: false))
        
        // Soba 3 Павиљон Дневна
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))
        
        // Soba 4 Павиљон Спаваћа
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: false, reVoxA: true, reVoxB: true))
        
        // Soba 5 Павиљон Билијарда
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))
        
        // Soba 6 Никола пробе
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: false, reVoxB: true))
        
        
        
        
        // Soba 101 Комната отдыха
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 102 Кабинет
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 103 Спальня 5
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 104 Спальня 1 M100
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 105 Спальня 1 V219
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 106 Спальня 2
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 107 Спальня 3
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 108 Спальня 4
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 109 Гостинная
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 110 Фитнес зал
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: false, reVoxA: false, reVoxB: false))

        // Soba 111 Комната отдыха 2
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

        // Soba 112 Спальня 6
        puk.append(Strukture.Prisutni_Uredjaji(TV: true, AppleTV: true, Kaleidescape: true, reVoxA: true, reVoxB: true))

// ==>  /* >>Mesto za narednu sobu (Soba 3)<< */
        
        /***********************************************************/
        
        /****** KRAJ PODEŠAVANJA ******/
        
        // Soba 101 Комната отдыха
        // Soba 102 Кабинет
        // Soba 103 Спальня 5
        // Soba 104 Спальня 1 M100
        // Soba 105 Спальня 1 V219
        // Soba 106 Спальня 2
        // Soba 107 Спальня 3
        // Soba 108 Спальня 4
        // Soba 109 Гостинная
        // Soba 110 Фитнес зал
        // Soba 111 Комната отдыха 2
        // Soba 112 Спальня 6

    }
    
    /* Interne metode */
    
    func return_tvk(select: Int) -> Strukture.TV_struktura {
        return tvk[select]
    }
    func return_atvk(select: Int) -> Strukture.ATV_struktura {
        return atvk[select]
    }
    func return_kalk(select: Int) -> Strukture.KAL_struktura {
        return kalk[select]
    }
    func return_revk(select: Int) -> Strukture.REV_struktura {
        return revk[select]
    }
    func return_knxk(select: Int) -> Strukture.KNX_Struktura {
        return knxk[select]
    }
    func return_akcije(select: Int) -> [Strukture.Akcije] {
        return listaAkcija[select + 1]
    }
    func return_akcijeOff(select: Int) -> [Strukture.Akcije] {
        return listaAkcijaOff[select + 1]
    }
    func return_room(select: Int) -> Strukture.Sobe {
        return sobe[select]
    }
    func return_rooms() -> [Strukture.Sobe] {
        return sobe
    }
    func return_pu(select: Int) -> Strukture.Prisutni_Uredjaji {
        return puk[select]
    }
    func verify() -> Bool {
        let ref = tvk.count
        if (atvk.count == ref && kalk.count == ref && revk.count == ref && sobe.count == ref) {
            return true
        } else {
            return false
        }
    }
    func return_settings() -> Strukture.Konfiguracija {
        return konfiguracija
    }
}
