<h3>这是来自tpl的文字</h3>
<p>首先，使用 <code>seajs.config</code> 激活文本插件：</p>
<div class="highlight"><pre><span class="nx">seajs</span><span class="p">.</span><span class="nx">config</span><span class="p">({</span>
  <span class="nx">preload</span><span class="o">:</span> <span class="p">[</span><span class="s1">'seajs/plugin-text'</span><span class="p">]</span>
<span class="p">});</span>
</pre></div>
<p>接下来，就可以直接通过 <code>require</code> 来加载文本文件了：</p>
<p>main.js:</p>
<div class="highlight"><pre><span class="nx">define</span><span class="p">(</span><span class="kd">function</span><span class="p">(</span><span class="nx">require</span><span class="p">)</span> <span class="p">{</span>
  <span class="kd">var</span> <span class="nx">tpl</span> <span class="o">=</span> <span class="nx">require</span><span class="p">(</span><span class="s1">'./a.tpl'</span><span class="p">);</span>
  <span class="c1">// do sth.</span>
<span class="p">});</span>
</pre></div>
<p>a.tpl:</p>
<pre><code>&lt;div&gt;I am {{name}}.&lt;/div&gt;
</code></pre>
<p>除了 <code>.tpl</code> 后缀, 还可以使用 <code>.htm</code>、 <code>.html</code> 后缀，或 <code>text!</code> 前缀来指明文本文件。</p>
<p>SeaJS 通过 XHR 来加载文本文件。受同源策略限制，在开发完成后，需要通过包管理工具 <a href="https://github.com/spmjs/spm/wiki">spm</a> 将文本文件转换为 jsonp 代码。这样，上线后可以从任何域加载。</p>