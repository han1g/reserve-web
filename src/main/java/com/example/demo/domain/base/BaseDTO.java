package com.example.demo.domain.base;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class BaseDTO {
    private String deleteflg;
    
    private Date createdat;
    
    private Date updatedat;
    
    
}
