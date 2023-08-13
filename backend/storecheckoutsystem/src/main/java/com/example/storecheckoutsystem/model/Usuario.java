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
    private int nivelPermissao_usuario;
}
