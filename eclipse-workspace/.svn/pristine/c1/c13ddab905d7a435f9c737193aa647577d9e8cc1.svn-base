package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import dto.OrdersDTO;

public class OrdersDAO extends JdbcDAO {
	private static OrdersDAO _dao;
	
	private OrdersDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new OrdersDAO();
	}
	
	public static OrdersDAO getDAO() {
		return _dao;
	}

	//메소드 추가 (08/07)
	//페이징 처리목적 - 전체 주문 개수 반환
	public int totalOrders(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rows=0;
		
		try {
			con = getConnection();
			String sql = "select count(*) from orders where id=? and o_state<>0";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
	
			if(rs.next()) {
				rows = rs.getInt(1);
			}
			
			
		} catch (SQLException e) {
			System.out.println("[에러] totalOrders() 메소드에서 오류 발생 ");
		} finally {
			close(con, pstmt, rs);
		}
		
		return rows;
	}
	
	//메소드 추가 (08/07)
	//페이징 처리목적 - 각 페이지마다 startRow ~ endRow 번째 검색 행 출력
	public List<OrdersDTO> selectOrder_list(String id, int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrdersDTO> OrderList = new ArrayList<OrdersDTO>();
		try {
			con = getConnection();
			String sql = "select * from (select rownum rn, temp.* from (select * from orders where id=? and o_state<>0 order by o_no desc) temp) where rn between ? and ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrdersDTO orders = new OrdersDTO();
				orders.setoNo(rs.getInt("o_no"));
				orders.setId(rs.getString("id"));
				orders.setpNo(rs.getInt("p_no"));
				orders.setcLettering(rs.getString("c_lettering"));
				orders.setoZipcode(rs.getString("o_zipcode"));
				orders.setoAddress1(rs.getString("o_address1"));
				orders.setoAddress2(rs.getString("o_address2"));
				orders.setoDate(rs.getString("o_date").substring(0,10));
				orders.setoState(rs.getInt("o_state"));
				OrderList.add(orders);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectOrder_list() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return OrderList;
	}
	
	//메소드 수정 (08/07)
	//전체 주문목록 반환시 주문 취소(o_state=0)목록도 출력되어 sql문 수정
	public List<OrdersDTO> selectAllOrders(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrdersDTO> orderList = new ArrayList<OrdersDTO>();
		
		try {
			con = getConnection();
			String sql = "select * from orders where id=? and o_state<>0 order by o_no desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersDTO orders = new OrdersDTO();
				orders.setoNo(rs.getInt("o_no"));
				orders.setId(rs.getString("id"));
				orders.setpNo(rs.getInt("p_no"));
				orders.setcLettering(rs.getString("c_lettering"));
				orders.setoZipcode(rs.getString("o_zipcode"));
				orders.setoAddress1(rs.getString("o_address1"));
				orders.setoAddress2(rs.getString("o_address2"));
				orders.setoDate(rs.getString("o_date").substring(0,10));
				orders.setoState(rs.getInt("o_state"));
				orderList.add(orders);
			}
			
			
		} catch (SQLException e) {
			System.out.println("[에러] selectAllOrders() 메소드에서 오류 발생 ");
		} finally {
			close(con, pstmt, rs);
		}
		
		return orderList;
		
	}
	
	public List<OrdersDTO> selectOrderNo(int oNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<OrdersDTO> orderList = new ArrayList<OrdersDTO>();
		
		try {
			con = getConnection();
			String sql = "select * from orders where o_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, oNo);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersDTO orders = new OrdersDTO();
				orders.setoNo(rs.getInt("o_no"));
				orders.setId(rs.getString("id"));
				orders.setpNo(rs.getInt("p_no"));
				orders.setcLettering(rs.getString("c_lettering"));
				orders.setoZipcode(rs.getString("o_zipcode"));
				orders.setoAddress1(rs.getString("o_address1"));
				orders.setoAddress2(rs.getString("o_address2"));
				orders.setoDate(rs.getString("o_date").substring(0,10));
				orders.setoState(rs.getInt("o_state"));
				orderList.add(orders);
			}
			
			
		} catch (SQLException e) {
			System.out.println("[에러] selectOrderNo() 메소드에서 오류 발생 ");
		} finally {
			close(con, pstmt, rs);
		}
		
		return orderList;
		
	}
	
	//메소드 추가 (08/05)
	//주문번호를 전달받아 ORDERS 테이블에 저장된 주문정보를 검색하여 반환하는 메소드 - 단일행 검색
	public OrdersDTO selectOrderNoRow(int oNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		OrdersDTO orders=null;
		try {
			con=getConnection();
			
			String sql="select * from orders where o_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, oNo);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				orders = new OrdersDTO();
				orders.setoNo(rs.getInt("o_no"));
				orders.setId(rs.getString("id"));
				orders.setpNo(rs.getInt("p_no"));
				orders.setcLettering(rs.getString("c_lettering"));
				orders.setoZipcode(rs.getString("o_zipcode"));
				orders.setoAddress1(rs.getString("o_address1"));
				orders.setoAddress2(rs.getString("o_address2"));
				orders.setoDate(rs.getString("o_date").substring(0,10));
				orders.setoState(rs.getInt("o_state"));
			}		
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderNoRow() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orders;
	}
	
	//메소드 추가 (08/06)
	//오늘 들어온 주문 개수 반환 메소드
	// => 취소 처리된 주문은 제외
	public int selectTodayOrderCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();

			String sql="select * from orders where o_date>=to_char(sysdate,'YYYYMMDD') and o_state!=0  order by o_no";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				count++;
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectTodayOrderCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			 close(con, pstmt, rs);
		}
		
		return count;
	}
	
	//메소드 추가 (08/06)
	//ORDERS 테이블에 저장된 오늘 들어온 주문정보를 검색하여 반환하는 메소드
	// => 취소 처리된 주문은 제외
	// => 최신순으로 정렬 - 주문번호 내림차순 정렬
	public List<OrdersDTO> selectTodayOrderList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrdersDTO> orderList = new ArrayList<OrdersDTO>();
		try {

			con=getConnection();
			String sql="select * from orders where o_date>=to_char(sysdate,'YYYYMMDD') and o_state!=0 order by o_no desc";
			pstmt=con.prepareStatement(sql);		
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersDTO order = new OrdersDTO();
				order.setoNo(rs.getInt("o_no"));
				order.setId(rs.getString("id"));
				order.setpNo(rs.getInt("p_no"));
				order.setcLettering(rs.getString("c_lettering"));
				order.setoZipcode(rs.getString("o_zipcode"));
				order.setoAddress1(rs.getString("o_address1"));
				order.setoAddress2(rs.getString("o_address2"));
				order.setoDate(rs.getString("o_date"));
				order.setoState(rs.getInt("o_state"));
				orderList.add(order);
			}
					
		} catch (SQLException e) {
			System.out.println("[에러]selectTodayOrderList() 메소드의 SQL 오류 = "+e.getMessage());
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
	
	//메소드 추가 (08/06)
	//ORDERS 테이블에 저장된 사용자의 오늘 주문한 정보를 검색하여 반환하는 메소드
	public List<OrdersDTO> selectTodayOrders(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrdersDTO> orderList = new ArrayList<OrdersDTO>();
		try {

			con=getConnection();
			String sql="select * from orders where id=? and to_char(o_date) =?";
			pstmt=con.prepareStatement(sql);
			
			String date = new SimpleDateFormat("yy/MM/dd").format(new Date());
			//System.out.println("date : "+date);

			pstmt.setString(1, id);
			pstmt.setString(2, date);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersDTO order = new OrdersDTO();
				order.setoNo(rs.getInt("o_no"));
				order.setId(rs.getString("id"));
				order.setpNo(rs.getInt("p_no"));
				order.setcLettering(rs.getString("c_lettering"));
				order.setoZipcode(rs.getString("o_zipcode"));
				order.setoAddress1(rs.getString("o_address1"));
				order.setoAddress2(rs.getString("o_address2"));
				order.setoDate(rs.getString("o_date"));
				order.setoState(rs.getInt("o_state"));
				orderList.add(order);
			}
					
		} catch (SQLException e) {
			System.out.println("[에러]selectTodayOrders() 메소드의 SQL 오류 = "+e.getMessage());
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
	
	public int insertOrders(List<OrdersDTO> orderList) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows=0;
		
		try {
			con = getConnection();
			
			for(OrdersDTO orders : orderList) {
				String sql ="insert into orders values(order_seq.nextval,?,?,?,?,?,?,sysdate,1)";
				OrdersDTO order = new OrdersDTO();
				
				order.setId(orders.getId());
				order.setpNo(orders.getpNo());
				order.setcLettering(orders.getcLettering());
				order.setoZipcode(orders.getoZipcode());
				order.setoAddress1(orders.getoAddress1());
				order.setoAddress2(orders.getoAddress2());
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, order.getId());
				pstmt.setInt(2, order.getpNo());
				pstmt.setString(3, order.getcLettering());
				pstmt.setString(4, order.getoZipcode());
				pstmt.setString(5, order.getoAddress1());
				pstmt.setString(6, order.getoAddress2());
				rows = pstmt.executeUpdate();
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] insertOrder() 메소드에서 오류 발생 : "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	public int updateOrder(OrdersDTO orders) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows=0;
		
		try {
			con = getConnection();
			String sql ="update orders set c_lettering=?, o_zipcode=?, o_address1=?, o_address2=?, o_state=? where o_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, orders.getcLettering());
			pstmt.setString(2, orders.getoZipcode());
			pstmt.setString(3, orders.getoAddress1());
			pstmt.setString(4, orders.getoAddress2());
			pstmt.setInt(5, orders.getoState());
			pstmt.setInt(6, orders.getoNo());
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] updateOrder() 메소드에서 오류 발생 ");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	
	
	public int deleteOrder(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows=0;
		
		try {
			con = getConnection();
			String sql ="delete orders where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] deleteOrder() 메소드에서 오류 발생 ");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//메소드 추가 (08/06)
	//제품번호를 전달받아 ORDERS 테이블에 저장된 주문정보를 검색하여 해당 주문정보의 상태를 주문취소로 변경하는 메소드 - 단일행 변경
	public int updateOrderState(int oNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows=0;
		
		try {
			con = getConnection();
			String sql ="update orders set o_state=0 where o_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, oNo);
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] updateOrderState() 메소드에서 오류 발생 ");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//메소드 추가(08/10)
	//ORDERS 테이블의 행의 개수를 반환하는 메소드 - 페이징
	public int totalOrderCount(String searchUser, String searchProduct) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rows=0;
		
		try {
			con = getConnection();
			if(!searchUser.equals("")){//아이디 값이 null이 아닐 경우 - 아이디 검색
				String sql="select count(*) from orders where id=? and o_state!=0 order by o_date desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchUser);
			} else if(!searchProduct.equals("")){//제품번호 값이 null이 아닐 경우 - 제품번호 검색
				String sql="select count(*) from orders where p_no=? and o_state!=0 order by o_date desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchProduct);
			} else { //아이디, 제품번호가 null일 경우 - 전체 반환
				String sql="select count(*) from orders where o_state!=0 order by o_date desc";
				pstmt=con.prepareStatement(sql);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				rows=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] totalOrderCount() 메소드에서 오류 발생 ");
		} finally {
			close(con, pstmt, rs);
		}
		
		return rows;
	}
	
	
	//메소드 추가 (08/05)
	//아이디, 제품번호를 전달받아 ORDERS 테이블에 저장된 주문정보를 검색하여 반환하는 메소드
	// => 아이디, 제품번호 미입력 시 전체 주문정보 반환
	// => 주문 상태가 주문취소(0)인 경우 미검색
	//메소드 수정(08/10)
	// => 페이징 기능을 위한 startRow, endRow 추가
	public List<OrdersDTO> selectOrderList(String searchUser, String searchProduct, int startRow, int endRow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrdersDTO> orderList=new ArrayList<OrdersDTO>();
		try {
			con=getConnection();
			
			if(!searchUser.equals("")){//아이디 값이 null이 아닐 경우 - 아이디 검색
				String sql="select * from (select rownum rn, temp.* from (select * from orders where id=? and o_state!=0 order by o_date desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchUser);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else if(!searchProduct.equals("")){//제품번호 값이 null이 아닐 경우 - 제품번호 검색
				String sql="select * from (select rownum rn, temp.* from (select * from orders where p_no=? and o_state!=0 order by o_date desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchProduct);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else { //아이디, 제품번호가 null일 경우 - 전체 반환
				String sql="select * from (select rownum rn, temp.* from (select * from orders where o_state!=0 order by o_date desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			}
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				OrdersDTO orders = new OrdersDTO();
				orders.setoNo(rs.getInt("o_no"));
				orders.setId(rs.getString("id"));
				orders.setpNo(rs.getInt("p_no"));
				orders.setcLettering(rs.getString("c_lettering"));
				orders.setoZipcode(rs.getString("o_zipcode"));
				orders.setoAddress1(rs.getString("o_address1"));
				orders.setoAddress2(rs.getString("o_address2"));
				orders.setoDate(rs.getString("o_date").substring(0,10));
				orders.setoState(rs.getInt("o_state"));
				
				orderList.add(orders);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectOrderList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
}
