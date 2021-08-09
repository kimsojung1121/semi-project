package dto;

public class OrdersDTO {
	private int oNo;			//주문 번호
	private String id;			//회원 아이디
	private int pNo;			//주문상품 번호
	private String cLettering;	//레터링 문구
	private String oZipcode;	//우편 번호
	private String oAddress1;	//기본 주소
	private String oAddress2;	//상세 주소
	private String oDate;		//주문 날짜
	private int oState;			//배송상태 1:주문확인(기본값)/2:배송준비/3:배송중/4:완료 (관리자 수동변경)
	
	public OrdersDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getoNo() {
		return oNo;
	}

	public void setoNo(int oNo) {
		this.oNo = oNo;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getpNo() {
		return pNo;
	}

	public void setpNo(int pNo) {
		this.pNo = pNo;
	}

	public String getcLettering() {
		return cLettering;
	}

	public void setcLettering(String cLettering) {
		this.cLettering = cLettering;
	}

	public String getoZipcode() {
		return oZipcode;
	}

	public void setoZipcode(String oZipcode) {
		this.oZipcode = oZipcode;
	}

	public String getoAddress1() {
		return oAddress1;
	}

	public void setoAddress1(String oAddress1) {
		this.oAddress1 = oAddress1;
	}

	public String getoAddress2() {
		return oAddress2;
	}

	public void setoAddress2(String oAddress2) {
		this.oAddress2 = oAddress2;
	}

	public String getoDate() {
		return oDate;
	}

	public void setoDate(String oDate) {
		this.oDate = oDate;
	}

	public int getoState() {
		return oState;
	}

	public void setoState(int oState) {
		this.oState = oState;
	}
	
	
}
