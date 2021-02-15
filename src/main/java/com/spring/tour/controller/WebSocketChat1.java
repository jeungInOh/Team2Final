package com.spring.tour.controller;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.tour.service.ChatService;



@Controller
@ServerEndpoint(value = "/echo1.do")
public class WebSocketChat1 {
	
	@Autowired
	private ChatService service;
	int cnt = 0;
	String username = "";
	private static final List<Session> sessionList = new ArrayList<Session>(); // hashmap 키를 id 벨류를 이름으로?
	private static final Logger logger = LoggerFactory.getLogger(WebSocketChat1.class);
	public WebSocketChat1() {
		System.out.println("웹소켓(서버) 객체 생성!");
	}
	 
	@OnOpen
	public void onOpen(Session session) {
		cnt=0; // 매번 들어올때마다 이름 가져오기 위함
		logger.info("Open Session id : " + session.getId());
		try {
			final Basic basic = session.getBasicRemote(); // 내가 보낸걸 나에게로!
			basic.sendText("SYSTEM대화방에 연결되었습니다");
		}catch(Exception e) {
			e.printStackTrace();
		}
		sessionList.add(session); // 채팅에 들어온 들어온 명단 저장
	}
	
	/*
	 * 모든 사용자에게 메세지를 전달한다
	 * @param self
	 * @param sender
	 * @param message
	 */
	private void sendAllSessionToMessage(Session self, String sender, String message) {
		try {
			for(Session session : WebSocketChat1.sessionList) {

				if(!self.getId().equals(session.getId())) { //보내는 대상이 내가 아니면 
					session.getBasicRemote().sendText(message); //상대방에게 보여지는 메세지
					//session.getBasicRemote().sendText(sender+""+message); //이게 상대방에게 보여지는 메세지
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/*
	 * 내가 입력하는 메세지
	 * @param message
	 * @param session
	 */

	@OnMessage
	public void onMessage(String message, Session session) {
		if(cnt++==0) {
			username=message;
		}
		
		String sender = message.split(",")[1];
		message=message.split(",")[0];	
		
		logger.info("Message From "+sender+":"+message);
		try {
			final Basic basic = session.getBasicRemote(); // 내가 보낸걸 나에게로!
			basic.sendText("#$#"+message); // 구분자를 보내줘야 따로 처리 가능
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		sendAllSessionToMessage(session, sender, message); // 상대에게 보내기
	}
	
	@OnError
	public void error(Throwable e, Session session) {
	}
	
	@OnClose
	public void onClose(Session session) {
		logger.info("Session "+session.getId()+ "has ended");
		sessionList.remove(session);
		service.isWaiting(username);
	}
	
}
