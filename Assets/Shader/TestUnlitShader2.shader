Shader "Acorn/TestUnlitShader2"
{
	Properties
	{
		_Color1("I am Color RGBA",Color) = (0,0,0,0)
	}
		SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			//在Cg/HLSL中使用Properties中的变量前还需要在Cg/HLSL中再重新声明一次，名称要求一致。
			fixed4 _Color1;

			//应用程序阶段的参数
			struct appdata
			{
				float4 vertex1:POSITION;
			};

			//顶点着色器传递给片元着色器的结构体(返回值)
			struct v2f
			{
				float4 pos:SV_POSITION;
			};

			//对于一个三角形,顶点着色器只会执行3次(3个顶点)
			v2f vert(appdata v)
			{
				v2f o;
				o.pos=UnityObjectToClipPos(v.vertex1);
				return o;
			}

			

			//同样对于一个三角形,像素/片段/片元着色器可能执行上千次(和有多少像素有关)
			float4 frag():SV_TARGET
			{
				return _Color1;
			}
			ENDCG
		}
	}
		FallBack "Difuse"
}