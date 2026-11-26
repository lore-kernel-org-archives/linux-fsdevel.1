Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693690;
	b=WehJBjOoMLYrJcTg5TshOoJxD0ol3RVTT1Mf67a+MZnrDCtN+uwD57+LlSs98kU0pxJu
	 ymcFnsPmjBvOOFDb9fWSe9v0iAzeMHp+V3qxWvXSIaopN+vnjFDFCyl/kogvqblE/3YWm
	 x08PiUrzaUHq7QgeoZEv9NGGniqcWRmY1QLe4UdfPk9872ZXJxneYqq81NfV6alSNsgBl
	 MuC2nQJkFA6wwjxrMuQ70xKnQKfxiHyWtagsAi1RItR7Dw+FND8Fssl5pnkNWL6kSEHSl
	 Kb52zxXIPWl1DfrwTyjIS+F99wVWiDfPsZ7PpL6wsY5sDHYWOAc9X+9Wx7Wuqp5ml2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693690;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=9ccEvPrk5Ukb6x7OchHxDRp27Y/H5iW0MG7iP5cWEVA=;
	b=ayr82+2uUOwIjNcLkxJVA9XqMVIQj/c8dJy8XKee6le/nQ7U8YTTRMFoWpMngyaadxrM
	 +eAr+dfvFeuHR0eZFywGATyglDupYDbXeE5g9q7+EbvilPLJuOZoaY0rllXssYx6pHGC5
	 z4830xBzYj8e1XCRIeQYMrhiwV0jPDgc4oKsHAIHwBBKuDABrYo5IBbFPLLsE+ad6QrxQ
	 fyNH5eagborIyJ85c2Df2CjqbdSBA6UVXynHuso5s17v4sC+tznsxwYV2BbfcC9lCUR1X
	 jvNP+i7PoLQ70UaoyV4HKcukvNEm7ZxgVMxi5thnLpyNWj3kGyXnWPgJmjl9selVSVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LldvK95u;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78838606A6A5;
	Thu, 26 Nov 2026 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LldvK95u
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795693689;
	b=H9mrrtzUJ5ajTfxyFCuFH6ZX95+Y2w2G6mb72Mp9sZJSzhBaPG1yujE+Hu87qQcVtxes
	 +ffhibRR+kIITBL98ake+tMKR+fcdP01SvZexdxhG6iKRmBoUDUfxh1TvijmJr9TLI60j
	 ECoM2nSEaj3YyEUXr7LFzppt/+kNagnz3ouFWhV6FUiT7IJ0YzE0Iwx6vLqHklvoQ23Fx
	 uWTqyWQu1CtQS2IgywX6HTDqCBx9fSzuZF6JXkYLq0AJJ6o6uA16C9NocRo0J+a1IKrbk
	 Ef5Skw+NPUtTjz3trhYUKvB1Wq818FsjHVJgJlLdpjtitGcXbgkcZ3X1XMzoFL8+sYg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795693689;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=9ccEvPrk5Ukb6x7OchHxDRp27Y/H5iW0MG7iP5cWEVA=;
	b=W/oP79AqP5Ygb/l5wWsTruOjnmGgdjB2RTxy8oxNpdd0iE7o099Zi6GT/waTOqPMYqdD
	 g3qRzhLwrZnSo7KEM1gxXgB0kWzzNOoaqSVxjS+Q2+Vh0M2LIdfPx5Jsu/5g7G8ux5OLD
	 koEl+OSZ3lrCXo0MSBAYVSSdT30fdk/ENfZ1ciIRzKdLPA8+legRkFoBt64E6WDZ1IsXp
	 XmIojiRhyiN5HDyKiGQx4HR2IqLM9BkOkxrxp2ofb2TkiDTK/Njr0uaik2KVpd2K8W+2+
	 qO3Td3PtbwgB0+v0M2WXspZ0ags3IIBT6fFu1n10YycZGbzS28uMphGxmO0CwAqvHsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 140431F000D0;
	Thu, 26 Nov 2026 11:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693689;
	bh=9ccEvPrk5Ukb6x7OchHxDRp27Y/H5iW0MG7iP5cWEVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LldvK95uhyRH9m5WYNzoZbMzg0+6F2jaksmU4HlktoBfZweIZvj6HcOt7121ZfCNb
	 rGZvNZXFnPVTAW3G4TJ+JKn17mJ/U4yyKE1W+XA4Yl2/UPzvkcu7pB0g4idb34u9NM
	 i2pTaG2ie99VNAcnjapNtRRWcIif3HoYbQF0CpmzGIYr9KhhHDZEa44Zu0NEzHDjOd
	 fSV9jd0HMhGbYjkk3sPheURXuQDug+bnQpZktPaEmgYywB32xmrhjU94ugAR2vjtkx
	 TY5Crw/I/b5u2H0NANsA3VOQbJPCeCSq2rygwOQyO/67xU4UPEuN3IjMROemjqlSXk
	 AFl8TXErwtRHA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D24A24D4A5;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 26 Nov 2026 12:47:49 +0100
