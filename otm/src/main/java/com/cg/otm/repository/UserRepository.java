package com.cg.otm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cg.otm.dto.User;

public interface UserRepository extends JpaRepository<User, Long>{

	public User findByUserId(Long id);
	public List<User> findByUserNameAndUserPassword(String userName, String userPassword);
}
