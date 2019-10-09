package com.cg.otm.dao;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cg.otm.dto.User;

public interface UserRepository extends JpaRepository<User, Long> {
	public List<User> findByUserNameAndUserPassword(String userName, String userPassword);
}
