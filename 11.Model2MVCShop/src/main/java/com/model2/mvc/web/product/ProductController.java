package com.model2.mvc.web.product;

import java.util.Map;
import java.text.DecimalFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;

		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	
	@RequestMapping(value="addProductView")
	public String addProductView() throws Exception {

		System.out.println("product/addProductView");
		
		return "forward:/product/addProductView.jsp";
	}
	
	@RequestMapping(value="addProduct")
	public String addProduct( @ModelAttribute("product") Product product ) throws Exception {

		System.out.println("/product/addProduct: GET");
		//Business Logic
		
		String manuDate = product.getManuDate().replaceAll("-","");
		product.setManuDate(manuDate);
		productService.addProduct(product);
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="getProduct")
	public String getProduct( @RequestParam("prodNo") int prodNo , @RequestParam("menu") String menu, Model model) throws Exception {
		
		System.out.println("/product/getProduct: GET");
		//가격 csv하기~
		DecimalFormat formatter = new DecimalFormat("###,###");
		Product product = productService.getProduct(prodNo);
		int price = product.getPrice();
		String priceformat = formatter.format(price);
		
		System.out.println("pf///////"+priceformat);
		
		
		model.addAttribute("priceformat", priceformat);
		model.addAttribute("product", product);
		System.out.println("menu : "+menu);
		
		if (menu.equals("manage")) {
		
			return "forward:/product/updateProduct.jsp?menu=manage";
		}
			return "forward:/product/getProduct.jsp?menu=search";
	}
	
	@RequestMapping(value="getJsonProduct/{prodNo}")
	public void getJsonProduct(@PathVariable int prodNo, @ModelAttribute("product") Product product01, Model model ) throws Exception{
		
		System.out.println("/getJsonProduct/getProduct : GET");
		
		DecimalFormat formatter = new DecimalFormat("###,###");
		
		int price = product01.getPrice();
		String priceformat = formatter.format(price);
		System.out.println("pf///////"+priceformat);
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("priceformat", priceformat);
		model.addAttribute("product", product);
	}
	
	
	@RequestMapping(value="updateProduct")
	public String updateProduct( @ModelAttribute("product") Product product  ,Model model, HttpSession session) throws Exception{

		System.out.println("/product/updateProduct");
		//Business Logic
		
		productService.updateProduct(product);
	
		return "forward:/product/getProduct.jsp?menu=manage";
	}
	
	@RequestMapping(value="updateProductView")
	public String updateUserView( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/prdouct/updateProductView: GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/product/updateProduct.jsp";
	}
	
	
	
	@RequestMapping(value="listProduct")
	public String listUser( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct: GET/ POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model and View 
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		return "forward:/product/listProduct.jsp";
	}
	
	@RequestMapping(value="postProudct")
	public String postProduct() throws Exception{
		return "forward:/product/postProduct.jsp";
	}
}