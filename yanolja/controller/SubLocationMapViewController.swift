//
//  SubLocationMapViewController.swift
//  yanolja
//
//  Created by 임건우 on 2018. 8. 22..
//  Copyright © 2018년 seob. All rights reserved.
//

import CoreLocation
import MapKit
import UIKit

class SubLocationMapViewController: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    private let SubLocationAnnotationID = "SubLocationAnnotationViewIdentifier"
    
    var subPensionData = Array<PensionList>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setRegion()
        addLocationAnnotations()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setRegion(){
        let center = CLLocationCoordinate2DMake(
            subPensionData[0].pensionLatitude,
            subPensionData[0].pensionLongitude
        )
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(center, span)
        mapView.setRegion(region, animated: true)
    }
    
    func addLocationAnnotations(){
        for i in 0...subPensionData.count - 1{
            let newLocation = LocationInfo()
            newLocation.title = subPensionData[i].pensionName
            newLocation.coordinate = CLLocationCoordinate2DMake(
                subPensionData[i].pensionLatitude,
                subPensionData[i].pensionLongitude
            )
            newLocation.pensionPk = subPensionData[i].pensionPk
            newLocation.pensionImageURL = subPensionData[i].pensionImage
            newLocation.pensionPrice = String(subPensionData[i].pensionLowestPrice)
            newLocation.pensionSubLocation = subPensionData[i].pensionSubLocation
            
            mapView.addAnnotation(newLocation)
        }
    }
}
extension SubLocationMapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is LocationInfo{
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: SubLocationAnnotationID)
            if annotationView == nil{
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: SubLocationAnnotationID)
            }
            else{
                annotationView?.annotation = annotation
            }
            
            annotationView?.image = UIImage(named: "icon_pin")
            annotationView?.frame.size = CGSize(width: 50, height: 50)
            
            annotationView?.canShowCallout = true
            
            return annotationView
        }
        return MKAnnotationView(frame: .zero)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let center = CLLocationCoordinate2D(
            latitude: (view.annotation?.coordinate.latitude)!,
            longitude: (view.annotation?.coordinate.longitude)!
        )
        let span = MKCoordinateSpan(
            latitudeDelta: mapView.region.span.latitudeDelta,
            longitudeDelta: mapView.region.span.longitudeDelta
        )
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        UIView.animateKeyframes(
            withDuration: 1.0,
            delay: 0.0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.5,
                    relativeDuration: 0.25,
                    animations: {
                        view.transform = view.transform.scaledBy(x: 1.5, y: 1.5)
                    }
                )
            },
            completion: { _ in
            
            })
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        UIView.animateKeyframes(
            withDuration: 0.5,
            delay: 0.0,
            options: [],
            animations: {
                UIView.addKeyframe(
                    withRelativeStartTime: 0.25,
                    relativeDuration: 0.5,
                    animations: {
                        view.transform = CGAffineTransform.identity
                })
                
        },
            completion: { _ in
                
        })
    }
}
