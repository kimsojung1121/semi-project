package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO {
	public static ReviewDAO _dao;
	
	public ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ReviewDAO();
	}
	public static ReviewDAO getDAO() {
		return _dao;
	}
	//전체 리뷰 출력
	public int selectReview_Count(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count = 0;
		try {
			con = getConnection();

			if (keyword.equals("")) {
				String sql = "select count(*) from review";
				pstmt = con.prepareStatement(sql);
			} else { 
				String sql = "select count(*) from review where " + search + " like '%'||?||'%' and r_state!=9";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("[에러] selectReview_Count() 메소드 구간 오류 = "+e.getMessage());
		}finally {
			close(con,pstmt,rs);
		}
		return count;
	}
	//시작행~종료행 범위글 리뷰 출력
	public List<ReviewDTO> selectReview_List(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList=new ArrayList<ReviewDTO>();
		try {
			con=getConnection();
			if (keyword.equals("")) {
				String sql="select * from (select rownum rn,temp.*from"
						+"(select * from review order by ref desc,re_step) temp) " + "where rn between ? and ? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			}else {
				String sql = "select * from (select rownum rn,temp.* from " + "(select * from review where " + search
						+ " like '%'||?||'%' and r_state!=9 "
						+ "order by ref desc,re_step) temp) where rn between ? and ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, keyword);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			}
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ReviewDTO review=new ReviewDTO();
				review.setR_no(rs.getInt("r_no"));
				review.setId(rs.getString("id"));
				review.setR_writer(rs.getString("r_writer"));
				review.setR_title(rs.getString("r_title"));
				review.setR_date(rs.getString("r_date"));
				review.setReadcount(rs.getInt("readcount"));
				review.setRef(rs.getInt("ref"));
				review.setRe_step(rs.getInt("re_step"));
				review.setRe_level(rs.getInt("re_level"));
				review.setR_content(rs.getString("r_content"));
				review.setR_state(rs.getInt("r_state"));
				reviewList.add(review);			
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectReview_List() 메소드 구간 오류 = "+e.getMessage());
		}finally {
			close(con,pstmt,rs);
		}
		return reviewList;
	}
	//아이디 기준 검색된 리뷰 전체 조회
	public List<ReviewDTO> selectReview_Id(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList=new ArrayList<ReviewDTO>();
	    try {
	    	con=getConnection();
	    	
	    	String sql = "select * from review where id=? order by r_date desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setR_no(rs.getInt("r_no"));
				review.setR_writer(rs.getString("r_writer"));
				review.setR_title(rs.getString("r_title"));
				review.setR_date(rs.getString("r_date"));
				review.setR_content(rs.getString("r_content"));
				review.setR_state(rs.getInt("r_state"));
				review.setId(rs.getString("id"));
				reviewList.add(review);

			}
		} catch (Exception e) {
			System.out.println("[에러]selectReview_Id 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;
	}
	// 글번호 기준 검색 - 단일행
		public ReviewDTO selectReview_No(int no) {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			ReviewDTO review = null;
			try {
				con = getConnection();

				String sql = "select * from review where r_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, no);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					review=new ReviewDTO();
					review.setR_no(rs.getInt("r_no"));
					review.setId(rs.getString("id"));
					review.setR_writer(rs.getString("r_writer"));
					review.setR_title(rs.getString("r_title"));
					review.setR_date(rs.getString("r_date"));
					review.setReadcount(rs.getInt("readcount"));
					review.setRef(rs.getInt("ref"));
					review.setRe_step(rs.getInt("re_step"));
					review.setRe_level(rs.getInt("re_level"));
					review.setR_content(rs.getString("r_content"));
					review.setR_state(rs.getInt("r_state"));
				
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectReview_No() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return review;
		}

		// 새글작성시 시퀀스객체를 이용하여 다음값 자동 증가
		public int selectNextReview() {
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			int nextNum = 0;
			try {
				con = getConnection();

				String sql = "select review_seq.nextval from dual";
				pstmt = con.prepareStatement(sql);

				rs = pstmt.executeQuery();

				if (rs.next()) {
					nextNum = rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]electNextReview() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return nextNum;
		}
		// Q&A 등록[삽입] - 새글
		public int insertReview(ReviewDTO review) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			try {
				con = getConnection();

				String sql = "insert into review values(?,?,?,?,sysdate,0,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, review.getR_no());
				pstmt.setString(2, review.getId());
				pstmt.setString(3, review.getR_writer());
				pstmt.setString(4, review.getR_title());
				pstmt.setInt(5, review.getRef());
				pstmt.setInt(6, review.getRe_step());
				pstmt.setInt(7, review.getRe_level());
				pstmt.setString(8, review.getR_content());
				pstmt.setInt(9, review.getR_state());

				rows = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertReview() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		//조회수 증가
		public int updateReviewCount(int no) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="update review set readcount=readcount+1 where r_no=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, no);
				
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]updateReviewCount() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}

		// 답글 달기 [UPDATE] - 단일행
		public int AddReview_Ans(int ref, int reStep) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			try {
				con = getConnection();

				String sql = "update review set re_step=re_step+1 where ref=? and re_step>?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, reStep);

				rows = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]AddReview_Ans() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}

		// 단일행 수정 및 변경
		public int ModifyReview_Ans(ReviewDTO qna) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			try {
				con = getConnection();

				String sql = "update review set r_title=?,r_content=?,r_state=? where r_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, qna.getR_title());
				pstmt.setString(2, qna.getR_content());
				pstmt.setInt(3, qna.getR_state());
				pstmt.setInt(4, qna.getR_no());

				rows = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]ModifyReview_Ans() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}

		// 삭제
		public int deleteReview_Ans(int num) {
			Connection con = null;
			PreparedStatement pstmt = null;
			int rows = 0;
			try {
				con = getConnection();

				String sql = "update review set r_state=9 where r_no=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);

				rows = pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]deleteReview_Ans() 메소드의 SQL 오류 = " + e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
	}
