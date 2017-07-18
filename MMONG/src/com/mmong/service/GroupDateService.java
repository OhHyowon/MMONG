package com.mmong.service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import com.mmong.vo.GroupDate;
import com.mmong.vo.MeetMember;
/**
 * 일정관리 서비스 입니다.
 * @author 강여림
 *
 */
public interface GroupDateService {
	/**
	 * 일정 하나 등록하는 메소드
	 * @param groupDate
	 * @return
	 * 작성자 : 강여림
	 */
	public int insertGroupDate(GroupDate groupDate);
	/**
	 * 일정번호로 일정 조회하는 메소드
	 * @param groupDateNo
	 * @return
	 *  작성자 : 강여림
	 */
	public GroupDate selectGroupDate(int groupDateNo);
	/**
	 * 모임에 참여한 멤버 번호 가져오는 메소드
	 * @param memberId
	 * @param groupNo
	 * @return
	 *  작성자 : 강여림
	 */
	public int selectMemberNo(String memberId, int groupNo);
	/**
	 * 일정 참여 멤버 등록하는 메소드
	 * @param mm
	 *  작성자 : 강여림
	 */
	public void insertMeetMember(MeetMember mm);
	/**
	 * 일정 번호 가지고 일정 참여 멤버 조회하는 메소드
	 * @param groupDateNo
	 * @return
	 * 작성자 : 강여림
	 */
	public List<Integer>selectMeetMemberList(int groupDateNo);
	/**
	 * 참여멤버 번호로 멤버 아이디 조회하는 메소드
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
	 * 전체 일정 조회하는 메소드 
	 * @param page
	 * @param groupNo
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object> selectAllGroupDateList (int page, int groupNo);
	/**
	 * 전체 일정 중 일정이름, 장소로 검색해서 조회하는 메소드
	 * @param page
	 * @param groupNo
	 * @param option
	 * @param key
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object>selectGroupDateOption(int page, int groupNo, String option, String key);
	/**
	 * 전체 일정 중 일정 일자로 검색해서 조회하는 메소드
	 * @param page
	 * @param groupNo
	 * @param dateTime
	 * @param option
	 * @return
	 * 작성자 : 강여림
	 */
	public HashMap<String,Object>selectGroupDateOption2(int page, int groupNo, Date dateTime, String option);
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
	 * 탈퇴시 일정 참여 멤버 삭제하는 메소드 
	 * @param groupMemberNo
	 * 작성자 : 강여림
	 */
	public void deleteMeetMemberByGroupMemberNo(int groupMemberNo);
	/**
	 * groupNo으로 groupDateNo 리스트로 조회하는 메소드
	 * @param groupNo
	 * 작성자 : 강여림
	 */
	public List<Integer> selectNoByGroupNo(int groupNo);
	/**
	 * groupNo으로 groupDate 전체 삭제하는 메소드
	 * @param groupNo
	 * 작성자 : 강여림
	 */
	public void deleteGroupDateByGroupNo(int groupNo);
	/**
	 * groupDateNo으로 일정 참여 멤버 삭제 하는 메소드
	 * @param groupDateNo
	 * 작성자 : 강여림
	 */
	public void deleteMeetMemberByGroupDateNo(int groupDateNo);
	
}
