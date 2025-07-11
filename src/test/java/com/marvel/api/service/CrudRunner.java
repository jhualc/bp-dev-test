package com.marvel.api.service;


import com.intuit.karate.junit5.Karate;

public class CrudRunner {


    @Karate.Test
    Karate runCrud() {
        return Karate.run("classpath:crud.feature");
    }
}
