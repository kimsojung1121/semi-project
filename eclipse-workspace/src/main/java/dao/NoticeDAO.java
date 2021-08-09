package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import dto.NoticeDTO;

public class NoticeDAO extends JdbcDAO {
	public static NoticeDAO _dao;

	public NoticeDAO() {
		// TODO Auto-generated constructor stub
	}

	static {
		_dao = new NoticeDAO();
	}

	public static NoticeDAO getDAO() {
		return _dao;
	}

	// 구 selectNotice_Count
	// 전체 공지사항 출력
	public int selectAll_Notice() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;
		try {
			con = getConnection();

			String sql = "select count(*) from notice";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}

		} catch (SQLException e) {
			System.out.println("[에러] selectAll_Notice() 메소드 구간 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	// 시작행~종료행 범위 공지사항 글 출력
	public List<NoticeDTO> selectNotice_List(int startRow, int endRow) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			con = getConnection();

			String sql = "select * from (select rownum rn,temp.* from"
					+ "(select * from notice order by rownum desc) temp) " + "where rn between ? and ? ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice.setN_no(rs.getInt("n_no"));
				notice.setId(rs.getString("id"));
				notice.setN_title(rs.getString("n_title"));
				notice.setN_date(rs.getString("n_date"));
				notice.setReadcount(rs.getInt("readcount"));
				notice.setN_content(rs.getString("n_content"));
				notice.setN_state(rs.getInt("n_state"));
				noticeList.add(notice);
			}
		} catch (SQLException e) {
			System.out.println("[에러] selectNotice_List() 메소드 구간 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;
	}

	// 새글작성시 시퀀스객체를 이용하여 다음값 자동 증가
	public int selectNextNotice() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int nextNum = 0;
		try {
			con = getConnection();

			String sql = "select notice_seq.nextval from dual";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				nextNum = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNotice() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}

	// 글번호 기준 검색 - 단일행
	public NoticeDTO selectNotice_No(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO notice = null;
		try {
			con = getConnection();

			String sql = "select * from notice where n_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				notice = new NoticeDTO();
				notice.setN_no(rs.getInt("n_no"));
				notice.setId(rs.getString("id"));
				notice.setN_title(rs.getString("n_title"));
				notice.setN_date(rs.getString("n_date"));
				notice.setReadcount(rs.getInt("readcount"));
				notice.setN_content(rs.getString("n_content"));
				notice.setN_state(rs.getInt("n_state"));

			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNotice_No() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return notice;
	}

	// 공지사항 등록[삽입] - 새글
	public int insertNotice(NoticeDTO notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "insert into notice values(?,?,?,sysdate,0,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, notice.getN_no());
			pstmt.setString(2, notice.getId());
			pstmt.setString(3, notice.getN_title());
			pstmt.setString(4, notice.getN_content());
			pstmt.setInt(5, notice.getN_state());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertNotice() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 조회수 증가
	public int updateNoticeCount(int no) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update notice set readcount=readcount+1 where n_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, no);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateNoticeCount() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 단일행 수정 및 변경
	public int ModifyNotice(NoticeDTO notice) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update notice set n_title=?,n_content=?,n_state=? where n_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, notice.getN_title());
			pstmt.setString(2, notice.getN_content());
			pstmt.setInt(3, notice.getN_state());
			pstmt.setInt(4, notice.getN_no());

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러] ModifyNotice() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	// 삭제
	public int deleteNotice(int num) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();

			String sql = "update notice set n_state=9 where n_no=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteNotice_Ans() 메소드의 SQL 오류 = " + e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
