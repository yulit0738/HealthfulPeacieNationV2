package com.willneiman.HealthfulPeacieNation.service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.willneiman.HealthfulPeacieNation.model.ProductImageInfo;
import com.willneiman.HealthfulPeacieNation.model.entity.product.NewProductForm;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class FileService {

    @Value("${file.upload-dir}")
    private String uploadDir;

    // 객체생성 비용은 비싸고 이렇게 static 으로 만들어 두지 않으면 파일 저장해서 할떄마다 매번 생성하므로 미리 만들어두고 재활용함
    private static final ObjectMapper objectMapper = new ObjectMapper();

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
                    //TODO chekced exception 이랑 unchecked exception 에 대해 찾아보면 좋을듯 ApplicationException 정도가 적당
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
        return "images/No-Image-Placeholder.png";
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

    public ProductImageInfo processProductFiles(NewProductForm form) {
        String thumbnailPath = storeFile(form.getThumbnail());
        String imagePath1 = storeFile(form.getImage1());
        String imagePath2 = storeFile(form.getImage2());


        // 굳이 이렇게 안해도 되지만 ObjectMapper가 하는일이 뭔지 찍먹하라고 해둠
        Map<String, String> fileMap = new HashMap<>();
        fileMap.put("thumbnail", thumbnailPath);
        fileMap.put("imagePath1", imagePath1);
        fileMap.put("imagePath2", imagePath2);

        return objectMapper.convertValue(fileMap, ProductImageInfo.class);
    }
}