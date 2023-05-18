package com.willneiman.HealthfulPeacieNation.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.io.IOException;
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
}