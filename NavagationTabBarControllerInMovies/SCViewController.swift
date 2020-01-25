//
//  SCViewController.swift
//  NavagationTabBarControllerInMovies
//
//  Created by THOTA NAGARAJU on 12/12/19.
//  Copyright © 2019 THOTA NAGARAJU. All rights reserved.
//

import UIKit
import AVKit
class SCViewController: UIViewController {
    
    var AV:AVPlayerViewController!
    var dataDetails:Int!
    var audiotag:Int?
    var serverData2 = [Movie]()
    var audioAV:AVPlayerViewController!
  //  var getServerdta:[Movie] = []
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageObj: UIImageView!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var actorLbl: UILabel!
    @IBOutlet weak var stacView: UIStackView!
    @IBOutlet weak var trilerView: UIView!
    @IBOutlet weak var storyLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        totalData()
        // Do any additional setup after loading the view.
    }
    
     func totalData(){
            
    //  Creating tittle name Label
            titleLbl.text = serverData2[dataDetails].title
    //  Creating Story  Label
        storyLbl.text = serverData2[dataDetails].story ?? "No Story Available in Server"
            
    //  Creating Director  Label

            let director = serverData2[dataDetails].director
            directorLbl.text = "\(director!)"
    //  Creating actors  Label
           
      //  let actor = serverData2[dataDetails].actors
         //   for i in 0...actor!.count-1{
           // let act = actor![i]
            //actorLbl.text = act
        
               //}
    
    let image = serverData2[dataDetails].posters!
            let posterData  = image[0]
            let url = "https://www.brninfotech.com/tws/\(posterData)"
            let newUrl:String = url.replacingOccurrences(of: " ", with:"%20")
            let image1 = URL(string: newUrl)
            let imageData = try! Data(contentsOf: image1!)
            let images = UIImage(data: imageData)

            imageObj.image = images
            
    //  Creating Auido video Controller
            
            AV = AVPlayerViewController()
            let video  = serverData2[dataDetails].trailers
            let videoData = video![0]
            let AVUrlString = "https://www.brninfotech.com/tws/\(videoData)"
            let AVUrl = AVUrlString.replacingOccurrences(of: " ", with:"%20")
        AV!.player = AVPlayer(url: URL(string:AVUrl)!)
        AV!.view.frame = CGRect(x: 0, y: 0, width:
            trilerView.frame.width, height: trilerView.frame.height)
        trilerView.addSubview(AV!.view)

            let audio = serverData2[dataDetails].songs!
            print("12367885\(audio.count)")


    // for loop in Audio Songs
            if(audio.count != 0){
            for a in  0...audio.count-1{
                
                        
            let button = UIButton()
            button.backgroundColor = .systemPink
            button.setTitle("song \(a)", for: UIControl.State.normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant:40).isActive = true
            button.widthAnchor.constraint(equalToConstant: 50).isActive = true
            stacView.addArrangedSubview(button)
            button.tag = a
            button.addTarget(self, action: #selector(addtarget), for:UIControl.Event.touchUpInside)
           
            }
            }
        }
            
    //  addtarget functon to Audiobutton
            
            @objc func addtarget (audioTag:UIButton)
            {

                
                
            audiotag = audioTag.tag
            let audio = serverData2[dataDetails].songs!
            let audioData = audio[audiotag!]
            let audioUrlString = "https://www.brninfotech.com/tws/\(audioData)"
            let audioURL = audioUrlString.replacingOccurrences(of: " ", with: "%20")
            let audioPlayer = AVPlayer(url: URL(string: audioURL)!)
            audioAV = AVPlayerViewController()
            audioAV.player = audioPlayer
            audioAV.player?.play()
                
            present(audioAV, animated: true) {
                
            let image = self.serverData2[self.dataDetails].posters!
            let posterData  = image[0]
            let url = "https://www.brninfotech.com/tws/\(posterData)"
            let newUrl:String = url.replacingOccurrences(of: " ", with:"%20")
            let image1 = URL(string: newUrl)
            let imageData = try! Data(contentsOf: image1!)
            let images = UIImage(data: imageData)
            var audioView = UIImageView()
            audioView.frame = CGRect(x: 0, y: 0, width: 414, height: 750)
            audioView.image = images
            self.audioAV.contentOverlayView?.addSubview(audioView)
                

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
