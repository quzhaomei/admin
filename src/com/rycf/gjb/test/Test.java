package com.rycf.gjb.test;

import java.util.ArrayList;
import java.util.List;


public class Test {
	public static void main(String[] args) {
		final List<Integer> food=new ArrayList<Integer>();
		final String get="watch";
		final String eat="watch";
		 Runnable load=new Runnable() {
			@Override
			public void run() {
				synchronized (get) {
					for(int i=0;i<=100;i++){
							food.add(i);
							System.out.println("补充了一点 i="+i);
						
							if(food.size()>0){
									eat.notify();
							}else{
								get.notify();
								try {
									eat.wait();
								} catch (InterruptedException e) {
									e.printStackTrace();
								}
							}
					}
					
				}
			}
		};
		
		Runnable ready=new Runnable() {
			@Override
			public void run() {
				synchronized (eat) {
				for(int i=0;i<=100;i++){
					if(food.size()>0){
						food.remove(0);
						System.out.println("吃掉了一点");
					}else{
						get.notify();
						try {
							eat.wait();
						} catch (InterruptedException e) {
							e.printStackTrace();
						}
						
					}
				}
				}
			}
		};
		Thread thread=new Thread(load);
		Thread thread1=new Thread(ready);
		thread1.start();
		thread.start();
		
		
	}
}
