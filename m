Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795693694;
	b=Ii7EcEIJeDP1J+DNrs61hwU6iZDg6g3AliclqDkvqpp9MDQdq4hpfuZlxVU1JPym45TC
	 DFc/T9pKKjtgs9Ptkl9Dm8sUtoXMtpNVqUzi6BjwSQZSa61MYMIyDKzyYf/7srx4YRY4F
	 SUje4rJBNh7o+2rWK2Njg6hEe6y+pgT22gg4jeOCyPyq+hD1LbIRR8KlD0aZvZpc9/Ybc
	 pda5oygQ5TpoIbcXjo7fthp60lPEPlGzKfFeizyQHSVzoTal9ObT+0RPmIW+iFx92mPCt
	 tM3yxH89CyYJasch7wCO2P01qtiML1k3QzprTRPbaIVkr5P3SpQa8nH/N89+f2i/U6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795693694;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received;
	bh=P1jXufVPzc9IkmUZ87kfTJT9n9zJtHlLLzaPGRLFINM=;
	b=5iLVNS6c/8VQplhc6qcnDU6Kbil0S/rMiHhv7IuN4FrXtfe74da/ge7ma3IoyDQ7gstw
	 zHWKThHaALHMN32MCypG/GqMYA7n1a28I6yp1M8+c2oGYvB5ecHuX7nCkC4nKH8g01Cac
	 2zxeV3whj2q8hjnFTDa7SdIKZJ52rV7TRcHH3aotr94MziM4c79zIJau6rz4aKxlV3Lka
	 weLOa6NiKDQZR7Bm6yrzG9AaQMejC3xAygS9FQvgJVxgJPCRIZm2f87uX4gUStdKw08Fy
	 lh53i7VaUO4/Irg4dW26D/Q00YMkf4lScbLv70RjbVNQtk9Qa1zVcwyDvjYeAh7S+8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhQBqCG3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EFD60A2602;
	Thu, 26 Nov 2026 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dhQBqCG3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795693693;
	b=23wW0JgI1tymhrKaarr51K+MbZOTN9J8nq1zmANUfopor6U8x/SYIfK+gxFVcn1Xr4mQ
	 iSrkaIJhx41cAq1rlzEUZcmqB5Ihw7usrQHc+2t7VCHl5/l4Wz+qw5XjDkK2YqtUyt/1K
	 5bRy6GWUHv4ivLkUD0x+JU0Z8NYkiPlzM8j6qBF4mk0kqcSFCGBQtLqia+IXgW8K2LXZc
	 vPQnavJWpxFjECaY0Qsznq0EHjEsfoFZJ/Hizc9tkR802DNi05m4ScQuHVgWtEcKXRrSL
	 /1pntc8DJ0jyCJ+XEpxL9BieRkMMOb68U3QHQGnoILpYZlpFT270QXzcPOkQI4nFdTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795693693;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
	bh=P1jXufVPzc9IkmUZ87kfTJT9n9zJtHlLLzaPGRLFINM=;
	b=c+5WaNEPQTHlIoEprox5nt8igr/JeiaNbQRlaOqvjduPP6D4QcpxQhx6atoyxQY1DhU3
	 aFWldRbBxZNnPGoCCGHe0p/UQm+Gg7SeZWIRURsWzuspzCcOixyk/VZcufD6C38ztyEDM
	 Ujmw4ZVuqu/4PUW4lsdnkpopgOx1OXo7q89YnUO1+t5/7yfs6CvXjBGH7Ehw/HM+qkGeZ
	 URFrsH7zoUTnNdWngPgA8dfhDMjW9Hv+cYcY4YD3aMvQwAQnG2cVK5CVEGmwqGhO2lQ5I
	 /ozmh/qEgTHWClatu401gNfA18o8/lrJtOOXC5aqd4cl3n1ZdWz4vkMxsDWN2hC96yA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2CB851F000E0;
	Thu, 26 Nov 2026 11:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795693693;
	bh=P1jXufVPzc9IkmUZ87kfTJT9n9zJtHlLLzaPGRLFINM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dhQBqCG3vUgbG3X4V3jpxQD2zjcvL70JtFL7jQ8kfVxxKPGTx7ueUV3ywQpk2vZXK
	 rEhgmFuRjEbDsQSbu7iZ90nzOEvkmrRW0r/A/cBf9/xFgbVxRhnZ4rv7Vjwu5WEqKM
	 6ut2xj+fGSLq9tpc6swIhpzprcgVsHaWGb3TJN7X+V7WVMxfb6IB7fQSxmisOiyP5g
	 zzPP7Q6c1pszYJdzPeMMSrXe6W6CmAwNU5PxTDTu6DlLt7PTG8NFfc5Z23iUW+Hneu
	 Ufsl3n6BU3Q2FqWFN+o3+lEluPEmb6ZST2b7xB+rrLLsn9DltTfsUiy1AeBCDmcW3c
	 vt7lcpZ8ztHQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B128A4D4A1;
	Thu, 26 Nov 2026 11:47:53 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Thu, 26 Nov 2026 12:47:48 +0100
