Shader "Acorn/TestUnlitShader"
{
	Properties
	{
		HDR_Color2("HdrColor",Color) = (0,0,0,0)
		_Color1("I am Color RGBA",Color) = (0,0,0,0)
	}
		SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			//对于一个三角形,顶点着色器只会执行3次(3个顶点)
			float4 vert(float4 vertex1 :POSITION):SV_POSITION
			{
				return UnityObjectToClipPos(vertex1);
			}

			//在Cg/HLSL中使用Properties中的变量前还需要在Cg/HLSL中再重新声明一次，名称要求一致。
			float4 _Color1;

			//同样对于一个三角形,像素/片段着色器可能执行上千次(和有多少像素有关)
			float4 frag():SV_TARGET
			{
				return _Color1;
			}
			ENDCG
		}
	}
		FallBack "Difuse"
}
