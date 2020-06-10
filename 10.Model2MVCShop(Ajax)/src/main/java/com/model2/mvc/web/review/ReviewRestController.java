package com.model2.mvc.web.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.review.ReviewService;

@RestController
@RequestMapping("/review/*")
public class ReviewRestController {
		
	//Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private ProductService prodService;
	//@Autowired
	//private UserService userService;
	
	//Constructor
	public ReviewRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="json/getReview/{reviewNo}", method=RequestMethod.GET )
	public Review getReview(@PathVariable("reviewNo") int reviewNo) throws Exception {

		System.out.println("/review/json/getReview : GET");
		
//		Product prod = prodService.getProduct(prodNo);
//		
//		Map map = new HashMap();
//		map.put("product", prod);
		
		return reviewService.getReview(reviewNo);
	}

}
