package com.rycf.gjb.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * ���󷽷������ǩ
 * @author qzm
 * @since 2015-5-13
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface MethodCache {
	/**
	 * ����Ĺ���ΪreadʱΪ�����棬ΪupdataʱΪ���»���
	 * @return
	 */
	String type() default MethodCache.CACHE_READ;
	/**
	 * ������������
	 * @return
	 */
	String className();
	public static final String CACHE_READ="read";//����
	public static final String CACHE_UPDATE="update";//����
}
