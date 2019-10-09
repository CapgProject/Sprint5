package com.cg.otm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.cg.otm.dto.Question;

public interface QuestionRepository extends JpaRepository<Question, Long>{

}
