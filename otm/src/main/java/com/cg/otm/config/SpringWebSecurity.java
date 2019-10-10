package com.cg.otm.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
public class SpringWebSecurity extends WebSecurityConfigurerAdapter {

	@Autowired
	UserDetailsService userDetailsService;
	
	@Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService);
    }
	@Bean
	public PasswordEncoder getPasswordEncoder() {
		return NoOpPasswordEncoder.getInstance();
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().antMatchers("/admin","/addtest","/addtestsubmit","/addquestionsubmit","/addquestion","/showalltests","/showallusers","/removetestsubmit","/removetest","/removequestionsubmit", "/removequestion", "/assigntestsubmit", "/assigntest","/updatetestsubmit", "/updatetest", "/updatetestinput", "/updatequestion", "/updatequestioninput", "/updatequestionsubmit", "/listquestion", "/listquestionsubmit").hasRole("ADMIN")
		.antMatchers("/user","/givetest", "/getresult").hasRole("USER")
		.antMatchers("/updateusersubmit", "/updateuser","/").permitAll()
		.and().formLogin().loginPage("/").permitAll()
		.and().logout().logoutSuccessUrl("/");
	}

}
