package com.example.storecheckoutsystem.controller;

import com.example.storecheckoutsystem.model.Markup;
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
    float productPrice = produto.getPrecoCustoProduto();
    float calculatedPrice = (float) markupController.calculateProductPrice(productPrice, lastMarkup);
    produto.setNomeProduto(produto.getNomeProduto());
    produto.setPrecoCustoProduto(produto.getPrecoCustoProduto());
    produto.setPrecoFinalProduto(calculatedPrice);
    produto.setCategoriaProduto(produto.getCategoriaProduto());
    produto.setDescricaoProduto(produto.getDescricaoProduto());
    produto.setQuantidadeProduto(produto.getQuantidadeProduto());
    return produtoRepository.save(produto);
  }

  /*
   * TODO dessa forma ele está pegando o preço final do produto multiplicando pelo
   * markup e deixando o valor dessa conta dentro do preço de custo e onde seria o
   * preço final está multiplicando pelo preço de custo pelo markup ou seja.
   * 
   * No cadastro:
   * preço de custo 60
   * preço final 100.2
   * 
   * ao editar por qq valor o preço de custo
   * preço de custo 100.20
   * preçofinal 167.33
   */
  @PutMapping("editar/{id}")
  public ResponseEntity<Produto> editarProduto(@PathVariable int id, @RequestBody Produto produto) {
    Optional<Produto> optionalProduto = produtoRepository.findById(id);
    if (!optionalProduto.isPresent()) {
      return ResponseEntity.notFound().build();
    }

    Produto produtoAtual = optionalProduto.get();
    produtoAtual.setPrecoCustoProduto(produto.getPrecoCustoProduto());
    Markup lastMarkup = markupController.getLastMarkup();
    float productPrice = produto.getPrecoCustoProduto();
    float calculatedPrice = (float) markupController.calculateProductPrice(productPrice, lastMarkup);
    produtoAtual.setPrecoFinalProduto(calculatedPrice);
    Produto atualizarProduto = produtoRepository.save(produtoAtual);
    return ResponseEntity.ok(atualizarProduto);
  }

  @DeleteMapping("/excluir/{id}")
  public ResponseEntity<Void> excluirProduto(@PathVariable int id) {
    produtoRepository.deleteById(id);
    return ResponseEntity.noContent().build();

  }

  @GetMapping("/quantidade/{id}")
  public ResponseEntity<Integer> buscarQuantidadeProduto(@PathVariable int id) {
    Optional<Produto> optionalProduto = produtoRepository.findById(id);
    if (!optionalProduto.isPresent()) {
      return ResponseEntity.notFound().build();
    }

    Produto produto = optionalProduto.get();
    return ResponseEntity.ok(produto.getQuantidadeProduto());
  }

}
