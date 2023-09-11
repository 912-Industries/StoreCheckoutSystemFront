package com.example.storecheckoutsystem.controller;

import com.example.storecheckoutsystem.model.Produto;

import com.example.storecheckoutsystem.repository.ProdutoRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;

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
    public ResponseEntity<Iterable<Produto>> pesquisaProduto() {
        Iterable<Produto> produtos = produtoRepository.findAll();
        return new ResponseEntity<>(produtos, HttpStatus.OK);
    }
    
    @PostMapping("/cadastro")
    public Produto cadastroProduto(@Validated @RequestBody Produto produto) {
        produto.setNomeProduto(produto.getNomeProduto());
        produto.setPrecoProduto(produto.getPrecoProduto());
        produto.setCategoriaProduto(produto.getCategoriaProduto());
        produto.setDescricaoProduto(produto.getDescricaoProduto());
        return produtoRepository.save(produto);
    }


  
    
}
