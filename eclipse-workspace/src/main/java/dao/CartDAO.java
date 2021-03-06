package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.CartDTO;

public class CartDAO extends JdbcDAO {

	public static CartDAO _dao;

	private CartDAO() {
			// TODO Auto-generated constructor stub
		}

	static {
		_dao = new CartDAO();
	}

	public static CartDAO getDAO() {
		return _dao;
	}
	
		public int insertCart(CartDTO cart) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into cart values(cart_seq.nextval,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, cart.getId());
				pstmt.setInt(2, cart.getpNo());
				pstmt.setString(3, cart.getcLettering());

				
				
				rows=pstmt.executeUpdate();
			} catch (Exception e) {
				System.out.println("[에러]insertCart() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			} 
			return rows; 
		}
		
		public int deleteCart(int cNo) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows=0;
			try {
				con=getConnection();
				String sql = "delete cart where c_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, cNo);
				rows = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러] deleteCart() 메소드 실행중 에러발생");
			} finally {
				close(con, pstmt);
			}
			
			return rows;
		}
		
		public List<CartDTO> selectAllCart(String id) {
		      Connection con = null;
		      PreparedStatement pstmt = null;
		      ResultSet rs = null;
		      List<CartDTO> cartList = new ArrayList<CartDTO>();
		      try {
		         con = getConnection();
		         String sql = "select * from cart where id=?";
		         pstmt = con.prepareStatement(sql);
		         pstmt.setString(1, id);
		         rs = pstmt.executeQuery();
		         
		         while(rs.next()) {
		            CartDTO cart = new CartDTO();
		            cart.setcNo(rs.getInt("c_no"));
		            cart.setId(rs.getString("id"));
		            cart.setpNo(rs.getInt("p_no"));
		            cart.setcLettering(rs.getString("c_lettering"));
		            cartList.add(cart);
		         }
		         
		      } catch (SQLException e) {
		         System.out.println("[에러] selectAllCart() 메소드 실행중 에러발생");
		      } finally {
		         close(con, pstmt, rs);
		      }
		      
		      return cartList;
		      
		   }
		
		public int deleteUserCart(String id) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows=0;
			try {
				con=getConnection();
				String sql = "delete cart where id=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				rows = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러] deleteCart() 메소드 실행중 에러발생");
			} finally {
				close(con, pstmt);
			}
			
			return rows;
		}
		
	}
		
		


