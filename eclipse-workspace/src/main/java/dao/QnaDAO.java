package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.QnaDTO;

public class QnaDAO extends JdbcDAO {
	public static QnaDAO _dao;

	public QnaDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new QnaDAO();
	}

	public static QnaDAO getDAO() {
		return _dao;
	}

	// 전체 Q&A 출력 - 전체 조회
	public int selectQna_Count(String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();

			if (keyword.equals("")) {// ▶검색 기능을 사용하지 않을경우임 즉, = 전체검색을 한다는 것
				String sql = "select count(*) from qna";
				pstmt = con.prepareStatement(sql);
			} else { // ▶검색 기능을 사용할 경우 - where
				String sql = "select count(*) from qna where " + search + " like '%'||?||'%' and q_state!=9";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectQna_Count() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	// 시작 행 ~ 종료행 범위의 게시글 목록 출력 [1페이 ~ 10페이지]
	public List<QnaDTO> selectQna_List(int startRow, int endRow, String search, String keyword) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		try {
			con = getConnection();

			if (keyword.equals("")) {
				String sql = "select * from (select rownum rn,temp.* from "
						+ "(select * from qna order by ref desc,re_step) temp) " + "where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				// 검색기능 추가 = where
				String sql = "select * from (select rownum rn,temp.* from " + "(select * from qna where " + search
						+ " like '%'||?||'%' and q_state!=9 "
						+ "order by ref desc,re_step) temp) where rn between ? and ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQ_no(rs.getInt("q_no"));
				qna.setId(rs.getString("id"));
				qna.setQ_writer(rs.getString("q_writer"));
				qna.setQ_title(rs.getString("q_title"));
				qna.setQ_date(rs.getString("q_date"));
				qna.setReadcount(rs.getInt("readcount"));
				qna.setRef(rs.getInt("ref"));
				qna.setRe_Step(rs.getInt("re_step"));
				qna.setRe_Level(rs.getInt("re_level"));
				qna.setQ_content(rs.getString("q_content"));
				qna.setQ_state(rs.getInt("q_state"));
				qnaList.add(qna);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQna_List() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}

	// 아이디 기준으로 검색된 Q&A 전체 조회
	public List<QnaDTO> selectQna_Id(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		try {
			con = getConnection();
			// String sql = "select q_no,q_title,q_content,q_date,q_state from qna where
			// id=? order by q_date desc";
			String sql = "select * from qna where id=? and q_state!=9 order by q_date desc";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQ_no(rs.getInt("q_no"));
				qna.setQ_writer(rs.getString("q_writer"));
				qna.setQ_title(rs.getString("q_title"));
				qna.setQ_date(rs.getString("q_date"));
				qna.setQ_content(rs.getString("q_content"));
				qna.setQ_state(rs.getInt("q_state"));
				qna.setId(rs.getString("id"));
				qnaList.add(qna);

			}
		} catch (Exception e) {
			System.out.println("[에러]selectQNA_Id() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}

	// 글번호 기준 검색 - 단일행
	public QnaDTO selectQna_No(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		QnaDTO qna = null;
		try {
			con = getConnection();

			String sql = "select * from qna where q_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				qna = new QnaDTO();
				qna.setQ_no(rs.getInt("q_no"));
				qna.setId(rs.getString("id"));
				qna.setQ_writer(rs.getString("q_writer"));
				qna.setQ_title(rs.getString("q_title"));
				qna.setQ_date(rs.getString("q_date"));
				qna.setReadcount(rs.getInt("readcount"));
				qna.setRef(rs.getInt("ref"));
				qna.setRe_Step(rs.getInt("re_step"));
				qna.setRe_Level(rs.getInt("re_level"));
				qna.setQ_content(rs.getString("q_content"));
				qna.setQ_state(rs.getInt("q_state"));
			
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQna_No() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qna;
	}

	// 새글작성시 시퀀스객체를 이용하여 다음값 자동 증가
	public int selectNextQna() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNum = 0;
		try {
			con = getConnection();

			String sql = "select qna_seq.nextval from dual";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				nextNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextQna() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}

	// 미등록 답변 조회
	public List<QnaDTO> selectQNA_State() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		try {
			con = getConnection();
			String sql = "select  * from qna where q_state=0";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQ_no(rs.getInt("q_no"));
				qna.setId(rs.getString("q_id"));
				qna.setQ_title(rs.getString("q_title"));
				qna.setQ_content(rs.getString("q_content"));
				qna.setQ_date(rs.getString("q_date"));
				qna.setQ_state(rs.getInt("q_state"));
				qnaList.add(qna);
			}
		} catch (Exception e) {
			System.out.println("[에러]selectQNA_State() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}

	// Q&A 등록[삽입] - 새글
	public int insertQna(QnaDTO qna) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "insert into qna values(?,?,?,?,sysdate,0,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, qna.getQ_no());
			pstmt.setString(2, qna.getId());
			pstmt.setString(3, qna.getQ_writer());
			pstmt.setString(4, qna.getQ_title());
			pstmt.setInt(5, qna.getRef());
			pstmt.setInt(6, qna.getRe_Step());
			pstmt.setInt(7, qna.getRe_Level());
			pstmt.setString(8, qna.getQ_content());
			pstmt.setInt(9, qna.getQ_state());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertQna() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);

		}
		return rows;
	}
	//조회수 증가
	public int updateQnaCount(int no) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qna set readcount=readcount+1 where q_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateQnaCount() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 답글 달기 [UPDATE] - 단일행
	public int AddQna_Ans(int ref, int reStep) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update qna set re_step=re_step+1 where ref=? and re_step>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reStep);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]AddQna_Ans() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 단일행 수정 및 변경
	public int ModifyQna_Ans(QnaDTO qna) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update qna set q_title=?,q_content=?,q_state=? where q_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, qna.getQ_title());
			pstmt.setString(2, qna.getQ_content());
			pstmt.setInt(3, qna.getQ_state());
			pstmt.setInt(4, qna.getQ_no());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]ModifyQna_Ans() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 삭제
	public int deleteQna_Ans(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update qna set q_state=9 where q_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteQna_Ans() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
      //관리자페이지
	   //Q&A전체출력
    	public List<QnaDTO> selectAllQna() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		
		try {
			con = getConnection();
			String sql = "select * from qna order by q_no";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setQ_no(rs.getInt("q_no"));
				qna.setId(rs.getString("id"));
				qna.setQ_writer(rs.getString("q_writer"));
				qna.setQ_date(rs.getString("q_date"));
				qna.setReadcount(rs.getInt("readcount"));
				qna.setRef(rs.getInt("ref"));
				qna.setRe_Step(rs.getInt("re_step"));
				qna.setRe_Level(rs.getInt("re_level"));
				qna.setQ_content(rs.getString("q_content"));
				qna.setQ_state(rs.getInt("q_state"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectAllQna() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt, rs);
		}
			
			return qnaList;
		}
}

    /*
	//메소드 추가(08/07) - 보류
	//회원 아이디 값을 전달받아 회원이 작성한 게시글의 REF를 검색하여 반환하는 메소드
	public List<QnaDTO> selectRef(String id) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<QnaDTO> qnaList = new ArrayList<QnaDTO>();
		try {
			con = getConnection();
			String sql = "select ref from qna where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaDTO qna = new QnaDTO();
				qna.setRef(rs.getInt("ref"));
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectRef() 메소드에서 에러 발생");
		} finally {
			close(con, pstmt, rs);
		}
		
		return qnaList;
		}
	}
    	*/