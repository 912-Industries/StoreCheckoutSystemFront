package com.example.storecheckoutsystem.repository;

import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import com.example.storecheckoutsystem.model.Produto;

public interface AutoCompleteRepository extends JpaRepository<Produto, Long> {

    @Query(
    value = "SELECT nome_produto, id_produto, categoria_produto FROM produto WHERE " +
            "LOWER(nome_produto) LIKE LOWER(CONCAT('%', :term, '%')) OR " +
            "CAST(id_produto AS CHAR(50)) LIKE LOWER(CONCAT('%', :term, '%')) OR " +
            "LOWER(categoria_produto) LIKE LOWER(CONCAT('%', :term, '%'))",
    nativeQuery = true
)
List<Object[]> findSuggestions(String term);
}