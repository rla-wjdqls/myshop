package kr.co.itwill.order;

public class OrderDTO {

	private String orderno;      
	private String id;          
	private int totalamount;                         
	private String payment;   
	private String deliverynm;  
	private String deliveryaddr;
	private String deliverymsg;  
	private String ordercheck;  
	private String orderdate;
	
	
	
	public OrderDTO() {}



	public String getOrderno() {
		return orderno;
	}



	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}



	public String getId() {
		return id;
	}



	public void setId(String id) {
		this.id = id;
	}



	public int getTotalamount() {
		return totalamount;
	}



	public void setTotalamount(int totalamount) {
		this.totalamount = totalamount;
	}



	public String getPayment() {
		return payment;
	}



	public void setPayment(String payment) {
		this.payment = payment;
	}



	public String getDeliverynm() {
		return deliverynm;
	}



	public void setDeliverynm(String deliverynm) {
		this.deliverynm = deliverynm;
	}



	public String getDeliveryaddr() {
		return deliveryaddr;
	}



	public void setDeliveryaddr(String deliveryaddr) {
		this.deliveryaddr = deliveryaddr;
	}



	public String getDeliverymsg() {
		return deliverymsg;
	}



	public void setDeliverymsg(String deliverymsg) {
		this.deliverymsg = deliverymsg;
	}



	public String getOrdercheck() {
		return ordercheck;
	}



	public void setOrdercheck(String ordercheck) {
		this.ordercheck = ordercheck;
	}



	public String getOrderdate() {
		return orderdate;
	}



	public void setOrderdate(String orderdate) {
		this.orderdate = orderdate;
	}



	@Override
	public String toString() {
		return "OrderDTO [orderno=" + orderno + ", id=" + id + ", totalamount=" + totalamount + ", payment=" + payment
				+ ", deliverynm=" + deliverynm + ", deliveryaddr=" + deliveryaddr + ", deliverymsg=" + deliverymsg
				+ ", ordercheck=" + ordercheck + ", orderdate=" + orderdate + "]";
	}         
	
	
	
	
	
	
	
	
	
	
	
	
}//class end
