package com.cg.otm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cg.otm.dto.OnlineTest;


public interface OnlineTestRepository extends JpaRepository<OnlineTest, Long>{

	public OnlineTest findByTestId(Long testId);

}
