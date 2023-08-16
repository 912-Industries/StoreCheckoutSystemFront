package com.example.storecheckoutsystem.repository;


import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.storecheckoutsystem.model.Produto;
import com.example.storecheckoutsystem.model.Usuario;


@Repository
public interface ProdutoRepository extends JpaRepository<Produto, Long>{
    
}