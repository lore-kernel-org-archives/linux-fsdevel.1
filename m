Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693687;
	b=anUNmDE4fVz1Jw+9xfCgu5xMsXvv3CVPw54DuSNXSh98StzndlmEvK+JNK71DAZbT9eH
	 maRL+m3Hm8wxptHl8BEADJfnbmSlovE6mcL7yok6/damGkrUrveXbutt1Ei5m/0IzCL8s
	 JL/UirJYaJxxmwor2VSu8Li7Jw/AnqnywQX12b2kUgViyH4gl4MGKrq6xktn3zXuVMbUj
	 DbBG8kQH/MvjBYwyACeLcje25O4fiMnPFQCyqc/mFJ0Kyr2vSv8ZsyZOdqSVd8FoBRQN+
	 8WGAWYD3/IoiRuGPcOCbNHaNJtwBvoDnXLvY7ZtIVieAPiFD3ygMHnHkYzIKH6uD8Ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693687;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=G9t/QEbzkMp/+fj9xN4tayGcCen2BxfvunU7ETry0BE=;
	b=ca5sThYUaXxKGrYtnTPho2AZpcj9CrdCKLy1vwws2RKEj5Z8PASD1SZDYX1np6UcrMmo
	 fndjyobvislgJHxrWXUopr0tCEViTSgDVkN1xxLlxwmG2QIMuUpMetUkpKTLwKZC7V5x+
	 K4/A9zpCFO3P1ZQHQ11TO47+zN/e1WH7J4UO57oIGxkvmnzD4P31I9WQ24MXK+0+HhdWk
	 +3GRatM84g31VC99l7skS3FHwXCl0y4M0lSYg7U7goxqajN2IcdVGaLBDcoI6CAidFTbz
	 XDc4qPFjkMgd/6qqfeo7ZgzZtmDaQldrTF1d3FyHfs5kDXBfQ8kE84x2zjsfJxrgkZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+clD61z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D228606A68B;
	Thu, 26 Nov 2026 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k+clD61z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795693687;
	b=xzW93O1UFCHSdJiOM1nCf+ClLt9rwF2CJ4cFzOVEsgwRZC/MBIr5CsmFtUX8fWybGQBO
	 8mhvy9EW+TGaRET9SopU2W5j9Rti8ZhFyqQWx72F1uuyIX4jobkzFWFLdKCkBZmwVqNbv
	 F6lbgAe7TnVOZEfmoEL+iM354RlkyuQW/Up38jvu3cA/oGIvWjnccggMnpNmak3bNVEg+
	 UBl4XCzFbXMfOoNLo2vPeqe5nLiZXNMBULiWid9XIRmSbKgfyYWXqY77DWRRDeV7Mfr/1
	 2eCZFzp4VyEWkhrTaTFLLHwM77Nwt0CJFdqwj7rD6AXH6c3tq5kFBnhwbh6vOXFgcUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795693687;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=G9t/QEbzkMp/+fj9xN4tayGcCen2BxfvunU7ETry0BE=;
	b=2rcR93fJzar+tnuaxnlzvfeCRTaaW91igfFEmLdTKvYf+ih7TzPrc8DzzX5r6qX2Qpff
	 r1sX6xSFcSIdMqDvox+dNakZ/OF4zFqtxlG8q7+qiHohTtrb8xaTBOjK/6KVmgT+faTBE
	 aSZpmGtuXm1vmxx1QjLVNqZNwLsVqg/nmox1UnmcY0ipzDaNZemmuOS2Dopgp8uZw2hKC
	 /wX8Ec1zXUzzNf3ZiobublJ3xneiIa7ozWGuYXxjQfYmBB8G1jCLXJHoP3A1ntXkpt2sy
	 bYby3PyY9xvgcxz05n4oDeZzEfal5Kohngylh7Zeb1CY04Ab0GWnaVF0hfVFB4Kuv2A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 705131F000D1;
	Thu, 26 Nov 2026 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693687;
	bh=G9t/QEbzkMp/+fj9xN4tayGcCen2BxfvunU7ETry0BE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k+clD61zS1kLMZu20rTdKzxQLtVTMkQjWG3ow1qkRnDSVIILBOxd0Az1KQbL7h++y
	 tWszIFHIbgbeDp62vBdee6n83fdGj1tnnizhTq0ZJSSXTqnZxGtrtQyCVW3riAA+Zb
	 uFiWc19kxZa8P7pOuTqxebgRPfvXLrfw2uCQIydiqrA1oFGJmgbjbS/EMmzmxZU3Dz
	 HmZR8EiTsEgtI4PLAncHpjgsBAkiq07/YRIHInMIHUzlbYp1gJ/ialZdsLkA19LKQD
	 Y4F49odqycDEz5uXYq5IBTbIDuJcRjkiPn2AiOq2ZYeO84BFikdDOnisnjZKlJWgnQ
	 9Xbox/Zn6T0uQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 49CD34D495;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 26 Nov 2026 12:47:45 +0100
Subject: [PATCH RFC 5/9] net: sysctl: Add sysctl registration to networking
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-lklm-sysctl-ctx-flatarray-v1-5-d7fc9cc9b03e@kernel.org>
References: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org>
In-Reply-To: <20261126-lklm-sysctl-ctx-flatarray-v1-0-d7fc9cc9b03e@kernel.org>
To: Kees Cook <kees@kernel.org>, Alexey Gladkov <legion@kernel.org>, 
 David Laight <david.laight.linux@gmail.com>, Wen Yang <wen.yang@linux.dev>
