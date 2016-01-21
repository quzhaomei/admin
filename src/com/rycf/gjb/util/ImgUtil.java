package com.rycf.gjb.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

import javax.imageio.ImageIO;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/*******************************************************************************
 * 缩略图类（通用） 本java类能将jpg、bmp、png、gif图片文件，进行等比或非等比的大小转换。 具体使用方法
 * compressPic(大图片路径,生成小图片路径,大图片文件名,生成小图片文名,生成小图片宽度,生成小图片高度,是否等比缩放(默认为true))
 */
public class ImgUtil {
	// 图片处理
	public static void compressPic(InputStream in, String path) {
		try {
			// 获得源文件
			Image img = ImageIO.read(in);
			// 判断图片格式是否正确
			int newWidth;
			int newHeight;
			// 判断是否是等比缩放
			// 为等比缩放计算输出的图片宽度及高度
			double rate1 = ((double) img.getWidth(null)) / (double) 1200 + 0.1;
			double rate2 = ((double) img.getHeight(null)) / (double) 1200 + 0.1;
			// 根据缩放比率大的进行缩放控制
			double rate = rate1 > rate2 ? rate1 : rate2;
			newWidth = (int) (((double) img.getWidth(null)) / rate);
			newHeight = (int) (((double) img.getHeight(null)) / rate);
			BufferedImage tag = new BufferedImage((int) newWidth,
					(int) newHeight, BufferedImage.TYPE_INT_RGB);

			/*
			 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
			 */
			tag.getGraphics().drawImage(
					img.getScaledInstance(newWidth, newHeight,
							Image.SCALE_SMOOTH), 0, 0, null);
			FileOutputStream out = new FileOutputStream(path);
			// JPEGImageEncoder可适用于其他图片类型的转换
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(tag);
			out.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	//px为生成头像的尺寸
	public static void compressPic(InputStream in, String path,Integer px) {
		try {
			if(px==null){
				px=1200;
			}
			// 获得源文件
			Image img = ImageIO.read(in);
			// 判断图片格式是否正确
			int newWidth;
			int newHeight;
			// 判断是否是等比缩放
			// 为等比缩放计算输出的图片宽度及高度
			double rate1 = ((double) img.getWidth(null)) / (double) px + 0.1;
			double rate2 = ((double) img.getHeight(null)) / (double) px + 0.1;
			// 根据缩放比率大的进行缩放控制
			double rate = rate1 > rate2 ? rate1 : rate2;
			newWidth = (int) (((double) img.getWidth(null)) / rate);
			newHeight = (int) (((double) img.getHeight(null)) / rate);
			int size=newWidth>newHeight?newHeight:newWidth;
			//设置画布为正方形
			BufferedImage tag = new BufferedImage((int) size,
					(int) size, BufferedImage.TYPE_INT_RGB);

			/*
			 * Image.SCALE_SMOOTH 的缩略算法 生成缩略图片的平滑度的 优先级比速度高 生成的图片质量比较好 但速度慢
			 */
			int x=0;
			int y=0;
			if(newWidth>=newHeight){//如果偏宽
				x=-(newWidth-newHeight)/2;
			}else{//如果偏高
				y=-(newHeight-newWidth)/2;
			}
			tag.getGraphics().drawImage(
					img.getScaledInstance(newWidth, newHeight,
							Image.SCALE_SMOOTH), x, y, null);
			FileOutputStream out = new FileOutputStream(path);
			// JPEGImageEncoder可适用于其他图片类型的转换
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(out);
			encoder.encode(tag);
			out.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

}
