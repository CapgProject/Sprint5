package com.cg.otm.view;

import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.cg.otm.dto.OnlineTest;
import com.cg.otm.dto.Question;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFView extends AbstractPdfView {

	private static final Logger logger = LoggerFactory.getLogger(PDFView.class);

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("In pdf");
		
		Paragraph header = new Paragraph(
				new Chunk("Result", FontFactory.getFont(FontFactory.HELVETICA, 30)));
		document.add(header);
		try{
			OnlineTest test = (OnlineTest) model.get("test");
			Set<Question> question = test.getTestQuestions();
			int num = 1;
			for(Question quest: question) {
				Paragraph printed_question = new Paragraph(new Chunk(num +". " +  quest.getQuestionTitle()));
				Paragraph questA = new Paragraph(new Chunk("a. "+ quest.getQuestionOptions()[0]));
				Paragraph questB = new Paragraph(new Chunk("b. "+ quest.getQuestionOptions()[1]));
				Paragraph questC = new Paragraph(new Chunk("c. "+ quest.getQuestionOptions()[2]));
				Paragraph questD = new Paragraph(new Chunk("d. "+ quest.getQuestionOptions()[3]));
				Paragraph chosenAnswer = new Paragraph(new Chunk("You Chose Option number" + quest.getChosenAnswer()));
				Paragraph actualAnswer = new Paragraph(new Chunk("Actual Answer : "+ quest.getQuestionAnswer()));
				num++;
				document.add(printed_question);
				document.add(questA);
				document.add(questB);
				document.add(questC);
				document.add(questD);
				document.add(chosenAnswer);
				document.add(actualAnswer);
			}
		}catch(ClassCastException e){
			logger.error(e.getMessage());
		}
	}

}