Cc: Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3478;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=BjxePkqZQh7SmQ/XefseKj5Jh2846+Y/W+u6eGkfSy4=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsIHGTHmbMrlU8rxlvUU0JesTYVV5pzN8ar5
 l2w8K9JUbkfY4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrCBxkAAoJELqXzVK3
 lkFPVPsL/iy1EnZYmVK2EHHCFf5ovFyK1uRFgYUBiPejvYnDYPhwGkB/NkT/LqIeSKLSLkOFWO/
 1exdqhA0TbTrur1c0YOMTxwM0i/hxZFjeH3PU2lDPjxA4Bl6nz6Pv5dVSHXoL/M0EP73oACNO0h
 tzvZtgmWiM4zrNg4xIXFExIj6+vc209hZHnESk/QwQrLH05ZXBhmT/quqVC7XnI3KEOlrrAWOCa
 couIamwZUx/7/WpMVZk68epOleIaydzUy5O/Ur7xfWQvhPqQSw/3s8KrfsSg0jd7Ch73auBC0Nh
 Rc1WYB/xSybY6IEaCrdOVs4aCS4xCwSuaGsbKfiGnj7quVy0kkStENK/oN4Gr4SfuzvUb8K77qy
 0QYHI15ifgYb79+QnrV/CTfLrcS9q5tj1wZYWCUTH6lsJ4/JOSkw2ZrxmjQuoSqp2JCqJJ+JFNH
 fAFEODHxjZn68D8BxPdX4CtAw3qt+8eA5mFtPC0W46v9Fay+JZ81PUZKUjiaonLduTT1VHNilU5
 +Y=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add the per-netns entry point for template registration. It takes the
shared template and the caller's overlay and registers in the
namespace's set through __register_sysctl_table_tmpl(). Run
ensure_safe_net_sysctl() on the overlay for namespaces other than
init_net.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 include/net/net_namespace.h | 14 ++++++++++++++
 net/sysctl_net.c            | 25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index c29a22ca178fa678c0468247b9f85f53eec86184..ecec120de3081d7e8f5c13b72ca98dc647704139 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -527,11 +527,19 @@ struct ctl_table;
 
 #define register_net_sysctl(net, path, table)	\
 	register_net_sysctl_sz(net, path, table, ARRAY_SIZE(table))
+#define register_net_sysctl_tmpl(net, path, tmpl, overlay)		\
+	register_net_sysctl_tmpl_sz(net, path, CTL_TABLE_TMPL(tmpl),	\
+				    overlay, ARRAY_SIZE(tmpl))
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
 struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
 						const struct ctl_table *table,
 						size_t table_size);
+struct ctl_table_header *register_net_sysctl_tmpl_sz(struct net *net,
+						     const char *path,
+						     const struct ctl_table_tmpl *tmpl,
+						     const struct ctl_table *overlay,
+						     size_t table_size);
 void unregister_net_sysctl_table(struct ctl_table_header *header);
 #else
 static inline int net_sysctl_init(void) { return 0; }
@@ -540,6 +548,12 @@ static inline struct ctl_table_header *register_net_sysctl_sz(struct net *net,
 {
 	return NULL;
 }
+static inline struct ctl_table_header *register_net_sysctl_tmpl_sz(
+	struct net *net, const char *path, const struct ctl_table_tmpl *tmpl,
+	const struct ctl_table *overlay, size_t table_size)
+{
+	return NULL;
+}
 static inline void unregister_net_sysctl_table(struct ctl_table_header *header)
 {
 }
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index e190a639eef2f6929c4aed85ad625aaf8a6ebd6a..c6eae05dedaecc3bdce402741140d8690d3c15ea 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -173,6 +173,31 @@ struct ctl_table_header *register_net_sysctl_sz(struct net *net,
 }
 EXPORT_SYMBOL_GPL(register_net_sysctl_sz);
 
+/**
+ * register_net_sysctl_tmpl_sz - register a shared template for one netns
+ * @net: the network namespace
+ * @path: path of the directory under /proc/sys
+ * @tmpl: the template every namespace shares, see register_sysctl_tmpl_sz()
+ * @overlay: copy of @tmpl holding values for @net; this ptr is not kept!
+ * @table_size: number of entries in @tmpl and @overlay
+ *
+ * The safety check runs on @overlay, since that is what @net will see
+ */
+struct ctl_table_header *register_net_sysctl_tmpl_sz(struct net *net,
+						     const char *path,
+						     const struct ctl_table_tmpl *tmpl,
+						     const struct ctl_table *overlay,
+						     size_t table_size)
+{
+	if (!net_eq(net, &init_net))
+		if (ensure_safe_net_sysctl(net, path, overlay, table_size))
+			return NULL;
+
+	return __register_sysctl_table_tmpl(&net->sysctls, path, tmpl, overlay,
+					    table_size);
+}
+EXPORT_SYMBOL_GPL(register_net_sysctl_tmpl_sz);
+
 void unregister_net_sysctl_table(struct ctl_table_header *header)
 {
 	unregister_sysctl_table(header);

-- 
2.50.1


