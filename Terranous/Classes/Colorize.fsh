void main() {
    vec4 color = texture2D(u_texture, v_tex_coord);
    
    if (color.a > 0.1 && color.r > 0.1) {
        
        vec3 h_color_top = vec3(0.6, 0.3, 0.8);
        vec3 h_color_bottom = vec3(0.8, 1, 1);
        //vec3 finalColor = vec3(0.01, 0.1, 1.0);
        //gl_FragColor = vec4(sqrt(clamp(finalColor, 0.0, 1.0)),1.0);
        gl_FragColor = vec4(h_color_top, 1.0, 1.0);
    } else {
        gl_FragColor = color;
    }
}