//
//  MapViewController.swift
//  GNT
//
//  Created by Shaneen on 5/29/23.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var mapView: UIView!
    
    @IBOutlet weak var pinImage: UIImageView!
    
    @IBOutlet weak var pinConstraint: NSLayoutConstraint!
    
    var centerMapCoordinate:CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
        initMap()
    }

    private func initMap(){
        let camera = GMSCameraPosition.camera(withLatitude: 33.315181, longitude: 44.366126, zoom: 12)
        let googleMapView = GMSMapView.map(withFrame: view.frame, camera: camera)
              mapView.addSubview(googleMapView)
        googleMapView.delegate = self

    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        let latitude = mapView.camera.target.latitude
            let longitude = mapView.camera.target.longitude
            centerMapCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        animatePin(true)
    }
   
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        animatePin(false)
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        if let center = centerMapCoordinate {
            UserInformation.didSelectLocation = true
            UserInformation.lat = center.latitude
            UserInformation.long = center.longitude
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func animatePin(_ animating: Bool){
        let animatingValue = animating ? -5 : 0
        pinConstraint.constant = CGFloat(animatingValue)
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
