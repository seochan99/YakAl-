package com.viewpharm.yakal.notablefeatures.dto.response;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NotableFeatureDateResponseDto {
    @NotNull
    private Long id;
    @NotNull
    private List<Integer> date;
}
