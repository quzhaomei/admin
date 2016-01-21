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
 * AOP编程，试用于日志，还有缓存
 * @author qzm
 * @since 2015-5-13
 */
@Component
@Aspect
public class LogAspect {
	@Resource
	private RedisCache cache;//注入缓存服务类
	private Logger logger = Logger.getLogger(this.getClass());

	//切面配置
	@Pointcut("execution(* com.rycf.gjb.service.*.*(..))")
	public void methodCachePointcut() {
	}

	@Around("methodCachePointcut()")//环绕通知
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
						: Integer.parseInt(cache.getString(className).trim());// 获得对象数据版本
				Integer versionMethod = cache.getString(key + "-version") == null ? 0
						: Integer.parseInt(cache.getString(key + "-version")
								.trim());// 获得方法返回数据的版本
				if (result == null || versionMethod < version) {
					result = point.proceed();// 得到原来的结果
					cache.setObject(key, result);// 重置key
					cache.setString(key + "-version", version + "");// 更新方法的最新版本号
					logger.info(methodName + Arrays.toString(arguments)
							+ ":查询数据库并放入缓存");
				}
			} else if (MethodCache.CACHE_UPDATE.equals(cacheTag.type())) {
				result = point.proceed();// 得到原来的结果
				Integer version = cache.getString(className) == null ? 1
						: Integer.parseInt(cache.getString(className).trim()) + 1;
				cache.setString(className, version + "");// 更新对象的版本
				logger.info(methodName + Arrays.toString(arguments) + "结果已经更新");
			}
		}else{
			result = point.proceed();//如果没有缓存拦截。则直接运行
		}
		return result;
	}

}
