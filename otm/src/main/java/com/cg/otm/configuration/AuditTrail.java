package com.cg.otm.configuration;

import java.util.Optional;

import org.springframework.data.domain.AuditorAware;

public class AuditTrail implements AuditorAware<String>{

	@Override
	public Optional<String> getCurrentAuditor() {
		// TODO Auto-generated method stub
		return Optional.of("Priya");
	}

}
