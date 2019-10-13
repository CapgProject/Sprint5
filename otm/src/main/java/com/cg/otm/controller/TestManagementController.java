package com.cg.otm.controller;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cg.otm.dto.OnlineTest;
import com.cg.otm.dto.Question;
import com.cg.otm.dto.User;
import com.cg.otm.exception.ExceptionMessage;
import com.cg.otm.exception.UserException;
import com.cg.otm.service.OnlineTestService;
import com.cg.otm.view.PDFView;

@Controller
public class TestManagementController {

	@Autowired
	OnlineTestService testservice;

	private static final Logger logger = LoggerFactory.getLogger(TestManagementController.class);
	
	private static int num = 0;

	/*Mapping for the home page*/
	@RequestMapping(value = {"/", "/login"}, method = RequestMethod.GET)
	public String displayHomePage(@ModelAttribute("user") User user, HttpSession session) {
		User loggeduser = (User) session.getAttribute("user");
		if(loggeduser != null) {
			if(loggeduser.getIsAdmin()) {
				return "admin";
			}
			else {
				return "user";
			}
		}
		return "home";
	}

	
	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display AddTest Page
	 */
	@RequestMapping(value = "/addtest", method = RequestMethod.GET)
	public String showAddTest(HttpSession session, @ModelAttribute("test") OnlineTest test) {
		System.out.println(session.getAttribute("user"));
		return "AddTest";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method takes all the test details from admin and then set those details and add the test in database
	 * Input: A test object having all details taken as input in AddTest page
	 * Return: Return to admin page if test is added successfully and in case of any exception, stay on the AddTest page
	 */
	@RequestMapping(value = "/addtestsubmit", method = RequestMethod.POST)
	public String addTest(@ModelAttribute("test") OnlineTest test, Map<String, Object> model) {
		try {
			OnlineTest testOne = new OnlineTest();
			Set<Question> question = new HashSet<Question>();
			testOne.setTestName(test.getTestName());
			testOne.setTestTotalMarks(new Double(0));
			testOne.setTestDuration(test.getTestDuration());
			testOne.setStartTime(test.getStartTime());
			testOne.setEndTime(test.getEndTime());
			testOne.setTestMarksScored(new Double(0));
			testOne.setIsdeleted(false);
			testOne.setIsTestAssigned(false);
			testOne.setTestQuestions(question);
			testservice.addTest(testOne);
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("error", e.getMessage());
			return "AddTest";

		}
		return "admin";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display AddQuestion Page
	 */
	@RequestMapping(value = "/addquestion", method = RequestMethod.GET)
	public String showAddQuestion(@ModelAttribute("question") Question question) {
		return "AddQuestion";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method takes test id as input and then takes the excel file and if file is properly validated then it is transferred to Excel_Files folder and then request is passed to service layer
	 * Input: An excel file containing questions and the test id in which questions are to be added
	 * Return: Return to admin page if questions are added successfully and in case of any exception, stay on the AddQuestion page
	 */
	@RequestMapping(value = "/addquestionsubmit", method = RequestMethod.POST)
	public String addQuestion(@RequestParam("testid") long id, @RequestParam("exfile") MultipartFile file, Map<String, Object> model) {
		try {
			String UPLOAD_DIRECTORY = "E:";
			String fileName = file.getOriginalFilename();
			String path = System.getProperty("catalina.home");
			File pathFile = new File(UPLOAD_DIRECTORY);
			if (!pathFile.exists()) {  //If the given path does not exist then create the directory
				pathFile.mkdir();
			}

			long time = new Date().getTime();
			pathFile = new File(UPLOAD_DIRECTORY + "\\" + time + fileName);   //appending time to filename so that files cannot have same name
			try {
				file.transferTo(pathFile);  //Transfer the file to the given path
			} catch (IOException e) {
				logger.error(e.getMessage());
			}
			testservice.readFromExcel(id, fileName, time);
		} catch (UserException | IOException e) {
			logger.error(e.getMessage());
			model.put("error", e.getMessage());
			return "AddQuestion";
		}
		return "admin";
	}
	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to navigate back to the add user page
	 * Input: link click
	 * Return: add user page
	 */
	/*Mapping for the page to display add user form*/
	@RequestMapping(value = "/adduser", method = RequestMethod.GET)
	public String showAddUser(@ModelAttribute("user") User user) {
		return "AddUser";
	}

	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to add the user to the database
	 * Input: Username and Password
	 * Return: homepage
	 */
	/*Mapping for the page to display after add user form is submitted*/
	@RequestMapping(value = "/addusersubmit", method = RequestMethod.POST)
	public ModelAndView addUser(@ModelAttribute("user") User user) {
		try {
			user.setUserTest(null);
			user.setIsAdmin(false);
			user.setIsDeleted(false);
			user.setUserTest(null);
			testservice.registerUser(user);
			return new ModelAndView("home");
		} catch (UserException e) {
			logger.error(e.getMessage());
			return new ModelAndView("home","error",e.getMessage());
		} catch (Exception e) {
			logger.error(e.getMessage());
			return new ModelAndView("home","error", ExceptionMessage.USERNAMEALREADYUSEDMESSAGE);
		}
		
	}

	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display ShowTest Page where the admin can see all the tests which are not deleted and not assigned
	 */
	@RequestMapping(value = "/showalltests", method = RequestMethod.GET)
	public ModelAndView showTest() {
		List<OnlineTest> testList = testservice.getTests();
		return new ModelAndView("ShowTest", "testdata", testList);
	}

	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to show all the users from the database
	 * Input: link click
	 * Return: List all users page
	 */
	/*Mapping for the table to display all users*/
	@RequestMapping(value = "/showallusers", method = RequestMethod.GET)
	public ModelAndView showUser() {
		List<User> userList = testservice.getUsers();
		return new ModelAndView("ShowUser", "userdata", userList);
	}

	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display RemoveTest Page
	 */
	@RequestMapping(value = "/removetest", method = RequestMethod.GET)
	public String showRemoveTest() {
		return "RemoveTest";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method searches the test with given test Id and if the test is found then delete the test
	 * Input: Test Id of the test to be deleted
	 * Return: Return to admin page if test is deleted successfully and in case of any exception, stay on the RemoveTest page
	 */
	@RequestMapping(value = "removetestsubmit", method = RequestMethod.POST)
	public String removeTest(@RequestParam("testid") long id, Map<String, Object> model) {
		try {
			OnlineTest deleteTest = testservice.searchTest(id);
			testservice.deleteTest(deleteTest.getTestId());
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("error", e.getMessage());
			return "RemoveTest";
		}
		return "admin";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display RemoveQuestion Page
	 */
	@RequestMapping(value = "/removequestion", method = RequestMethod.GET)
	public String showRemoveQuestion() {
		return "RemoveQuestion";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method searches the question with given question Id and if the question is found then delete the question
	 * Input: Question Id of the question to be deleted
	 * Return: Return to admin page if question is deleted successfully and in case of any exception, stay on the RemoveQuestion page
	 */
	@RequestMapping(value = "removequestionsubmit", method = RequestMethod.POST)
	public String removeQuestion(@RequestParam("questionid") long id, Map<String, Object> model) {
		try {
			Question question = testservice.searchQuestion(id);
			testservice.deleteQuestion(question.getOnlinetest().getTestId(), question.getQuestionId());
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("error", e.getMessage());
			return "RemoveQuestion";
		}
		return "admin";
	}

	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to show the first question of the test
	 * Input: link click
	 * Return: Give Test Page
	 */
	/*Mapping for the page where the user can give test and see the first question*/
	@RequestMapping(value = "/givetest", method = RequestMethod.GET)
	public ModelAndView showQuestion(HttpSession session, @ModelAttribute("Question") Question question) {
		User currentUser = (User) session.getAttribute("user");
		ModelAndView mav = new ModelAndView("GiveTest");

		if (currentUser.getUserTest() == null) {
			mav.addObject("heading", "No Test Assigned Yet");
			return mav;
		} else {
			mav.addObject("heading", currentUser.getUserTest().getTestName());
			if (currentUser.getUserTest().getTestQuestions().toArray().length < num) {
				return new ModelAndView("user");
			}
			mav.addObject("questions", currentUser.getUserTest().getTestQuestions().toArray()[num]);
			num++;
			return mav;
		}
	}
	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to take the answers that the user chose and saving them and showing the next question
	 * Input: Chosen Answer
	 * Return: Give test Page
	 */
	/*Mapping to display questions one at a time*/
	@RequestMapping(value = "/givetest", method = RequestMethod.POST)
	public ModelAndView submitQuestion(HttpSession session, @ModelAttribute("Question") Question question) {
		User currentUser = (User) session.getAttribute("user");
		ModelAndView mav = new ModelAndView("GiveTest");
		Question quest = (Question) currentUser.getUserTest().getTestQuestions().toArray()[num - 1];
		quest.setChosenAnswer(question.getChosenAnswer());
		System.out.println(quest);
		try {
			System.out.println(
					testservice.updateQuestion(quest.getOnlinetest().getTestId(), quest.getQuestionId(), quest));

			mav.addObject("heading", currentUser.getUserTest().getTestName());
			if (num >= currentUser.getUserTest().getTestQuestions().toArray().length) {
				num = 0;
				return new ModelAndView("user");
			} else {
				mav.addObject("questions", currentUser.getUserTest().getTestQuestions().toArray()[num]);
				num++;
				return mav;
			}
		} catch (UserException e) {
			logger.error(e.getMessage());
			return new ModelAndView("user");
		}
	}

	@RequestMapping(value = "assigntest", method = RequestMethod.GET)
	public String showAssignTest() {
		return "AssignTest";
	}

	@RequestMapping(value = "assigntestsubmit", method = RequestMethod.POST)
	public String assignTest(@RequestParam("testid") long testId, @RequestParam("userid") long userId,Map<String,Object> model) {
		try {
			testservice.assignTest(userId, testId);
		} catch (UserException e) {
			model.put("error", e.getMessage());
			logger.error(e.getMessage());
		}
		return "admin";
	}

	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to get the result of the test for the logged in user
	 * Input: link click
	 * Return: get result page
	 */
	@RequestMapping(value = "/getresult", method = RequestMethod.GET)
	public ModelAndView showGetResult(HttpSession session) {
		User currentUser = (User) session.getAttribute("user");
		if (currentUser.getUserTest() ==null) {
			logger.error("No test assigned");
			return new ModelAndView("GetResult", "result", 0.0);
		}
		OnlineTest test;
		try {
			test = testservice.searchTest(currentUser.getUserTest().getTestId());
			Double marksScored = test.getTestMarksScored();
			test.setTestMarksScored(new Double(0.0));
			return new ModelAndView("GetResult", "result", marksScored);
			
		} catch (UserException e) {
			// TODO Auto-generated catch block
			logger.error(e.getMessage());
			return new ModelAndView("GetResult", "result", 0.0);
		}
		
	}

	
	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display UpdateTest Page
	 */
	@RequestMapping(value = "/updatetest", method = RequestMethod.GET)
	public String showUpdateTest(@ModelAttribute("test") OnlineTest test) {
		return "UpdateTest";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method searches the test with given test Id and if the test is found then return the test details and show the UpdateTestDetails page included in UpdateTest page
	 * Input: Test Id of the test to be deleted
	 * Return: Stay on UpdateTest page which includes UpdateTestDetails if test is found else show exception message and stay on UpdateTest page
	 */
	@RequestMapping(value = "/updatetestinput", method = RequestMethod.POST)
	public ModelAndView updateTest(@RequestParam("testid") long id, @ModelAttribute("test") OnlineTest test, Map<String, Object> model) {
		OnlineTest testOne;
		try {
			testOne = testservice.searchTest(id);
			return new ModelAndView("UpdateTest", "Update", testOne);
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("error", e.getMessage());
			return new ModelAndView("UpdateTest");
		}
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method sets the updated details in a test object and passes the details to service layer
	 * Input: Test Id of the test to be updated and the object containing updated test details
	 * Return: Return to admin page if test is updated successfully and in case of any exception, stay on the UpdateTestDetails page
	 */
	@RequestMapping(value = "/updatetestsubmit", method = RequestMethod.POST)
	public String actualUpdate(@RequestParam("testId") long id, @ModelAttribute("test") OnlineTest test, Map<String, Object> model) {
		OnlineTest testOne = new OnlineTest();
		Set<Question> questions = new HashSet<Question>();
		testOne.setTestId(id);
		testOne.setTestName(test.getTestName());
		testOne.setTestDuration(test.getTestDuration());
		testOne.setStartTime(test.getStartTime());
		testOne.setEndTime(test.getEndTime());
		testOne.setIsdeleted(false);
		testOne.setTestMarksScored(new Double(0));
		testOne.setTestTotalMarks(new Double(0));
		testOne.setTestQuestions(questions);
		testOne.setIsTestAssigned(false);
		try {
			testservice.updateTest(id, testOne);
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("errorsubmit", e.getMessage());
			return "UpdateTestDetails";
		}
		return "admin";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display UpdateQuestion Page
	 */
	@RequestMapping(value = "/updatequestion", method = RequestMethod.GET)
	public String showUpdateQuestion(@ModelAttribute("question") Question question) {
		return "UpdateQuestion";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method searches the question with given question Id and if the question is found then return the question details and show the UpdateQuestionDetails page included in UpdateQuestion page
	 * Input: Question Id of the question to be updated
	 * Return: Stay on UpdateQuestion page which includes UpdateQuestionDetails if question is found else show exception message and stay on UpdateQuestion page
	 */
	@RequestMapping(value = "/updatequestioninput", method = RequestMethod.POST)
	public ModelAndView updateQuestion(@RequestParam("questionid") long id,
			@ModelAttribute("question") Question question, Map<String, Object> model) {
		Question questionOne;
		try {
			questionOne = testservice.searchQuestion(id);
			return new ModelAndView("UpdateQuestion", "Update", questionOne);
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("error", e.getMessage());
			return new ModelAndView("UpdateQuestion");
		}
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method sets the updated details in a question object and passes the details to service layer
	 * Input: Test Id of the test which contains the question to be updated and the object containing updated question details
	 * Return: Return to admin page if question is updated successfully and in case of any exception, stay on the UpdateQuestionDetails page
	 */
	@RequestMapping(value = "/updatequestionsubmit", method = RequestMethod.POST)
	public String actualUpdate(@RequestParam("testId") long testid, @ModelAttribute("question") Question question, Map<String, Object> model) {

		OnlineTest test;
		try {
			test = testservice.searchTest(testid);
			Question questionOne = new Question();
			questionOne.setQuestionId(question.getQuestionId());
			questionOne.setQuestionTitle(question.getQuestionTitle());
			questionOne.setQuestionOptions(question.getQuestionOptions());
			questionOne.setQuestionAnswer(question.getQuestionAnswer());
			questionOne.setQuestionMarks(question.getQuestionMarks());
			questionOne.setChosenAnswer(0);
			questionOne.setIsDeleted(false);
			questionOne.setMarksScored(new Double(0));
			questionOne.setOnlinetest(test);
			testservice.updateQuestion(testid, question.getQuestionId(), questionOne);
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("errorsubmit", e.getMessage());
			return "UpdateQuestionDetails";
		}
		return "admin";
	}

	@RequestMapping(value = "/updateuser", method = RequestMethod.GET)
	public ModelAndView showUpdateUser(@ModelAttribute("user") User user, HttpSession session) {
		
		User originalUser = (User) session.getAttribute("user");
		if (originalUser.getIsAdmin()) {
			return new ModelAndView("UpdateAdminDetails", "Update", session.getAttribute("user"));
		}
		else {
			return new ModelAndView("UpdateUserDetails", "Update", session.getAttribute("user"));
		}
	}

	@RequestMapping(value = "/updateusersubmit", method = RequestMethod.POST)
	public String actualUpdate(@ModelAttribute("user") User user, HttpSession session,Map<String,Object> model) {
		User originalUser = (User) session.getAttribute("user");
		try {
			User userOne = testservice.searchUser(user.getUserId());
			userOne.setUserName(user.getUserName());
			userOne.setUserPassword(user.getUserPassword());
			userOne.setIsDeleted(false);

			userOne.setIsAdmin(originalUser.getIsAdmin());
			testservice.updateProfile(userOne);
			logger.info("User details updated");
		} catch (UserException e) {
			model.put("error", e.getMessage());
			logger.error(e.getMessage());
		}
		if (originalUser.getIsAdmin()) {
			logger.info("This user is an admin");
			return "admin";
			
		} else {
			logger.info("This user is not  an admin");
			return "user";
			
		}
	}

	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to login the user to the application
	 * Input: Username and Password
	 * Return: Student Page(Normal User), Admin Page(Admin), home page[with error](if wrong input)
	 */
	@RequestMapping(value = "/onlogin", method = RequestMethod.POST)
	public ModelAndView onLogin(@ModelAttribute("user") User user, HttpSession session) {
		User foundUser=null;
		try {
			foundUser = testservice.login(user.getUserName(), user.getUserPassword());
		} catch (UserException e) {
			logger.error(e.getMessage());
		}
		if (foundUser != null) {
			session.setAttribute("user", foundUser);
			if (foundUser.getIsAdmin()) {
				return new ModelAndView("admin");
			} else {
				return new ModelAndView("user");
			}
		} else {
			return new ModelAndView("home","error","Either the Username or Password was incorrect!");
		}

	}
	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to logout the user from the application and invalidate its sessions
	 * Input: button click
	 * Return: home page
	 */
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String onLogout(HttpSession session, @ModelAttribute("user") User user) {
		session.invalidate();
		return "home";
	}

	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to navigate back to the user page
	 * Input: link click
	 * Return: user page
	 */
	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String user(HttpSession session) {

		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username="",password="";
		if(principal instanceof UserDetails) {
			username = ((UserDetails)principal).getUsername();
			password = ((UserDetails)principal).getPassword();
		}
		try {
			User user = testservice.login(username, password);
			session.setAttribute("user", user);
		} catch (UserException e) {
			logger.error(e.getMessage());
		}
		return "user";
	}
	/*
	 * Author: Piyush Daswani
	 * Description: This Method is used to navigate back to the admin page
	 * Input: button click
	 * Return: admin page
	 */
	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String admin(HttpSession session) {
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String username="",password="";
		if(principal instanceof UserDetails) {
			username = ((UserDetails)principal).getUsername();
			password = ((UserDetails)principal).getPassword();
		}
		try {
			User user = testservice.login(username, password);
			session.setAttribute("user", user);
		} catch (UserException e) {
			logger.error(e.getMessage());
		}
		return "admin";
	}
	
	/*
	 * Author: Swanand Pande
	 * Description: This is a mapping to display ListQuestion Page
	 */
	@RequestMapping(value = "/listquestion", method = RequestMethod.GET)
	public String showListQuestion() {
		return "ListQuestion";
	}

	/*
	 * Author: Swanand Pande
	 * Description: This method displays all the questions which are present in a given test
	 * Input: Test Id of the test whose questions are to be returned
	 * Return: Stay on the ListQuestion page in case of any exception
	 */
	@RequestMapping(value = "/listquestionsubmit", method = RequestMethod.POST)
	public ModelAndView submitListQuestion(@RequestParam("testId") long testId, Map<String, Object> model) {
		try {
			OnlineTest test = testservice.searchTest(testId);
			List<Question> list = new ArrayList<Question>();
			Set<Question> questions = test.getTestQuestions();
			questions.forEach(question->{
				if(question.getIsDeleted()!=true) {
					list.add(question);
				}
			});
			return new ModelAndView("ListQuestion", "questiondata", list);
		} catch (UserException e) {
			logger.error(e.getMessage());
			model.put("error", e.getMessage());
			return new ModelAndView("ListQuestion");
		}
	}
	
	@RequestMapping(value = "/resultpdf", method = RequestMethod.GET)
	public ModelAndView getResultPdf() {	
		return new ModelAndView(new PDFView(),"Result","Result");
	}
	
}
