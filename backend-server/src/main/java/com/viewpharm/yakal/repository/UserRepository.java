package com.viewpharm.yakal.repository;

import com.viewpharm.yakal.domain.User;
import com.viewpharm.yakal.base.type.EJob;
import com.viewpharm.yakal.base.type.ELoginProvider;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Optional;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findBySocialIdAndLoginProvider(String socialId, ELoginProvider loginProvider);

    Optional<User> findByIdAndIsLoginAndRefreshTokenIsNotNull(Long userId, Boolean isLogin);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.isDetail = :isDetail where u.id = :userId")
    Integer updateIsDetailById(Long userId, Boolean isDetail);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.notiIsAllowed = :notiIsAllowed where u.id = :userId")
    Integer updateNotiIsAllowedById(Long userId, Boolean notiIsAllowed);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.name = :name where u.id = :userId")
    Integer updateNameById(Long userId, String name);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.name = :name, u.isDetail = :isDetail where u.id = :userId")
    Integer updateNameAndIsDetailById(Long userId, String name, Boolean isDetail);

    @Modifying(clearAutomatically = true)
    @Query("update User u set u.isCertified = :isCertified, u.job = :job  where u.id = :userId")
    Integer updateIsCertified(Long userId, Boolean isCertified, EJob job);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.breakfast_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndBreakfastTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.lunch_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndLunchTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.dinner_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndDinnerTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query(value = "SELECT user_id as UserId, user_name as Username, COUNT(dose_id) as Count" +
            " FROM (SELECT m.user_id as user_id, name as user_name, d.id as dose_id" +
            " from mobile_users m" +
            " inner join users u on m.user_id = u.id" +
            " inner join doses d on m.user_id = d.user_id" +
            " where d.date = :date and m.dinner_time = :localTime) as q" +
            " GROUP BY user_name, user_id", nativeQuery = true)
    List<UserNotificationForm> findByDateAndTime(@Param("date") LocalDate localDate, @Param("localTime") LocalTime localTime);

    @Query("select u from User u where u.id=:id and (u.job=:doctor or u.job = :pharmacist)")
    Optional<User> findByIdAndJobOrJob(@Param("id") Long userId, @Param("doctor") EJob doctor, @Param("pharmacist") EJob pharmacist);

    Optional<User> findByIdAndJob(Long userId, EJob patient);

    List<User> findByNameAndBirthday(String name, LocalDate birthday);

    interface UserNotificationForm {
        Long getUserId();

        String getUsername();

        Integer getCount();
    }
}
