package com.maitrongnghia.controller;

import org.springframework.context.ResourceLoaderAware;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

public class CustomLoader implements ResourceLoaderAware {
	
	private ResourceLoader resourceLoader;

	public void setResourceLoader(ResourceLoader arg) {
		resourceLoader = arg;
	}

	public Resource getResource(String duongdan) {
		// TODO Auto-generated method stub
		return resourceLoader.getResource(duongdan);
	}

}
