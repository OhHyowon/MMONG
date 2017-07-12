package com.mmong.dao;

import java.util.HashMap;
import java.util.List;

import com.mmong.vo.Message;

/**
 * Message 테이블 DAO
 * @author kosta
 *
 */
public interface MessageDao {

	/**
	 * 쪽지 보내기 (DB에 저장)
	 * @param session
	 * @param message
	 * @return
	 */
	int insertMessage(Message message);
	
	/**
	 * 받은 쪽지함
	 * 페이징을 위한 조회 목록의 전체 개수 세기
	 * @param id
	 * @return
	 */
	int selectReceiveMessageCount(String id);
	
	/**
	 * 받은 쪽지 전체 목록 조회
	 * @param id
	 * @return
	 */
	List<Message> selectReceiveMsg(String id, int beginMessageNo, int endMessageNo);
	
	/**
	 * 보낸 쪽지함
	 * 페이징을 위한 조회 목록의 전체 개수 세기
	 * @param id
	 * @return
	 */
	int selectSendMessageCount(String id);
	
	/**
	 * 보낸 쪽지 전체 목록 조회
	 * @param id
	 * @param beginMessageNo
	 * @param endMessageNo
	 * @return
	 */
	List<Message> selectSendMsg(String id, int beginMessageNo, int endMessageNo);

	/**
	 * 파라미터 no값에 알맞는 쪽지의 상태 확인
	 * @param no
	 * @return
	 */
	int selectMessageState(String no);
	
	/**
	 * 쪽지 table 데이터베이스에서 파라미터 no값에 알맞는 쪽지 삭제
	 * @param no
	 * @return
	 */
	void deleteMessage(String no);
	
	/**
	 * 보낸메세지함에서 파라미터 no값에 알맞는 쪽지를 삭제했다고 상태를 업데이트
	 * @param no
	 * @return
	 */
	void updateSendMsgState(String no);
	
	/**
	 * 받은메세지함에서 파라미터 no값에 알맞는 쪽지를 삭제했다고 상태를 업데이트
	 * @param no
	 */
	void updateReceiveMsgState(String no);

	/**
	 * 받은 쪽지를 열었을 때 쪽지의 상태가 읽지않음 -> 읽음 으로 전환
	 */
	void updateMsgState(int no);
	
	/**
	 * 받은 쪽지 자세히 보기
	 * @param no
	 * @return
	 */
	Message viewReceiveMsg(int no);
	
	/**
	 * 보낸 쪽지 자세히 보기
	 * @param no
	 * @return
	 */
	Message viewSendMsg(int no);
	
	/**
	 * 답장 보내기 위해 쪽지를 보내온 사람의 id와 nickname 가져오기
	 * @param no
	 * @return
	 */
	Message selectMsgIdNick(int no);
	
	/**
	 * 보낸 쪽지함에서 검색을 통해 결과값 도출 - 페이징 위한 개수 세기
	 * @param hashMap
	 * @return
	 */
	int searchSendMsgCount(HashMap<String, Object> hashMap);
	
	/**
	 * 보낸 쪽지함에서 option에 따라 검색하기
	 * @param hashMap
	 * @param beginMessageNo
	 * @param endMessageNo
	 * @return
	 */
	List<Message> searchSendMsg(HashMap<String, Object> hashMap, int beginMessageNo, int endMessageNo);
	
	/**
	 * 받은 쪽지함에서  검색을 통해 결과값 도출 - 페이징 위한 개수 세기
	 * @param hashMap
	 * @return
	 */
	int searchReceiveMsgCount(HashMap<String, Object> hashMap);
	
	/**
	 * 받은 쪽지함에서 option에 따라 검색하기
	 * @param hashMap
	 * @param beginMessageNo
	 * @param endMessageNo
	 * @return
	 */
	List<Message> searchReceiveMsg(HashMap<String, Object> hashMap, int beginMessageNo, int endMessageNo);
	
}
