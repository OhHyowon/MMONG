package com.mmong.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mmong.vo.Message;

/**
 * Message 테이블의 Service
 * @author kosta
 *
 */
public interface MessageService {

	/**
	 * 쪽지 보내기
	 * @param message
	 */
	void insertMessage(Message message);

	/**
	 * 받은 쪽지함
	 * @param id
	 * @param page
	 * @return
	 */
	Map<String, Object> selectReceiveMsg(String id, int page);
	
	/**
	 * 보낸 쪽지함
	 * @param id
	 * @param page
	 * @return
	 */
	Map<String, Object> selectSendMsg(String id, int page);
	
	/**
	 * 보낸 쪽지함에서 쪽지 삭제
	 * @param memberId
	 * @param msgNo
	 */
	void deleteSendMessage(List msgNo);
	
	/**
	 * 받은 쪽지함에서 쪽지 삭제
	 * @param memberId
	 * @param msgNo
	 */
	void deleteReceiveMessage(List msgNo);
	
	/**
	 * 받은 쪽지를 열람했을 때 쪽지상태를 읽지않음 -> 읽음 으로 전환
	 */
	void updateMsgState(int no);
	
	/**
	 * 받은 쪽지 조회 (한 개)
	 * @param no
	 * @return
	 */
	Message viewReceiveMsg(int no);
	
	/**
	 * 보낸 쪽지 조회 (한 개)
	 * @param no
	 * @return
	 */
	Message viewSendMsg(int no);
	
	/**
	 * 답장을 보내기 위해 보낸 사람의 id와 nickname 가져오기
	 * @param no
	 * @return
	 */
	Message selectMsgIdNick(int no);
	
	/**
	 * 보낸 쪽지함에서 option에 따라 쪽지 검색
	 * @param hashMap
	 * @param page
	 * @return
	 */
	Map<String, Object> searchSendMsg(HashMap<String, Object> hashMap, int page);
	
	/**
	 * 받은 쪽지함에서 option에 따라 쪽지 검색
	 * @param hashMap
	 * @param page
	 * @return
	 */
	Map<String, Object> searchReceiveMsg(HashMap<String, Object> hashMap, int page);
}
