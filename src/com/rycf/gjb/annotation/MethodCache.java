package com.rycf.gjb.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 对象方法缓存标签
 * @author qzm
 * @since 2015-5-13
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface MethodCache {
	/**
	 * 缓存的规则，为read时为读缓存，为updata时为更新缓存
	 * @return
	 */
	String type() default MethodCache.CACHE_READ;
	/**
	 * 缓存的类的名称
	 * @return
	 */
	String className();
	public static final String CACHE_READ="read";//读，
	public static final String CACHE_UPDATE="update";//更新
}
