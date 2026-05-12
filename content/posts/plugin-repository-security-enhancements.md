---
title: "Plugin Repository Security Enhancements"
date: "2026-04-23T13:29:52+00:00"
draft: false
authors: ["timlinux"]
categories: ["Uncategorized"]
---

<p class="wp-block-paragraph">We want to share some updates we have made on the <a href="https://plugins.qgis.org">QGIS Plugin Repository</a>. In January 2026 we shared <a href="https://github.com/qgis/QGIS-Enhancement-Proposals/blob/master/qep-409-plugins-security-validator.md">QEP 409</a>. The proposal seeks to improve the general working practices with QGIS plugins, adding some optional and some <strong>mandatory</strong> checks to every plugin that gets published in the QGIS plugin repo. This builds on initial work (<a href="https://github.com/qgis/QGIS-Plugins-Website/pull/219">see PR</a>) we did to run &#8216;soft&#8217; checks on every plugin when they are published.</p>



<p class="wp-block-paragraph">We also &#8216;back ran&#8217; the new security checks on every existing plugin in the plugin repository (latest versions only) and assigned them a security badge without blocking or removing any plugin from being published.</p>



<p class="wp-block-paragraph">Now if your plugin has flagged issues you will see a badge like this (in red below):</p>



<figure class="wp-block-image size-large"><a href="/wp-content/uploads/2026/04/image-2.png"><img data-attachment-id="3530" data-permalink="http://blog.qgis.org/2026/04/23/plugin-repository-security-enhancements/image-22/" data-orig-file="/wp-content/uploads/2026/04/image-2.png" data-orig-size="1386,754" data-comments-opened="0" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;,&quot;alt&quot;:&quot;&quot;}" data-image-title="image" data-image-description="" data-image-caption="" data-large-file="/wp-content/uploads/2026/04/image-2.png" loading="lazy" width="1024" height="557" src="/wp-content/uploads/2026/04/image-2.png" alt="" class="wp-image-3530" srcset="/wp-content/uploads/2026/04/image-2.png 1024w, /wp-content/uploads/2026/04/image-2.png 150w, /wp-content/uploads/2026/04/image-2.png 300w, /wp-content/uploads/2026/04/image-2.png 768w, /wp-content/uploads/2026/04/image-2.png 1386w" sizes="(max-width: 1024px) 100vw, 1024px" /></a></figure>



<p class="wp-block-paragraph">If your plugin passes all checks, you will see a green badge like this:</p>



<figure class="wp-block-image size-large"><a href="/wp-content/uploads/2026/04/image-1.png"><img data-attachment-id="3528" data-permalink="http://blog.qgis.org/2026/04/23/plugin-repository-security-enhancements/image-21/" data-orig-file="/wp-content/uploads/2026/04/image-1.png" data-orig-size="1400,722" data-comments-opened="0" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;,&quot;alt&quot;:&quot;&quot;}" data-image-title="image" data-image-description="" data-image-caption="" data-large-file="/wp-content/uploads/2026/04/image-1.png" loading="lazy" width="1024" height="528" src="/wp-content/uploads/2026/04/image-1.png" alt="" class="wp-image-3528" srcset="/wp-content/uploads/2026/04/image-1.png 1024w, /wp-content/uploads/2026/04/image-1.png 150w, /wp-content/uploads/2026/04/image-1.png 300w, /wp-content/uploads/2026/04/image-1.png 768w, /wp-content/uploads/2026/04/image-1.png 1400w" sizes="(max-width: 1024px) 100vw, 1024px" /></a></figure>



<p class="wp-block-paragraph">If you see a small &#8216;i&#8217; on the left there may still be some non-blocking checks to look at.</p>



<p class="wp-block-paragraph">If you are the owner of a plugin, you can log in to <a href="https://plugins.qgis.org">https://plugins.qgis.org</a>  and review the issues that have been flagged for your plugin:</p>



<figure class="wp-block-image size-large"><a href="/wp-content/uploads/2026/04/image-4.png"><img data-attachment-id="3533" data-permalink="http://blog.qgis.org/2026/04/23/plugin-repository-security-enhancements/image-24/" data-orig-file="/wp-content/uploads/2026/04/image-4.png" data-orig-size="1452,892" data-comments-opened="0" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;,&quot;alt&quot;:&quot;&quot;}" data-image-title="image" data-image-description="" data-image-caption="" data-large-file="/wp-content/uploads/2026/04/image-4.png" loading="lazy" width="1024" height="629" src="/wp-content/uploads/2026/04/image-4.png" alt="" class="wp-image-3533" srcset="/wp-content/uploads/2026/04/image-4.png 1024w, /wp-content/uploads/2026/04/image-4.png 150w, /wp-content/uploads/2026/04/image-4.png 300w, /wp-content/uploads/2026/04/image-4.png 768w, /wp-content/uploads/2026/04/image-4.png 1440w, /wp-content/uploads/2026/04/image-4.png 1452w" sizes="(max-width: 1024px) 100vw, 1024px" /></a></figure>



<p class="wp-block-paragraph">If you expand the detail blocks, you can see the individual issues that were flagged:</p>



