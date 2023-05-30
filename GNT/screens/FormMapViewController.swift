//
//  FormMapViewController.swift
//  GNT
//
//  Created by Shaneen on 5/31/23.
//

import UIKit
import GoogleMaps

class FormMapViewController: UIViewController {
    
    var lat = 0.0
    var long = 0.0
    
    @IBOutlet weak var mapView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func initMap(){
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 16)
        let googleMapView = GMSMapView.map(withFrame: mapView.frame, camera: camera)
        self.view.addSubview(googleMapView)
        let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
                marker.title = "Sydney"
                marker.snippet = "Australia"
                marker.map = googleMapView

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
