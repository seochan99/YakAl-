package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

@Getter
@Builder
public class DoseCodesDto {
    private String kdCode;
    private String atcCode;
}
