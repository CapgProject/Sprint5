package com.cg.otm.exception;

public class UserException extends RuntimeException{
	
	private static final long serialVersionUID = -713445405585046419L;

	public UserException() {
		super();
	}
	
	public UserException(String exceptionMessage) {
		super(exceptionMessage);
	}

}
