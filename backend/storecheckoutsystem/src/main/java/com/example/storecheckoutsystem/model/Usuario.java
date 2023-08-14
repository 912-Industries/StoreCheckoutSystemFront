package com.example.storecheckoutsystem.model;

import com.fasterxml.jackson.annotation.JsonProperty;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "usuario")
public class Usuario {

  @Id
  @GeneratedValue(strategy = GenerationType.AUTO)
  private int id_usuario;

  @Column(name = "nome_usuario")
  @JsonProperty("nome_usuario")
  private String nomeUsuario;

  @Column(name = "email_usuario")
  @JsonProperty("email_usuario")
  private String email_usuario;

  @Column(name = "senha_usuario")
  @JsonProperty("senha_usuario")
  private String senha_usuario;

  @Column(name = "nivel_permissao_usuario")
  @JsonProperty("nivel_permissao_usuario")
  private int nivel_permissao_usuario;

  public int getId_usuario() {
    return id_usuario;
  }

  public String getNome_usuario() {
    return nomeUsuario;
  }

  public String getEmail_usuario() {
    return email_usuario;
  }

  public String getSenha_usuario() {
    return senha_usuario;
  }

  public int getNivel_permissao_usuario() {
    return nivel_permissao_usuario;
  }
}
