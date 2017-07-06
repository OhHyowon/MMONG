package com.mmong.vo;

import java.io.Serializable;

public class BoardPicture implements Serializable {
	
	private int no;
	private String route;
	
	private int boardNo;
	private Board board;
	
	public BoardPicture(){}

	public BoardPicture(int no, String route, int boardNo, Board board) {
		super();
		this.no = no;
		this.route = route;
		this.boardNo = boardNo;
		this.board = board;
	}

	public BoardPicture(int no, String route, int boardNo) {
		super();
		this.no = no;
		this.route = route;
		this.boardNo = boardNo;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getRoute() {
		return route;
	}

	public void setRoute(String route) {
		this.route = route;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public Board getBoard() {
		return board;
	}

	public void setBoard(Board board) {
		this.board = board;
	}

	@Override
	public String toString() {
		return "BoardPicture [no=" + no + ", route=" + route + ", boardNo=" + boardNo + ", board=" + board + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((board == null) ? 0 : board.hashCode());
		result = prime * result + boardNo;
		result = prime * result + no;
		result = prime * result + ((route == null) ? 0 : route.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BoardPicture other = (BoardPicture) obj;
		if (board == null) {
			if (other.board != null)
				return false;
		} else if (!board.equals(other.board))
			return false;
		if (boardNo != other.boardNo)
			return false;
		if (no != other.no)
			return false;
		if (route == null) {
			if (other.route != null)
				return false;
		} else if (!route.equals(other.route))
			return false;
		return true;
	}
}
