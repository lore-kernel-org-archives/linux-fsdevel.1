Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074879;
	b=GG2gavjTZVBRGlYBfhnseZltl5ZMj3j6+1chqw93Oqr7+JXYFTQOwowN7cJws8hDVfYH
	 M89PI+oGm7FqWGtm7MNIKXVbTBBGYGvAqLV3OC3REoQWhISyTsVea/0nGohjlmKappEce
	 z+GTEYkYiARUvNR5rYVr31ADrZJx0AdzTASqswnEStJhq1dEiiLuJVo0fj9CYH7GRQAuu
	 dUUBuU/y2F9I/gTLY7zd6IeNO5O3KCaf/a/OvrwmzDtPNItEp8ZiqsX6Zg/moF/VNlZhQ
	 xSqBz/vMOn4KI0rLU7RXpf7l8g7229HlSlWUYp4bM7Nu9PAAMJmBuKGYAEzI+MttZBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=IbKbkm2FCu1dJjWm0bA0zRZkrHajWkzVG1UGfJQ9bvA=;
	b=CBY4ER0d8hbXW7/GQiNOQSnfS70aevlpKanylQ8xBhzU1SROGIN5hhPgI/U1ljP9H0Wf
	 qJg1Wr/9jPXg6Eg+7yhk4yLPwyKzUu8aPaiTL1E6Slwa8UgB/2goZHic1b7RiPrtZ9sv1
	 LfJFQxAJSkAaX9BCtYt9Qoci2HLaEZMszuNGtljUPZLYGwXLsXtlxDMee462FiBw7+sP5
	 cwjbCpQS3mZwNDPQWCfnxy3LSRIa/dTV5eNOEarr+HZ4ZRg1lA57aHXuUVSsnMacUXxLt
	 ndh523U05xRf1kib0runtx+tQ0h6WqwCTufWL+OqW42sZMYdOGbHBgDUX0wwi8Fo1ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b="U+webZk/";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA7F606A31E
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Oct 2026 04:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BA7F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=U+webZk/
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso2662038a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Oct 2026 21:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793074879; x=1793679679; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IbKbkm2FCu1dJjWm0bA0zRZkrHajWkzVG1UGfJQ9bvA=;
        b=U+webZk/UC0AmEh8JfGeN0MsgqZ5s35ckHlqcQZGpqM5matT9IESNMyqgLlqhn8+LU
         62r6mR2RVpK4FKHh/WYKLLfw4IkyeBL78s9aMyPY/LBrc/ElrYJXV4FSqAoO8HPIUfve
         57DIfcFTgwcH9ibOsaVbpBayQsR7iIg7tLxZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074879; x=1793679679;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=IbKbkm2FCu1dJjWm0bA0zRZkrHajWkzVG1UGfJQ9bvA=;
        b=oddHEnWcg6hAfWfUiAKDg+pkDpA4vqS0FegJKFyVrWNXtnpD5dzKBvSwQhmJ0jJfkJ
         86YBymj//n2H1VU9mnGH1D2OPLGO6cHEzH4NqJVRDhTi3PE12tBbptjZKeEDNig0rp7E
         GVQUkZ5hA0bJ12RQg+vHYQWMDvXlxXUIBnUe22kofaYv9sVGAbX8jog2il20J8CBBx9m
         x6EuB6f8iqo+pJhEz/BVcFKID3lFZE3lwODuzZ+lCxZ+H+UeojB39Kl6m2pj3fb2zTxK
         +k0vMC9+kp8Fw3LiPMZPrKp8dZPne5udN0/J0tWRJMSiJI802CRR9vo1O/GG4CAglsjw
         R+TA==
X-Forwarded-Encrypted: i=1; AKwUvBwTbzcBVZMmR1I/Ha3e54v7CuVcKlk2t79EMB6cwUkfqQGRD18xDQtxmGe1CwEVUbJq9Cd8hYnchB52UgLa@vger.kernel.org
X-Gm-Message-State: AFq9FYKfaefdKJ0XyKz1c95k3kwsq4Ej3d19GL1Y3YOOw3DmN5C0a+w3
	bPnvDQf88maAraUJgQzHCrLqTP3N5L6b6bm5+W4XEkX4eT21LO319ZZNsrSlyzleBc8=
