
INSERT INTO health VALUES(health_no_seq.nextval, '면역증강제','m');
INSERT INTO health VALUES(health_no_seq.nextval, '면역증강제','g');					INSERT INTO health VALUES(health_no_seq.nextval, '면역증강제','c');		
INSERT INTO health VALUES(health_no_seq.nextval, '회충약 복용','m');
INSERT INTO health VALUES(health_no_seq.nextval, '회충약 복용','g');					INSERT INTO health VALUES(health_no_seq.nextval, '회충약 복용','c');				
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 1차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 1차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 1차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 1차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 1차','g');			INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 1차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 2차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 2차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 2차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 2차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 2차','g');			INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 2차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '켄넬코프 1차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '켄넬코프 1차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '켄넬코프 1차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 4차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 4차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 4차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '켄넬코프 2차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '켄넬코프 2차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '켄넬코프 2차' ,'c');	
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 5차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 5차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 5차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '신종플루 1차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '신종플루 1차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '신종플루 1차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '광견병 - 연 1~2회','m');
INSERT INTO health VALUES(health_no_seq.nextval, '광견병 - 연 1~2회','g');			INSERT INTO health VALUES(health_no_seq.nextval, '광견병 - 연 1~2회','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '신종플루 2차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '신종플루 2차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '신종플루 2차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '항체가 검사','m');
INSERT INTO health VALUES(health_no_seq.nextval, '항체가 검사','g');					INSERT INTO health VALUES(health_no_seq.nextval, '항체가 검사','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '중성화수술 - 효과 : 남성호르몬 관련 질환인 전립선비대, 전립선낭종등 전립선 질환과 고환종양 등을 예방할 수 있음.','m');
INSERT INTO health VALUES(health_no_seq.nextval, '초경 - 효과 : 난소낭종, 난소종양 예방, 자궁축농증, 자궁점액종, 자궁수종 등 예방, 유선염, 유선종양등 예방','g');
INSERT INTO health VALUES(health_no_seq.nextval, '혈액검사','m');
INSERT INTO health VALUES(health_no_seq.nextval, '혈액검사','g');						INSERT INTO health VALUES(health_no_seq.nextval, '혈액검사','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '곰팡이 백신 - 기초접종 완료후 2차 까지 접종','m');
INSERT INTO health VALUES(health_no_seq.nextval, '곰팡이 백신 - 기초접종 완료후 2차 까지 접종','g');
INSERT INTO health VALUES(health_no_seq.nextval, '혈액검사 - 월 1회, 예방약 투여전 심장사상충 감염여부 검사','m');
INSERT INTO health VALUES(health_no_seq.nextval, '혈액검사 - 월 1회, 예방약 투여전 심장사상충 감염여부 검사','g');
INSERT INTO health VALUES(health_no_seq.nextval, '외부 기생충 예방 - 월 1회(년 중) 옴, 벼룩, 진드기 등 외부기생충 예방 및 치료','m');
INSERT INTO health VALUES(health_no_seq.nextval, '외부 기생충 예방 - 월 1회(년 중) 옴, 벼룩, 진드기 등 외부기생충 예방 및 치료','g');


INSERT INTO users VALUES('adminABC', 'pwd', 'ROLE_0', 1);
INSERT INTO administrator VALUES('adminABC', '어드민', '01029934482', 'admin@kosta.or.kr');

INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] MMONG 홈페이지 개설 안내','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2006/10/25 16:10:40','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 새해 복 많이 받으세요','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2006/10/25 16:10:40','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 신종금융사기! 스미싱 주의바랍니다!!','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2007/10/25 16:10:40','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 2016 국가고객만족도(NCSI) 애완어플 부문 최초 1위 선정','MMONG 홈페이지가 내용 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2008/11/25 08:14:30','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] MMONG 개인정보 처리방침이 일부 개정되어 안내드립니다.','MMONG 내용. 많은 활동 부탁드립니다.',TO_DATE('2009/06/15 10:10:20','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[이벤트] Best 소모임을 찾아라!','회원 여러분들의 많은 참여 부탁드립니다.',TO_DATE('2010/09/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 자유게시판 홈페이지 검색도움말 개선 안내','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2010/10/21 16:15:40','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 마케팅정보 수신동의 확인 안내 (11/28) 제목','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2011/10/25 07:10:10','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 시스템점검으로 인한 홈페이지시스템 사용 일시 중지 안내 제목','MMONG 내용 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2011/10/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[이벤트] 이벤트 당첨자 공지','당첨자 아이디 : tpdus123',TO_DATE('2012/10/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 2014년 일부 서비스 점검 안내(9/7-8) 제목','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2011/10/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'adminABC');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'[공지] 산책로 기능 향상 안내','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2017/05/11 14:10:10','yyyy/mm/dd hh24:mi:ss'),'adminABC');









