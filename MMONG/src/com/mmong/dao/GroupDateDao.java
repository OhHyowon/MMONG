package com.mmong.dao;

import java.util.Date;
import java.util.List;

import com.mmong.vo.GroupDate;
import com.mmong.vo.MeetMember;

public interface GroupDateDao {
	/**
	 * 일정 하나 등록하는 메소드
	 * @param groupDate
	 * 작성자 : 강여림
	 */
	public void insertGroupDate(GroupDate groupDate);
	/**
	 * 일정번호로 일정 조회하는 메소드
	 * @param groupDateNo
	 * @return
	 * 작성자 : 강여림
	 */
	public GroupDate selectGroupDate(int groupDateNo);
	/**
	 * 모임에 참여한 멤버 번호 가져오는 메소드
	 * @param memberId
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public int selectMemberNo(String memberId, int groupNo);
	/**
	 * 일정 참여 등록하는 메소드 
	 * @param mm
	 * 작성자 : 강여림
	 */
	public void insertMeetMember(MeetMember mm);
	/**
	 * 일정 참여 멤버 조회하는 메소드
	 * @param groupDateNo
	 * @return
	 * 작성자 : 강여림
	 */
	public List<Integer>selectMeetMemberList(int groupDateNo);
	/**
	 * 일정 번호로 멤버 아이디 조회하는 메소드
	 * @param memberNo
	 * @return
	 * 작성자 : 강여림
	 */
	public String selectMemberId(int memberNo);
	/**
	 * 멤버 아이디로 닉네임 조회하는 메소드
	 * @param memberId
	 * @return
	 * 작성자 : 강여림
	 */
	public String selectNickname(String memberId);
	/**
	 * 일정 참여 멤버 삭제하는 메소드
	 * @param mm
	 * 작성자 : 강여림
	 */
	public void deleteMeetmember(MeetMember mm);
	/**
	 * 전체 일정 목록 조회하는 메소드
	 * @param beginItemNo
	 * @param endItemNo
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public List<GroupDate> selectAllGroupDateList(int beginItemNo, int endItemNo, int groupNo);
	/**
	 * 전체 일정 갯수 조회하는 메소드
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public int selectGroupDateCount (int groupNo);
	/**
	 * 전체 일정 중 일정이름, 장소로 검색했을 때 나오는 전체 일정 갯수 조회하는 메소드
	 * @param groupNo
	 * @param option
	 * @param key
	 * @return
	 * 작성자 : 강여림
	 */
	public int selectGroupDateOptionCount(int groupNo, String option, String key);
	/**
	 * 일정이름, 장소로 일정 목록 조회하는 메소드
	 * @param beginItemNo
	 * @param endItemNo
	 * @param groupNo
	 * @param option
	 * @param key
	 * @return
	 * 작성자 : 강여림
	 */
	public List<GroupDate> selectOptionGroupDate(int beginItemNo, int endItemNo, int groupNo, String option, String key);
	/**
	 * 날짜로 검색했을 때 일정 목록 갯수를 조회하는 메소드
	 * @param groupNo
	 * @param option
	 * @param dateTime
	 * @return
	 * 작성자 : 강여림
	 */
	public int selectGroupDateOptionCount2(int groupNo, String option, Date dateTime);
	/**
	 * 날짜로 검색했을 때 일정 목록을 조회하는 메소드
	 * @param beginItemNo
	 * @param endItemNo
	 * @param groupNo
	 * @param option
	 * @param dateTime
	 * @return
	 * 작성자 : 강여림
	 */
	public List<GroupDate> selectOptionGroupDate2(int beginItemNo, int endItemNo,int groupNo, String option, Date dateTime);
	/**
	 * 일정 수정하는 메소드
	 * @param groupDate
	 * 작성자 : 강여림
	 */
	public void upDateGroupDate(GroupDate groupDate);
	/**
	 * 일정 삭제하는 메소드
	 * @param groupDateNo
	 * 작성자 : 강여림
	 */
	public void deleteGroupDate(int groupDateNo);
	/**
	 * 소모임 탈퇴시 일정 참여한 일정이 있으면 목록에서 본인 삭제하는 메소드
	 * @param groupMemberNo
	 * 작성자 : 강여림
	 */
	public void deleteMeetMemberByGroupMemberNo(int groupMemberNo);
	/**
	 * groupNo으로 일정 참여 no 조회하는 메소드 (소모임 삭제시 필요)
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public List<Integer> selectNoByGroupNo(int groupNo);
	/**
	 * groupNo으로 일정 전체 삭제하는 메소드 (소모임 삭제시 필요)
	 * @param groupNo
	 * 작성자 : 강여림
	 */
	public void deleteGroupDateByGroupNo(int groupNo);
	/**
	 * groupDateNo로 일정 참여자 삭제하는 메소드 (소모임 삭제시 필요)
	 * @param groupDateNo
	 * 작성자 : 강여림
	 */
	public void deleteMeetMemberByGroupDateNo(int groupDateNo);
	
}
