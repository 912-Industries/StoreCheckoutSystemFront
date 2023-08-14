package com.example.storecheckoutsystem.model;

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
    private String nome_usuario; 
    private String email_usuario;
    private String senha_usuario;
    private int nivel_permissao_usuario;

    public int getId_usuario() {
        return id_usuario;
    }

    public String getNome_usuario() {
        return nome_usuario;
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

