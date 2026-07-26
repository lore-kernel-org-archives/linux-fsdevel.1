Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7323DD520
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090383; cv=none; b=esjrbpIYOtKcv1Tm6WrMIAbOr+jvF4hzwRuCFSFqNfIBVAf+NJLV7IAGlEJHEAYMP6o9UzUvzp9dKcPbAGibi0sxdzOhaZVN5l5vrNggPoaD9K190fx24NnuGNZsQuNsm5uepqtKiJFCvnbLraP3KqdzH/gUWEOP6oAgw8aBpww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090383; c=relaxed/simple;
	bh=lUvgWhRJlS4qWacSnTf0d0Euj7ZlbZFLffeKzUCvhow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OtIZ8H1iUCxxEGt/6Bh5bM8OX+liOGDM+0dQlSsnSR8eyn0lEBjpZCNxeWI+0DN/3MlD+02Z/47caSn9LJjziDBcvIkr3YtnFXSpetOkuE5E+4V97wA+2wWBQlX3i9EC2FQxTEgJVjFKvGEhHlcdfQFOhzsIPx9+MXVrPmBVtEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q3WexNCf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3WexNCf"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39eb257e9fbso14102781fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 11:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090380; x=1785695180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2MfaM8lGUxER0ipr+SoknIiqDst1iFaOEk1cKwZO4EU=;
        b=q3WexNCf3baOEqMmZuqODbACO1nECn6GoA3Pb0rkQumhH7108mJXLB3Oq4OIA+jc3/
         8V28qMaDPl3o8laECWddpGoQR+hOltdXQTXlNx2ByS1uaqg9FjmBHy6iU92QgdtdEVoy
         IexS/2qtNPGt10IMlmy0OD2vHAqa8OYCuZQ1YNejrtmfXa4UbK/BdjUOWJEZoDeO/Fve
         cYX5v2dlbywnnKgDv8fHgV6Q9e4Ka8lIgHjAomyNQsUwygl8WCXx4d2UBp+nw19f6Nm6
         HHifvCGwuPkOMGQdgBNkNCOqyc0opo0QpTnmK97F6yPDKFWRIwzwPUYQn9JQ2agADD2N
         59GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090380; x=1785695180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2MfaM8lGUxER0ipr+SoknIiqDst1iFaOEk1cKwZO4EU=;
        b=K3lz2pye1zla/GEnpp+WVzxNvsnaF1JSCtirZyz2xmaZlmPk+b7cYekgTjMY6Nq2Y/
         VhqBEBBgXbkv+BTGIahqfNF0HE5u9iZqUczBnWoSObNlkTARnE39HmXo8J+0K+9oYpEQ
         gZws9tT14Fg068HAXQGrfBrguzp/PdCuUf1XsDS2x1Vnz9mNYabCQkkWs9MQB+GBLnZ2
         l9DrfRmH1gbiPNrAEAb5SeJiI08XqzQrJLIwbvFzIKmsx1nor0Xs8XP2XK/k+yoYRLhU
         cT4Gps67iyJO2lr4pM/osoF2IJZaNLuW/jIqIQIpfIt5Bl8LT2mT+mfrtsxxkP7GXV6e
         kX9w==
X-Gm-Message-State: AOJu0YxhoIVpGtlSxLuXdVRSfRXEnF1UvKnPt8HmIAiCgEtSHNub0k0K
	NXkxnHIkH0H1XW2xiXXGnvntuXopvoYzFHpEJd/0Wmd/e4N2TPrgcNXi
X-Gm-Gg: AR+sD12Cd1vq2WvgK4fJgu0GXXqjOtdD9yhrBN+MhnMI4l7jIYOhFUfriOvlgdIz5hZ
	pNBPCKu9XkIkuat/wRLl0JpV0eIc+dtkTMrC3kj5zslnU0I34b9SWPSV2apJFCRWAf0PPdnTJiR
	bavSLCgiXGOk5ll+oadDgSZCDfvGx50UUjw8PUW4a2vUGAm0fbp0V1LVIPwdeA7uBVGZpBv8WFn
	0HsTouCsGkXS2G6tnVW1ZU32WuhE7+7FImNPzEVQ2EoDkF0uwSE0lK0KiKjX7XD8+LKlhUdyUrP
	0v0+G/cVZUUanIOsCe9VGFOE+fzJbT5CtIv7gLA8oEUqza6eY4P2IFEZdhuT2YmPKUbawA2hrtS
	liC+Ql9sJasYqfynXPlwWRmrCdwRIVPCfUqwefK+TF14/yiMm2qBEloOvMMnvAruRH/EEHsxrc3
	/Xfb1fJA+wl1Roe1e/jGSyMuEdkfs=
X-Received: by 2002:a05:6512:130f:b0:5b2:a22c:50e7 with SMTP id 2adb3069b0e04-5b2c1b2ee3fmr1144582e87.32.1785090379729;
        Sun, 26 Jul 2026 11:26:19 -0700 (PDT)
Received: from localhost.localdomain ([78.156.235.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2224c91csm9231761fa.31.2026.07.26.11.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:26:19 -0700 (PDT)
From: Akhmad <akhmad100913@gmail.com>
X-Google-Original-From: Akhmad <Akhmad100913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
Subject: [PATCH 6/6] fs/cachefiles: replace simple_strtoul with kstrtoul in debug
Date: Sun, 26 Jul 2026 21:25:40 +0300
Message-Id: <20260726182540.40891-6-Akhmad100913@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20260726182540.40891-1-Akhmad100913@gmail.com>
References: <20260726182540.40891-1-Akhmad100913@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>

Replace deprecated simple_strtoul() with kstrtoul() in
cachefiles_daemon_debug(). The kstrtoul() function provides
strict overflow checking and is the recommended replacement.
Removed unnecessary manual validation as kstrtoul already
validates the entire input string.

Signed-off-by: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
---
 fs/cachefiles/daemon.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 0afe4288e..f971fbfa9 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -710,20 +710,17 @@ static int cachefiles_daemon_cull(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_debug(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long mask;
+	int ret;
 
 	_enter(",%s", args);
 
-	mask = simple_strtoul(args, &args, 0);
-	if (args[0] != '\0')
-		goto inval;
+	ret = kstrtoul(args, 0, &mask);
+	if (ret < 0)
+		return ret;
 
 	cachefiles_debug = mask;
 	_leave(" = 0");
 	return 0;
-
-inval:
-	pr_err("debug command requires mask\n");
-	return -EINVAL;
 }
 
 /*
-- 
2.37.1 (Apple Git-137.1)