<figure class="wp-block-image size-large"><a href="/wp-content/uploads/2026/04/image-5.png"><img data-attachment-id="3535" data-permalink="http://blog.qgis.org/2026/04/23/plugin-repository-security-enhancements/image-25/" data-orig-file="/wp-content/uploads/2026/04/image-5.png" data-orig-size="1028,779" data-comments-opened="0" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;,&quot;alt&quot;:&quot;&quot;}" data-image-title="image" data-image-description="" data-image-caption="" data-large-file="/wp-content/uploads/2026/04/image-5.png" loading="lazy" width="1024" height="775" src="/wp-content/uploads/2026/04/image-5.png" alt="" class="wp-image-3535" srcset="/wp-content/uploads/2026/04/image-5.png 1024w, /wp-content/uploads/2026/04/image-5.png 150w, /wp-content/uploads/2026/04/image-5.png 300w, /wp-content/uploads/2026/04/image-5.png 768w, /wp-content/uploads/2026/04/image-5.png 1028w" sizes="(max-width: 1024px) 100vw, 1024px" /></a></figure>



<p class="wp-block-paragraph">There are two blocking issue categories (that will prevent you from publishing your plugin) and additional non-blocking issue categories (that are advisories only). You can see all the details at the information page here:</p>



<p class="wp-block-paragraph"><a href="https://plugins.qgis.org/docs/security-scanning">https://plugins.qgis.org/docs/security-scanning</a></p>



<p class="wp-block-paragraph">We would like to note that these security advisories and badges are <strong>only shown on the plugins website</strong>, the plugin manager in QGIS Desktop does not yet provide any indication of the security scan results.</p>



<figure class="wp-block-image size-large"><a href="/wp-content/uploads/2026/04/image-6.png"><img data-attachment-id="3538" data-permalink="http://blog.qgis.org/2026/04/23/plugin-repository-security-enhancements/image-26/" data-orig-file="/wp-content/uploads/2026/04/image-6.png" data-orig-size="1600,785" data-comments-opened="0" data-image-meta="{&quot;aperture&quot;:&quot;0&quot;,&quot;credit&quot;:&quot;&quot;,&quot;camera&quot;:&quot;&quot;,&quot;caption&quot;:&quot;&quot;,&quot;created_timestamp&quot;:&quot;0&quot;,&quot;copyright&quot;:&quot;&quot;,&quot;focal_length&quot;:&quot;0&quot;,&quot;iso&quot;:&quot;0&quot;,&quot;shutter_speed&quot;:&quot;0&quot;,&quot;title&quot;:&quot;&quot;,&quot;orientation&quot;:&quot;0&quot;,&quot;alt&quot;:&quot;&quot;}" data-image-title="image" data-image-description="" data-image-caption="" data-large-file="/wp-content/uploads/2026/04/image-6.png" loading="lazy" width="1024" height="502" src="/wp-content/uploads/2026/04/image-6.png" alt="" class="wp-image-3538" srcset="/wp-content/uploads/2026/04/image-6.png 1024w, /wp-content/uploads/2026/04/image-6.png 150w, /wp-content/uploads/2026/04/image-6.png 300w, /wp-content/uploads/2026/04/image-6.png 768w, /wp-content/uploads/2026/04/image-6.png 1440w, /wp-content/uploads/2026/04/image-6.png 1600w" sizes="(max-width: 1024px) 100vw, 1024px" /></a></figure>



<p class="wp-block-paragraph"><strong>What to do if you have a red badge on a plugin you manage?</strong></p>



<p class="wp-block-paragraph">Firstly, don&#8217;t panic. Almost all plugins initially have this badge, but we expect over time that the repository is populated with &#8216;green badged&#8217; plugins as developers publish their updates. Then review the issues listed in the report and fix them systematically, refer to <a href="https://plugins.qgis.org/docs/security-scanning">https://plugins.qgis.org/docs/security-scanning</a> for the specific tools we use on the server if you want to run them locally too.</p>



<p class="wp-block-paragraph"><strong>What to do if you see a red badge on your favourite plugin.</strong></p>



<p class="wp-block-paragraph">Again, don&#8217;t panic. In a year&#8217;s time when most plugins have been updated we expect green badges to be the norm, but for now, just know that we are working on improving the security of our plugin ecosystem.</p>



<p class="wp-block-paragraph"><strong>What if my plugin has a flagged issue for something that is a feature?</strong></p>



<p class="wp-block-paragraph">We know that in some cases you may actually need to embed API keys or credentials or do things that raise a flag. QGIS does not play an enforcement role beyond requiring that all newly uploaded plugins are green flagged. You can use pragmas / overrides where needed. What we are trying to do is ensure that plugin developers have visited each reported issue, considered it and either consciously chosen to ignore it, or fixed it.</p>



<p class="wp-block-paragraph"><strong>What if I still have questions?</strong></p>



<p class="wp-block-paragraph">Please file a ticket at <a href="https://github.com/qgis/QGIS-Plugins-Website/issues">https://github.com/qgis/QGIS-Plugins-Website/issues</a></p>



<p class="wp-block-paragraph"><strong>I have an issue with XXX</strong></p>



<p class="wp-block-paragraph">We are aware that there are some teething problems with our ruleset e.g. hashlib.md5, xml library flagging etc. Please raise an issue if you think the rules are too strict and we will update them accordingly. If you want to review how the scanning is implemented, please see <a href="https://github.com/qgis/QGIS-Plugins-Website/blob/master/qgis-app/plugins/security_scanner.py">https://github.com/qgis/QGIS-Plugins-Website/blob/master/qgis-app/plugins/security_scanner.py</a></p>



<p class="wp-block-paragraph"></p>
