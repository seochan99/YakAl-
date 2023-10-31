package com.viewpharm.yakal.medicalestablishments.domain;

import com.viewpharm.yakal.base.type.EMedical;
import com.viewpharm.yakal.medicalestablishments.domain.MedicalEstablishment;
import com.viewpharm.yakal.user.domain.User;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor
@Table(name = "expert_certifications")
public class ExpertCertification {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "medical_establishment_id", nullable = false)
    private MedicalEstablishment medicalEstablishment;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(name = "type", nullable = false)
    @Enumerated(EnumType.STRING)
    private EMedical type;

    @Column(name = "license_img", nullable = false)
    private String licenseImg;

    @Column(name = "affiliation_img", nullable = false)
    private String affiliationImg;

    // 처리 상태
    @Column(name = "is_processed", nullable = false)
    private Boolean isProcessed = Boolean.FALSE;

    @Builder
    public ExpertCertification(MedicalEstablishment medicalEstablishment, User user, EMedical type, String licenseImg, String affiliationImg) {
        this.medicalEstablishment = medicalEstablishment;
        this.user = user;
        this.type = type;
        this.licenseImg = licenseImg;
        this.affiliationImg = affiliationImg;
    }
}