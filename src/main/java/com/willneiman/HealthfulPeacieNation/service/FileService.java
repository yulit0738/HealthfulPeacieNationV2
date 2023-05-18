package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.product.ProductForm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class FileService {

    @Value("${file.upload-dir}")
    private String uploadDir;

    public String storeFile(MultipartFile file) {
        if (file != null && !file.isEmpty()) {
            String originalFilename = file.getOriginalFilename();
            String fileExtension = getFileExtension(originalFilename);
            String uniqueFileName = generateUniqueFileName(fileExtension);

            Path path = Paths.get(uploadDir, uniqueFileName);
            // 디렉토리가 존재하는지 확인하고, 없다면 생성
            if (!Files.exists(path.getParent())) {
                try {
                    Files.createDirectories(path.getParent());
                } catch (IOException e) {
                    throw new RuntimeException("디렉토리 생성 실패: " + path.getParent(), e);
                }
            }

            try {
                file.transferTo(path);
                return "productImages/" + uniqueFileName;
            } catch (IOException e) {
                throw new RuntimeException("파일 저장 실패: " + uniqueFileName, e);
            }
        }
        // 기본 플레이스 홀더 이미지 반환
        return "productImages/No-Image-Placeholder.png";
    }

    private String getFileExtension(String filename) {
        int dotIndex = filename.lastIndexOf(".");
        if (dotIndex > 0 && dotIndex < filename.length() - 1) {
            return filename.substring(dotIndex + 1);
        }
        return "";
    }

    private String generateUniqueFileName(String fileExtension) {
        String uniqueFilename = UUID.randomUUID().toString();
        if (!fileExtension.isEmpty()) {
            uniqueFilename += "." + fileExtension;
        }
        return uniqueFilename;
    }

    public Map<String, String> processProductFiles(ProductForm form) {
        String thumbnailPath = storeFile(form.getThumbnail());
        String imagePath1 = storeFile(form.getImage1());
        String imagePath2 = storeFile(form.getImage2());

        Map<String, String> fileMap = new HashMap<>();
        fileMap.put("thumbnail", thumbnailPath);
        fileMap.put("image1", imagePath1);
        fileMap.put("image2", imagePath2);

        return fileMap;
    }
}