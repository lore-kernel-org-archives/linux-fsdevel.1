Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486956;
	b=rdgEKk45ESu9WuF4UoNtVK4OnFdd2bBBsjBnHjR4qhF8/UHnHUlw/Y1xUukFIf5cpUv6
	 CUUFrdDr2Q1DgpDWKAQpY53aS7xx2t24nWAiEeEO+IxuXP5LdA45PQulMOVF5TzRsGIno
	 ijX4Yf62Ot6ipcRbwBDjpGVsM6XK+405HbxxNM7tzQhiHENNbt8lGANi+Qa5b2gvYxQMd
	 eK79SxiSew4mmeUrir+DJcT7j8zdm1GkG/Y5z9RcSI78h5vqKqoSpd2j+hWevpgp0BpMy
	 6smeASb3G48O0R11z1gFGKtQM24CUyt69KMZ57tsPuuIbuCRgIeJnNT+IdIhwhRhSoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
	b=SkvTIHFmZKF55XZTa0EhjTQMQ3OEi/ApXPqluvMSJPf9RuhEIcq06qS3SGSYh2iZr8Vn
	 t+aEddF405gJ1Be7um8k795BcFQcQ/nkDpoUCgu72U6ojArVDYlZcw3qB9RakucX0+3vh
	 fGLhssk0VTzqVUiEbtBPSBEvPs5N7m5jpn99669YlxRqm+CZaDWYYM7aj/QAHkSAqCFkG
	 Nfcec5Hv3SauyVKmQpI/5ERcj1bzeifOksmlpuY/yVF5NKKclEUmlt3CWagAQ9Xo61xrm
	 XiAh9sR3+FpIyUg5zteJLXzkCap0aMTxoJA0FiwlHJPPl/gEMBBRNFeWHu5a8LpvMfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DKFP3HH5;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFB8606A31D
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 09:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FFB8606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DKFP3HH5
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1682bff3cso14330125e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792486953; x=1793091753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=DKFP3HH5xkEVzudg7J2oCkxEv63gXy59fH6PmGnoXYbvc/Tpn7SgV8Dv5eYJWndKdF
         0gPK2x7sAz3AYT8RhM/rHIAGIPXBDkqLTKvDbhEjSB4NOAXpwUrUWYuWZBbs+QX5g7EH
         KHBuhZ60BQCzJV93iDirg+lePGYCDsw68pX8qHFwLpaXeoybsVRwJiU6FbG1Koyi3afU
         LKu9EGas773lgo5srdIo/xgpLajo7HooInu/5WPcW47GgxVz3rvUPojFuKTiumaRzeTO
         sVtXXwAJqhrVO8uj6GDvQI6nPca476LM1GgzAVdc5eYajgUqbR4TK/Y6/PJzWxvQ6pIl
         WTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792486953; x=1793091753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=l9xYQAX/NHo4JOCfUNg3vid6V4UvqJcllybPENUoBjh0Otjmy3yfqYqbBm2Gg9XeAj
         Q2M7Dx3/Thq5gRLWa9R2/AHtyRcky4sPYmSZ4wbOcW54H/nxJz+rq+jz35/4hZS3K53y
         j/OntNt0fMSYZ6uQce9gPstetAyweSAgTkvWtymsCDFT9ipbJ6gGgaLJux2CWGfvXqAR
         PhrH+IpL+4e1cr9pD28DPpglDsqe5Q/EJxjRDDNVH7Yx+iPYVMrUN7rX3naJ0BwHx/cz
         27mCycrrlv5adGopzR8FAjJidGtNaFGy8z1J3BdkvZC6YIL7rMQD45I6iZaMqiksTMkr
         P7qQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6gO9Lp3qgmFWD3rQjFGC/7v70j5CQnqFRZglTZhYysVwRVFwjpQQM1RSOsgUMCpECkrOOPMQoHTG6ZGYb@vger.kernel.org
X-Gm-Message-State: AFq9FYKOrYAWSejxh65h9Ro5Zdoej3b2m0QWd6Wwx3N81QzUn6hYwp3P
	ytE6raoi6KkxIUM/SgjiqJTtOMtzyI6whacJZe9CTbHj5uxZ3vu3ben2
