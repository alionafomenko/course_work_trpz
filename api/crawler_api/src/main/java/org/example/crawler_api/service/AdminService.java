package org.example.crawler_api.service;


import org.example.crawler_api.model.Admin;
import org.example.crawler_api.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class AdminService {

    @Autowired
    AdminRepository adminRepository;

    public AdminService() {

    }

    public Admin loginAdmin(String login, String password) {
        return adminRepository.loginAdmin(login, password);
    }

    public void approveSite(int adminId, int siteId) {
        adminRepository.approveSite(adminId, siteId);
    }

    public void rejectSite(int siteId) {
        adminRepository.rejectSite(siteId);
    }



}
