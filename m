Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693693;
	b=frR66V0/IgDbj5ZfK3FWehXFwIfwWbjyskvLfPGR7eq0lvl03C656ZEZeT0lNPbI8fWH
	 HY6D9TZHQF3GqKOgFuxgL+UI+OFEzauC306kbgF7KKHZPuJT37vlVg0uTRAcpMu38J2WF
	 LeFEZpyI5HXaydVeOFg1XgapXBZpJrQTecDq2Vq38PQdWE/bf4LtzzmnBAWfrXM/zGLce
	 qXJ6crdJ00bPZW7fobkv0awpWgMln8Fd2oC4qzwhSeoAUzAdwRpPXI1mi5HGvg0miljTR
	 WKRLlf5/wra8jCA+ZGGY/qa0BAuvGF1WvJVnrwwxR9X0pn+wsRJIeQPvdLnv3MZhvww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693693;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=JMOqSQXm9yjr94VJxt+wr5RlHBO3egF6Z5jn0YsYKKk=;
	b=rgYtd75CZS13jt7TSPE2t7VhC3EuP78INg6aKOBhOU4K2FeNMyFaXh1WHEJpS6TbYVV6
	 tSaYUud1eBZpkBF12tSLmGK3XY+r91mE8yvpa+SLkgwxuvDJdJPN/nF4UWydE/Z6VW2sp
	 uq3p+mVDJa05xbTVEcBk7pmG4FJEDQrpSRQ/78+vHh6i548CviokY20+sYPAjoBl8Yqta
	 HG4lRG1zoyR0n428P7qxPpZvJgxEAHJpKv/FWx99l+cQCpBYqHuInlpL/fcVtvBPYtryA
	 mIjJ6TXYYJfEH4eLGgqX+51vE6RlwcsEmO6OLfiujkbG+TWEgU1blpdLiMz9AiYqgrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzL2RnUh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E77660A3807;
	Thu, 26 Nov 2026 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YzL2RnUh
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795693692;
	b=QVz5CFGUVseD48h+0pzrVhL4baPcM+B+C5ZTz8XC5dC2vN/n3iIOgEyc/YMu2jqHGDpW
	 PXE06jcrC0W2kowgYTRxSEwLmIAWE6MMe8uXBNf1isMo768L5bj9DFCqactONXvQ86TJU
	 mkoUwNtlEe4bl16zwEA/O6Gt+TIkD7/I7rRG9l8l/6SRob5MRANSw1wY+zubfzLcW1SAQ
	 5Mhaf7fuL6QrxKI3gm2CbieQUaPQclfLBH+9mn5iKs6cRb9wrqNTKJFV+IQ4qq/PHvXXM
	 RRuy2b+2+WIu1mzEBLdI3Qr2X/kBWKp3P7z+RVYz9/N19j/kUbOdqf42fBqwAmPpW9Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795693692;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=JMOqSQXm9yjr94VJxt+wr5RlHBO3egF6Z5jn0YsYKKk=;
	b=fP212NZOa9wEILe97mQpSEbLtYqTCZu7uwAQoIJ4gwWFfcXhEHTx7LRw43ZYoAaWqDcx
	 cr/svxpKlIdgGNCQ3vjglB3q/lXWrh5+hEj146y6Lx1Suyc7Im3aJHvjYrM36VD73fhUq
	 dvkKtfgOJ2HAq3D00YCEySpvrZ2xcqsYWi01Thzso7ghyu5W4ixBPfegzdyP8lFhIJ86+
	 /SZ6RJtIt/cS/c6xaFe60XXaawvLBEtwGqwyvFnGLcuGbiYlY8nv8Iel7AWqENo8wArZO
	 R+XYeUteKbUKRoD2TKWmAXiL/URg8oplKuWNiy4bNowj8ZsiMwepkSzuth1T+2qVkzQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 279BC1F000D4;
	Thu, 26 Nov 2026 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693692;
	bh=JMOqSQXm9yjr94VJxt+wr5RlHBO3egF6Z5jn0YsYKKk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YzL2RnUhxz/ebRJXU9rSSAlPC785wUJ5rgCKS9gn9p8eyxfAXmq1gLzd/vQW63/+X
	 WTkFPliOuW2ifVTJ6WGWUhS7uzq5gTf6k+xoIGjNZJpsVzu7ZW4Q1GGo95rDLeFMXz
	 g4bCtdG6H4CTQvyqTs+koexu2RmrdQk9zWUIDyyBNOVACzBdxnTbDiWz3gtc2njdsz
	 sGvJqEG/f0VUPIE6Mm7Qqhch+KGjjaHMTFvxiFoSfYVubEuH4Z0mZ/cNJ3iDoRCWx4
	 n7BHcNocm0q/lwUqfg0Q0IjeBaRCocukVwRATv4SrbqZGaxxuXw0HLW5iu5vPwPYDh
	 Ipx91Yt3omCwA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8BFBF4D49D;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 26 Nov 2026 12:47:47 +0100
