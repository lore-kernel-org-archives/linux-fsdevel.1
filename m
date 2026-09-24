Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0A2D876F
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 09:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240738; cv=none; b=KMfgwnXJQ3vWP9l2C9CGAkTvLomWnCAAM/B3VoEtkJPIQLMHRtc5z9FLMr03fANUMV8MM939YUCOnFAVzV5FAM4KtSINEf9eJMBjUpI95vNcFYPdzLvnINO5wQyl873EtmL3tyk08e0fOsP2k7gy2EuyBQGSaJ5Qz5HQhpjjnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240738; c=relaxed/simple;
	bh=gneipLsgqKEAyVQAZll6RiNG8vO7ec73+30d+3Gw2Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YaIlahy5Q3OL8OsPywuVJHEoK+YCKX4S9GjQQ8xdd5ziGUVdCkpNI/9QrJHOn4JF0g8O7rwBEqQz2yJ3nxzhdBpGIxs1JSM8KHrK+GGdcqXoVq48XGljN8iLiaxYznTKfCJj6zPoxaSieDuUIOU9JWudnIOloUPRRGNrPCwujx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FYpqsvWo; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYpqsvWo"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so13884725e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 02:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790240734; x=1790845534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=FYpqsvWoijJm2RUXLVNt1YhKhj3xaPMGf70DiciPjlN+u2x3zZX/RREQkKCQuXojOw
         BSTqC9giJKQLrIJgbjqFXd7M45XcbhC4KKP6irjvWLeALiZymNx/rM7/PplYT7vx0YXd
         px3y2um1oYnaH2a5sFDMOKFpn9vPtiDFFFlVOkPi+4+kxNNrinn+rF33YMqJ5vdMoh+q
         fZxSDN34iPokwYVZIEX9AAjArAGLWTWhFdc/ducFIsGapMZN2+5jBnX1Abrqstu5a7B/
         HpGEt6xuuUgXFzwkSZpXPxrDOwpPOC2khNK5XGe7K6kpLaTOsHQb++fU0mTyrLBOEz/s
         /b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790240734; x=1790845534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ppC8TRBPEanEndEB0ZLxZ/g+4/pJXzez/E6F6ayShus=;
        b=a+PRWXVWv6Np4UctnedSwBRALYYE+M7DcVoaYKwgsZ1zLj9CRJl37qREpLq5MhMc5X
         zJVabLdK34aNTOrnZ3I3RWLpXy48VGdj+jUwGvL9+jPVTqOJzEJGSy2nYYlReyBhSttE
         F4QckPoIwWAF62kF5myeuO0ptW7kw/kUa8r7SjYWXzyb0ne6fjQYjDHAGxuAPSx3hZnv
         WjwD62ZBOn7QI1uLUPmr54bWt0Ha3Mw67G40+nrr3mmLqgWZtHOYgVeHpPAq5XzHP39E
         e+CRb1Kc8MFasNIUnPUj78ZE48BeAOxwrJuROY+N2bdnur4Jt+SBZ3013oEPJs94fDiT
         xmsQ==
X-Forwarded-Encrypted: i=1; AKwUvBw41JelpaUuMI04rzLbwcJKOrZn7sqTUsm1/GpCjfUrK+kMD4JpqE8QGje/AZN5VR9GalZ25m5vpWkU8XEf@vger.kernel.org
X-Gm-Message-State: AFuF++nY/qB2L/QoCaj84h8leKoXuNmcVIWJo/5GOI1pZZh/42x/rDk+
	JPnvy1E6BDhT2Ddd8idkgCXXCsTTURMU0n8dnB0TCBz0u0+AJs8aVJgMxdbMxQ==
X-Gm-Gg: AYBFou1f0kVHmUxZ4dOnx/10J74JFxdV3HQ1oKZ9+5ZYhPy2Xjq3DZDxQIcdeS44AuK
	5y1KCuUWsYl33QIa3DWtTORcAZtu9+xX8L4Lqme0FhMM1IZ5HkGdBKs9LY9y1PNc5/v4lz8rFuN
	/xjsGp88u1xM/FU1pWNf8A3e3LP2HsROHf30dqjwOIyz95Tt8BPYJYras8tDE1QrqnQzEiTJmOu
	tYdhOw+E8eKIdSH1KEwZ/HUomnQKD0QkCLCy3UXcJIFp0XnDcIDkptllVGjD9pCRvh+eQsSbjn5
	K8YDwfj7jgw4lXz0I4L2BmBungUIY+TS13Kz4kMsrDlBUsMH7IF4M9AYFocY9Nvy4BLFkuDCVSY
	/rn/1uSwqLZ2LdLGN06PCTNAiD5XcI7ZE/+mWnh3PsgWjcKEF55PmxI81Fuj0Isdk8TL9DhyJkW
	MMVBOIRDO0mnMh0r3bRs4+ojmSuiLN5Yp4n+0213j98csn7VRF07gWEL2oRbWu4BOjcR/XcDm5n
	ymLoIHT7VJ8j/4tFpYtveLr2/Qn+t1exFx8htt4MwQpRNyz
X-Received: by 2002:a05:600c:8b6e:b0:49c:fc6e:8cbb with SMTP id 5b1f17b1804b1-49fe66f9fe3mr28311825e9.31.1790240734292;
        Thu, 24 Sep 2026 02:05:34 -0700 (PDT)
Received: from DESKTOP-IR7J1S9.localdomain ([129.45.65.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dff204sm80100715e9.14.2026.09.24.02.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:05:33 -0700 (PDT)
From: Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Drif Abdelmalek Mohamed Said <drifabdelmalekmohamedsaid@gmail.com>
Subject: [PATCH RESEND] cachefiles: convert deprecated simple_strtoul() to kstrtoul() in percentage command handlers
Date: Thu, 24 Sep 2026 10:05:30 +0100
Message-ID: <20260924090530.134-1-drifabdelmalekmohamedsaid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
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

