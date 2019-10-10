package com.cg.otm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cg.otm.dto.User;


public interface UserRepository extends JpaRepository<User, Long>{

	public User findByUserId(Long userId);
	



}
