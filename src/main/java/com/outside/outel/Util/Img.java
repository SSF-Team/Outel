package com.outside.outel.Util;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Base64;

/**
 * @Version: 1.0
 * @Date: 2020/12/31 下午 02:41
 * @ClassName: img
 * @Author: Stapxs
 * @Description TO DO
 **/
public class Img {


    /**
     * @Author Stapx Steve
     * @Description TODO 将图片短边等比缩小（放大）为 size 并获取图片中央 size 平方像素的图片
     * @Date 下午 02:47 2020/12/31
     * @Param [img, size]
     * @return java.awt.image.BufferedImage
    **/
    public static BufferedImage getImangeInPic(BufferedImage img, int size) {
        System.out.println("================> 图片操作");
        // 缩放目标尺寸
        double width = img.getWidth();
        double height = img.getHeight();
        if(width > height) {
            width = ((double)size / height) * width;
            height = size;
        } else if(width < height) {
            height = ((double)size / width) * height;
            width= size;
        } else {
            height = width = size;
        }
        System.out.println("> 缩放目标大小：W-" + img.getWidth() + " -> " + width + ", H-" + img.getHeight() + " -> " + height);
        // 缩放
        img = toBufferedImage(img.getScaledInstance((int)width, (int)height, Image.SCALE_FAST));
        // 裁剪目标位置
        double x = 0;
        double y = 0;
        if(width > height) {
            x = (width / 2) - (size / 2);
        } else if(width < height) {
            y = (height / 2) - (size / 2);
        } else {
            return img;
        }
        img = img.getSubimage((int)x, (int)y, size, size);
        return img;
    }
    private static BufferedImage toBufferedImage(Image img)
    {
        // TODO From https://stackoverflow.com/questions/13605248/java-converting-image-to-bufferedimage/13605411
        if (img instanceof BufferedImage)
        {
            return (BufferedImage) img;
        }

        // Create a buffered image with transparency
        BufferedImage bimage = new BufferedImage(img.getWidth(null), img.getHeight(null), BufferedImage.TYPE_INT_ARGB);

        // Draw the image on to the buffered image
        Graphics2D bGr = bimage.createGraphics();
        bGr.drawImage(img, 0, 0, null);
        bGr.dispose();

        // Return the buffered image
        return bimage;
    }

    /**
     * @Author Stapx Steve
     * @Description TODO 将 Base64 图片转为 BufferedImage
     * @Date 下午 02:41 2020/12/31
     * @Param [base64string]
     * @return BufferedImage
    **/
    public static BufferedImage getBufferedImage(String base64string) throws IOException {
        String encodingPrefix = "base64,";
        int contentStartIndex = base64string.indexOf(encodingPrefix) + encodingPrefix.length();
        base64string = base64string.substring(contentStartIndex);
        byte[] bytes1 = Base64.getDecoder().decode(base64string.replace("\r\n", ""));
        ByteArrayInputStream bais = new ByteArrayInputStream(bytes1);
        return ImageIO.read(bais);
    }

    /**
     * @Author Stapx Steve
     * @Description TODO 将 BufferedImage 图片转为 Base64
     * @Date 下午 03:01 2020/12/31
     * @Param [path]
     * @return java.lang.String
    **/
    public static String getBase64(BufferedImage image) throws IOException {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        ImageIO.write(image, "jpeg", outputStream);
        String base64Img = Base64.getEncoder().encodeToString(outputStream.toByteArray());
        return "data:image/jpeg;base64," + base64Img;
    }

}
