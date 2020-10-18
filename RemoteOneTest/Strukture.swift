//
//  Strukture.swift
//  RemoteOneTest
//
//  Created by Nikola Drndarevic
//  Copyright © 2018. Nikola Drndarevic. All rights reserved.
//

import Foundation

class Strukture {
    
    struct TV_struktura {
        var ip: String
        var port: String
        var tv_ir_port: String
        var stb_ir_port: String
        
        var channel_up: String
        var channel_down: String
        var channel_list: String
        var key1: String
        var key2: String
        var key3: String
        var key4: String
        var key5: String
        var key6: String
        var key7: String
        var key8: String
        var key9: String
        var key0: String
        
        var forward: String
        var reverse: String
        
        var play: String
        var pause: String
        
        var mute: String
        var volume_down: String
        var volume_up: String
        
        var cursor_up: String
        var cursor_down: String
        var cursor_left: String
        var cursor_right: String
        var cursor_enter: String
        
        var menu: String
        var exit: String
        
        var info: String
        var power_off: String
    }
    
    struct ATV_struktura {
        var ip: String
        var port: String
        var atv_ir_port: String
        
        var reverse: String
        var forward: String
        
        
        var play: String
        var pause: String
        var stop: String
        
        var mute: String
        var volume_down: String
        var volume_up: String
        
        var cursor_up: String
        var cursor_down: String
        var cursor_left: String
        var cursor_right: String
        var cursor_enter: String
        
        var menu: String
    }
    
    struct KAL_struktura {
        var ip: String
        var port: String
        var device: String
        var server: String
        
        var reverse: String
        var forward: String
        var movie_covers: String
        var music_covers: String
        
        let play: String
        let pause: String
        let stop: String
        
        var mute: String
        var volume_down: String
        var volume_up: String
        
        var cursor_up: String
        var cursor_down: String
        var cursor_left: String
        var cursor_right: String
        var cursor_enter: String
        
        var menu: String
        var subtitle: String
        var exit: String
        
        var power_off: String
    }
    
    struct REV_struktura {
        var ip: String
        var port: String
        
        var u_userA: String
        var r_roomA: String
        var s_userA: String
        var s_roomA: String
        
        var u_userB: String
        var r_roomB: String
        var s_userB: String
        var s_roomB: String
        
        var mediaA: String
        var ambientA: String
        
        var radioA: String
        var playlistA: String
        
        var previousA: String
        var nextA: String

        var volume_downA: String
        var volume_upA: String
        var muteA: String
        
        var offA: String
        
        var mediaB: String
        var ambientB: String
        
        var radioB: String
        var playlistB: String
        
        var previousB: String
        var nextB: String
        
        var volume_downB: String
        var volume_upB: String
        var muteB: String
        
        var offB: String
    }
    
    struct KNX_Struktura {
        var ip: String
        var port: String
        
        var reconnect: Bool
        
        var group_address: String
        
        var scene_ON: String
        var scene_1: String
        var scene_2: String
        var scene_OFF: String
      
    }
    
    struct Sobe {
        var ime_sobe: String
        var sifra_sobe: String
    }
    
    struct Konfiguracija {
        var TV_timeout: Int
        var TV_newline: Bool
        var TV_return: Bool
        var AppleTV_timeout: Int
        var AppleTV_newline: Bool
        var AppleTV_return: Bool
        var Kaleidescape_timeout: Int
        var Kaleidescape_newline: Bool
        var Kaleidescape_return: Bool
        var reVox_timeout: Int
        var reVox_newline: Bool
        var reVox_return: Bool
        var KNX_timeout: Int
        var KNX_newline: Bool
        var KNX_return: Bool
    }
    
    struct Prisutni_Uredjaji {
        var TV: Bool
        var AppleTV: Bool
        var Kaleidescape: Bool
        var reVoxA: Bool
        var reVoxB: Bool
    }
    
    struct Akcije {
        var Komanda: String
        var Kasnjenje: Double
        var Uredjaj: Tag
        var Kartica: Kartica
    }
    
}
