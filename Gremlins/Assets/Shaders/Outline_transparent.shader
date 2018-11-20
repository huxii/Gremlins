﻿Shader "Custom/Outline_transparent" 
{
	Properties 
	{
		[Header(Base)]
		_MainTex("Texture", 2D) = "white" {}
		_XPositiveColor("X+ Color", Color) = (1, 1, 1, 1)
		_XNegativeColor("X- Color", Color) = (1, 1, 1, 1)
		_YPositiveColor("Y+ Color", Color) = (1, 1, 1, 1)
		_YNegativeColor("Y- Color", Color) = (1, 1, 1, 1)

		[Header(Lighting)]
		_LightRamp("Light Ramp", 2D) = "white" {}

		_RimColor("Rim Color", Color) = (1, 1, 1, 1)
		_RimPower("Rim Power", Range(0.1, 10.0)) = 3.0

		[Header(Outline)]
		_OutlineColor("Outline Color", Color) = (0, 0, 0, 1)
		_OutlineWidth("Outline Width", Range(0, 1.0)) = 0.05
	}

	SubShader
	{
		CGPROGRAM
		#include "ToonUtils.cginc"

		#pragma surface surf Toon addshadow alpha:blend
		#pragma target 3.0

		uniform sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceCustomOutput o)
		{
			half4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
		
		Pass
		{
			Name "Base"
			Tags
			{
				"LightMode" = "ForwardBase"
				"Queue" = "Transparent"
				"RenderType" = "Transparent"
				"IgnoreProjector" = "True"
			}
			LOD 200
			ZWrite On
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMask RGB
		}
		
		Pass
		{
			Name "Outline"

			Cull Front

			CGPROGRAM
			#include "OutlineUtils.cginc"

			#pragma vertex vert
			#pragma fragment frag

			uniform float _OutlineWidth;
			uniform float4 _OutlineColor;

			float4 vert(vertexInput v) : SV_POSITION
			{
				return GetClipPosition(v.vertex, normalize(v.color.xyz), _OutlineWidth);
			}

			float4 frag() : COLOR
			{
				return _OutlineColor;
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
