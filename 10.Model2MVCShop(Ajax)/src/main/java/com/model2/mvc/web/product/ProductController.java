package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;

@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	//Filed
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService prodService;
	
	//Constructor
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addProduct")
	public String addProduct(@ModelAttribute("prod") Product prod, MultipartHttpServletRequest request) throws Exception {

		System.out.println("/product/addProduct : GET / POST");
		
		Map<String, MultipartFile> files = request.getFileMap();
		CommonsMultipartFile cmf = (CommonsMultipartFile) files.get("file");
		
		if (cmf.getSize()!=0) {
			
			//String path ="C:/Users/user/git/repository/07MiniProject/07.Model2MVCShop(URI,pattern)/WebContent/images/uploadFiles/"+cmf.getOriginalFilename();
			String path ="C:/Users/home/git/10MVC2Project/10.Model2MVCShop(Ajax)/WebContent/images/uploadFiles"+cmf.getOriginalFilename();
			
			prod.setFileName(cmf.getOriginalFilename());
		    	
	    	File f = new File(path);
	    	cmf.transferTo(f);
		}
		
		prod.setManuDate(prod.getManuDate().replace("-", ""));
		
		prodService.addProduct(prod);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET )
	public String getProduct(@RequestParam("prodNo") int prodNo, @RequestParam("menu") String menu, Model model) throws Exception {

		System.out.println("/product/getProduct : GET");
		
		Product prod = prodService.getProduct(prodNo);
		
		
		model.addAttribute("prod", prod);
//		User user = (User)session.getAttribute("user");
//		
//		if (user!=null) {
//			String userId = ((User)session.getAttribute("user")).getUserId();
//			
//			if(userId.equals(user.getUserId())){
//				user.setUserId(userId);
//				//session.setAttribute("user", user); 
//			}
//
//		}
		
		if (menu.contentEquals("manage")) {
			return "forward:/product/updateProductView.jsp";
		} else {
			return "forward:/product/getProduct.jsp";
		}
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST )
	public String updateProduct(@ModelAttribute("prod") Product prod) throws Exception {
		
		System.out.println("/product/updateProduct : POST");
		
		prod.setManuDate(prod.getManuDate().replace("-", ""));
		prodService.updateProduct(prod);
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model) throws Exception{
		
		System.out.println("/product/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		
		// Business logic 수행
		Map<String , Object> map=prodService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("search", search);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		
		
		return "forward:/product/listProduct.jsp";
	}
}
