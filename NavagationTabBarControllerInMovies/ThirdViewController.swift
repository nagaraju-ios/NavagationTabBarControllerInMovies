//
//  ThirdViewController.swift
//  NavagationTabBarControllerInMovies
//
//  Created by THOTA NAGARAJU on 12/14/19.
//  Copyright © 2019 THOTA NAGARAJU. All rights reserved.
//

import UIKit
import AVKit
class ThirdViewController: UIViewController {
    @IBOutlet weak var scrollView3: UIScrollView!
    
  
    @IBOutlet weak var uiview3: UIView!
    var AV:AVPlayerViewController!
    
    var videoData:Int!
    var videoServer=[Movie]()
    var button:UIButton!
    @IBOutlet weak var TrailerView: UIView!
    var buttonArray:[UIButton]=[]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
         AudioVideo()
        print(videoServer)
        // Do any additional setup after loading the view.
    }

        func AudioVideo(){
        //  Creating Auido video Controller
           
        
          //  var video  = videoServer[videoData].trailers
            
             for i in 0...videoServer.count-1
                         {
                             
                                
                                button = UIButton()
                               // pageControlObj.numberOfPages = dataToServer.count
                                button.tag = i
                                button.translatesAutoresizingMaskIntoConstraints = false
                                button.heightAnchor.constraint(equalToConstant: 243).isActive = true
                                button.widthAnchor.constraint(equalToConstant: 414).isActive = true
                                let posters = videoServer[videoData].posters!
                                let posterData = posters[0]
                                let url = "https://www.brninfotech.com/tws/\(posterData)"
                                let newUrl:String = url.replacingOccurrences(of: " ", with: "%20")
                                let image = URL(string: newUrl)
                                let imageData = try!  Data(contentsOf: image!)
                                let images = UIImage(data: imageData)
                                button.setImage(images, for: UIControl.State.normal)
                                buttonArray.append(button)
                                print(buttonArray.count)
        button.addTarget(self, action:#selector(videob(button:)), for: UIControl.Event.touchUpInside)
                                scrollView3.addSubview(button)
                                frame.origin.x = scrollView3.frame.size.width*CGFloat(i)
                                frame.size = scrollView3.frame.size
                            self.scrollView3.addSubview(button)
                  
                        }
                    scrollView3.contentSize = CGSize(width: (scrollView3.frame.size.width * CGFloat(videoServer.count)), height: (scrollView3.frame.size.height))
                      
            }
            
        @objc func videob(button:UIButton){
            
          
                
         
           //var videoTag = button.tag
                AV = AVPlayerViewController()
            
           // TrailerView.frame = frame
                let video  = videoServer[videoData].trailers!
                let videoData = video[0]
                let AVUrlString = "https://www.brninfotech.com/tws/\(videoData)"
                let AVUrl = AVUrlString.replacingOccurrences(of: " ", with:"%20")
            AV.player = AVPlayer(url: URL(string:AVUrl)!)
            
            AV.view.frame = CGRect(x: 0, y: 0, width: TrailerView.frame.width, height: TrailerView.frame.height)
            
            TrailerView.addSubview(AV.view)
        

            
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
