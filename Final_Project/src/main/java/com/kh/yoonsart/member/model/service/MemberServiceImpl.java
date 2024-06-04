package com.kh.yoonsart.member.model.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.yoonsart.member.model.dao.MemberDao;
import com.kh.yoonsart.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public Member loginMember(Member m) {
		
		return memberDao.loginMember(sqlSession, m);
		
	}

	@Override
	@Transactional
	public int insertMember(Member m) {
		// 회원가입용 서비스 MemberServiceImpl 0604 - 무진
		return memberDao.insertMember(sqlSession, m);
	}

	@Override
	public int updateMember(Member m) {
		
		return 0;
	}

	@Override
	public int deleteMember(String userId) {
		
		return 0;
	}

	@Override
	public int idCheck(String checkId) {
		
		return 0;
	}
}