Subject: [PATCH RFC 9/9] ucount: Register user_table as a template
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
Message-Id: <20261126-lklm-sysctl-ctx-flatarray-v1-9-d7fc9cc9b03e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1852;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=xxV6z++7ScCL89/Zbrnu7BW+bL94aG5P2MD4Ph2vuSk=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsIHGb4MoAhfzZ1I0S/+EBq8ElFI7wbN0PZ+
 Imexis5rB3Dv4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrCBxmAAoJELqXzVK3
 lkFPHbcMAIU+j6RI+3mitsigy7GoDEHm1dD/3TlR1oUbw7PCY3S8JrChRnPm4SNvA9aXEsHeP2y
 zwimrDfTY2CJiq29aw3N5lxRVm/nTT66Di5jUpBol57ZSsMKXsGv5cTRGzqeuSLzNAVtgfwJsX0
 I044x1WNml5Pc5C+aaC3Wzcqrd49uw1ub50fPyC0Oq2DhnO56ncCGd2+Bh5hrFfQHBatgX2LwwG
 e0lDhNjYH/1Ey7Cz1inFdzeGW5uXR6qGmXg+nTpGnq5DscCxinI2yATfwG3vU4EL3Nd8zaynH4L
 Dfms9KJtEWkR3uu6BVGOJmGF4/U+Uho8+gyy/YeZogtV/CypF6nMdJqG4UeG6EnG4wVArESfoJa
 +nkXL+PbLC5NKQTQ+ueg/gVDtu32DLcv8F3whKBJTz7AqaPee9PxC4dfVwwSBlCqW3KGos9p5mX
 ENmW1MVCZmCwFH0GYSFhOYf4JqcPAOX1kvR1SwciZ9elw65+Vbjgm7j9rYIIlmDi69ZKeJ54467
 AY=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Add SYSCTL_OVERLAY_DATA to UCOUNT_ENTRY() so every entry of user_table
carries it, and register the table through
__register_sysctl_table_tmpl(), passing the copy that
setup_userns_sysctls() already fills by position as the overlay. Free
the copy once the call returns and stop freeing ctl_table_arg in
retire_userns_sysctls().

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 kernel/ucount.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 94b70502dc9ded4de4a946b73141119efc3a26fe..bf021247f5ee5999f3c298e318c25dc2164a8c9b 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -69,6 +69,7 @@ static long ue_int_max = INT_MAX;
 		.procname	= name,				\
 		.maxlen		= sizeof(long),			\
 		.mode		= 0644,				\
+		.flags		= SYSCTL_OVERLAY_DATA,		\
 		.proc_handler	= proc_doulongvec_minmax,	\
 		.extra1		= &ue_zero,			\
 		.extra2		= &ue_int_max,			\
@@ -109,11 +110,12 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 		for (i = 0; i < UCOUNT_COUNTS; i++) {
 			tbl[i].data = &ns->ucount_max[i];
 		}
-		ns->sysctls = __register_sysctl_table(&ns->set, "user", tbl,
-						      ARRAY_SIZE(user_table));
-	}
-	if (!ns->sysctls) {
+		ns->sysctls = __register_sysctl_table_tmpl(&ns->set, "user",
+							   CTL_TABLE_TMPL(user_table),
+							   tbl, ARRAY_SIZE(user_table));
 		kfree(tbl);
+	}
+	if (!ns->sysctls) {
 		retire_sysctl_set(&ns->set);
 		return false;
 	}
@@ -124,12 +126,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 void retire_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
-	const struct ctl_table *tbl;
-
-	tbl = ns->sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->sysctls);
 	retire_sysctl_set(&ns->set);
-	kfree(tbl);
 #endif
 }
 

-- 
2.50.1


