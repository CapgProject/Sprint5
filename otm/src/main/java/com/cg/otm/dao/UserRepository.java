package com.cg.otm.dao;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cg.otm.dto.User;

public interface UserRepository extends JpaRepository<User, Long> {
}
