Shader "Ciconia Studio/Effects/Cartoon Water/2Sided/Advanced Water" {
    Properties {
        [Space(15)][Header(Main Properties)]
        [Space(10)]_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Diffuse", 2D) = "white" {}
        _Tiling ("Tiling", Float ) = 1
        [Space(10)]_AnimationSpeed ("Animation Speed", Range(0, 10)) = 0.05
        _Angle ("Angle (Degree)", Float ) = 0

        [Space(25)][MaterialToggle] _Activesecondarytexture ("Active secondary texture", Float ) = 0
        [Space(10)]_Color2 ("Color2", Color) = (1,1,1,1)
        _Diffuse2 ("Diffuse2", 2D) = "white" {}
        _Tiling2 ("Tiling2", Float ) = 1
        [Space(10)]_TransparenceDiffuse2 ("Transparency", Range(0, 1)) = 0
        [Space(10)]_AnimationSpeed2 ("Animation Speed2", Range(0, 10)) = 0.05
        _Angle2 ("Angle (Degree)", Float ) = 0

        [Space(15)][Header(Turbulence Properties)]
        [Space(10)][MaterialToggle] _VisualizeMap ("Visualize Map", Float ) = 1
        [Space(10)]_WaveMap ("Wave Map", 2D) = "white" {}
        _TilingTurbulencemap ("Tiling", Float ) = 1
        [Space(10)]_Speed ("Speed", Range(0, 1)) = 0.02
        _AngleTurbulence ("Angle (Degree)", Float ) = 0
        [Space(10)]_DistortionAmount ("Distortion Amount", Range(0, 4)) = 0.5
        _Multiplicator ("Multiplicator", Float ) = 1
        [Space(10)]_SmoothDeformation ("Smooth Deformation", Range(0, 8)) = 0

        [Space(15)][Header(Foam Properties)]
        [Space(10)][MaterialToggle] _LinearDodge ("Linear Dodge", Float ) = 0
        [Space(10)]_FoamTextureBlackandwhite ("Foam Texture (Black and white)", 2D) = "white" {}
        _TilingFoam ("Tiling", Float ) = 1
        [Space(10)][MaterialToggle] _EnableWhiteFoamOntop ("Enable White Foam On top", Float ) = 1
        [Space(10)]_FoamIntensity ("Foam Intensity", Range(0, 2)) = 1
        _FoamDepth ("Foam Depth", Range(0, 10)) = 1
        _Foamspeed ("Foam speed", Range(0, 0.5)) = 0

        [Space(25)]_TideColor ("Tide Color", Color) = (1,1,1,1)
        [Space(10)]_TideIntensity ("Tide Intensity", Range(0, 1)) = 0.1
        _TideDepth ("Tide Depth", Range(0, 10)) = 1

        [Space(15)][Header(Camera Blend Properties)]
        [Space(10)][MaterialToggle] _EnableDistanceColor ("Enable Distance Color", Float ) = 1
        [Space(10)]_ColorDistance ("Color Distance", Color) = (1,1,1,1)
        _Diffusetocolor ("Diffuse to color", Range(0, 1)) = 0
        [Space(10)]_Distancevalue ("Distance value", Float ) = 7
        _Falloff ("Falloff", Float ) = 0.5
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _ColorDistance;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _AnimationSpeed2;
            uniform sampler2D _Diffuse2; uniform float4 _Diffuse2_ST;
            uniform float _AnimationSpeed;
            uniform float _Diffusetocolor;
            uniform float _Tiling;
            uniform float _Distancevalue;
            uniform float _Falloff;
            uniform fixed _EnableDistanceColor;
            uniform float4 _Color;
            uniform float4 _Color2;
            uniform float _Tiling2;
            uniform sampler2D _WaveMap; uniform float4 _WaveMap_ST;
            uniform float _SmoothDeformation;
            uniform float _DistortionAmount;
            uniform float _Multiplicator;
            uniform float _Speed;
            uniform fixed _VisualizeMap;
            uniform float _TilingTurbulencemap;
            uniform float _FoamDepth;
            uniform float4 _TideColor;
            uniform float _TideDepth;
            uniform float _Foamspeed;
            uniform sampler2D _FoamTextureBlackandwhite; uniform float4 _FoamTextureBlackandwhite_ST;
            uniform float _FoamIntensity;
            uniform fixed _LinearDodge;
            uniform fixed _Activesecondarytexture;
            uniform float _AngleTurbulence;
            uniform float _Angle;
            uniform float _Angle2;
            uniform float _TilingFoam;
            uniform float _TideIntensity;
            uniform fixed _EnableWhiteFoamOntop;
            uniform float _TransparenceDiffuse2;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 projPos : TEXCOORD7;
                LIGHTING_COORDS(8,9)
                UNITY_FOG_COORDS(10)
                #if defined(LIGHTMAP_ON) || defined(UNITY_SHOULD_SAMPLE_SH)
                    float4 ambientOrLightmapUV : TEXCOORD11;
                #endif
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                #ifdef LIGHTMAP_ON
                    o.ambientOrLightmapUV.xy = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
                    o.ambientOrLightmapUV.zw = 0;
                #elif UNITY_SHOULD_SAMPLE_SH
                #endif
                #ifdef DYNAMICLIGHTMAP_ON
                    o.ambientOrLightmapUV.zw = v.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
                #endif
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// GI Data:
                UnityLight light;
                #ifdef LIGHTMAP_OFF
                    light.color = lightColor;
                    light.dir = lightDirection;
                    light.ndotl = LambertTerm (normalDirection, light.dir);
                #else
                    light.color = half3(0.f, 0.f, 0.f);
                    light.ndotl = 0.0f;
                    light.dir = half3(0.f, 0.f, 0.f);
                #endif
                UnityGIInput d;
                d.light = light;
                d.worldPos = i.posWorld.xyz;
                d.worldViewDir = viewDirection;
                d.atten = attenuation;
                #if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
                    d.ambient = 0;
                    d.lightmapUV = i.ambientOrLightmapUV;
                #else
                    d.ambient = i.ambientOrLightmapUV;
                #endif
                Unity_GlossyEnvironmentData ugls_en_data;
                ugls_en_data.roughness = 1.0 - 0;
                ugls_en_data.reflUVW = viewReflectDirection;
                UnityGI gi = UnityGlobalIllumination(d, 1, normalDirection, ugls_en_data );
                lightDirection = gi.light.dir;
                lightColor = gi.light.color;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float3 indirectDiffuse = float3(0,0,0);
                indirectDiffuse += gi.indirect.diffuse;
                float4 node_311 = _Time;
                float node_7662_ang = node_311.g;
                float node_7662_spd = _Foamspeed;
                float node_7662_cos = cos(node_7662_spd*node_7662_ang);
                float node_7662_sin = sin(node_7662_spd*node_7662_ang);
                float2 node_7662_piv = float2(0.5,0.5);
                float2 node_2694 = ((i.uv0*4.0)*_TilingFoam);
                float2 node_7662 = (mul(node_2694-node_7662_piv,float2x2( node_7662_cos, -node_7662_sin, node_7662_sin, node_7662_cos))+node_7662_piv);
                float4 _FoamTexture1 = tex2D(_FoamTextureBlackandwhite,TRANSFORM_TEX(node_7662, _FoamTextureBlackandwhite));
                float node_200_ang = node_311.g;
                float node_200_spd = (-1*_Foamspeed);
                float node_200_cos = cos(node_200_spd*node_200_ang);
                float node_200_sin = sin(node_200_spd*node_200_ang);
                float2 node_200_piv = float2(0.5,0.5);
                float2 node_200 = (mul(node_2694-node_200_piv,float2x2( node_200_cos, -node_200_sin, node_200_sin, node_200_cos))+node_200_piv);
                float2 node_9929 = (node_200+float2(0.6,0.6));
                float4 _FoamTexture2 = tex2D(_FoamTextureBlackandwhite,TRANSFORM_TEX(node_9929, _FoamTextureBlackandwhite));
                float3 ColorDistance = _ColorDistance.rgb;
                float4 node_2489 = _Time;
                float node_9007_ang = ((_AngleTurbulence*3.141592654)/180.0);
                float node_9007_spd = 1.0;
                float node_9007_cos = cos(node_9007_spd*node_9007_ang);
                float node_9007_sin = sin(node_9007_spd*node_9007_ang);
                float2 node_9007_piv = float2(0.5,0.5);
                float2 node_9007 = (mul((i.uv0*_TilingTurbulencemap)-node_9007_piv,float2x2( node_9007_cos, -node_9007_sin, node_9007_sin, node_9007_cos))+node_9007_piv);
                float2 node_6468 = (node_9007+(node_2489.g*_Speed)*float2(0,0.1));
                float4 _WaveMap_var = tex2Dlod(_WaveMap,float4(TRANSFORM_TEX(node_6468, _WaveMap),0.0,_SmoothDeformation));
                float2 Turbulence = lerp(i.uv0,_WaveMap_var.rgb.rg,(lerp(0,0.1,_DistortionAmount)*_Multiplicator));
                float4 node_8333 = _Time;
                float node_7396_ang = (((_Angle*3.141592654)/180.0)+90.0);
                float node_7396_spd = 1.0;
                float node_7396_cos = cos(node_7396_spd*node_7396_ang);
                float node_7396_sin = sin(node_7396_spd*node_7396_ang);
                float2 node_7396_piv = float2(0.5,0.5);
                float2 node_7396 = (mul(((i.uv0*4.0)*_Tiling)-node_7396_piv,float2x2( node_7396_cos, -node_7396_sin, node_7396_sin, node_7396_cos))+node_7396_piv);
                float2 node_6553 = (Turbulence+(node_7396+(node_8333.g*_AnimationSpeed)*float2(0,0.6)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_6553, _MainTex));
                float3 node_6684 = (_Color.rgb*_MainTex_var.rgb);
                float4 node_5680 = _Time;
                float node_7767_ang = ((_Angle2*3.141592654)/180.0);
                float node_7767_spd = 1.0;
                float node_7767_cos = cos(node_7767_spd*node_7767_ang);
                float node_7767_sin = sin(node_7767_spd*node_7767_ang);
                float2 node_7767_piv = float2(0.5,0.5);
                float2 node_7767 = (mul(((i.uv0*4.0)*_Tiling2)-node_7767_piv,float2x2( node_7767_cos, -node_7767_sin, node_7767_sin, node_7767_cos))+node_7767_piv);
                float2 node_1757 = (Turbulence+(node_7767+(node_5680.g*_AnimationSpeed2)*float2(0.6,0)));
                float4 _Diffuse2_var = tex2D(_Diffuse2,TRANSFORM_TEX(node_1757, _Diffuse2));
                float3 diffuseColor = lerp( saturate((1.0-(1.0-saturate(max((_TideColor.rgb*(1.0 - saturate((sceneZ-partZ)/_TideDepth))*lerp(0,10,_TideIntensity)),((lerp( saturate((_FoamTexture1.rgb*_FoamTexture2.rgb)), saturate((_FoamTexture1.rgb+_FoamTexture2.rgb)), _LinearDodge )*_FoamIntensity*lerp( _TideColor.rgb, float3(1,1,1), _EnableWhiteFoamOntop ))*(1.0 - saturate((sceneZ-partZ)/_FoamDepth))))))*(1.0-lerp(_ColorDistance.rgb,lerp(ColorDistance,lerp( node_6684, saturate(( (_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2))) > 0.5 ? (1.0-(1.0-2.0*((_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2)))-0.5))*(1.0-node_6684)) : (2.0*(_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2)))*node_6684) )), _Activesecondarytexture ),(1.0 - _Diffusetocolor)),lerp( 1.0, saturate(pow(saturate((_Distancevalue/distance(i.posWorld.rgb,_WorldSpaceCameraPos))),_Falloff)), _EnableDistanceColor ))))), float3(Turbulence,0.0), _VisualizeMap );
                float3 diffuse = (directDiffuse + indirectDiffuse) * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor,1);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            Cull Off
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _ColorDistance;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _AnimationSpeed2;
            uniform sampler2D _Diffuse2; uniform float4 _Diffuse2_ST;
            uniform float _AnimationSpeed;
            uniform float _Diffusetocolor;
            uniform float _Tiling;
            uniform float _Distancevalue;
            uniform float _Falloff;
            uniform fixed _EnableDistanceColor;
            uniform float4 _Color;
            uniform float4 _Color2;
            uniform float _Tiling2;
            uniform sampler2D _WaveMap; uniform float4 _WaveMap_ST;
            uniform float _SmoothDeformation;
            uniform float _DistortionAmount;
            uniform float _Multiplicator;
            uniform float _Speed;
            uniform fixed _VisualizeMap;
            uniform float _TilingTurbulencemap;
            uniform float _FoamDepth;
            uniform float4 _TideColor;
            uniform float _TideDepth;
            uniform float _Foamspeed;
            uniform sampler2D _FoamTextureBlackandwhite; uniform float4 _FoamTextureBlackandwhite_ST;
            uniform float _FoamIntensity;
            uniform fixed _LinearDodge;
            uniform fixed _Activesecondarytexture;
            uniform float _AngleTurbulence;
            uniform float _Angle;
            uniform float _Angle2;
            uniform float _TilingFoam;
            uniform float _TideIntensity;
            uniform fixed _EnableWhiteFoamOntop;
            uniform float _TransparenceDiffuse2;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float3 normalDir : TEXCOORD4;
                float3 tangentDir : TEXCOORD5;
                float3 bitangentDir : TEXCOORD6;
                float4 projPos : TEXCOORD7;
                LIGHTING_COORDS(8,9)
                UNITY_FOG_COORDS(10)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                i.normalDir = normalize(i.normalDir);
                i.normalDir *= faceSign;
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float3 attenColor = attenuation * _LightColor0.xyz;
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
/////// Diffuse:
                float NdotL = max(0.0,dot( normalDirection, lightDirection ));
                float3 directDiffuse = max( 0.0, NdotL) * attenColor;
                float4 node_5618 = _Time;
                float node_7662_ang = node_5618.g;
                float node_7662_spd = _Foamspeed;
                float node_7662_cos = cos(node_7662_spd*node_7662_ang);
                float node_7662_sin = sin(node_7662_spd*node_7662_ang);
                float2 node_7662_piv = float2(0.5,0.5);
                float2 node_2694 = ((i.uv0*4.0)*_TilingFoam);
                float2 node_7662 = (mul(node_2694-node_7662_piv,float2x2( node_7662_cos, -node_7662_sin, node_7662_sin, node_7662_cos))+node_7662_piv);
                float4 _FoamTexture1 = tex2D(_FoamTextureBlackandwhite,TRANSFORM_TEX(node_7662, _FoamTextureBlackandwhite));
                float node_200_ang = node_5618.g;
                float node_200_spd = (-1*_Foamspeed);
                float node_200_cos = cos(node_200_spd*node_200_ang);
                float node_200_sin = sin(node_200_spd*node_200_ang);
                float2 node_200_piv = float2(0.5,0.5);
                float2 node_200 = (mul(node_2694-node_200_piv,float2x2( node_200_cos, -node_200_sin, node_200_sin, node_200_cos))+node_200_piv);
                float2 node_9929 = (node_200+float2(0.6,0.6));
                float4 _FoamTexture2 = tex2D(_FoamTextureBlackandwhite,TRANSFORM_TEX(node_9929, _FoamTextureBlackandwhite));
                float3 ColorDistance = _ColorDistance.rgb;
                float4 node_2489 = _Time;
                float node_9007_ang = ((_AngleTurbulence*3.141592654)/180.0);
                float node_9007_spd = 1.0;
                float node_9007_cos = cos(node_9007_spd*node_9007_ang);
                float node_9007_sin = sin(node_9007_spd*node_9007_ang);
                float2 node_9007_piv = float2(0.5,0.5);
                float2 node_9007 = (mul((i.uv0*_TilingTurbulencemap)-node_9007_piv,float2x2( node_9007_cos, -node_9007_sin, node_9007_sin, node_9007_cos))+node_9007_piv);
                float2 node_6468 = (node_9007+(node_2489.g*_Speed)*float2(0,0.1));
                float4 _WaveMap_var = tex2Dlod(_WaveMap,float4(TRANSFORM_TEX(node_6468, _WaveMap),0.0,_SmoothDeformation));
                float2 Turbulence = lerp(i.uv0,_WaveMap_var.rgb.rg,(lerp(0,0.1,_DistortionAmount)*_Multiplicator));
                float4 node_8333 = _Time;
                float node_7396_ang = (((_Angle*3.141592654)/180.0)+90.0);
                float node_7396_spd = 1.0;
                float node_7396_cos = cos(node_7396_spd*node_7396_ang);
                float node_7396_sin = sin(node_7396_spd*node_7396_ang);
                float2 node_7396_piv = float2(0.5,0.5);
                float2 node_7396 = (mul(((i.uv0*4.0)*_Tiling)-node_7396_piv,float2x2( node_7396_cos, -node_7396_sin, node_7396_sin, node_7396_cos))+node_7396_piv);
                float2 node_6553 = (Turbulence+(node_7396+(node_8333.g*_AnimationSpeed)*float2(0,0.6)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_6553, _MainTex));
                float3 node_6684 = (_Color.rgb*_MainTex_var.rgb);
                float4 node_5680 = _Time;
                float node_7767_ang = ((_Angle2*3.141592654)/180.0);
                float node_7767_spd = 1.0;
                float node_7767_cos = cos(node_7767_spd*node_7767_ang);
                float node_7767_sin = sin(node_7767_spd*node_7767_ang);
                float2 node_7767_piv = float2(0.5,0.5);
                float2 node_7767 = (mul(((i.uv0*4.0)*_Tiling2)-node_7767_piv,float2x2( node_7767_cos, -node_7767_sin, node_7767_sin, node_7767_cos))+node_7767_piv);
                float2 node_1757 = (Turbulence+(node_7767+(node_5680.g*_AnimationSpeed2)*float2(0.6,0)));
                float4 _Diffuse2_var = tex2D(_Diffuse2,TRANSFORM_TEX(node_1757, _Diffuse2));
                float3 diffuseColor = lerp( saturate((1.0-(1.0-saturate(max((_TideColor.rgb*(1.0 - saturate((sceneZ-partZ)/_TideDepth))*lerp(0,10,_TideIntensity)),((lerp( saturate((_FoamTexture1.rgb*_FoamTexture2.rgb)), saturate((_FoamTexture1.rgb+_FoamTexture2.rgb)), _LinearDodge )*_FoamIntensity*lerp( _TideColor.rgb, float3(1,1,1), _EnableWhiteFoamOntop ))*(1.0 - saturate((sceneZ-partZ)/_FoamDepth))))))*(1.0-lerp(_ColorDistance.rgb,lerp(ColorDistance,lerp( node_6684, saturate(( (_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2))) > 0.5 ? (1.0-(1.0-2.0*((_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2)))-0.5))*(1.0-node_6684)) : (2.0*(_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2)))*node_6684) )), _Activesecondarytexture ),(1.0 - _Diffusetocolor)),lerp( 1.0, saturate(pow(saturate((_Distancevalue/distance(i.posWorld.rgb,_WorldSpaceCameraPos))),_Falloff)), _EnableDistanceColor ))))), float3(Turbulence,0.0), _VisualizeMap );
                float3 diffuse = directDiffuse * diffuseColor;
