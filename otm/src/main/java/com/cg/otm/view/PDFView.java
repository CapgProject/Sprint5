package com.cg.otm.view;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

public class PDFView extends AbstractPdfView {

	@Override
	protected void buildPdfDocument(Map<String, Object> model, Document document, PdfWriter writer,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("In pdf");
		Paragraph header = new Paragraph(
				new Chunk("Generate Pdf USing Spring Mvc", FontFactory.getFont(FontFactory.HELVETICA, 30)));

		document.add(header);
	}

}