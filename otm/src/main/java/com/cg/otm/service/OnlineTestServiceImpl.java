package com.cg.otm.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import java.util.Set;
import java.util.StringTokenizer;

import javax.transaction.Transactional;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cg.otm.dao.OnlineTestDao;
import com.cg.otm.dto.OnlineTest;
import com.cg.otm.dto.Question;
import com.cg.otm.dto.User;
import com.cg.otm.exception.ExceptionMessage;
import com.cg.otm.exception.UserException;
import com.cg.otm.repository.OnlineTestRepository;
import com.cg.otm.repository.QuestionRepository;
import com.cg.otm.repository.UserRepository;
@Service("testservice")
@Transactional
public class OnlineTestServiceImpl implements OnlineTestService{
	
	private static final Logger logger = LoggerFactory.getLogger(OnlineTestServiceImpl.class);
 

	@Autowired
	OnlineTestDao testdao;


	@Autowired
	UserRepository userRepository;
	
	@Autowired
	OnlineTestRepository onlineTestRepository;
	
	@Autowired
	QuestionRepository questionRepository;

	
	//Method to register a student
	@Override
	public User registerUser(User user) throws UserException {
		//Adding the user into the database
		User returnedUser = userRepository.save(user); 
		if (returnedUser != null)
			return user;													//User is added
		else {
			throw new UserException(ExceptionMessage.DATABASEMESSAGE);		//Not added
		}
	}

	@Override
	public Boolean answerQuestion(OnlineTest onlineTest, Question question, Integer chosenAnswer) throws UserException {
		if (!onlineTest.getTestQuestions().contains(question)) {
			throw new UserException(ExceptionMessage.QUESTIONMESSAGE);
		}
		question.setChosenAnswer(chosenAnswer);
		if (question.getChosenAnswer() == question.getQuestionAnswer()) {
			question.setMarksScored(question.getQuestionMarks());
		} else {
			question.setMarksScored(new Double(0.0));
		}
		testdao.updateQuestion(question);
		return true;
	}

	@Override
	public Question showQuestion(OnlineTest onlineTest, Long questionId) throws UserException {
		Question question = questionRepository.findByQuestionId(questionId);
		if (question == null || !onlineTest.getTestQuestions().contains(question)) {
			throw new UserException(ExceptionMessage.QUESTIONMESSAGE);
		}
		return question;
	}

	/* Method to assign a test to user
    * Author <Priya>
    */
	@Override
	public Boolean assignTest(Long userId, Long testId) throws UserException {
		User user = userRepository.findByUserId(userId);
		OnlineTest onlineTest = onlineTestRepository.findByTestId(testId);
		if (user == null) {
			logger.error("The user does not exist");
			throw new UserException(ExceptionMessage.USERMESSAGE);
		}
		if (user.getIsAdmin()) {
			logger.error("Admin cannot be assigned a test");
			throw new UserException(ExceptionMessage.ADMINMESSAGE);
		}
		if (onlineTest == null) {
			logger.error("The test does not exist");
			throw new UserException(ExceptionMessage.TESTMESSAGE);
		}
		if (onlineTest.getIsTestAssigned()) {
			logger.info("The test is already assigned");
			throw new UserException(ExceptionMessage.TESTASSIGNEDMESSAGE);
		} else {
			
		user.setUserTest(onlineTest);
		logger.info("Test is being assigned to user");
		onlineTest.setIsTestAssigned(true);
		}
		
		return true;
	}

	@Override
	public OnlineTest addTest(OnlineTest onlineTest) throws UserException {
		OnlineTest returnedTest = onlineTestRepository.save(onlineTest);
		if (returnedTest == null) {
			throw new UserException(ExceptionMessage.DATABASEMESSAGE);
		}
		return returnedTest;
	}

