void main() {
    vec4 color = texture2D(u_texture, v_tex_coord);
    
    if (color.a > 0.1 && color.r > 0.1) {
        vec2 coord = v_tex_coord;
        
        coord.x = floor(coord.x * u_amount) / u_amount;
        coord.y = floor(coord.y * u_amount) / u_amount;
        
        vec4 texture = texture2D(u_texture, coord);
        gl_FragColor = texture;
    } else {
        gl_FragColor = color;
    }
}