Subject: [PATCH RFC 7/9] ipc: Register ipc_sysctls as a template
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
Message-Id: <20261126-lklm-sysctl-ctx-flatarray-v1-7-d7fc9cc9b03e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4976;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=54HGww1X23ASNOxIGe3Rxq7gJzlT62N2Vt9USaYOQiY=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsIHGUvwSVAnNS5lLfxc7WVC/uJB8e3Oz0ob
 bPc1/RP5CyLL4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrCBxlAAoJELqXzVK3
 lkFPgTIMAIR4yCRrf8qNLZiE+iuepvt8fDSt9M1X3AAwFrc+ny59YhNL7QAc3Ko4szYiepSb0cU
 43nc4NArMYz2Wa5IBpKTqp3R/qOpwfQ53vqLschdcs4afJKoaU/4ix/ZuoJp9Y3KVU2P88TAoTp
 I3iqlwwbobpD0wxNQpkr2OBNxljQgBp+wWABEtDc//EUVp+lPQNBBaJWOCnxGGmRd8W26XgHAK+
 x5s2Erb1XZiwdvz8jR8SxiBiLz+whvpvuz8RLpLAm9bxyLpCNzeZZv5VHktDh+ePud9At9jSl/X
 /3IUsvRIoblRzQzfjHhD9Bhw7u0jSqVfphjSK8ckB+WyWu/C9+gERcB0W+84dwI5Os9z+5MEOZd
 2i0xaH3D785woVTYapd1j8xC/Xrv+YoQSRcOMZtRZmSsHFCzLNnpy60RW7nx2J8FTltLWG1IaXK
 cP4Hb2ufYtt5lrOVeL7RUf7qz20ai9s46L+tQmftRO2VfXfGVGM6zfXeSFNsFJp80PHG2WEdsg5
 +Q=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Flag SYSCTL_OVERLAY_DATA on every entry of ipc_sysctls that has a .data
pointer and register the table through __register_sysctl_table_tmpl(),
passing the rebased copy that setup_ipc_sysctls() already builds as the
overlay. Free the copy once the call returns and stop freeing
ctl_table_arg in retire_ipc_sysctls(). auto_msgmni has no .data and
stays unflagged.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 ipc/ipc_sysctl.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index d038d944257f60b3a35b72492c73c41774a73da4..42a249cb58747e75fa76aa94570e5ad23cf8b003 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -79,6 +79,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmax),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
@@ -86,6 +87,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_ctlall,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlall),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_doulongvec_minmax,
 	},
 	{
@@ -93,6 +95,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.shm_ctlmni),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
@@ -102,6 +105,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.shm_rmid_forced,
 		.maxlen		= sizeof(init_ipc_ns.shm_rmid_forced),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_ipc_dointvec_minmax_orphans,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
@@ -111,6 +115,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.msg_ctlmax,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmax),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -120,6 +125,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.msg_ctlmni,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmni),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &ipc_mni,
@@ -138,6 +144,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.msg_ctlmnb,
 		.maxlen		= sizeof(init_ipc_ns.msg_ctlmnb),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -147,6 +154,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.sem_ctls,
 		.maxlen		= 4*sizeof(int),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_ipc_sem_dointvec,
 	},
 #ifdef CONFIG_CHECKPOINT_RESTORE
@@ -155,6 +163,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.ids[IPC_SEM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SEM_IDS].next_id),
 		.mode		= 0444,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -164,6 +173,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.ids[IPC_MSG_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_MSG_IDS].next_id),
 		.mode		= 0444,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -173,6 +183,7 @@ static const struct ctl_table ipc_sysctls[] = {
 		.data		= &init_ipc_ns.ids[IPC_SHM_IDS].next_id,
 		.maxlen		= sizeof(init_ipc_ns.ids[IPC_SHM_IDS].next_id),
 		.mode		= 0444,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_INT_MAX,
@@ -290,11 +301,12 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 				tbl[i].data = NULL;
 		}
 
-		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set, "kernel", tbl,
-							  ARRAY_SIZE(ipc_sysctls));
-	}
-	if (!ns->ipc_sysctls) {
+		ns->ipc_sysctls = __register_sysctl_table_tmpl(&ns->ipc_set, "kernel",
+							       CTL_TABLE_TMPL(ipc_sysctls),
+							       tbl, ARRAY_SIZE(ipc_sysctls));
 		kfree(tbl);
+	}
+	if (!ns->ipc_sysctls) {
 		retire_sysctl_set(&ns->ipc_set);
 		return false;
 	}
@@ -304,12 +316,8 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 void retire_ipc_sysctls(struct ipc_namespace *ns)
 {
-	const struct ctl_table *tbl;
-
-	tbl = ns->ipc_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->ipc_sysctls);
 	retire_sysctl_set(&ns->ipc_set);
-	kfree(tbl);
 }
 
 static int __init ipc_sysctl_init(void)

-- 
2.50.1


