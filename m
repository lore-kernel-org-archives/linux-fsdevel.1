Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0242A82
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 18:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090364; cv=none; b=ZMj4ntmXMzPV+Viexe1L755KrXO0ADSnCJYi8RlzuxfdrnNC5kJVSjnVhmwyIu4hVMk6+Oa6o6OT04HFkbvrWslU7zwovHYRdiNm2zsmOK8NsmRj6CuOp/MGqedL0JGAgoKxn8Ml2nJSxzAdtHEkMNybq/+aL8s/prp75LkLcqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090364; c=relaxed/simple;
	bh=wFi2ZmLt1fVOun8+bcJJco709rRvvk74CejdfKTWdYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=skxVQUHiYhJs86ssrsjvTT3rmqB3QsY1G8QtaKzAKwhDMk0IBEoSCYk6ZCMxZJj2tXhLzLsfS0IlRaTvgeQk8uyo7lmYxmsSHMHlWvkZGfpoEUugZdhAUIRSP6oY2pKRbJvP31eFjIrqH7C+0aHPNrHfSB0p+YSpqUVHWxwLf9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJCdM81V; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJCdM81V"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-39c923b8c2aso20487231fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 11:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090361; x=1785695161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aga692/QS8ET29eHPIYX0mtfw1e5+Pz2MaYmtUr/dvY=;
        b=LJCdM81VN5pK3osX4vO8N/EvmCnZRgPiX1dxcKtWuCMCrgiwfWjwaT/wjaMToORYDr
         d4qBBnxSwhFJPbmhPba6U1ZRE2DAM4IvV+plAIfhVzkv1HAlr1FyH6+msClMvWY6r/gJ
         z1f1wOV2untw5RGs0iNQXZItw66UHKA5biM/lkwLvQqFwSxQ7hrublhWyjG7agEWqWAA
         1ISzC1D6irIB+dYL999bLVmdq0ebzmZB/xbTOeZtgjg86Vjp3h08smS838DCS22UbITu
         WHLbQWINofYRuK6pndJiH6ShgLSgueZYFiygEzvyagwCD0D3aflZlLcxrdd1LAn+4wLs
         DKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090361; x=1785695161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aga692/QS8ET29eHPIYX0mtfw1e5+Pz2MaYmtUr/dvY=;
        b=Z+lMezWxYSL6ggO000j4V8lAGpEI0nLfbqYKW9kp/TnegFgRYahVIXadRHfy4OyCzD
         6bSxLV/hLBJlM0Gxyf1L/lb94C7eTY2EGrb+ZHq+LLJCn2eLN+ptVhFexnNYjRDItc0s
         mT+CnpwdA6SKDSR72z22cZgeXvRmK/YVUcx2tODaQmOqM2kNWLbbRPhincFki5Jcj2b+
         WYmaH5FcOv0AZ2IzuQQOuX2w7tS1E7/y+s2PExJNvDXEWs5ZDm4OuT287Gjb/oQZdXe7
         HTDsAyOMMTdwl1LHDnfRVFLvgVQL12rV7f4P4I4NrVZkfJXx0i/g/SPHQsB5mp1M/R3G
         3kCA==
X-Gm-Message-State: AOJu0YywNVW7kURPFaULDXgtBZBxYOW8CRZT+qClPpfHfoYuLg8nuXnE
	CU2sfrEpclAq7nEOABRsygK9tDygtszqqlRRLBk/xaJyr6PaSpiVlcNQ
X-Gm-Gg: AR+sD13IEM2vaEUQ99VcUu0Ev62e6H6JiDscin2XxxWXRgbo43BRTSpi5Id2G7XN0U3
	P1P3bho6elGunNRHHkc/2yyOr6Ge4q9uYlMFRoRW79TgH2ZCERrIxL0hGXUW6OIH06whlIiuJfb
	v+8CuWAFP6ZyGrVTjm0ssso/zBSkftyrglfqLlPjAWzeCKUbEgqKJEH2bD/c/mxzA4HHUnLsxuf
	IUwcJ6FC8QW62HWjSawEmKIpin9xG9w0lJfyWm6/nJayvtP4XcM1r9WWCUcrRhtSLyvX5EvyQXl
	ziPRfA2YEcvwS4uYu6OPTQJ8j65a428UBazj3Qbc/83PXhMk2ojv3VNK4weYActfCA/pfiCY1/Y
	WLhvEASmL75GBqexuNy9vkbr+8e8qEkHaEUtc76aXKnEO5TFzqUgDPz7VsrqMLCcQVT3QqqFDgv
	vJCyzAKV8IBLPNhIHckdYnwADdz6g=
X-Received: by 2002:a2e:be1a:0:b0:39f:fbd:69d8 with SMTP id 38308e7fff4ca-39f2891969emr9497231fa.32.1785090360703;
        Sun, 26 Jul 2026 11:26:00 -0700 (PDT)
Received: from localhost.localdomain ([78.156.235.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2224c91csm9231761fa.31.2026.07.26.11.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:25:59 -0700 (PDT)
From: Akhmad <akhmad100913@gmail.com>
X-Google-Original-From: Akhmad <Akhmad100913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
Subject: [PATCH 2/6] fs/cachefiles: replace simple_strtoul with kstrtoul in fstop
Date: Sun, 26 Jul 2026 21:25:36 +0300
Message-Id: <20260726182540.40891-2-Akhmad100913@gmail.com>
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
cachefiles_daemon_fstop(). The kstrtoul() function provides
strict overflow checking and is the recommended replacement.

Signed-off-by: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
---
 fs/cachefiles/daemon.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7feae63e6..67c5b16bb 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -464,14 +464,19 @@ static int cachefiles_daemon_fcull(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long fstop;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	fstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	ret = kstrtoul(args, 10, &fstop);
+	if (ret < 0)
+		return ret;
+
+	args = strchr(args, '%');
+	if (!args || args[1] != '\0')
 		return -EINVAL;
 
 	if (fstop >= cache->fcull_percent)
-- 
2.37.1 (Apple Git-137.1)

