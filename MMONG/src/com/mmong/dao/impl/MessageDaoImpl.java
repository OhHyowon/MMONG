package com.mmong.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mmong.dao.MessageDao;
import com.mmong.vo.Message;

@Repository
public class MessageDaoImpl implements MessageDao{

	@Autowired
	private SqlSessionTemplate session;
	
	private String makeSqlId(String id){
		return "com.mmong.config.mapper.messageMapper."+id;
	}
	
	@Override
	public int insertMessage(Message message) {
		System.out.println("dao"+message);
		return session.insert(makeSqlId("insertMessage"), message);
	}

	@Override
	public List<Message> selectReceiveMsg(String id, int beginMessageNo, int endMessageNo) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("beginMessageNum", beginMessageNo);
		map.put("endMessageNum", endMessageNo);
		return session.selectList(makeSqlId("selectReceiveMsg"), map);
	}

	@Override
	public int selectReceiveMessageCount(String id) {
		return session.selectOne(makeSqlId("selectReceiveMessageCount"), id);
	}

	@Override
	public int selectSendMessageCount(String id) {
		return session.selectOne(makeSqlId("selectSendMessageCount"), id);
	}

	@Override
	public List<Message> selectSendMsg(String id, int beginMessageNo, int endMessageNo) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("beginMessageNum", beginMessageNo);
		map.put("endMessageNum", endMessageNo);
		return session.selectList(makeSqlId("selectSendMsg"), map);
	}

	@Override
	public int selectMessageState(String no) {
		return session.selectOne(makeSqlId("selectMessageState"), no);
	}

	@Override
	public void deleteMessage(String no) {
		session.delete(makeSqlId("deleteMessage"), no);
	}

	@Override
	public void updateSendMsgState(String no) {
		session.update(makeSqlId("updateSendMsgState"), no);
	}

	@Override
	public void updateReceiveMsgState(String no) {
		session.update(makeSqlId("updateReceiveMsgState"), no);
	}
	
	@Override
	public void updateMsgState(int no) {
		session.update(makeSqlId("updateMsgState"), no);
	}

	@Override
	public Message viewReceiveMsg(int no) {
		return session.selectOne(makeSqlId("viewReceiveMsg"), no);
	}
	
	@Override
	public Message viewSendMsg(int no) {
		return session.selectOne(makeSqlId("viewSendMsg"), no);
	}

	@Override
	public Message selectMsgIdNick(int no) {
		return session.selectOne(makeSqlId("selectMsgIdNick"), no);
	}

	@Override
	public int searchSendMsgCount(HashMap<String, Object> hashMap) {
		return session.selectOne(makeSqlId("searchSendMsgCount"), hashMap);
	}

	@Override
	public List<Message> searchSendMsg(HashMap<String, Object> hashMap, int beginMessageNo, int endMessageNo) {
		hashMap.put("beginMessageNum", beginMessageNo);
		hashMap.put("endMessageNum", endMessageNo);	
		return session.selectList(makeSqlId("searchSendMsg"), hashMap);
	}

	@Override
	public int searchReceiveMsgCount(HashMap<String, Object> hashMap) {
		return session.selectOne(makeSqlId("searchReceiveMsgCount"), hashMap);
	}

	@Override
	public List<Message> searchReceiveMsg(HashMap<String, Object> hashMap, int beginMessageNo, int endMessageNo) {
		hashMap.put("beginMessageNum", beginMessageNo);
		hashMap.put("endMessageNum", endMessageNo);	
		return session.selectList(makeSqlId("searchReceiveMsg"), hashMap);
	}
}
