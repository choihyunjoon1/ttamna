
-- 계정 생성. SYSTEM계정으로 접속 후 진행
create user ttamna identified by ttamna;

-- 권한 부여
grant connect, resource, create view to ttamna;

-- 계정 확인
select username from dba_users;

-- 접속 정보 생성
-- 접속 이름 : ttamna
-- 사용자 이름 : ttamna
-- 비밀번호 : ttamna

-- DB 공용
-- 호스트이름 : 125.191.92.229
-- 포트 : 1521 
-- SID : orcl