	@Override
	public OnlineTest updateTest(Long testId, OnlineTest onlineTest) throws UserException {
		OnlineTest temp = onlineTestRepository.findByTestId(testId);
		if (temp != null) {
			temp.setTestId(testId);
			temp.setTestName(onlineTest.getTestName());
			temp.setTestDuration(onlineTest.getTestDuration());
			temp.setStartTime(onlineTest.getStartTime());
			temp.setEndTime(onlineTest.getEndTime());
			temp.setIsdeleted(onlineTest.getIsdeleted());
			temp.setIsTestAssigned(onlineTest.getIsTestAssigned());
			temp.setTestMarksScored(onlineTest.getTestMarksScored());
			temp.setTestQuestions(onlineTest.getTestQuestions());
			temp.setTestTotalMarks(onlineTest.getTestMarksScored());
			onlineTestRepository.save(temp);
			return onlineTest;
		} else
			throw new UserException(ExceptionMessage.TESTMESSAGE);
	}

	@Override
	public OnlineTest deleteTest(Long testId) throws UserException {
		OnlineTest returnedTest = onlineTestRepository.findByTestId(testId);
		if (returnedTest != null && returnedTest.getIsdeleted() == false) {
			returnedTest.setIsdeleted(true);
		} else {
			throw new UserException(ExceptionMessage.TESTNOTFOUNDMESSAGE);
		}
		return returnedTest;
	}

	@Override
	public Question updateQuestion(Long testId, Long questionId, Question question) throws UserException {
		OnlineTest temp = onlineTestRepository.findByTestId(testId);
		if (temp != null) {
			Set<Question> quests = temp.getTestQuestions();
			Question tempQuestion = questionRepository.findByQuestionId(questionId);
			if (tempQuestion != null && quests.contains(tempQuestion)) {
				tempQuestion.setChosenAnswer(question.getChosenAnswer());
				if (tempQuestion.getChosenAnswer() == tempQuestion.getQuestionAnswer()) {
					tempQuestion.setMarksScored(question.getQuestionMarks());
				}
				question.setQuestionId(questionId);
				temp.setTestTotalMarks(
						temp.getTestTotalMarks() - tempQuestion.getQuestionMarks() + question.getQuestionMarks());
				temp.setTestMarksScored(temp.getTestMarksScored() + tempQuestion.getMarksScored());
				tempQuestion.setQuestionMarks(question.getQuestionMarks());
				tempQuestion.setIsDeleted(question.getIsDeleted());
				tempQuestion.setOnlinetest(question.getOnlinetest());
				tempQuestion.setQuestionAnswer(question.getQuestionAnswer());
				tempQuestion.setQuestionId(questionId);
				tempQuestion.setQuestionOptions(question.getQuestionOptions());
				tempQuestion.setQuestionTitle(question.getQuestionTitle());
				questionRepository.save(tempQuestion);
				onlineTestRepository.save(temp);
				return question;
			} else
				throw new UserException(ExceptionMessage.QUESTIONMESSAGE);
		} else
			throw new UserException(ExceptionMessage.TESTMESSAGE);
	}

	@Override
	public Question deleteQuestion(Long testId, Long questionId) throws UserException {
		OnlineTest temp = onlineTestRepository.findByTestId(testId);
		if (temp != null) {
			Set<Question> quests = temp.getTestQuestions();
			Question tempQuestion = questionRepository.findByQuestionId(questionId);
			if (tempQuestion != null && quests.contains(tempQuestion) && tempQuestion.getIsDeleted() == false) {
				temp.setTestTotalMarks(temp.getTestTotalMarks() - tempQuestion.getQuestionMarks());
				onlineTestRepository.save(temp);
				tempQuestion.setIsDeleted(true);
				return tempQuestion;
			} else
				throw new UserException(ExceptionMessage.QUESTIONMESSAGE);
		} else
			throw new UserException(ExceptionMessage.TESTMESSAGE);
	}

	@Override
	public Double getResult(OnlineTest onlineTest) throws UserException {
		Double score = calculateTotalMarks(onlineTest);
		onlineTest.setIsTestAssigned(false);
		testdao.updateTest(onlineTest);
		return score;
	}

	@Override
	public Double calculateTotalMarks(OnlineTest onlineTest) throws UserException {
		Double score = new Double(0.0);
		for (Question question : onlineTest.getTestQuestions()) {
			score = score + question.getMarksScored();
		}
		onlineTest.setTestMarksScored(score);
		testdao.updateTest(onlineTest);
		return score;
	}

