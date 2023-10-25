package com.example.storecheckoutsystem.controller;

import com.example.storecheckoutsystem.model.Markup;
import com.example.storecheckoutsystem.controller.MarkupController;

import com.example.storecheckoutsystem.model.Produto;
import com.example.storecheckoutsystem.repository.ProdutoRepository;

import java.util.Optional;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PutMapping;


@RestController
@RequestMapping("/api/produto")
public class ProdutoController {

  private static final Logger logger = LoggerFactory.getLogger(
    UsuarioController.class
    
  );
  Produto produto = new Produto();
  @Autowired
  private ProdutoRepository produtoRepository;
  @Autowired
  private MarkupController markupController;

  @GetMapping
  public ResponseEntity<Iterable<Produto>> pesquisaProduto() {
    Iterable<Produto> produtos = produtoRepository.findAll();
    return new ResponseEntity<>(produtos, HttpStatus.OK);
  }
@PostMapping("/cadastro")
public Produto cadastroProduto(@Validated @RequestBody Produto produto) {
    Markup lastMarkup = markupController.getLastMarkup();
    float productPrice = produto.getPrecoProduto();
    float calculatedPrice =  (float) markupController.calculateProductPrice(productPrice, lastMarkup);
    produto.setNomeProduto(produto.getNomeProduto());
    produto.setPrecoProduto(calculatedPrice);
    produto.setCategoriaProduto(produto.getCategoriaProduto());
    produto.setDescricaoProduto(produto.getDescricaoProduto());
    return produtoRepository.save(produto);
}

  @PutMapping("editar/{id}")
  public ResponseEntity<Produto> editarProduto(@PathVariable int id, @RequestBody Produto produto) {
      Optional<Produto> optionalProduto = produtoRepository.findById(id);
      if (!optionalProduto.isPresent()){
        return ResponseEntity.notFound().build();
      }

      produto.setId_produto(id);
      Produto atualizarProduto = produtoRepository.save(produto);

      return ResponseEntity.ok(atualizarProduto);
  }
  
  @DeleteMapping("/excluir/{id}")
  public ResponseEntity<Void> excluirProduto(@PathVariable int id){
    produtoRepository.deleteById(id);
    return ResponseEntity.noContent().build();

  }
}
