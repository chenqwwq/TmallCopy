package chen.util;

import org.springframework.web.multipart.MultipartFile;

/**
 * tmallCopy
 * Create by chen on 17-11-3
 */
public class UploadedImageFile {
    MultipartFile image;

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }
}
