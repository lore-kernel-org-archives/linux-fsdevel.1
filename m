Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205541;
	b=R9cImpH4+O4NDZUFQBq2JxsjpBadXueGjU6xWmJEMj8hyc3wO9fbdvFzKfchrugP0Mox
	 /871x2o4xfgixjWTbCuY3KqLBvi2Hj1+42vWBRdQ5Ls0FR5c2n0oxzbx10mnndx31M1cn
	 FQpDL8k6bmsZbgS36kmS7b2FPkSIOLWDkfutbctiB0lZIsXt/VuO50K30d+Xu6A2qc6TR
	 vJbEWHzwB1Elcd+GudKOzPiQiTn/fhdUxNMR2ZG3HEdN3YaYvPyGV9XtTkFuAkqPBoRxz
	 dikaqlEcLlBTITivIiPvQVxizYdLWTvElZ5aIjuZKvVyQExmwOUJQIyIO7PnpOCP31A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205541;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o14Y8GioHe5xKGETtV+6mIGsvynFWBNAqqz3q1Plk64=;
	b=0SdJYygtJHIGtJ4h8P1lNdA1qEBGgChUP6PSiXHHsrQB6SYVUdq3g6mzz/l4yOCyR0Ha
	 Rm4stpXTfEW8JqDmcHLpjmWri4JcjVbCRmGPrmZL0bBzoKfAelpKQtO8uDLWXL/qNjBDo
	 /WPPs/HVo/k1+Cc5w/2uERzbw8Yt2NRES77SORyF6B5/j+knu/E2IJlGpEu3EVD0lFWoX
	 GUtqX2hmk8Uq6PLb+LAKP7QSZR7CwN4PHkpmHLAdCqVSaTtMJwlrM85AUSyC567OAr9wG
	 Otqxeorzf8/AI1WT30/ECWAUXRcQ97ia5H0R8zFyxZuOY/u+ngoB4RLj06gspb8aRtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YxF4Cpw+;
	arc=none smtp.remote-ip=95.215.58.136
Received: from mta1.migadu.com (out-136.mta1.migadu.com [95.215.58.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E1860A260A
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84E1860A260A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=YxF4Cpw+
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FL7qyygk0WpLM2HIqHVy+cQvsdnGXSZjWaxsKWXACz0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205538; v=1; x=1793810338;
 b=YxF4Cpw+iakzD6IeKVDaTTCj1oCcus0T+oStlsHMCGaMGSvTIoLjsDw1QRT+jaCOt4k5440Q
 vj2LLerm2g2Ibo+lvj3dxe6bjGK/0v3OEpWt9sIeCLkfkYuPk5283SU8Pm0kU7bb0VWn+hs5rWs
 lIlBwDcA/XdJt/PcBIg0JzI4=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 166e4e174b8e3a3d;
	Wed, 28 Oct 2026 16:38:58 +0000
X-Mizu-Trace-ID: 166e4e174b8e3a3d
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 38/39] arm64: move vector-length sysctl context to priv
Date: Thu, 29 Oct 2026 00:35:17 +0800
Message-Id: <ccd456ca9a22b5ff9ef240a871f4fdd1fb515365.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wen Yang <wen.yang@linux.dev>

The two default-vector-length entries borrow extra1 for a struct vl_info
pointer, which is not a bound, while the handler delegates with a local
int table.

Pass vl_info through priv and leave extra1/extra2 to the numeric bounds.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/arm64/kernel/fpsimd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ecfa21615f16..97e746bca99b 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -549,15 +549,14 @@ static unsigned int find_supported_vector_length(enum vec_type type,
 static int vec_proc_do_default_vl(const struct ctl_table *table, int write,
 				  void *buffer, size_t *lenp, loff_t *ppos)
 {
-	struct vl_info *info = table->extra1;
+	struct vl_info *info = table->priv;
 	enum vec_type type = info->type;
 	int ret;
 	int vl = get_default_vl(type);
-	struct ctl_table tmp_table = {
-		.data = &vl,
-		.maxlen = sizeof(vl),
-	};
+	struct ctl_table tmp_table = *table;
 
+	tmp_table.data = &vl;
+	tmp_table.maxlen = sizeof(vl);
 	ret = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
 	if (ret || !write)
 		return ret;
@@ -578,7 +577,7 @@ static const struct ctl_table sve_default_vl_table[] = {
 		.procname	= "sve_default_vector_length",
 		.mode		= 0644,
 		.proc_handler	= vec_proc_do_default_vl,
-		.extra1		= &vl_info[ARM64_VEC_SVE],
+		.priv		= &vl_info[ARM64_VEC_SVE],
 	},
 };
 
@@ -601,7 +600,7 @@ static const struct ctl_table sme_default_vl_table[] = {
 		.procname	= "sme_default_vector_length",
 		.mode		= 0644,
 		.proc_handler	= vec_proc_do_default_vl,
-		.extra1		= &vl_info[ARM64_VEC_SME],
+		.priv		= &vl_info[ARM64_VEC_SME],
 	},
 };
 
-- 
2.25.1

