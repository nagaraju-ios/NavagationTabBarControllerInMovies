//
//  ViewController.swift
//  NavagationTabBarControllerInMovies
//
//  Created by THOTA NAGARAJU on 12/11/19.
//  Copyright © 2019 THOTA NAGARAJU. All rights reserved.
//

import UIKit
import AVKit
class ViewController: UIViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var scrollViewObj: UIScrollView!
    @IBOutlet weak var pageControlObj: UIPageControl!
    
    @IBOutlet weak var stackView1: UIStackView!
    
    @IBOutlet weak var uiView: UIView!
    var image :UIImageView!
        var label:UILabel!
        var tag : Int!
      
        var dataToServer = [Movie]()
        var imageArray:[UIImageView] = []
        var labelArray:[UILabel] = []
        var AV:AVPlayerViewController!
        var data1:Int!
        var view1:UIView!
        var audiotag:Int?
        
        var audioAV:AVPlayerViewController!
        var videoView:UIView!
 
  var frame = CGRect (x: 0, y: 0, width: 0, height: 0)
  var modeOfSegView = UISegmentedControl()
        
    var viewArray:[UIView]  = []
    
    
    var mm:[String:String] = ["War":"bollywood","Frozen 2":"Hollywood" ,"Ala Vaikuntapuram lo":"tollywood","Saaho":"tollywood","Pehlwaan":"bollywood","Frozen%202":"tollywood","Rakshasudu":"tollywood","Jersey":"tollywood","Manmadhudu 2":"tollywood","Mallesham":"tollywood","Khaidi":"tollywood",
    "Agent Sai Srinivasa Athreya":"tollywood","Sye Raa Narasimha Reddy":"tollywood","The Zoya Factor":"bollywood","Gaddalakonda Ganesh":"tollywood","George Reddy":"tollywood","Game Over":"tollywood","Dear Comrade":"tollywood","Petta":"tollywood","118" :"tollywood","Gang Leader":"tollywood","Oh! Baby":"tollywood","Whistle":"tollywood","Ranarangam":"tollywood","Evvarikee Cheppoddu":"tollywood","Evaru":"tollywood"]
    
        override func viewDidLoad() {
            super.viewDidLoad()
         
          
           dataFromServer()
         
            scrollViewObj.isPagingEnabled = true
            scrollViewObj.showsHorizontalScrollIndicator = false
            scrollViewObj.delegate = self
            pageControlObj.addTarget(self, action: #selector(onPageCntrl), for: UIControl.Event.valueChanged)
            var timerObj:Timer!
                       
        timerObj = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(onTimer), userInfo: nil, repeats: true)
                    
            // Do any additional setup after loading the view.
        }
    
    
 
    @IBAction func posterBtn(_ sender: Any) {
       
      
    }
    
    @IBAction func AVplayBtn(_ sender: Any) {
//        var dataToServer = movieDetails()
//
//        let tvc = self.storyboard?.instantiateViewController(withIdentifier: "TVC")
//        as! ThirdViewController
//        tvc.videoData = (sender as AnyObject).tag
//        tvc.videoServer =  dataToServer
//        present(tvc, animated: true){
//
//        }
       // navigationController?.pushViewController(tvc, animated: true)
    }
   
    @IBAction func allData(_ sender: Any) {
//        var dataToServer = movieDetails()
//
//
//        let svc = storyboard?.instantiateViewController(identifier: "SVC")as! SCViewController
//        svc.dataDetails = (sender as AnyObject).tag
//            svc.serverData2 =  dataToServer
//       // navigationController?.pushViewController(svc, animated: true)
//        present(svc, animated: true){
//
//        }
                   
    }
    @IBAction func pageCntrlAction(_ sender: Any) {
        
    }

   
    // @IBAction func addBtn(_ sender: Any) {
            
func dataFromServer(){
    
        var dataToServer = movieDetails()
    
            pageControlObj.isHidden = false
    
    
    
    // lops for remove posters
              for y in imageArray{
              y.removeFromSuperview()
              }
        
    // lops for WholeData
     
             for i in 0...dataToServer.count-1
                 {
                     
                  image = UIImageView(frame: frame)
                  view1 = UIView()
                  pageControlObj.numberOfPages = dataToServer.count-1
                       image.tag = i
                  let posters = dataToServer[i].posters!
                  let posterData = posters[0]
                  let url = "https://www.brninfotech.com/tws/\(posterData)"
                  let newUrl:String = url.replacingOccurrences(of: " ", with: "%20")
                  let image1 = URL(string: newUrl)
                  let imageData = try!  Data(contentsOf: image1!)
                  let images = UIImage(data: imageData)
                  image.image = images!
                  view1.addSubview(image)
                  frame.origin.x = self.scrollViewObj.frame.size.width * CGFloat(i)
                  frame.size = self.scrollViewObj.frame.size
                  scrollViewObj.addSubview(view1)
               
                  
//                 let image = serverData2[dataDetails].posters!
//                 let posterData  = image[0]
//                 let url = "https://www.brninfotech.com/tws/\(posterData)"
//                 let newUrl:String = url.replacingOccurrences(of: " ", with:"%20")
//                 let image1 = URL(string: newUrl)
//                 let imageData = try! Data(contentsOf: image1!)
//                 let images = UIImage(data: imageData)
//
//                 imageObj.image = images
//
    
    
    
    
    }
      scrollViewObj.contentSize = CGSize(width: self.scrollViewObj.frame.size.width * CGFloat(dataToServer.count), height: self.scrollViewObj.frame.size.height)
             
   
    
    
    
    
    
    
    
    
    
    
    
    
    }
  
    
        @objc func onPageCntrl()
       {
//        scrollViewObj.scrollRectToVisible(CGRect(x:CGFloat(pageControlObj.currentPage)*scrollViewObj.frame.width, y: 0, width: scrollViewObj.frame.width, height: scrollViewObj.frame.height), animated: true)
        }
        
        @objc func onTimer()  {

            
            if(pageControlObj.currentPage < Int(pageControlObj.numberOfPages-1))
            {
                pageControlObj.currentPage += 1
                
              
            }else{
                
                pageControlObj.currentPage = 0
                
               
            }
            scrollViewObj.scrollRectToVisible(CGRect(x:CGFloat(pageControlObj.currentPage)*scrollViewObj.frame.width, y: 0, width: scrollViewObj.frame.width, height: scrollViewObj.frame.height), animated: true)
            
            
        }
        
    // ScrollView Fun pageControl
        
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            var sv = scrollView.contentOffset.x/scrollViewObj.frame.width
            pageControlObj.currentPage = Int(sv)
        }

    
    // Get Data From JsonDecoder
    
    func movieDetails()->[Movie]{
        
            var URLReqObj :URLRequest!
            var dataTaskObj:URLSessionDataTask!
            var convertedData:[Movie]!

            URLReqObj = URLRequest(url: URL(string:"https://www.brninfotech.com/tws/MovieDetails2.php?mediaType=movies")!)

            URLReqObj.httpMethod = "GET"
            dataTaskObj = URLSession.shared.dataTask(with: URLReqObj, completionHandler: {( data,ConnDetails,Error) in

                print("got data from server")

            do{
                 
                var decoder = JSONDecoder()
                convertedData = try
                decoder.decode([Movie].self, from: data!)
               // print(convertedData[1])
                print(convertedData.count)
                
                }catch
                {
                    print("something went wrong")
                }


                })
                dataTaskObj.resume()

                while (convertedData == nil){
                }
                return convertedData

        }


    
    
    
}

