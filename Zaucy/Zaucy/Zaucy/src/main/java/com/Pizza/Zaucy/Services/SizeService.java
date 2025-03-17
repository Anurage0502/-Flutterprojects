package com.Pizza.Zaucy.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Pizza.Zaucy.Beans.Size;
import com.Pizza.Zaucy.Repositories.SizeRepo;

@Service
public class SizeService {
    @Autowired
    private SizeRepo sizeRepository;

    public List<Size> getallSizes() {
        return sizeRepository.findAll();
    }

    public Size addSize(Size size) {
        return sizeRepository.save(size);
    }

    public Size UpdateSize(Size size, int id) {
        if (sizeRepository.existsById(id)) {
            size.setId(id);
            return sizeRepository.save(size);
        } else {
            return null;
        }
    }

    public void DeleteSize(int id) {
        sizeRepository.deleteById(id);
    }

}
