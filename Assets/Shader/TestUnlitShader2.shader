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
				float2 uv:TEXCOORD;
			};

			//顶点着色器传递给片元着色器的结构体(返回值)
			struct v2f
			{
				float4 pos:SV_POSITION;
				float2 uv:TEXCOORD;
			};

			//对于一个三角形,顶点着色器只会执行3次(3个顶点)
			v2f vert(appdata v)
			{
				v2f o;
				o.pos=UnityObjectToClipPos(v.vertex1);
				o.uv=v.uv;
				return o;
			}

			fixed checker(float2 uv)
            {
                float2 repeatUV=uv*10;
                float2 c=floor(repeatUV)/2;
                float checker=frac(c.x+c.y)*2;
                return checker;
            }

			//同样对于一个三角形,像素/片段/片元着色器可能执行上千次(和有多少像素有关)
			fixed4 frag(v2f param):SV_TARGET
			{
			    fixed col=checker(param.uv);
				return col;
			}



			ENDCG
		}
	}
		FallBack "Difuse"
}