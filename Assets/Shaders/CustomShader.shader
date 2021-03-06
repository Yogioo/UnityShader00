﻿Shader "Unlit/CustomShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" { }
        _MousePos ("Mouse", Color) = (0, 0, 0, 0)
        _MouseTex ("MouseTex", 2D) = "while" { }
    }
    SubShader
    {
        Tags { "RenderType" = "Opaque"}
        LOD 100
        
        Pass
        {
            CGPROGRAM
            
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog
            
            #include "UnityCG.cginc"
            
            struct appdata
            {
                float4 vertex: POSITION;
                float2 uv: TEXCOORD0;
            };
            
            struct v2f
            {
                float2 uv: TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex: SV_POSITION;
                float4 mousePos: TEXCOORD1;
                float4 worldPos: TEXCOORD2;
            };
            
            sampler2D _MainTex;
            float4 _MainTex_ST;
            sampler2D _MouseTex;
            float4 _MouseTex_ST;
            
            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.worldPos = mul(unity_ObjectToWorld, v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                //_MouseTex_ST = float4(1,1,_MousePos.xy);
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }
            
            fixed4 frag(v2f i): SV_Target
            {
                // sample the texture
                //fixed4 col = tex2D(_MainTex, i.uv);
                
                fixed4 col = tex2D(_MainTex, i.uv.xy);// * tex2D(_MouseTex,i.uv.zw);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);

                return col;
            }
            ENDCG
            
        }
    }
}
