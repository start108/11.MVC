package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.purchase.impl.PurchaseServiceImpl;

@Controller
@RequestMapping("/purchase/*") 
public class PurchaseController {
	
	@Qualifier("purchaseServiceImpl")
	@Autowired
	private PurchaseService purchaseService;
	
	@Qualifier("productServiceImpl")
	@Autowired
	private ProductService productService;
	 
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	@RequestMapping( value="addPurchase")
	public String addPurchase(@ModelAttribute("purchase") Purchase purchase, @ModelAttribute("product") Product product,HttpSession session) throws Exception {
		
		System.out.println("purchase/addPurchase");
		System.out.println(purchase);
		User user = (User)session.getAttribute("user");
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		purchaseService.addPurchase(purchase);
	
		return "forward:/purchase/addPurchase.jsp";
	}
	
	
	@RequestMapping( value="addPurchaseView")
	public String addPurchaseView(@RequestParam("prodNo") int prodNo, Model model) throws Exception {
		
		System.out.println("purchase/addPurchaseView");
		
		Product product = productService.getProduct(prodNo);
		
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping( value="getPurchase")
	public String getPurchase(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		System.out.println("purchase/getPurchase");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
	
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping( value="updatePurchase" )
	public String updatePurchase(@ModelAttribute("purchase") Purchase purchase) throws Exception {
		
		System.out.println("purchase/updatePurchase");
		
		purchaseService.updatePurchase(purchase);
		
		return "redirect:purchase/getPurchase?tranNo="+purchase.getTranNo();
	}
	
	@RequestMapping( value="updatePurchaseView")
	public String updatePurchaseView(@RequestParam("tranNo") int tranNo, Model model) throws Exception {
		
		System.out.println("purchase/updatePurchaseView");
		Purchase purchase = purchaseService.getPurchase(tranNo);

		purchase.setDivyDate(purchase.getDivyDate().substring(0,10).replace("-", ""));
	
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping("/purchase/updateTranCodeListPurchase")
	public String updateTranCodeListPurchase(@RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode) throws Exception {
		
		System.out.println("updateTranCodeByTranNo");
		
		Purchase purchase = purchaseService.getPurchase(tranNo);
		
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
		
		return "redirect:/purchase/listPurchase";
		
	}
	
	@RequestMapping("/purchase/updateTranCodeListProduct")
	public String updateTranCodeListProduct(@RequestParam("tranNo") int tranNo, @RequestParam("tranCode") String tranCode) throws Exception{

		System.out.println("/updateTranCodeByProdNo");
		//Business Logic


		Purchase purchase = purchaseService.getPurchase(tranNo);
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
	
		return "redirect:/product/listProduct?menu=manage";
	}
	/*
	@RequestMapping( value="getPurchaseList" )
	public String listPurchase( @ModelAttribute("purchase") Purchase purchase, @ModelAttribute("search") Search search , @ModelAttribute("product") Product product, Model model ,HttpSession session ) throws Exception {
		
	System.out.println("purchase/getPurchaseList");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
	
		
		User user = (User)session.getAttribute("user");
		String userId = user.getUserId();
		System.out.println(user);
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		Map<String , Object> map = purchaseService.getPurchaseList(search, userId);//getPurchaseList(search, userId)
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/purchase/listPurchase.jsp";
	}
	*/
	
	
}