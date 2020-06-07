package com.model2.mvc.web.review;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.Review;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.review.ReviewService;
import com.model2.mvc.service.user.UserService;

@Controller
@RequestMapping("/review/*")
public class ReviewController {
	
	//Field
	@Autowired
	@Qualifier("reviewServiceImpl")
	private ReviewService reviewService;
	@Autowired
	private PurchaseService purchaseService;
	@Autowired
	private ProductService prodService;
	@Autowired
	private UserService userService;
	
	//Constructor
	public ReviewController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="addReview", method = RequestMethod.GET)
	public ModelAndView addReview(@RequestParam("tranNo") int tranNo, HttpSession session) throws Exception {
		
		System.out.println("/review/addReview : GET");
		
		User user = (User)session.getAttribute("user");
		session.setAttribute("user", user);
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/review/addReviewView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping(value="addReview", method = RequestMethod.POST)
	public ModelAndView addReview(Review review, Product prod, Purchase purchase, User user) throws Exception {
		
		System.out.println("/review/addReview : POST");
		
		review.setReviewBuyer(user);
		purchase.setTranCode("4");
		review.setReviewTran(purchase);
		review.setReviewProd(prod);
		reviewService.addReview(review);
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listPurchase");
		modelAndView.addObject("review",review);
		
		return modelAndView;
	}
	
	@RequestMapping(value="listReview", method = RequestMethod.GET)
	public ModelAndView listReview(Search search , @RequestParam("prodNo") int prodNo) throws Exception {
		
		System.out.println("/review/listReview : GET");
		
		// Business logic ����
		Map<String , Object> map=reviewService.getReviewList(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/review/listReview.jsp");
		modelAndView.addObject("list", map.get("list"));
		
		return modelAndView;
	}
}
