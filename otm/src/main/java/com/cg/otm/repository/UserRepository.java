package com.cg.otm.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cg.otm.dto.User;

public interface UserRepository extends JpaRepository<User, Long>{

	public User findByUserId(Long id);
	public List<User> findByUserNameAndUserPassword(String userName, String userPassword);
	public Optional<User> findByUserName(String userName);
}
