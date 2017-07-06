package com.mmong.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.mmong.dao.MessageDao;
import com.mmong.paging.util.PagingBean;
import com.mmong.service.MessageService;
import com.mmong.vo.Message;

@Service
public class MessageServiceImpl implements MessageService{

	@Autowired
	@Qualifier("messageDaoImpl")
	private MessageDao dao;
	
	@Override
	public void insertMessage(Message message) {
		
		System.out.println("service"+message);
		dao.insertMessage(message);
		
	}

	@Override
	public Map<String, Object> selectReceiveMsg(String id, int page) {

		Map<String, Object> map = new HashMap<>(); 
		int totalCount = dao.selectReceiveMessageCount(id);
		PagingBean pageBean = new PagingBean(totalCount, page);
		
		List<Message> list = dao.selectReceiveMsg(id,  pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		List<Message> notRemove = new ArrayList<>();
		
		// 쪽지 상태 확인해서 삭제 상태가 아니면 조회
		for(Message m : list){
			if(m.getState() != 3){ //3: 받은 사람이 삭제
				notRemove.add(m);
			}
		}

		map.put("pageBean", pageBean);
		map.put("list", notRemove);
		
		return map;
	}

	@Override
	public Map<String, Object> selectSendMsg(String id, int page) {

		Map<String, Object> map = new HashMap<>(); 
		int totalCount = dao.selectSendMessageCount(id);
		PagingBean pageBean = new PagingBean(totalCount, page);
		

		List<Message> list = dao.selectSendMsg(id,  pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		List<Message> notRemove = new ArrayList<>();
		
		// 쪽지 상태 확인해서 삭제 상태가 아니면 조회
		for(Message m : list){
			if(m.getState() != 2){ //2: 보낸 사람이 삭제
				notRemove.add(m);
			}
		}

		map.put("pageBean", pageBean);
		map.put("list", notRemove);
		
		return map;
	}

	@Override
	public void deleteSendMessage(List msgNo) { //보낸쪽지함
		
		for(Object o : msgNo){
			String no = (String) o;
			
			//그 쪽지의 상태가 받은쪽에서 삭제한 상태인지 아닌지 확인 필요
			//if(삭제한상태 state=3)이면 db내에서 완전 delete
			int state = dao.selectMessageState(no);
			if(state==3){
				dao.deleteMessage(no); 
			}else{ //else면 state=2으로 update
				dao.updateSendMsgState(no);
			}
		}
	}

	@Override
	public void deleteReceiveMessage(List msgNo) { //받은쪽지함
		
		for(Object o : msgNo){
			String no = (String) o;
			
			//그 쪽지의 상태가 보낸쪽에서 삭제한 상태인지 아닌지 확인 필요
			//if(삭제한상태 state=2)이면 db내에서 완전 delete
			int state = dao.selectMessageState(no);
			if(state==2){
				dao.deleteMessage(no);
			}else{ //else면 state=3으로 update
				dao.updateReceiveMsgState(no);
			}
		}
	}
	
	@Override
	public void updateMsgState(int no) {
		dao.updateMsgState(no);
	}

	@Override
	public Message viewReceiveMsg(int no) {

		Message message = dao.viewReceiveMsg(no);
		return message;
	}

	@Override
	public Message viewSendMsg(int no) {

		Message message = dao.viewSendMsg(no);
		return message;
	}

	@Override
	public Message selectMsgIdNick(int no) {
		
		Message message = dao.selectMsgIdNick(no);
		
		return message;
	}

	@Override
	public Map<String, Object> searchSendMsg(HashMap<String, Object> hashMap, int page) {

		Map<String, Object> map = new HashMap<>(); 
		
		int totalCount = dao.searchSendMsgCount(hashMap);
		PagingBean pageBean = new PagingBean(totalCount, page);
		

		List<Message> list = dao.searchSendMsg(hashMap,  pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		List<Message> notRemove = new ArrayList<>();
		
		// 쪽지 상태 확인해서 삭제 상태가 아니면 조회
		for(Message m : list){
			if(m.getState() != 2){ //2: 보낸 사람이 삭제
				notRemove.add(m);
			}
		}

		map.put("pageBean", pageBean);
		map.put("list", notRemove);

		return map;
		
	}

	@Override
	public Map<String, Object> searchReceiveMsg(HashMap<String, Object> hashMap, int page) {
		
		Map<String, Object> map = new HashMap<>(); 
		
		int totalCount = dao.searchReceiveMsgCount(hashMap);
		PagingBean pageBean = new PagingBean(totalCount, page);
		

		List<Message> list = dao.searchReceiveMsg(hashMap,  pageBean.getBeginItemInPage(), pageBean.getEndItemInPage());
		List<Message> notRemove = new ArrayList<>();
		
		// 쪽지 상태 확인해서 삭제 상태가 아니면 조회
		for(Message m : list){
			if(m.getState() != 3){ //3: 받은 사람이 삭제
				notRemove.add(m);
			}
		}

		map.put("pageBean", pageBean);
		map.put("list", notRemove);

		return map;
		
	}
	
}
