package com.example.storecheckoutsystem.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import jakarta.persistence.Table;

@Entity
@Table(name = "produto")
public class Produto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_produto")
    @JsonProperty("id_produto")
    private int idProduto;

    @Column(name = "nome_produto")
    @JsonProperty("nome_produto")
    private String nomeProduto;

    @Column(name = "preco_produto")
    @JsonProperty("preco_produto")
    private float precoProduto;

    @Column(name = "categoria_produto")
    @JsonProperty("categoria_produto")
    private String categoriaProduto;

    @Column(name = "descricao_produto")
    @JsonProperty("descricao_produto")
    private String descricaoProduto;

    public int getId_produto() {
        return idProduto;
    }

    public String getNomeProduto() {
        return nomeProduto;
    }

    public float getPrecoProduto() {
        return precoProduto;
    }

    public String getCategoriaProduto() {
        return categoriaProduto;
    }

    public String getDescricaoProduto() {
        return descricaoProduto;
    }


    public void setId_produto(int id_produto) {
        this.idProduto = id_produto;
    }


    public void setNomeProduto(String nomeProduto) {
        this.nomeProduto = nomeProduto;
    }


    public void setPrecoProduto(float precoProduto) {
        this.precoProduto = precoProduto;
    }


    public void setCategoriaProduto(String categoriaProduto) {
        this.categoriaProduto = categoriaProduto;
    }


    public void setDescricaoProduto(String descricaoProduto) {
        this.descricaoProduto = descricaoProduto;
    }

}
