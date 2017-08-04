//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Dane Miller on 6/11/17.
//  Copyright © 2017 Dane Miller. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController : UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    var audioRecorder :AVAudioRecorder!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureUI(recording : false)
    }

    
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(recording : true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        debugPrint(filePath!)
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
        configureUI(recording : false)
        audioRecorder.stop()
        let session = AVAudioSession.sharedInstance()
        try! session.setActive(false)
        

    }
    
    func configureUI(recording isRecording : Bool){
        stopRecordingButton.isEnabled = isRecording
        recordingButton.isEnabled = !isRecording
        recordingLabel.text = isRecording ? "Recording ... " : "Tap to record"
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder : AVAudioRecorder, successfully flag : Bool){
        if flag {
            print("OK")
            performSegue(withIdentifier : SegueIdentifiers.playback, sender : audioRecorder.url)
        } else {
            print("Not sacing")
            basicAlert(title: "Error", message: "Audio did not finish recording successfully", context: self) // Defined in Utils.swift
        }
        print("OK")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.playback {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}



