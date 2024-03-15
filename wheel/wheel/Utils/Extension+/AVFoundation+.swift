//
//  AVFoundation+.swift
//  wheel
//
//  Created by admin on 15/03/2024.
//

import AVFoundation
import UIKit

//extension AVAudioPlayer {
//    static func playSound(named soundName: String, duration: TimeInterval? = nil, delay: TimeInterval? = nil) {
//        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: nil) else {
//            print("Không tìm thấy tệp âm thanh.")
//            return
//        }
//        
//        do {
//            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
//            
//            DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 0.0)) {
//                audioPlayer.play()
//                
//                if let duration = duration {
//                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
//                        audioPlayer.stop()
//                    }
//                }
//            }
//        } catch {
//            print("Không thể phát âm thanh: \(error.localizedDescription)")
//        }
//    }
//}
//
//extension AVAudioPlayer {
//    static func stopAllSounds() {
//        // Lấy danh sách tất cả các audio players đang phát
//        let audioPlayers = findAVAudioPlayersInViewHierarchy()
//        
//        // Dừng phát các audio players
//        audioPlayers.forEach { $0.stop() }
//    }
//    
//    private static func findAVAudioPlayersInViewHierarchy() -> [AVAudioPlayer] {
//        var audioPlayers = [AVAudioPlayer]()
//        
//        if let window = UIApplication.shared.keyWindow {
//            findAVAudioPlayers(in: window, audioPlayers: &audioPlayers)
//        }
//        
//        return audioPlayers
//    }
//    
//    private static func findAVAudioPlayers(in view: UIView, audioPlayers: inout [AVAudioPlayer]) {
//        for subview in view.subviews {
//            if let audioPlayer = subview as? AVAudioPlayer {
//                audioPlayers.append(audioPlayer)
//            } else {
//                findAVAudioPlayers(in: subview, audioPlayers: &audioPlayers)
//            }
//        }
//    }
//}
//

class SoundManager {
    static var audioPlayers = [AVAudioPlayer]()
    
    static func playSound(named soundName: String, duration: TimeInterval? = nil, delay: TimeInterval? = nil) {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: nil) else {
            print("Không tìm thấy tệp âm thanh.")
            return
        }
        
        do {
            let audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayers.append(audioPlayer)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + (delay ?? 0.0)) {
                audioPlayer.play()
                
                if let duration = duration {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        stopSound(audioPlayer)
                    }
                }
            }
        } catch {
            print("Không thể phát âm thanh: \(error.localizedDescription)")
        }
    }
    
    static func stopAllSounds() {
        audioPlayers.forEach { stopSound($0) }
        audioPlayers.removeAll()
    }
    
    private static func stopSound(_ audioPlayer: AVAudioPlayer) {
        audioPlayer.stop()
        if let index = audioPlayers.firstIndex(of: audioPlayer) {
            audioPlayers.remove(at: index)
        }
    }
}
