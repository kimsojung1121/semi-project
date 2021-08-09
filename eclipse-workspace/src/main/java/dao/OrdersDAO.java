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

	//�޼ҵ� �߰� (08/07)
	//����¡ ó������ - ��ü �ֹ� ���� ��ȯ
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
			System.out.println("[����] totalOrders() �޼ҵ忡�� ���� �߻� ");
		} finally {
			close(con, pstmt, rs);
		}
		
		return rows;
	}
	
	//�޼ҵ� �߰� (08/07)
	//����¡ ó������ - �� ���������� startRow ~ endRow ��° �˻� �� ���
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
			System.out.println("[����]selectOrder_list() �޼ҵ��� SQL ���� = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return OrderList;
	}
	
	//�޼ҵ� ���� (08/07)
	//��ü �ֹ���� ��ȯ�� �ֹ� ���(o_state=0)��ϵ� ��µǾ� sql�� ����
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
			System.out.println("[����] selectAllOrders() �޼ҵ忡�� ���� �߻� ");
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
			System.out.println("[����] selectOrderNo() �޼ҵ忡�� ���� �߻� ");
		} finally {
			close(con, pstmt, rs);
		}
		
		return orderList;
		
	}
	
	//�޼ҵ� �߰� (08/05)
	//�ֹ���ȣ�� ���޹޾� ORDERS ���̺� ����� �ֹ������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ� - ������ �˻�
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
			System.out.println("[����]selectOrderNoRow() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orders;
	}
	
	//�޼ҵ� �߰� (08/06)
	//���� ���� �ֹ� ���� ��ȯ �޼ҵ�
	// => ��� ó���� �ֹ��� ����
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
			System.out.println("[����]selectTodayOrderCount() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			 close(con, pstmt, rs);
		}
		
		return count;
	}
	
	//�޼ҵ� �߰� (08/06)
	//ORDERS ���̺� ����� ���� ���� �ֹ������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	// => ��� ó���� �ֹ��� ����
	// => �ֽż����� ���� - �ֹ���ȣ �������� ����
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
			System.out.println("[����]selectTodayOrderList() �޼ҵ��� SQL ���� = "+e.getMessage());
			e.printStackTrace();
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
	
	//�޼ҵ� �߰� (08/06)
	//ORDERS ���̺� ����� ������� ���� �ֹ��� ������ �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
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
			System.out.println("[����]selectTodayOrders() �޼ҵ��� SQL ���� = "+e.getMessage());
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
			System.out.println("[����] insertOrder() �޼ҵ忡�� ���� �߻� : "+e.getMessage());
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
			System.out.println("[����] updateOrder() �޼ҵ忡�� ���� �߻� ");
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
			System.out.println("[����] deleteOrder() �޼ҵ忡�� ���� �߻� ");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//�޼ҵ� �߰� (08/06)
	//��ǰ��ȣ�� ���޹޾� ORDERS ���̺� ����� �ֹ������� �˻��Ͽ� �ش� �ֹ������� ���¸� �ֹ���ҷ� �����ϴ� �޼ҵ� - ������ ����
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
			System.out.println("[����] updateOrderState() �޼ҵ忡�� ���� �߻� ");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	//�޼ҵ� �߰�(08/10)
	//ORDERS ���̺��� ���� ������ ��ȯ�ϴ� �޼ҵ� - ����¡
	public int totalOrderCount(String searchUser, String searchProduct) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int rows=0;
		
		try {
			con = getConnection();
			if(!searchUser.equals("")){//���̵� ���� null�� �ƴ� ��� - ���̵� �˻�
				String sql="select count(*) from orders where id=? and o_state!=0 order by o_date desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchUser);
			} else if(!searchProduct.equals("")){//��ǰ��ȣ ���� null�� �ƴ� ��� - ��ǰ��ȣ �˻�
				String sql="select count(*) from orders where p_no=? and o_state!=0 order by o_date desc";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchProduct);
			} else { //���̵�, ��ǰ��ȣ�� null�� ��� - ��ü ��ȯ
				String sql="select count(*) from orders where o_state!=0 order by o_date desc";
				pstmt=con.prepareStatement(sql);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				rows=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[����] totalOrderCount() �޼ҵ忡�� ���� �߻� ");
		} finally {
			close(con, pstmt, rs);
		}
		
		return rows;
	}
	
	
	//�޼ҵ� �߰� (08/05)
	//���̵�, ��ǰ��ȣ�� ���޹޾� ORDERS ���̺� ����� �ֹ������� �˻��Ͽ� ��ȯ�ϴ� �޼ҵ�
	// => ���̵�, ��ǰ��ȣ ���Է� �� ��ü �ֹ����� ��ȯ
	// => �ֹ� ���°� �ֹ����(0)�� ��� �̰˻�
	//�޼ҵ� ����(08/10)
	// => ����¡ ����� ���� startRow, endRow �߰�
	public List<OrdersDTO> selectOrderList(String searchUser, String searchProduct, int startRow, int endRow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<OrdersDTO> orderList=new ArrayList<OrdersDTO>();
		try {
			con=getConnection();
			
			if(!searchUser.equals("")){//���̵� ���� null�� �ƴ� ��� - ���̵� �˻�
				String sql="select * from (select rownum rn, temp.* from (select * from orders where id=? and o_state!=0 order by o_date desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchUser);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else if(!searchProduct.equals("")){//��ǰ��ȣ ���� null�� �ƴ� ��� - ��ǰ��ȣ �˻�
				String sql="select * from (select rownum rn, temp.* from (select * from orders where p_no=? and o_state!=0 order by o_date desc) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, searchProduct);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			} else { //���̵�, ��ǰ��ȣ�� null�� ��� - ��ü ��ȯ
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
			System.out.println("[����]selectOrderList() �޼ҵ��� SQL ���� = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return orderList;
	}
}
