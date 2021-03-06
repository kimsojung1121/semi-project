package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.ProductsDTO;

public class ProductsDAO extends JdbcDAO{
	
	private static ProductsDAO _dao;
	
	private ProductsDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new ProductsDAO();
	}
	
	public static ProductsDAO getDAO() {
		return _dao;
	}
	
	
	public List<ProductsDTO> selectAllProducts() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductsDTO> productList = new ArrayList<ProductsDTO>();
		
		try {
			con = getConnection();
			String sql = "select * from products";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductsDTO product = new ProductsDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpImag(rs.getString("p_image"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectAllProducts() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt, rs);
		}
		
		return productList;
	}
	
	public ProductsDTO selectProductsInfo(int pNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProductsDTO product = null;
		try {
			con = getConnection();
			String sql = "select * from products where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				product = new ProductsDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpImag(rs.getString("p_image"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectProductInfo() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt, rs);
		}
		
		return product;
	}
	
	public List<ProductsDTO> selectProductsName(String pName) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductsDTO> productList = new ArrayList<ProductsDTO>();
		
		try {
			con = getConnection();
			String sql = "select * from products where p_name like '%'||?||'%’";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, pName);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductsDTO product = new ProductsDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpImag(rs.getString("p_image"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectAllProducts() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt, rs);
		}
		
		return productList;
	}
	
	public int insertProduct(ProductsDTO product) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "insert into products values(?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, product.getpNo());
			pstmt.setString(2, product.getpName());
			pstmt.setInt(3, product.getpPrice());
			pstmt.setString(4, product.getpImage());
			
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] insertProduct() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	public int updateProduct(ProductsDTO product) { //수정필요
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			
			String sql = "update products set p_name=?, p_price=? where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, product.getpName());
			pstmt.setInt(2, product.getpPrice());
			pstmt.setInt(3, product.getpNo());
			
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] updateProductName() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}

	
	public int deleteProduct(int pNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		
		try {
			con = getConnection();
			String sql = "delete products where p_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, pNo);
			
			rows = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러] deleteProduct() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt);
		}
		
		return rows;
	}
	
	public int totalProductCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		
		try {
			con=getConnection();

			String sql="select * from products";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				count++;
			}
			
		} catch (SQLException e) {
			System.out.println("[에러]selectTotalProductCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			 close(con, pstmt, rs);
		}
		
		return count;
	}
	
	//메소드 추가 (08/10)
	// => 페이징 기능을 위한 List 반환 메소드
	public List<ProductsDTO> selectProductList(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<ProductsDTO> productList = new ArrayList<ProductsDTO>();
		
		try {
			con = getConnection();
			String sql = "select * from (select rownum rn, temp.* from (select * from products) temp) where rn between ? and ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductsDTO product = new ProductsDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpImag(rs.getString("p_image"));
				productList.add(product);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectProductList() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt, rs);
		}
		
		return productList;
	}
}
