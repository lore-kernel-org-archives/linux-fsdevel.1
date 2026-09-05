Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249F32B130
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651508; cv=none; b=N9tqjuv1VlcB+ZaMSgcTS5V0f9jsHtQOwk+oeVUevhRiBF7Oj1rXh80pI0Mos+DMkcO+HVVUNt9sVdtD/i2sPBVUWsN0VYX6wgwoDomfqW3EZfM2SgpIK0a9SYgIn4KVPFkayKeOA5lgBF3b9enZ9cHCNar+o6xlspb2lSJxZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651508; c=relaxed/simple;
	bh=VBwqJxVdt1Xq0XVIzyQS3Rava+X0ogxWnXZEjgkvgLE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Bm7pQq3Zw9wCPvj7a4B8N15384/cJXwXDf0YCWbyQZ/ePEEPhisyMU7FIhF59DtLzUVm/3Jxh8iroScJpNKtQ3QnENieJ1xFqx1Vw+pNNA/Ih9ieZo4peikX7+TwHDhi7XypUCedzKMflf80P+Ws5HSoFSqhbQN3TM8zoEZVLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OG/EGSAz; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OG/EGSAz"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ec0f510a9so4212024a91.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 05 Sep 2026 16:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788651506; x=1789256306; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r15LapvVWVwQkzcr61T+u7jhLX/Oi5sEbrvA8bk0n6k=;
        b=OG/EGSAzCN2zpvMptGZ8bzr4ZU9H5C9pUwTmwZudMcjbtph3aNa7TwkEKPZggcP6no
         RHt6aXmkqfoQIUqbDYksbD+IU4dwXkLcSL/0NfnJQp1VQrFZurCM85NZPjm3fr0oD4XL
         axaqCFX/pcEtCK+/5Yf5iNm1sAVyp+ZxSJshPKkR6PD7QJNKAb9jrmRWStuMRKaj+dJc
         nklx4gtmW96jT/btayFNSBVV3i/XJkulsVQgsn1+Pi7ca5tKkuVal3U9twxhSblprCky
         XyeUZwB8mkJ5Xqk/TK22zgNcP3ea1rsmysjg7orOFCeliOk890yRyn/1blh7GIvA2olp
         7ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788651506; x=1789256306;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r15LapvVWVwQkzcr61T+u7jhLX/Oi5sEbrvA8bk0n6k=;
        b=eoXuZ0cgeNFJlG/FhzOkbt0PNWNgyM+fmzzoyZmIEFE9oyLGZo2VpAwlGeolfAQVD/
         MVuiLfq0GZjh8feWB0F0jX5ZVcq5zqyxqkYcunlObfkGU9LSD2DKDSR5s/6xbsgYIPAP
         tv7ZnmJLucwXvDziYdi6kHyyfMhuExpUzVSaOQEBImVEHrh+NFgAUpesh2qSjB38taCw
         r7wSFsS1Z9W1/bckMtMEPFulaXStRDvEnsOVwCfzdQy8cJMR8nF+65tVlRVb1b+7xRTu
         ZhL6edaXhi45cXQp1KblYdTSQVbyDx4+MNUiFGUY4WL0dwCc+1SVZVk0+wWBvJ5fGKcG
         jWwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxm1CkVBhpBU+kCMM291SGHzFN5D6d9FkDKtTcIXDbEURp2ob6+m5V4R8beX0o+cgHFKkl+NKocP8kYKuEq@vger.kernel.org
X-Gm-Message-State: AFuF++ld8UeYqwWnqFDFx+4YAIbcB1gyPr66ejpohY+B0VxrtYTteFlP
	vrlNgesCKYb0HVwV9t6I0yxsaDVAWZOnddLco8d3VG+LRA4nXZEh7IqJ6bq01AwF9GdZA93Ti03
	Lc1JA7g==
X-Received: from pjtl8.prod.google.com ([2002:a17:90a:c588:b0:39b:272c:6659])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3943:b0:398:d8eb:cb2a
 with SMTP id 98e67ed59e1d1-39b26273e31mr24737207a91.23.1788651506033; Sat, 05
 Sep 2026 16:38:26 -0700 (PDT)
Date: Sat,  5 Sep 2026 23:36:30 +0000
In-Reply-To: <20260905233819.1064529-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260905233819.1064529-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260905233819.1064529-2-kuniyu@google.com>
Subject: [PATCH 1/2] sysctl: Make proc_dointvec_ms_jiffies_minmax() enforce
 minmax again.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Kees Cook <kees@kernel.org>, Joel Granados <joel.granados@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the cited commit converted the SYSCTL_INT_CONV_CUSTOM macro to
functions, it accidentally changed do_proc_int_conv_ms_jiffies_minmax()
to pass false for k_ptr_range_check.

Since then, net.ipv[46].neigh.${dev}.interval_probe_time_ms no
longer enforces the lower bound.

  # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=0
  net.ipv4.neigh.bond0.interval_probe_time_ms = 0

Let's restore the minmax check.

With this:

  # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=0
  sysctl: setting key "net.ipv4.neigh.bond0.interval_probe_time_ms": Invalid argument

Fixes: d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with functions")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 kernel/time/jiffies.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index 213ae1d6a014..70926b73905a 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -181,7 +181,7 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr,
 					      int *k_ptr, int dir,
 					      const struct ctl_table *tbl)
 {
-	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
+	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
 			     sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_ms);
 }
 
-- 
2.55.0.1003.g10538fe699-goog

