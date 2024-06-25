package domain.catalogo;

import domain.tendencias.Popularidad;

import java.time.LocalDateTime;

public class Cancion {
    private String nombre;
    private Integer dislikes;
    private Integer likes;
    private Integer cantReproducciones;
    private LocalDateTime ultReproduccion;
    private Album album;
    private Popularidad popularidad;

    public Cancion(String nombre) {
        this.nombre = nombre;
    }

    private void reproducir(){
        cantReproducciones++;

    }
    public String serReproducida(){
        this.reproducir();
        return this.popularidad.generarMensaje(this):

    }
}

