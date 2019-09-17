#ifdef GL_ES
#define LOWP lowp
precision mediump float;
#else
#define LOWP
#endif

varying LOWP vec4 v_ambient;
varying vec2 v_texCoords;

uniform sampler2D u_texture_diffuse;
uniform sampler2D u_texture_bump;
uniform sampler2D u_texture_light_diffuse;
uniform sampler2D u_texture_light_attenuation;

void main()
{
    vec4 diffuseColor = texture2D(u_texture_diffuse, v_texCoords);
    vec4 normalColor = texture2D(u_texture_bump, v_texCoords);
    vec4 lightDiffuseColor = texture2D(u_texture_light_diffuse, v_texCoords);
    vec4 lightAttenuationColor = texture2D(u_texture_light_attenuation, v_texCoords);

    vec3 lightColor = lightAttenuationColor.rgb;
    float attenuation = lightAttenuationColor.a;
    vec3 normal = normalize(normalColor.rgb * 2.0 - 1.0);
    vec3 lightNormal = lightDiffuseColor.rgb * 2.0 - 1.0;
    vec3 ambient = v_ambient.rgb * v_ambient.a;
    vec3 diffuse = lightColor * max(dot(normal, lightNormal), 0.0);

    vec3 intensity = ambient + diffuse * attenuation;
    vec3 final = diffuseColor.rgb * intensity * lightAttenuationColor.rgb;
    gl_FragColor = vec4(final, 1);
}