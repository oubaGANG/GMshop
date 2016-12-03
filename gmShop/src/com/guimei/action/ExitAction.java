package com.guimei.action;

public class ExitAction extends BaseAction{
	
	public String exit() throws Exception {
		// TODO Auto-generated method stub
		request.getSession().invalidate();
		return "exit";
	}

}
