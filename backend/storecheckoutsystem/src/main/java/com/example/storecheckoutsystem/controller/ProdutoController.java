package com.example.storecheckoutsystem.controller;

import com.example.storecheckoutsystem.model.Produto;
import com.example.storecheckoutsystem.model.Usuario;
import com.example.storecheckoutsystem.repository.ProdutoRepository;
import com.example.storecheckoutsystem.repository.UsuarioRepository;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.HttpStatus;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RestController
@RequestMapping("/api/produto")
public class ProdutoController {
    private static final Logger logger = LoggerFactory.getLogger(UsuarioController.class);

    @Autowired
    private ProdutoRepository produtoRepository;

    @GetMapping
    public Iterable<Produto> pesquisaProduto() {
        return produtoRepository.findAll();
    }

    @PostMapping
    public Produto salvarProduto(@Validated @RequestBody Produto produto) {
        return produtoRepository.save(produto);
    }
}
