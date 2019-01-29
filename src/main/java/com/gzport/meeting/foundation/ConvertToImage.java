package com.gzport.meeting.foundation;

/**
 * Created by zhangxiang on 2019/1/28.
 */
import com.aspose.cells.ImageFormat;
import com.aspose.cells.ImageOrPrintOptions;
import com.aspose.cells.SheetRender;
import com.aspose.cells.Workbook;
import com.aspose.cells.Worksheet;
import java.io.File;

public class ConvertToImage {

    public  static void ConvertToImage (){

        String dataDir = getDataDir(ConvertToImage.class);
// Create a new Workbook object
// Open a template excel file
        Workbook book = null;
        try {
            //book = new Workbook(dataDir + "2018各项目情况.xlsx");
            book = new Workbook("D:\\file\\jiaoban2.xls");
            // Get the first worksheet
            //Worksheet sheet = book.getWorksheets().get(0);
            Worksheet sheet = book.getWorksheets().get(1);
            sheet.getPageSetup().setLeftMargin(-20);
            sheet.getPageSetup().setRightMargin(0);
            sheet.getPageSetup().setBottomMargin(0);
            sheet.getPageSetup().setTopMargin(0);

            ImageOrPrintOptions imgOptions = new ImageOrPrintOptions();
            imgOptions.setImageFormat(ImageFormat.getJpeg());
            imgOptions.setCellAutoFit(true);
            imgOptions.setOnePagePerSheet(true);
            SheetRender render = new SheetRender(sheet, imgOptions);
            render.toImage(0, "D:\\file\\SheetImage.jpg");
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public  static void ConvertToImage (Worksheet sheet,String imagePath){

        String dataDir = getDataDir(ConvertToImage.class);
        try {
            sheet.getPageSetup().setLeftMargin(-20);
            sheet.getPageSetup().setRightMargin(0);
            sheet.getPageSetup().setBottomMargin(0);
            sheet.getPageSetup().setTopMargin(0);

            ImageOrPrintOptions imgOptions = new ImageOrPrintOptions();
            imgOptions.setImageFormat(ImageFormat.getJpeg());
            imgOptions.setCellAutoFit(true);
            imgOptions.setOnePagePerSheet(true);
            SheetRender render = new SheetRender(sheet, imgOptions);
            render.toImage(0, imagePath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * @param filepath  .xls或者.xlsx文件的路径
     * @parampicpath   jpg或者png图片的路径
     */
    public  static void ConvertToImage (String filepath ,String picpath){

        String dataDir = getDataDir(ConvertToImage.class);
        Workbook book = null;
        try {
            book = new Workbook(filepath);
            Worksheet sheet = book.getWorksheets().get(0);
            ImageOrPrintOptions imgOptions = new ImageOrPrintOptions();
            imgOptions.setImageFormat(ImageFormat.getJpeg());
            imgOptions.setCellAutoFit(true);
            imgOptions.setOnePagePerSheet(true);
            imgOptions.setDefaultFont("200");
            SheetRender render = new SheetRender(sheet, imgOptions);
            render.toImage(0, picpath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String getDataDir(Class c) {
        File dir = new File(System.getProperty("user.dir"));

        System.out.println("shake" + dir.getAbsolutePath());

        dir = new File(dir, "src");
        dir = new File(dir, "main");
        dir = new File(dir, "resources");

        for (String s : c.getName().split("\\.")) {
            dir = new File(dir, s);
        }

        if (dir.exists()) {
            System.out.println("Using data directory: " + dir.toString());
        } else {
            dir.mkdirs();
            System.out.println("Creating data directory: " + dir.toString());
        }

        return dir.toString() + File.separator;
    }
}
