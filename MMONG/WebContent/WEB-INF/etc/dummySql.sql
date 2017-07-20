INSERT INTO health VALUES(health_no_seq.nextval, '면역증강제','m');
INSERT INTO health VALUES(health_no_seq.nextval, '면역증강제','g');						INSERT INTO health VALUES(health_no_seq.nextval, '면역증강제','c');		
INSERT INTO health VALUES(health_no_seq.nextval, '회충약 복용','m');
INSERT INTO health VALUES(health_no_seq.nextval, '회충약 복용','g');					INSERT INTO health VALUES(health_no_seq.nextval, '회충약 복용','c');				
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 1차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 1차','g');					INSERT INTO health VALUES(health_no_seq.nextval, '종합백신 1차','c');	
INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 1차','m');
INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 1차','g');				INSERT INTO health VALUES(health_no_seq.nextval, '코로나 장염 1차','c');	
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


INSERT INTO users VALUES('admin999', 'pwd', 'ROLE_0', 1);
INSERT INTO administrator VALUES('admin999', '어드민', '01029934482', 'admin@kosta.or.kr');

INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'MMONG 홈페이지 개설 안내','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2006/10/25 16:10:40','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'홈페이지 점검 안내','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2006/10/25 16:10:40','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항1','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2007/10/25 16:10:40','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항2','MMONG 홈페이지가 내용 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2008/11/25 08:14:30','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항3','MMONG 내용. 많은 활동 부탁드립니다.',TO_DATE('2009/06/15 10:10:20','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항4','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2010/10/21 16:15:40','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항5 제목','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2011/10/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항6 제목','MMONG 내용 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2011/10/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항7 제목','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2011/10/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항8','MMONG 홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2011/10/11 06:10:10','yyyy/mm/dd hh24:mi:ss'),'admin999');
INSERT INTO administrator_notice VALUES(administrator_notice_no_seq.nextval,'공지사항9 제목','MMONG 내용홈페이지가 개설 되었습니다. 많은 활동 부탁드립니다.',TO_DATE('2012/10/25 06:10:10','yyyy/mm/dd hh24:mi:ss'),'admin999');










