package com.willneiman.HealthfulPeacieNation.service;

import com.willneiman.HealthfulPeacieNation.entity.product.Product;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class RatingService {

    public Map<String, Object> calculateRating(Product product) {
        Map<String, Object> ratingData = new HashMap<>();

        double rating = Math.round(product.getRating() * 2) / 2.0;
        int fullStarCount = (int) rating;
        boolean hasHalfStar = (rating - fullStarCount) >= 0.5;
        int emptyStarCount = 5 - fullStarCount - (hasHalfStar ? 1 : 0);

        ratingData.put("fullStarCount", fullStarCount);
        ratingData.put("hasHalfStar", hasHalfStar);
        ratingData.put("emptyStarCount", emptyStarCount);

        return ratingData;
    }
}
