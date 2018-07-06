package com.model2.mvc.web.reply;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.service.cart.CartService;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Reply;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.reply.ReplyService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/reply/*")
public class ReplyRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	@Autowired
	@Qualifier("replyServiceImpl")
	private ReplyService replyService;
	
	
	//setter Method 구현 않음
	public ReplyRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="json/addReply", method=RequestMethod.POST)
	public ResponseEntity<String> AddProduct ( @RequestBody Reply reply ) throws Exception{
		
		ResponseEntity<String> entity = null;
		System.out.println("reply/json/AddReply/ : POST");
		try {
			replyService.addReply(reply);
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	//댓글 리스트 뽑아오기!
	@RequestMapping( value="json/getReplyList/{noticeNo}", method = RequestMethod.GET)
	  public ResponseEntity<List<Reply>> getReplyList(@PathVariable("noticeNo") int noticeNo) {
	    ResponseEntity<List<Reply>> entity = null;
	    try {
	        entity = new ResponseEntity<>(replyService.getReplyList(noticeNo), HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	}
	
	//댓글 수정 처리 메서드 작성
	@RequestMapping(value = "json/updateReply/{replyNo}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	public ResponseEntity<String> updateReply(@PathVariable("replyNo") int replyNo, @RequestBody Reply reply) {
	    ResponseEntity<String> entity = null;
	    try {
	        reply.setReplyNo(replyNo);
	        replyService.updateReply(reply);
	        entity = new ResponseEntity<>("modSuccess", HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	}
	
	//댓글 삭제 처리 메서드 작성
	@RequestMapping(value = "json/deleteReply/{replyNo}", method = RequestMethod.DELETE)
	public ResponseEntity<String> deleteReply(@PathVariable("replyNo") int replyNo) {
	    ResponseEntity<String> entity = null;
	    try {
	        replyService.deleteReply(replyNo);
	        entity = new ResponseEntity<>("deleteSuccess", HttpStatus.OK);
	    } catch (Exception e) {
	        e.printStackTrace();
	        entity = new ResponseEntity<>(e.getMessage(), HttpStatus.BAD_REQUEST);
	    }
	    return entity;
	}
	
}