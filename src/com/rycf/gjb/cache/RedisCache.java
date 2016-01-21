package com.rycf.gjb.cache;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Repository;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.JedisPoolConfig;
/**
 * redis��������࣬���𻺴�java����
 * @author qzm
 * @since 2015-5-27
 */
@Repository
public class RedisCache {
	/**
	 * �����������IP
	 */
	@Value("#{propertyConfigurer['redis.ip']}")
	private String redis_ip="127.0.0.1";//127.0.0.1
	/**
	 * ����������Ķ˿�
	 */
	@Value("#{propertyConfigurer['redis.port']}")
	private Integer redis_port=6379;//6379
	/**
	 * ���û���������������
	 */
	@Value("#{propertyConfigurer['redis.live.time']}")
	private Integer liveTime=3600;//3600 (s)
	
	/**
	 * ���ӻ�������������ӳ�
	 */
	private JedisPool pool = null;
	/**
	 * ����redis���ӳ�
	 * 
	 * @param ip
	 * @param port
	 * @return JedisPool
	 */
	@PostConstruct
	public JedisPool getPool() {
		if (pool == null) {
			JedisPoolConfig config = new JedisPoolConfig();
			config.setMaxActive(500);
			config.setMaxIdle(5);
			config.setMaxWait(1000 * 100);
			config.setTestOnBorrow(true);
			pool = new JedisPool(config, redis_ip, redis_port);
		}
		return pool;
	}

	/**
	 * ���������ӳ�
	 * 
	 * @param pool
	 * @param redis
	 */
	private void returnResource(JedisPool pool, Jedis redis) {
		if (redis != null) {
			pool.returnResource(redis);
		}
	}

	/**
	 * ����ַ��ȡ���뻺����ַ�
	 * 
	 * @param key
	 * @return
	 */
	public String getString(String key) {
		String value = null;
		JedisPool pool = null;
		Jedis jedis = null;
		try {
			pool = getPool();
			jedis = pool.getResource();
			value = jedis.get(key);
		} catch (Exception e) {
			// �ͷ�redis����
			pool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			returnResource(pool, jedis);
		}
		return value;
	}
	/**
	 * ��ֵ�Դ��뻺�� String,String
	 * @param key ��
	 * @param value ֵ
	 * @return
	 */
	public String setString(String key,String value) {
		JedisPool pool = null;
		Jedis jedis = null;
		try {
			pool = getPool();
			jedis = pool.getResource();
			value = jedis.set(key, value);
		} catch (Exception e) {
			// �ͷ�redis����
			pool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			returnResource(pool, jedis);
		}
		return value;
	}
	/**
	 * ���key��ȡ����������Ķ���
	 * @param key
	 * @return
	 */
	public Object getObject(String key) {
		JedisPool pool = null;
		Jedis jedis = null;
		Object result = null;
		try {
			pool = getPool();
			jedis = pool.getResource();
			byte[] bytes = jedis.get(key.getBytes());
			result = unserialize(bytes);
		} catch (Exception e) {
			// �ͷ�redis����
			pool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			returnResource(pool, jedis);
		}
		return result;
	}
	/**
	 * ��ݼ�ֵ�Դ��뻺��String,Object
	 * @param key ��
	 * @param object ֵ
	 */
	public void setObject(String key, Object object) {
		JedisPool pool = null;
		Jedis jedis = null;
		try {
			pool = getPool();
			jedis = pool.getResource();
			jedis.setex(key.getBytes(), liveTime, serialize(object));
		} catch (Exception e) {
			// �ͷ�redis����
			pool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			returnResource(pool, jedis);
		}
	}
	/**
	 * ��ݼ�ɾ����뻺��Ķ���
	 * @param key ��
	 */
	public void delObject(String key) {
		JedisPool pool = null;
		Jedis jedis = null;
		try {
			pool = getPool();
			jedis = pool.getResource();
			jedis.del(key.getBytes());
		} catch (Exception e) {
			// �ͷ�redis����
			pool.returnBrokenResource(jedis);
			e.printStackTrace();
		} finally {
			// ���������ӳ�
			returnResource(pool, jedis);
		}
	}
	/**
	 * �Ѷ������л�������һ��Ҫʵ�����л��ӿ�
	 * @param object
	 * @return
	 */
	private byte[] serialize(Object object) {
		ObjectOutputStream oos = null;
		ByteArrayOutputStream baos = null;
		try {
			// ���л�
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(object);
			byte[] bytes = baos.toByteArray();
			return bytes;
		} catch (Exception e) {

		}
		return null;
	}
	/**
	 * �������л�
	 * @param bytes
	 * @return
	 */
	private  Object unserialize(byte[] bytes) {
		ByteArrayInputStream bais = null;
		try {
			// �����л�
			bais = new ByteArrayInputStream(bytes);
			ObjectInputStream ois = new ObjectInputStream(bais);
			return ois.readObject();
		} catch (Exception e) {

		}
		return null;
	}
}