/// Final Color:
                float3 finalColor = diffuse;
                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "ShadowCaster"
            Tags {
                "LightMode"="ShadowCaster"
            }
            Offset 1, 1
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                V2F_SHADOW_CASTER;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_SHADOW_CASTER(o)
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : COLOR {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                SHADOW_CASTER_FRAGMENT(i)
            }
            ENDCG
        }
        Pass {
            Name "Meta"
            Tags {
                "LightMode"="Meta"
            }
            Cull Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define SHOULD_SAMPLE_SH ( defined (LIGHTMAP_OFF) && defined(DYNAMICLIGHTMAP_OFF) )
            #define _GLOSSYENV 1
            #include "UnityCG.cginc"
            #include "Lighting.cginc"
            #include "UnityPBSLighting.cginc"
            #include "UnityStandardBRDF.cginc"
            #include "UnityMetaPass.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile LIGHTMAP_OFF LIGHTMAP_ON
            #pragma multi_compile DIRLIGHTMAP_OFF DIRLIGHTMAP_COMBINED DIRLIGHTMAP_SEPARATE
            #pragma multi_compile DYNAMICLIGHTMAP_OFF DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal d3d11_9x xboxone ps4 psp2 n3ds wiiu 
            #pragma target 3.0
            uniform sampler2D _CameraDepthTexture;
            uniform float4 _ColorDistance;
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float _AnimationSpeed2;
            uniform sampler2D _Diffuse2; uniform float4 _Diffuse2_ST;
            uniform float _AnimationSpeed;
            uniform float _Diffusetocolor;
            uniform float _Tiling;
            uniform float _Distancevalue;
            uniform float _Falloff;
            uniform fixed _EnableDistanceColor;
            uniform float4 _Color;
            uniform float4 _Color2;
            uniform float _Tiling2;
            uniform sampler2D _WaveMap; uniform float4 _WaveMap_ST;
            uniform float _SmoothDeformation;
            uniform float _DistortionAmount;
            uniform float _Multiplicator;
            uniform float _Speed;
            uniform fixed _VisualizeMap;
            uniform float _TilingTurbulencemap;
            uniform float _FoamDepth;
            uniform float4 _TideColor;
            uniform float _TideDepth;
            uniform float _Foamspeed;
            uniform sampler2D _FoamTextureBlackandwhite; uniform float4 _FoamTextureBlackandwhite_ST;
            uniform float _FoamIntensity;
            uniform fixed _LinearDodge;
            uniform fixed _Activesecondarytexture;
            uniform float _AngleTurbulence;
            uniform float _Angle;
            uniform float _Angle2;
            uniform float _TilingFoam;
            uniform float _TideIntensity;
            uniform fixed _EnableWhiteFoamOntop;
            uniform float _TransparenceDiffuse2;
            struct VertexInput {
                float4 vertex : POSITION;
                float2 texcoord0 : TEXCOORD0;
                float2 texcoord1 : TEXCOORD1;
                float2 texcoord2 : TEXCOORD2;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                float4 posWorld : TEXCOORD3;
                float4 projPos : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.uv1 = v.texcoord1;
                o.uv2 = v.texcoord2;
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityMetaVertexPosition(v.vertex, v.texcoord1.xy, v.texcoord2.xy, unity_LightmapST, unity_DynamicLightmapST );
                o.projPos = ComputeScreenPos (o.pos);
                COMPUTE_EYEDEPTH(o.projPos.z);
                return o;
            }
            float4 frag(VertexOutput i, float facing : VFACE) : SV_Target {
                float isFrontFace = ( facing >= 0 ? 1 : 0 );
                float faceSign = ( facing >= 0 ? 1 : -1 );
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float sceneZ = max(0,LinearEyeDepth (UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)))) - _ProjectionParams.g);
                float partZ = max(0,i.projPos.z - _ProjectionParams.g);
                UnityMetaInput o;
                UNITY_INITIALIZE_OUTPUT( UnityMetaInput, o );
                
                o.Emission = 0;
                
                float4 node_9120 = _Time;
                float node_7662_ang = node_9120.g;
                float node_7662_spd = _Foamspeed;
                float node_7662_cos = cos(node_7662_spd*node_7662_ang);
                float node_7662_sin = sin(node_7662_spd*node_7662_ang);
                float2 node_7662_piv = float2(0.5,0.5);
                float2 node_2694 = ((i.uv0*4.0)*_TilingFoam);
                float2 node_7662 = (mul(node_2694-node_7662_piv,float2x2( node_7662_cos, -node_7662_sin, node_7662_sin, node_7662_cos))+node_7662_piv);
                float4 _FoamTexture1 = tex2D(_FoamTextureBlackandwhite,TRANSFORM_TEX(node_7662, _FoamTextureBlackandwhite));
                float node_200_ang = node_9120.g;
                float node_200_spd = (-1*_Foamspeed);
                float node_200_cos = cos(node_200_spd*node_200_ang);
                float node_200_sin = sin(node_200_spd*node_200_ang);
                float2 node_200_piv = float2(0.5,0.5);
                float2 node_200 = (mul(node_2694-node_200_piv,float2x2( node_200_cos, -node_200_sin, node_200_sin, node_200_cos))+node_200_piv);
                float2 node_9929 = (node_200+float2(0.6,0.6));
                float4 _FoamTexture2 = tex2D(_FoamTextureBlackandwhite,TRANSFORM_TEX(node_9929, _FoamTextureBlackandwhite));
                float3 ColorDistance = _ColorDistance.rgb;
                float4 node_2489 = _Time;
                float node_9007_ang = ((_AngleTurbulence*3.141592654)/180.0);
                float node_9007_spd = 1.0;
                float node_9007_cos = cos(node_9007_spd*node_9007_ang);
                float node_9007_sin = sin(node_9007_spd*node_9007_ang);
                float2 node_9007_piv = float2(0.5,0.5);
                float2 node_9007 = (mul((i.uv0*_TilingTurbulencemap)-node_9007_piv,float2x2( node_9007_cos, -node_9007_sin, node_9007_sin, node_9007_cos))+node_9007_piv);
                float2 node_6468 = (node_9007+(node_2489.g*_Speed)*float2(0,0.1));
                float4 _WaveMap_var = tex2Dlod(_WaveMap,float4(TRANSFORM_TEX(node_6468, _WaveMap),0.0,_SmoothDeformation));
                float2 Turbulence = lerp(i.uv0,_WaveMap_var.rgb.rg,(lerp(0,0.1,_DistortionAmount)*_Multiplicator));
                float4 node_8333 = _Time;
                float node_7396_ang = (((_Angle*3.141592654)/180.0)+90.0);
                float node_7396_spd = 1.0;
                float node_7396_cos = cos(node_7396_spd*node_7396_ang);
                float node_7396_sin = sin(node_7396_spd*node_7396_ang);
                float2 node_7396_piv = float2(0.5,0.5);
                float2 node_7396 = (mul(((i.uv0*4.0)*_Tiling)-node_7396_piv,float2x2( node_7396_cos, -node_7396_sin, node_7396_sin, node_7396_cos))+node_7396_piv);
                float2 node_6553 = (Turbulence+(node_7396+(node_8333.g*_AnimationSpeed)*float2(0,0.6)));
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(node_6553, _MainTex));
                float3 node_6684 = (_Color.rgb*_MainTex_var.rgb);
                float4 node_5680 = _Time;
                float node_7767_ang = ((_Angle2*3.141592654)/180.0);
                float node_7767_spd = 1.0;
                float node_7767_cos = cos(node_7767_spd*node_7767_ang);
                float node_7767_sin = sin(node_7767_spd*node_7767_ang);
                float2 node_7767_piv = float2(0.5,0.5);
                float2 node_7767 = (mul(((i.uv0*4.0)*_Tiling2)-node_7767_piv,float2x2( node_7767_cos, -node_7767_sin, node_7767_sin, node_7767_cos))+node_7767_piv);
                float2 node_1757 = (Turbulence+(node_7767+(node_5680.g*_AnimationSpeed2)*float2(0.6,0)));
                float4 _Diffuse2_var = tex2D(_Diffuse2,TRANSFORM_TEX(node_1757, _Diffuse2));
                float3 diffColor = lerp( saturate((1.0-(1.0-saturate(max((_TideColor.rgb*(1.0 - saturate((sceneZ-partZ)/_TideDepth))*lerp(0,10,_TideIntensity)),((lerp( saturate((_FoamTexture1.rgb*_FoamTexture2.rgb)), saturate((_FoamTexture1.rgb+_FoamTexture2.rgb)), _LinearDodge )*_FoamIntensity*lerp( _TideColor.rgb, float3(1,1,1), _EnableWhiteFoamOntop ))*(1.0 - saturate((sceneZ-partZ)/_FoamDepth))))))*(1.0-lerp(_ColorDistance.rgb,lerp(ColorDistance,lerp( node_6684, saturate(( (_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2))) > 0.5 ? (1.0-(1.0-2.0*((_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2)))-0.5))*(1.0-node_6684)) : (2.0*(_Color2.rgb*lerp((_MainTex_var.rgb-_Diffuse2_var.rgb),_Diffuse2_var.rgb,lerp(1,0.5,_TransparenceDiffuse2)))*node_6684) )), _Activesecondarytexture ),(1.0 - _Diffusetocolor)),lerp( 1.0, saturate(pow(saturate((_Distancevalue/distance(i.posWorld.rgb,_WorldSpaceCameraPos))),_Falloff)), _EnableDistanceColor ))))), float3(Turbulence,0.0), _VisualizeMap );
                o.Albedo = diffColor;
                
                return UnityMetaFragment( o );
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}