X-Gm-Gg: AYBFou0PCGWG0Rvp4MZ6EenvIF4HDXIIlIabzpQRXO+ZdYCIf74QMilf3LTa1xPd1wV
	tJeB4MtlFpOEjfT1POZFnVcEUr7GfaFU4yRklgZd5k9/FRVkQXSbI/HTV+OfLkfXCK6HNM5ND3S
	atwHosGrPsEyASNFupTW4haltKLAiK59ztpjyImKGKlr1dSwj6j+lDHmpqU2OGQV9eoMJxBhaB+
	C0VJaBuvUCAih9fOqRAGMEpE4IbJMrCsyjYtd0X8++DN9cuplvBBuoTbLDrnMl7LIjNpjNWlsno
	/feJDRs88RaHgfE4gJcNo/C5p0ZbtKnu5wZRvCpq/Lbec004caE5wzgQxVZ45Iv8C8Qs11ujHrA
	n5Kun07bAMQJzem82HDQ1gDHjOyzl6ae26OMjNd5hAIFb79Z2LastAq/K1tnnVvlvcGd1a/ciQO
	2JAc5KyGQ4sWRogj/NSW+ZGM2fFTgYsZLCN4KtRN0E0kX8cjaUuuJ19sKkLXRftzWsSmjCZCpAD
	sQryZevDBYvWXMyGJA4gyVkcMUxETXe/QLDKasL14YIbRj8dKl+GpUfCVGTpkvR4mjt1g6gZaAU
	coKsNT2mApb6zXKnx7JpDHR/Cnb1UV5qvUkQCONUdPGGVRtKoF8AL1oo53qwBhVJnxkFNeb8Fda
	OMe7j9rNlxbupoBt182hxkmr6xT5GKTwba5RG8RpxmYHu
X-Received: by 2002:a17:90b:2d86:b0:3ac:17c:6e89 with SMTP id 98e67ed59e1d1-3adeae6d79amr6903972a91.19.1793074878569;
        Mon, 26 Oct 2026 21:21:18 -0700 (PDT)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae40427bf1sm1790327a91.6.2026.10.26.21.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:21:17 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:21:14 +0800
From: Chris Down <chris@chrisdown.name>
To: Omar Sandoval <osandov@osandov.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-debuggers@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH] proc/kcore: Allow disabling /proc/kcore at boot
Message-ID: <auAmuqZyUodq3iqk@chrisdown.name>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

/proc/kcore lets any process with CAP_SYS_RAWIO read all of kernel
memory. That's a pretty large read primitive for anyone who obtains
CAP_SYS_RAWIO (and it also gives away the KASLR layout).

For this reason on some hosts we want to turn /proc/kcore off. However,
on a kernel built with CONFIG_PROC_KCORE=y the only ways to block it
today are lockdown=confidentiality (which also disables many other
things we perhaps don't want to disable), or LSM. That's annoying,
because on the majority of hosts we do want it on for things like
drgn/crash, so today we build two separate kernels.

Let's add a "kcore=" boot parameter so that this can be disabled at
boot.

Signed-off-by: Chris Down <chris@chrisdown.name>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 ++++++
 fs/proc/kcore.c                                 | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..d8acce2878ab 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2915,6 +2915,12 @@ Kernel parameters
 			parameter KASAN will print report only for the first
 			invalid access.
 
+	kcore=		[KNL,EARLY]
+			Enable or disable /proc/kcore on kernels built with
+			CONFIG_PROC_KCORE=y.
+			Format: <bool>
+			Default: on
+
 	keep_bootcon	[KNL,EARLY]
 			Do not unregister boot console at start. This is only
 			useful for debugging when something happens in the window
diff --git a/fs/proc/kcore.c b/fs/proc/kcore.c
index 390547b992ac..6a29a3e0ed92 100644
--- a/fs/proc/kcore.c
+++ b/fs/proc/kcore.c
@@ -69,6 +69,7 @@ static size_t kcore_notes_len;
 static size_t kcore_data_offset;
 DEFINE_STATIC_PERCPU_RWSEM(kclist_lock);
 static int kcore_need_update = 1;
+static bool kcore_enabled __initdata = true;
 
 /*
  * Returns > 0 for RAM pages, 0 for non-RAM pages, < 0 on error
@@ -720,8 +721,19 @@ static void __init add_modules_range(void)
 }
 #endif
 
+static int __init parse_kcore(char *str)
+{
+	return kstrtobool(str, &kcore_enabled);
+}
+early_param("kcore", parse_kcore);
+
 static int __init proc_kcore_init(void)
 {
+	if (!kcore_enabled) {
+		pr_info("/proc/kcore disabled on command line\n");
+		return 0;
+	}
+
 	proc_root_kcore = proc_create("kcore", S_IRUSR, NULL, &kcore_proc_ops);
 	if (!proc_root_kcore) {
 		pr_err("couldn't create /proc/kcore\n");

base-commit: 01146870c415f6ff70a469fb7ceb962a3f2c8c52
-- 
2.54.0

