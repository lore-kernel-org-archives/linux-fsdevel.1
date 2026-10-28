Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205456;
	b=PlaUvDdk5saQOFzsAfV/Ag8ESp7JcpXP8quSItjXZlIHO4wSuT9isiuaVfBrCqZUEH3f
	 EAO66vDWPftsn+3KR85Ibz7SzbvBGpwNMS75dXjNIvI//hX5XBTzzc/uOEW7xD96ZnhJX
	 GDpKie5ikK/kq2jaI/5rK3caSvAAIAyjHKzxz1Vpk/bAy5EpgGkxFPAa3Yk9ZbgqkRwqT
	 UYghpv2A/15kJf8KbblwuLVC3+r/wJRHcVoZJuF222mzm4lSE42lTqv+hC3WkbJWfwhKi
	 FaA7y2erqvWIRsMBL3KtxMZ2Z4ANQRdK8klTP6zhb4oWg9o0J6QGyVgyQh6J+2+8VZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205456;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nK3Nt8cGE3hJPWcMvC7YNISaGC69jVpDN/QOixd7gtc=;
	b=vViw3B1t4n/QdkkpZGAf5aynobF5PXPpkRs4TRmdEONYoNUZxt83wdBxamOWespU6qk8
	 R+2Dpd/lkMmW6BDCES758Pxbpn1CwhMSSBzZHaxrwXTDFCcp3xTsh5IGntsldLdNBi/ns
	 oJBG+qrAeWu2LZizxg8IIVVZrlgeb0q/pYgOHkdKJhrounLC/lUTIHA1/lg2b4fWrzfX/
	 Qto6nTGB4+uk77lNewIDjWq+qNuki1DQjGfnclJVPGv3cK9CADQRpM7moJikzRjIWsaiJ
	 jpe7wnb4JD8igeZ1EAbOk4F12AzfMf2hz4hI9ZdAop1VOBIrarcFyLlIdFF6/G8gpxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GvX2RI4Z;
	arc=none smtp.remote-ip=91.218.175.51
Received: from mta0.migadu.com (out-51.mta0.migadu.com [91.218.175.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEC0606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:37:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0AEC0606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=GvX2RI4Z
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0y0cpyImzffhtGDB41PPSGb7C8URf8GX0d2rmRQc21M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205454; v=1; x=1793810254;
 b=GvX2RI4ZUGGf8yQ4BPPQm5R3xrlMOXRdpblpLi7tH+znBDm6z0mCPPnCCP24FPcWFvJBmBWH
 E+W7ASYyzbxU3tRzzxFkFUsQOPdRZLwpRqU0r9ETIePweXOfbHhFtlyeUAHyCi4YOP34dywlUbo
 KSJDfFpgjXk1GjWq0MdUH970=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id d9f5c6d6368c6816;
	Wed, 28 Oct 2026 16:37:34 +0000
X-Mizu-Trace-ID: d9f5c6d6368c6816
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 21/39] sysctl: refresh device-dependent bounds per call
Date: Thu, 29 Oct 2026 00:35:00 +0800
Message-Id: <c96f489625c12846bd4f8b41bd89b027beb9013a.1793204511.git.wen.yang@linux.dev>
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

Refresh device-dependent limits before validating sysctl writes.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 drivers/base/power/main.c        | 21 +++++++++++++++------
 drivers/gpu/drm/i915/i915_perf.c | 19 ++++++++++++++-----
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 88a31e09e4f3..8346875a4fa2 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -543,7 +543,6 @@ MODULE_PARM_DESC(dpm_watchdog_enabled, "Enable DPM watchdog");
 static unsigned int __read_mostly dpm_watchdog_timeout = CONFIG_DPM_WATCHDOG_TIMEOUT;
 static unsigned int __read_mostly dpm_watchdog_warning_timeout =
 						CONFIG_DPM_WATCHDOG_WARNING_TIMEOUT;
-static const unsigned int dpm_watchdog_timeout_max = CONFIG_DPM_WATCHDOG_TIMEOUT;
 
 static int proc_dodpm_watchdog_timeout_secs(const struct ctl_table *table,
 					    int write, void *buffer,
@@ -565,23 +564,33 @@ static int proc_dodpm_watchdog_timeout_secs(const struct ctl_table *table,
 	return 0;
 }
 
+static int proc_dodpm_watchdog_warning_timeout_secs(const struct ctl_table *table,
+						    int write, void *buffer, size_t *lenp,
+						    loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.max = READ_ONCE(dpm_watchdog_timeout);
+	return proc_douintvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static const struct ctl_table dpm_watchdog_sysctls[] = {
 	{
 		.procname	= "dpm_watchdog_timeout_secs",
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
 		.proc_handler	= proc_dodpm_watchdog_timeout_secs,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= (void *)&dpm_watchdog_timeout_max,
+		.min		= 1,
+		.max		= CONFIG_DPM_WATCHDOG_TIMEOUT,
 	},
 	{
 		.procname	= "dpm_watchdog_warning_timeout_secs",
 		.data		= &dpm_watchdog_warning_timeout,
 		.maxlen		= sizeof(unsigned int),
 		.mode		= 0644,
-		.proc_handler	= proc_douintvec_minmax,
-		.extra1		= SYSCTL_ONE,
-		.extra2		= (void *)&dpm_watchdog_timeout,
+		.proc_handler	= proc_dodpm_watchdog_warning_timeout_secs,
+		.min		= 1,
+		.max		= UINT_MAX,
 	},
 };
 
diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 19b82427aa41..2e758f2008db 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4795,6 +4795,15 @@ int i915_perf_remove_config_ioctl(struct drm_device *dev, void *data,
 	return ret;
 }
 
+static int oa_max_sample_rate_handler(const struct ctl_table *table, int write,
+				      void *buffer, size_t *lenp, loff_t *ppos)
+{
+	struct ctl_table tmp = *table;
+
+	tmp.max = (unsigned long)READ_ONCE(oa_sample_rate_hard_limit);
+	return proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
+}
+
 static const struct ctl_table oa_table[] = {
 	{
 	 .procname = "perf_stream_paranoid",
@@ -4802,17 +4811,17 @@ static const struct ctl_table oa_table[] = {
 	 .maxlen = sizeof(i915_perf_stream_paranoid),
 	 .mode = 0644,
 	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = SYSCTL_ZERO,
-	 .extra2 = SYSCTL_ONE,
+	 .min = 0,
+	 .max = 1,
 	 },
 	{
 	 .procname = "oa_max_sample_rate",
 	 .data = &i915_oa_max_sample_rate,
 	 .maxlen = sizeof(i915_oa_max_sample_rate),
 	 .mode = 0644,
-	 .proc_handler = proc_dointvec_minmax,
-	 .extra1 = SYSCTL_ZERO,
-	 .extra2 = &oa_sample_rate_hard_limit,
+	 .proc_handler = oa_max_sample_rate_handler,
+	 .min = 0,
+	 .max = INT_MAX,
 	 },
 };
 
-- 
2.25.1

