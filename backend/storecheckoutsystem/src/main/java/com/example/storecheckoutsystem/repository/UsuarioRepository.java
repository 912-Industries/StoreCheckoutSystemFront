package com.example.storecheckoutsystem.repository;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.storecheckoutsystem.model.Usuario;

@Repository
    public interface UsuarioRepository extends CrudRepository<Usuario,Integer>{

    }