Subject: [PATCH RFC 8/9] ipc: Register mq_sysctls as a template
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
Message-Id: <20261126-lklm-sysctl-ctx-flatarray-v1-8-d7fc9cc9b03e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2968;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=WkQNr6QnWoumKVxyewSSlZ9tzXOb2ucls8i2JZ231Ug=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGsIHGYrbDOl6KkAQLkQYC3EcXdsceyF87xgq
 rrHsSB5YX02q4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJrCBxmAAoJELqXzVK3
 lkFPJgAL/A6cdr0GRDrKF/B80MWYZTZqDRohMggTUeQdBzrDwqcU2tVGBxU7mLJq/E88lCWqPM2
 3b3FsML3WG3jFhBeDUs0AUrbM4LF1pjOmasf4uwI+jA/Httyl4nl3CtlMRJeN3beA7sdNRdakmD
 wu/qkaq5BGsIh8SAxt8m3Q6vLwscikzkJ0u8H4hjrzOUSu4MoKoinxIA01G+f7rFwsSC5pF38sk
 ETn1JJuJ+4YCZhR7EUMZJC7MLTGb8ZYuzvbg6jeoKRO+dTsL/sOa6n+T1U55kpw537DzvIMfiHH
 LQvgPXk57ne/v2tY472d7rDSV1eW3Tts/yV7iUg3h178npeoRSOJNqkq0EmPwe3rl1PuieCt2Oc
 SuoZW4WZmFsk+4/Bfxz7nzOekoVUURlRnSgkARCxfRPsRiuJSIUv+UAgG3HhDGdjs4DMb3lJRxE
 WI3m4dH8lag+CFxcqxlz3ljGxO4di2VAR2t8hN71DVwY8XVmDU9NsErUhMnfy+GwqB+ghdbcmD7
 Ls=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Flag SYSCTL_OVERLAY_DATA on all five entries of mq_sysctls and register
the table through __register_sysctl_table_tmpl(), passing the rebased
copy that setup_mq_sysctls() already builds as the overlay. Free the
copy once the call returns and stop freeing ctl_table_arg in
retire_mq_sysctls().

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 ipc/mq_sysctl.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 0dd12e1c9f53ef07092ca3b638335a438d273a8c..d98c90595fabedc30fa565c8e0ca16ec3399bcf4 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -26,6 +26,7 @@ static const struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_queues_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec,
 	},
 	{
@@ -33,6 +34,7 @@ static const struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_msg_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_max_limit_min,
 		.extra2		= &msg_max_limit_max,
@@ -42,6 +44,7 @@ static const struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_msgsize_max,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_maxsize_limit_min,
 		.extra2		= &msg_maxsize_limit_max,
@@ -51,6 +54,7 @@ static const struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_msg_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_max_limit_min,
 		.extra2		= &msg_max_limit_max,
@@ -60,6 +64,7 @@ static const struct ctl_table mq_sysctls[] = {
 		.data		= &init_ipc_ns.mq_msgsize_default,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
+		.flags		= SYSCTL_OVERLAY_DATA,
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= &msg_maxsize_limit_min,
 		.extra2		= &msg_maxsize_limit_max,
@@ -143,12 +148,13 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
 				tbl[i].data = NULL;
 		}
 
-		ns->mq_sysctls = __register_sysctl_table(&ns->mq_set,
-							 "fs/mqueue", tbl,
-							 ARRAY_SIZE(mq_sysctls));
-	}
-	if (!ns->mq_sysctls) {
+		ns->mq_sysctls = __register_sysctl_table_tmpl(&ns->mq_set,
+							      "fs/mqueue",
+							      CTL_TABLE_TMPL(mq_sysctls),
+							      tbl, ARRAY_SIZE(mq_sysctls));
 		kfree(tbl);
+	}
+	if (!ns->mq_sysctls) {
 		retire_sysctl_set(&ns->mq_set);
 		return false;
 	}
@@ -158,10 +164,6 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
 
 void retire_mq_sysctls(struct ipc_namespace *ns)
 {
-	const struct ctl_table *tbl;
-
-	tbl = ns->mq_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->mq_sysctls);
 	retire_sysctl_set(&ns->mq_set);
-	kfree(tbl);
 }

-- 
2.50.1