	//Method to get User object using the ID
	@Override
	public User searchUser(Long userId) throws UserException {
		User returnedUser = userRepository.getOne(userId);			//Search user method
		if (returnedUser != null) {
			return returnedUser;									//User found
		} else {
			throw new UserException(ExceptionMessage.USERMESSAGE);	//User Not Found
		}

	}

	@Override
	public OnlineTest searchTest(Long testId) throws UserException {
		OnlineTest returnedTest = onlineTestRepository.findByTestId(testId);
		if (returnedTest != null) {
			return returnedTest;
		} else {
			throw new UserException(ExceptionMessage.TESTNOTFOUNDMESSAGE);
		}
	}

	//Update User Method
	@Override
	public User updateProfile(User user) throws UserException {
		User returnedUser = userRepository.save(user);				//Update the user
		if (returnedUser == null) {
			throw new UserException(ExceptionMessage.USERMESSAGE); //User not updated
		}
		return returnedUser;										//User Updated

	}

	//Method to list all the users
	@Override
	public List<User> getUsers() {
		return userRepository.findAll();							//Listing all the users
	}

	@Override
	public List<OnlineTest> getTests() {
		return onlineTestRepository.findAllNotAssignedAndNotDeleted();
	}

	@Override
	public Question searchQuestion(Long questionId) throws UserException {
		Question question = questionRepository.findByQuestionId(questionId);
		if (question != null) {
			return question;
		} else {
			throw new UserException(ExceptionMessage.QUESTIONNOTFOUNDMESSAGE);
		}
	}
	
	@Override
	public User login(String userName, String pass) throws UserException{
		List<User> userList = userRepository.findByUserNameAndUserPassword(userName, pass);
		if(userList.isEmpty()) {
			throw new UserException(ExceptionMessage.INVALIDLOGINMESSAGE);
		}
		else {
			return userList.get(0);
		}
	}
	
	@Override
	public void readFromExcel(long id, String fileName, long time) throws IOException, UserException {
		String UPLOAD_DIRECTORY = "E:";
		File dataFile = new File(UPLOAD_DIRECTORY + "\\" + time + fileName);
		FileInputStream fis = new FileInputStream(dataFile);
		XSSFWorkbook workbook = new XSSFWorkbook(fis);
		XSSFSheet sheet = workbook.getSheetAt(0);
		Row row;
		Double testMarks = 0.0;
		for (int i = 1; i <= sheet.getLastRowNum(); i++) {
			row = (Row) sheet.getRow(i);
			String title;
			if (row.getCell(0) == null) {
				throw new UserException(ExceptionMessage.QUESTIONTITLEMESSAGE);
			} else {
				title = row.getCell(0).toString();
			}
			String marks;
			if (row.getCell(1) == null) {
				throw new UserException(ExceptionMessage.QUESTIONMARKSMESSAGE);
			} else {
				marks = row.getCell(1).toString();
				testMarks = testMarks + Double.parseDouble(marks);
			}
			String options;
			if (row.getCell(2) == null) {
				throw new UserException(ExceptionMessage.QUESTIONOPTIONSMESSAGE);
			} else {
				options = row.getCell(2).toString();
			}
			String answer;
			if (row.getCell(3) == null) {
				throw new UserException(ExceptionMessage.QUESTIONANSWERMESSAGE);
			} else {
				answer = row.getCell(3).toString();
			}

			Question question = new Question();
			OnlineTest test = onlineTestRepository.findByTestId(id);
			if(test == null) {
				throw new UserException(ExceptionMessage.TESTNOTFOUNDMESSAGE);
			}
			test.setTestTotalMarks(testMarks);
			String option[] = new String[4];
			question.setQuestionTitle(title);
			question.setQuestionMarks(Double.parseDouble(marks));
			StringTokenizer token = new StringTokenizer(options, ",");
			int k = 0;
			while (token.hasMoreTokens()) {
				option[k] = token.nextToken();
				k++;
			}
			question.setQuestionOptions(option);
			question.setQuestionAnswer((int) Double.parseDouble(answer));
			question.setChosenAnswer(0);
			question.setIsDeleted(false);
			question.setMarksScored(new Double(0));
			question.setOnlinetest(test);
			questionRepository.save(question);
		}
		fis.close();
	}

}
