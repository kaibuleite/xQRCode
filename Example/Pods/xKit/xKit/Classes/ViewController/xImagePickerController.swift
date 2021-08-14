//
//  xImagePickerController.swift
//  xSDK
//
//  Created by Mac on 2020/9/17.
//

import UIKit

public class xImagePickerController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: - Handler
    /// 选取照片回调
    public typealias xHandlerChoosePhoto = (UIImage) -> Void
    
    // MARK: - Private Property
    /// 回调
    private var chooseHandler : xHandlerChoosePhoto?
    
    // MARK: - 内存释放
    deinit {
        self.chooseHandler = nil
        self.delegate = nil
        print("💥 照片库")
    }
    
    // MARK: - Public Override Func
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    // MARK: - Public Func
    /// 开启相册(默认无法编辑图片)
    public func displayAlbum(from viewController : UIViewController,
                             choose handler : @escaping xHandlerChoosePhoto)
    {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            print("⚠️ 相册数据源不可用")
            return
        }
        self.sourceType = .photoLibrary
        self.chooseHandler = handler
        viewController.present(self, animated: true, completion: nil)
    }
    
    /// 开启相机(默认无法编辑图片)
    public func displayCamera(from viewController : UIViewController,
                              choose handler : @escaping xHandlerChoosePhoto)
    {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("⚠️ 相机数据源不可用")
            return
        }
        self.sourceType = .camera
        self.chooseHandler = handler
        viewController.present(self, animated: true, completion: nil)
    }

    // MARK: - UIImagePickerControllerDelegate
    /// 获取图片
    public func imagePickerController(_ picker: UIImagePickerController,
                                      didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        var type = UIImagePickerController.InfoKey.originalImage
        if picker.allowsEditing == true {
            type = .editedImage
        }
        guard let img = info[type] as? UIImage else {
            self.failure(picker)
            return
        }
        // 图片方向
        print("图片原始方向 = \(img.imageOrientation.rawValue)")
        picker.dismiss(animated: true) {
            self.chooseHandler?(img)
        }
    }
    /// 取消
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        print("⚠️ 用户取消选择")
        self.failure(picker)
    }
    /// 失败
    func failure(_ picker: UIImagePickerController)
    {
        print("⚠️ 获取图片失败")
        picker.dismiss(animated: true, completion: nil)
    }
}
