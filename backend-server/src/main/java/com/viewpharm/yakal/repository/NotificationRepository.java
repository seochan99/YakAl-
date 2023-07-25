package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.Notification;
import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.dto.MessageDto;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface NotificationRepository extends JpaRepository<Notification,Long> {
    Page<Notification> findByUser(User user, Pageable pageable);
    Optional<Notification> findByIdAndUserId(Long notificationId, Long userId);
}
