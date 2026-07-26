Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56C13DAAB5
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090364; cv=none; b=ZeoBoEdBLHOBSXbMf+yj2B793aFVLSBmMCgWoaaSWSfjdx7XSMoUnEYpqBidQpEG3jdI+43+WfDmreaSx2u+nR33e1SmVVF8f2HThoLH+m/FbXYPWMEu0rAyik8SMufdMDVqUjErwbKIJQ9Tmt5OgOiXKEx4rvs+sOCT/alPFmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090364; c=relaxed/simple;
	bh=hbWLLeK++kOPdv+2+kB/AuMn0t8pB5xhBDHlGH35JN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZVLFPos3dnCQzae9hV4q8/0nT1TfN3Nj5sOU5o96EpGA0IvTsq9hrZE51fvGXqBajH+l/PLnZLRHbcPKQmWeZ7cdMTAmNMYPSD2FMTOfVeULS8/z2jfWaHXbjOGLkIbdbireImow1jws6bq90ZEsLQlRpyDvVfclVh1dxLmFK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OnZVLxcj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnZVLxcj"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso17473071fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090357; x=1785695157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2sPtrBRSmwshC+k6p8r7S96vNjrTtTzNPMarP6lHZ/o=;
        b=OnZVLxcjWXHRj1npb3V35jJR+SlsUDLMP7H0eKC0BvGB9GF48aIEJ4lrZbHmegKPsJ
         z2HHOW5qhadMZtvfbukz4dRYy94i2Dp+PgAhOBuuZKVUiOKKpimlyPil3ZO4hz6hZKhp
         3RqER8QHhZ/ERKizLQKh2oaYFskjde9cCjzAM6MRFz2TcGs7Bw4ncAaOBs+MJEyA+I25
         45N3tgv5Obkn5LTSinGpRXiMjmzoSZkS+3aB/NjYzhspM63kFBnrdRh8U4KjgF+mIZoN
         iaxXueIsNcw9X9FiKmApq0NaBxBuhN4KcwIXdEgDVxv7fVVfNoGwqSSsUP4DTHr081KK
         JnMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090357; x=1785695157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sPtrBRSmwshC+k6p8r7S96vNjrTtTzNPMarP6lHZ/o=;
        b=MYkMhUZLEiV+Gzl/Y1bSUrskAvPxNtoNHGW8QkWwy71Fj4ZI8hRZLOTAqsPZFMMMu1
         tS/oFXb3TRojPEgKngr7e/5HaLX2fhh0tNcl+axYbKVKk68Ruymbyn1EAnoCSOSF4PAe
         PtbZMermguYicJolkmxrEFuO1kajD8q47/xIwtef9Upue9MQbEsBt0c2IvztmERyknM1
         4G+nSlM8L405dyPkWzLpAu/QvExxXE4cdF+BudapZSEosqs4w1BuYYS5xyi4Xhi7d5Ir
         gwYGbFURXbeE8EqLgaUYGnQMVScPKPZ0+keQj+oseywUuEHlMohH1+IXWn17Y+m6zNpO
         +Pkg==
X-Gm-Message-State: AOJu0Yyis+MWxoRuj6vYSGD03MYLkAaRCBbrtbjYaouYCfxhqvkA50/Y
	mj37uFlSZtSl0N+BdWhfGu2Sux1XXWEtIkskl7gJwd69XyTsigkIvzI+
X-Gm-Gg: AR+sD12ufZLTUccJrjEq114RNxcrDeMjn+Lz7JzdKBlIl4p+8UE2oCnowkyL7yE+jWh
	vPA2NZCMqZ0QacvlyqIbS7NUy40hA7TY0BYcKRTK9n48r08xqHGuU/m9MsfmPG8Fblm4F7FyKHf
	PaBzcdM5J53hQZ78aJQmD1YyV3+6/XLDhwqKuRzSyr/relaQ/c1whoIIIxZjtfkjEqsvlhc/93+
	BiFsd8rbzBq5D5/FaOrWOe2LzszaOucByH2ZepZ3Lps2wvNew3fQIgzJr/ko6PsDg1tmZLUf8E1
	GSruhQYg6omgbJZeo9EL6+hcS43MNVi6VlEu7gpJbFhhBsGOGKHVmTk2jbocwrrbr1rN4amnn0i
	Inbkxhw7AeOmWLIq5T6EZsTnnkX/AvUmPhxfPOYADc1sW9zOOOwAWzxpbng+at6vmaWI1JQjcVQ
	GxJ2rZTUyupguOmcrGmHWNpFUyHCLUykKoe2jeaw==
X-Received: by 2002:a05:651c:983:b0:39b:3018:fbb5 with SMTP id 38308e7fff4ca-39f2881c188mr11799481fa.26.1785090356576;
        Sun, 26 Jul 2026 11:25:56 -0700 (PDT)
Received: from localhost.localdomain ([78.156.235.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2224c91csm9231761fa.31.2026.07.26.11.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:25:55 -0700 (PDT)
From: Akhmad <akhmad100913@gmail.com>
X-Google-Original-From: Akhmad <Akhmad100913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
Subject: [PATCH 1/6] fs/cachefiles: replace simple_strtoul with kstrtoul in fcull
Date: Sun, 26 Jul 2026 21:25:35 +0300
Message-Id: <20260726182540.40891-1-Akhmad100913@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>

Replace deprecated simple_strtoul() with kstrtoul() in
cachefiles_daemon_fcull(). The kstrtoul() function provides
strict overflow checking and is the recommended replacement.

Signed-off-by: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
---
 fs/cachefiles/daemon.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 4117b145a..7feae63e6 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -405,22 +405,27 @@ static int cachefiles_daemon_range_error(struct cachefiles_cache *cache,
  */
 static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
 {
-	unsigned long frun;
+        unsigned long frun;
+        int ret;
 
-	_enter(",%s", args);
+        _enter(",%s", args);
 
-	if (!*args)
-		return -EINVAL;
+        if (!*args)
+                return -EINVAL;
 
-	frun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
-		return -EINVAL;
+        ret = kstrtoul(args, 10, &frun);
+        if (ret < 0)
+                return ret;
 
-	if (frun <= cache->fcull_percent || frun >= 100)
-		return cachefiles_daemon_range_error(cache, args);
+        args = strchr(args, '%');
+        if (!args || args[1] != '\0')
+                return -EINVAL;
 
-	cache->frun_percent = frun;
-	return 0;
+        if (frun <= cache->fcull_percent || frun >= 100)
+                return cachefiles_daemon_range_error(cache, args);
+
+        cache->frun_percent = frun;
+        return 0;
 }
 
 /*
@@ -430,14 +435,19 @@ static int cachefiles_daemon_frun(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long fcull;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	fcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	ret = kstrtoul(args, 10, &fcull);
+	if (ret < 0)
+		return ret;
+
+	args = strchr(args, '%');
+	if (!args || args[1] != '\0')
 		return -EINVAL;
 
 	if (fcull <= cache->fstop_percent || fcull >= cache->frun_percent)
-- 
2.37.1 (Apple Git-137.1)

