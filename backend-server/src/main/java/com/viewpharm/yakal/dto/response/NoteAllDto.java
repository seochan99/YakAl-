package com.viewpharm.yakal.dto.response;

import lombok.Builder;
import lombok.Getter;

import java.util.List;

//기능 삭제 예정
@Deprecated
@Getter
public class NoteAllDto {
    private List<NoteDetailDto> datalist;
    private PageInfo pageInfo;

    @Builder
    public NoteAllDto(List<NoteDetailDto> datalist, PageInfo pageInfo) {
        this.datalist = datalist;
        this.pageInfo = pageInfo;
    }
}
