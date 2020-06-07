package com.model2.mvc.service.review.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.review.ReviewDao;
import com.model2.mvc.service.review.ReviewService;

@Service("reviewServiceImpl")
public class ReviewServiceImpl implements ReviewService{
	
	///Field
	@Autowired
	@Qualifier("reviewDaoImpl")
	private ReviewDao reviewDao;
	public void setReviewDao(ReviewDao reviewDao) {
		this.reviewDao = reviewDao;
	}
	
	///Constructor
	public ReviewServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addReview(Review review) throws Exception {
		reviewDao.insertReview(review);
	}
	
	public Map<String , Object > getReviewList(int prodNo) throws Exception {
		List<Review> list= reviewDao.getReviewList(prodNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		return map;
	}

}