X-Gm-Gg: AYBFou1/ZvAHlN6azCYJ57g3fDFFcm2XeVC6kk3Z9isqZH79hTRVu6FeMg4oFvvXZtn
	prvZjjWk02QSwQArXtfwXhXNTRQ0ocaffyxPemsH4psmS6/lmh3d304jTxlQpfngoyuniAbzwpi
	9epNKAlCG/E33P4+X/N+Vm1shMKNHtI0B3388WIPw4cRfRFJdxRSlNaqkJNPEoP7LRbeRrmjy/B
	vSlQSdsCxU72V7Usj1r3chX+o7HYZNR2nT59+aRxUMsvtH9DdYt7tmGodjwyRt1jHttxhSBOHDJ
	PTMGYg2GGbP6hhtJhVNLrHxaz4EMshAYid7HP6gkCbegdivYEqm3ZnYhAZlPMrEUKq42Q3eTVQD
	KYdW+6EDysxNPXrw8NhT/9GwtzFXAJjS4odiuUOckZT859jA+Nvmj+u3tIU6XbT8sFEg+JUpT31
	/Ia3cMiPQbc/BWCAFSTkO0Y8TIyGCgYNlgYjjayHqQgbzhI1unVGkNCDNMsUxbTFjB+9pvdrUDl
	mvGBicQXrVGOJkwAIHz+4DIPnF7vxnpEBEnSF+NZKz7QnY=
X-Received: by 2002:a05:600c:1f8d:b0:4a0:1b14:d00c with SMTP id 5b1f17b1804b1-4a1d75ab306mr239129235e9.3.1792486951816;
        Tue, 20 Oct 2026 02:02:31 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([129.45.77.32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cf04ffe9sm243295495e9.0.2026.10.20.02.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:02:31 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: dhowells@redhat.com,
	brauner@kernel.org
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH] cachefiles: convert deprecated simple_strtoul() to kstrtoul() in percentage command handlers
Date: Tue, 20 Oct 2026 10:02:26 +0100
Message-ID: <20261020090226.271-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Convert the six <N>% percentage command handlers -
cachefiles_daemon_frun(), _fcull(), _fstop(), _brun(), _bcull(), and
_bstop() - from the deprecated simple_strtoul() to kstrtoul(). These
are the only handlers in this file that take a trailing '%' after
the number; other nearby commands take plain values and are
unaffected.

Since kstrtoul() requires the whole input to be a valid number, each
handler now walks the digit run itself, checks it's followed by '%'
and NUL, and temporarily null-terminates at the '%' to isolate the
number for kstrtoul(), restoring it afterwards.

Signed-off-by: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
---
 fs/cachefiles/daemon.c | 78 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 1a66e0af2837..12c38b366881 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -331,16 +331,25 @@ static int cachefiles_daemon_range_error(struct cachefiles_cache *cache,
 static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long frun;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	frun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &frun);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (frun <= cache->fcull_percent || frun >= 100)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -355,16 +364,25 @@ static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long fcull;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	fcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &fcull);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (fcull <= cache->fstop_percent || fcull >= cache->frun_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -379,16 +397,25 @@ static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long fstop;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	fstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &fstop);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (fstop >= cache->fcull_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -403,16 +430,25 @@ static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long brun;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	brun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &brun);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (brun <= cache->bcull_percent || brun >= 100)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -427,16 +463,25 @@ static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long bcull;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	bcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &bcull);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (bcull <= cache->bstop_percent || bcull >= cache->brun_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
@@ -451,16 +496,25 @@ static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_bstop(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long bstop;
+	char *end = args;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	bstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	while (isdigit(*end))
+		end++;
+	if (end == args || *end != '%' || end[1] != '\0')
 		return -EINVAL;
 
+	*end = '\0';
+	ret = kstrtoul(args, 10, &bstop);
+	*end = '%';
+	if (ret)
+		return ret;
+
 	if (bstop >= cache->bcull_percent)
 		return cachefiles_daemon_range_error(cache, args);
 
-- 
2.43.0

