package com.example.demo.domain.etc;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class GetListDTO<T> {
	 private List<T> list;
	 private int total;
}
