package org.zerock.util.file;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import lombok.extern.log4j.Log4j;

@Log4j
public class FileUtil {

	// 파일이 존재하는지 확인하는 메서드 : File
	public static boolean isExist(File file) throws Exception{
		return file.exists();
	}
	
	// 파일이 존재하는지 확인하는 메서드 : String
	public static boolean isExist(String fileName) throws Exception {
		return toFile(fileName).exists();
	}
	
	// 문자열을 파일 객체로 만들어주는 메서드
	public static File toFile(String fileName) throws Exception {
		return new File(fileName);
	}
	
	// 파일 지우기
	public static boolean delete(File file) throws Exception {
		return file.delete();
	}
	
	// 파일 정보를 문자열로 넘겨주면 지워주는 메서드
	// realpath를 넘겨주어야 합니다.
	public static boolean remove(String fileName) throws Exception {
		// 1. 문자열을 파일 객체로 만든다.
		// 2. 있는지 확인한다.
		// 3. 삭제한다.
		// 4. 결과 리턴
		File file = toFile(fileName);
		
		if (!isExist(file))
			log.warn("삭제하려는 파일이 존재하지 않습니다.");
		else if (delete(file))
			log.warn("삭제하려는 파일이 삭제되지 않았습니다.");
		else
			log.info("파일이 삭제 되었습니다.");
		return true;
	}
	
	// 서버의 상대주소를 절대 주소로 바꿔주는 메서드
	public static String getRealPath(String path, String fileName, HttpServletRequest request) throws Exception{
		String filePath = path + "/" + fileName;
		return request.getServletContext().getRealPath(filePath);
	}
	
	// 중복파일 처리
	// 파일의 절대 위치를 받아서 중복되지 않는 File 객체를 리턴함
	public static File noDuplicate(String fileRealName) throws Exception {
		File file = null;
		int dotPos = fileRealName.lastIndexOf(".");
		String fileName = fileRealName.substring(0, dotPos); // 경로포함 파일이름
		String ext = fileRealName.substring(dotPos); // .확장자
		int cnt = 0;
		
		log.info("FileUtil.noDuplicate(): fileName= " + fileName + ", ext= " + ext);
		while(true) {
			if (cnt == 0) {
				file = toFile(fileRealName);
			}
			else {
				file = toFile(fileName + cnt + ext);
			}
			if (!isExist(file)) break; // 중복이 되지 않으면 while문을 빠져나온다.
			// 중복되면 cnt를 1 증가 시키고 while문 처음으로 돌아간다.
			cnt++;
		} // E while(true)
		return file;
	}
	
	// 서버에 올리는 메서드
	public static String upload(final String PATH, MultipartFile multipartFile, HttpServletRequest request) throws Exception {
		String fileFullName = "";
		if (multipartFile != null && !multipartFile.getOriginalFilename().equals("")) {
			String fileName = multipartFile.getOriginalFilename();
			// 서버에서 중복파일을 확인한 File 객체 생성
			File saveFile = noDuplicate(getRealPath(PATH, fileName, request));
			fileFullName = PATH + "/" + saveFile.getName();
			log.info(fileFullName);
			// 실제적인 파일 upload
			multipartFile.transferTo(saveFile);
		}
		else {
			fileFullName = PATH + "/" + "noImage.jpg";			
		}
		return fileFullName;
	}
}
