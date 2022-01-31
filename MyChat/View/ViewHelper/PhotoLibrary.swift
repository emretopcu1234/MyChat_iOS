//
//  PhotoLibrary.swift
//  MyChat
//
//  Created by Emre Topçu on 25.01.2022.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) private var presentationMode
    
    @Binding var selectedImage: UIImage
    @Binding var imageUrl : URL?
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        var parent: ImagePicker
     
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
     
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL {
                parent.imageUrl = imageUrl
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
}









//struct ImagePicker: UIViewControllerRepresentable {
//
//    @Environment(\.presentationMode)
//    private var presentationMode
//
//    let sourceType: UIImagePickerController.SourceType
//    let onImagePicked: (UIImage) -> Void
//
//    final class Coordinator: NSObject,
//                             UINavigationControllerDelegate,
//                             UIImagePickerControllerDelegate {
//
//        @Binding
//        private var presentationMode: PresentationMode
//        private let sourceType: UIImagePickerController.SourceType
//        private let onImagePicked: (UIImage) -> Void
//
//        init(presentationMode: Binding<PresentationMode>,
//             sourceType: UIImagePickerController.SourceType,
//             onImagePicked: @escaping (UIImage) -> Void) {
//            _presentationMode = presentationMode
//            self.sourceType = sourceType
//            self.onImagePicked = onImagePicked
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//            onImagePicked(uiImage)
//            presentationMode.dismiss()
//
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            presentationMode.dismiss()
//        }
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(presentationMode: presentationMode,
//                           sourceType: sourceType,
//                           onImagePicked: onImagePicked)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.sourceType = sourceType
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController,
//                                context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//}
