package Connection;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 * Simple Java Program to read and write dates from Excel file in Java.
 * This example particularly read Excel file in OLE format i.e.
 * Excel file with extension .xls, also known as XLS files.
 * 
 * @author WINDOWS 8
 *
 */
public class dataImport {

    public static void main(String[] args) throws FileNotFoundException, IOException {
         readFromExcel("C:\\Users\\Sakshi\\Desktop\\excel.xlsx");
    }
    

    public static void readFromExcel(String file) throws IOException{
        XSSFWorkbook myExcelBook = new XSSFWorkbook(new FileInputStream(file));
        XSSFSheet myExcelSheet = myExcelBook.getSheet("PA");
        XSSFRow row = null;
        for(int i=6;i<=76;i++) {    
            row = myExcelSheet.getRow(i);
           
            if(row.getCell(1).getCellType() == XSSFCell.CELL_TYPE_NUMERIC){
                long name = (long) row.getCell(1).getNumericCellValue();
                System.out.println("Enroll : " + name);
            }
           for(int j=2;j<=4;j++) { 
           if(row.getCell(j).getCellType() == XSSFCell.CELL_TYPE_NUMERIC){
               double name = row.getCell(j).getNumericCellValue();
               System.out.println("Q"+(j-1)+" : " + name);
           }
           }
       } 
        myExcelBook.close();
        
    }
}