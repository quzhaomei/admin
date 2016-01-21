package com.rycf.gjb.aop;

import java.lang.reflect.Method;
import java.util.Arrays;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import com.rycf.gjb.annotation.MethodCache;
import com.rycf.gjb.cache.RedisCache;

/**
 * AOP��̣���������־�����л���
 * @author qzm
 * @since 2015-5-13
 */
@Component
@Aspect
public class LogAspect {
	@Resource
	private RedisCache cache;//ע�뻺�������
	private Logger logger = Logger.getLogger(this.getClass());

	//��������
	@Pointcut("execution(* com.rycf.gjb.service.*.*(..))")
	public void methodCachePointcut() {
	}

	@Around("methodCachePointcut()")//����֪ͨ
	public Object around(ProceedingJoinPoint point) throws Throwable {
		String targetName = point.getTarget().getClass().getName();
		String methodName = point.getSignature().getName();
		Object[] arguments = point.getArgs();
		Class targetClass = Class.forName(targetName);
		Class[] classArr = new Class[arguments.length];
		for (int i = 0; i < arguments.length; i++) {
			classArr[i] = arguments[i].getClass();
		}
		Method method = targetClass.getMethod(methodName, classArr);
		MethodCache cacheTag = method.getAnnotation(MethodCache.class);
		Object result = null;
		if (cacheTag != null) {
			String className = cacheTag.className();
			if (MethodCache.CACHE_READ.equals(cacheTag.type())) {
				String key = methodName + Arrays.toString(arguments);
				result = cache.getObject(key);
				Integer version = cache.getString(className) == null ? 0
						: Integer.parseInt(cache.getString(className).trim());// ��ö������ݰ汾
				Integer versionMethod = cache.getString(key + "-version") == null ? 0
						: Integer.parseInt(cache.getString(key + "-version")
								.trim());// ��÷����������ݵİ汾
				if (result == null || versionMethod < version) {
					result = point.proceed();// �õ�ԭ���Ľ��
					cache.setObject(key, result);// ����key
					cache.setString(key + "-version", version + "");// ���·��������°汾��
					logger.info(methodName + Arrays.toString(arguments)
							+ ":��ѯ���ݿⲢ���뻺��");
				}
			} else if (MethodCache.CACHE_UPDATE.equals(cacheTag.type())) {
				result = point.proceed();// �õ�ԭ���Ľ��
				Integer version = cache.getString(className) == null ? 1
						: Integer.parseInt(cache.getString(className).trim()) + 1;
				cache.setString(className, version + "");// ���¶���İ汾
				logger.info(methodName + Arrays.toString(arguments) + "����Ѿ�����");
			}
		}else{
			result = point.proceed();//���û�л������ء���ֱ������
		}
		return result;
	}

}
