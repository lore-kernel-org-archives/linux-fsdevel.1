Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2433DAAB5
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090375; cv=none; b=ASkm20cViToK2cm+cMZuprQdPP/UeR5DOErDlSWjmIu3X8pUktCI1WuI+r3CK1Po39X3jBlJzDDOPsA0PMekxAbVoGrzgP0pBi46TPl81ke/wbFptuudGlakeAK1A24DE9B9du34N4ucOseHhdVFoADXZuHln/y/zzxLVi6kIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090375; c=relaxed/simple;
	bh=Ng862Yi8s1doAZCFWCNRE80r8DygtE+3jl9oFvn7Kdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J3HeRpVnMulH0Q6FYNTAEqnp8ibFtH97ThI4RekgoNyz3QHMp8vcrE6Uz1nKDqIWujrfdafcINEOnSlRu3Ed1dOLvucJENWvdMgx8NNqP+Bp8ojySRUl+Ziv5ok+/oCimK8g032UPFGtLkinK5HltCs1FI/B8/xPYkOT9jVCMhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5zb9pZO; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5zb9pZO"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39b22d0e488so19360841fa.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 11:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090372; x=1785695172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I1B8kjQ0tn6xjm7eh0oJ/GAy21I2oUQVlOodFBIan+s=;
        b=a5zb9pZOZy4rHHP4jZXerT0sJ4E8ABJwehpm/qsr+KPvjuU49kXzJWS6Rbokdv9i/g
         L+DA/9FHcYfmeKIxs3uyH+LSQ7YEDl0uYnMvoWhj0GzdvO+JpBweQ7v78CQUEn+NTRNO
         /ea/WA0EV8bM7OkDm3Xn9qYejWQ6k9PMgf3X2m4Pkzl32+uKEPTrIwb+LAEweBf9n7ez
         dpnSDpTT8WMEyXOrWMw1DYzyiVyBHlmn8gPQoAV/CFK9yNddHFDGBTZbPO+DL1DhwBdA
         tvR8v0+eNI12ItAyQvu4bzsdsHoPFTfpXmMt86JJJLdVZ3NztOuWPsghbHEhGb+cMx2w
         QJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090372; x=1785695172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I1B8kjQ0tn6xjm7eh0oJ/GAy21I2oUQVlOodFBIan+s=;
        b=fhAe9wkvoX4+zDPtQOKY/yjRX1wHFl1RHrv5/oOGDyDrRb2ik3WM743SvZ47fuYj1d
         b8wtaF0tb7ArhtvUvse3Q4iN5IeU3hzKYoCxAU32X9OMmAZ1KMcLtAKqlFQdilxd76YU
         J9y8SPRcOgGxlkYyVq/qtdPcHksHPdlEG0Acs7d7iilGRIkYkFVDsJ6yHpr5KmKuegr4
         Cdia+otlld8PXmolCRNsjZzSmShzmkpch4fX0jrzpTOf/93w8E0FzOnXPIbAMMHQePij
         PrZ6VY99exfwgAcMV5mu+itZhsKfvCWOGGmNKExSX6MsxjczkBUNcwa+p3yZcLzlsDZs
         QsOQ==
X-Gm-Message-State: AOJu0YxLWQ4MTh+8O/y577o7NeJO6rdNxdI2atgJL8DsEylsuqP0RbWI
	yOmRR3vRoRU3M9WtVOqn7tdFidiZxnJ0YZ+Fej3lh0w3f5wcWQS5S3XN
X-Gm-Gg: AR+sD11wehJRkeQ1NDBuGtwa1Lf/v1KG2hf9q3eRUBhNw1f91hQC0z5IgCH/0cXzVjj
	luDxQhqtb/4DTSQoA8Q85aTaZe2x1EpqQPo1F8MGXPf29zNMyrZ6GpgHBriNFaX647P6vd955lG
	rV46gQMTXMYeOXQwwJkGKbLjdyB2Q96W2JaSKQ2NCvVW67vHS7Lk7ZYg6s4zGniwl8RyfDeyCsF
	k98TI4nNzls7k59uB9RSQCS92CqI9tI2C7O/MbBk0n44O/43ixkx7Q9U6Ldkz3lC3UCOmycpsBi
	gy88ZtUKbhZPa3H5EiXlyyUGuoaPgUzuk0ujYfaZg5g+xsRxRWZ+23ykixYApRLWt/UWvQGq+Gk
	1XNw9d9otuBxn51gfPL+fsZvnv0e/qpzJ4LHfo01Q0FnUadoxDow+rthM36Ui/wCvHEadt1HU1X
	DbmAtQPEWNKuxkUShhgxW2uF3j8Fc=
X-Received: by 2002:a05:651c:1473:b0:39d:ab45:893f with SMTP id 38308e7fff4ca-39f2888bdd5mr9943461fa.41.1785090371478;
        Sun, 26 Jul 2026 11:26:11 -0700 (PDT)
Received: from localhost.localdomain ([78.156.235.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2224c91csm9231761fa.31.2026.07.26.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:26:10 -0700 (PDT)
From: Akhmad <akhmad100913@gmail.com>
X-Google-Original-From: Akhmad <Akhmad100913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
Subject: [PATCH 4/6] fs/cachefiles: replace simple_strtoul with kstrtoul in bcull
Date: Sun, 26 Jul 2026 21:25:38 +0300
Message-Id: <20260726182540.40891-4-Akhmad100913@gmail.com>
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
cachefiles_daemon_bcull(). The kstrtoul() function provides
strict overflow checking and is the recommended replacement.

Signed-off-by: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
---
 fs/cachefiles/daemon.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index fd97195ec..7cb1a2b19 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -522,14 +522,19 @@ static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long bcull;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	bcull = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	ret = kstrtoul(args, 10, &bcull);
+	if (ret < 0)
+		return ret;
+
+	args = strchr(args, '%');
+	if (!args || args[1] != '\0')
 		return -EINVAL;
 
 	if (bcull <= cache->bstop_percent || bcull >= cache->brun_percent)
-- 
2.37.1 (Apple Git-137.1)

