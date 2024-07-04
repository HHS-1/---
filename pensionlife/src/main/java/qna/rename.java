package qna;

import java.text.SimpleDateFormat;
import java.util.Date;

public class rename {
	String filenm = "";
	public rename(String z) {
		this.filenm = z;
		this.re();
	}

	public void re() {
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHms");
		int rn = (int)Math.ceil(Math.random()*1500);
		//int id = filenm.lastIndexOf(".");
		//String type = filenm.substring(id);
		this.filenm = sdf.format(today)+rn+"_"+this.filenm;
	}
}
