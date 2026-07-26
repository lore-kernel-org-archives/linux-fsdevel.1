Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D13DD520
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090379; cv=none; b=ZXy7af9UzUV08V0L/4JCOtZA6XBk6/ZvA6ihta6BEmcC5qYu9ZACwmC6h5wjkCVLNWnDBA3pB0UWBNI7n3RM1nmKmE85VDIPcn3MtfkyCmCChEjlttA6nwDY59JaTzqCCOi9xTFD453H+NU5f1UoNmgIOj8ls/geASmEJJMuDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090379; c=relaxed/simple;
	bh=RJk24pMyVy3Sq22tjBNHyXJIjQLkH22YycC/hu/zMc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JfCqpG0w2Qat4wOsX5XQBJaHBIdtAOqYg7F28cHzMTjO1vcpqs+0MfEMyuiAlnqLNDO5geHILmIOl4Wm1KlHXHGrW3J3d+Z8WUpfFKSzY+/q0XXems3kzYXnmKe1UIt+yPSiiJFv82MITYuL3vupDO+1F1ip1lHQyDU2295dfmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+QvY/Ig; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+QvY/Ig"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso2023700e87.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090376; x=1785695176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lHcuVJgpRGWabfpHssLi0ZwcF1t0ue69aZcczGtRR+w=;
        b=e+QvY/IgQBQencJIW3sfAw+VTr9YMozPESo/pLGk9Ui33wI/+C93zgEc+LSXGDGj61
         IhTcnl3CQ+xlEVEkOb5qJfC6Pyl5OyzXmqm+5qvoq7z6/LA6Iklkxzx/IGOE9Sxq9JrE
         w+xiS8pWLsC6Cx8YMKFAUw4qr+jJRw/Ar7PPwV0rNkTumjFSMsnEEwXw87icMvmWSluo
         oGS/b2WeoPTwArSOGfClrMnoJ2UmjQDK0iHKyT+MT1tIJH8zXE0U+2dzrQxDq9EOvmqb
         eMCaUkBdQc+MW5ctHHma2l4IyoLIgbdCfTTaeo8Gtgel1PMkdestmQ9YUaFHnZa3pPU8
         jKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090376; x=1785695176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHcuVJgpRGWabfpHssLi0ZwcF1t0ue69aZcczGtRR+w=;
        b=PkOz3IRTOb9NmaS+mGBtgk8IcdBnrLSWaAmTijl+0JrHZdnC/Do0aMCHVq1NYudEfP
         JRBl28MuhsTU3FsiOwK74GAZLyEhiY/c91Jo53OWjMxhaqNuY/Or/KKG+N0tpIQoQZIn
         jlZDVf+9k7v1MXxaD1wpvZsOMrpk3J4BiY04aoLuBRnVr7Qo9QXQ26Ew7IMrHyoeYyZc
         RHDSxJdBN90Ix4Pmt654S0jQEmr+QH65oNxW0ToiCPTMJ8lyRRSQ82SugFtc+pcqb2rE
         kuGTxRDkZrNR3NyKC8uhn3AcODkRY88MHGVlWhtobQLEtLW9qkfLybjxwEKwOOU5FdVb
         hSHA==
X-Gm-Message-State: AOJu0YzyP6KDPtk7M2hJ4W6nmwRzv0+rdGxu4610qWcMGdnM8vKUnovw
	zPbtzGqNBaCu8PUeQ/RrI6mxsW3ol6EXIyYIPsHAhUE6uys74WUFm+rj
X-Gm-Gg: AR+sD10t2AORbD16SBE1b4Ybwy3OlaQaheV/40bQy7/G/JABJmC7TKOYVJ5bq4xIx04
	hw9RLy2yLG9h2lsR3YyfnQTZu2Ra69G9SdiO4h6XwU2AawJqqEc8QYI5F/6yyMxdfDUAvrI0tVL
	lB2negGoDMZO43WY7uk1MuHU+UnS2d7ORUkMSsX4UqfF7bDbyuXYYonrYidoMcQkQD2Vg75gSJ0
	rUIvSV6CwsJMq8VlQYskoLU+8L0H5eViv8DpOgs4Y3dw3k0spPScZOCzlTsoCkkAK3baAig8fVD
	38mEMI55kahtad+3fMIjXz7muZaw8v9nS0mzsMmE0wVglBazS5Jvs76EHc5jQYakMijUJFAJrXr
	TM5sGqcz4MZ3tlU2K7ybuLddJkcJ5x3qAXLOtW2s9SZlmZ8cY0INWBk5xMm5FSo0/hXrSjcIFSR
	fxzmSaAhisVzBBHwglKgp3XG80/qM=
X-Received: by 2002:a05:6512:3d1a:b0:5ae:c561:3ace with SMTP id 2adb3069b0e04-5b2c1b4fb94mr961243e87.57.1785090376202;
        Sun, 26 Jul 2026 11:26:16 -0700 (PDT)
Received: from localhost.localdomain ([78.156.235.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2224c91csm9231761fa.31.2026.07.26.11.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:26:14 -0700 (PDT)
From: Akhmad <akhmad100913@gmail.com>
X-Google-Original-From: Akhmad <Akhmad100913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
Subject: [PATCH 5/6] fs/cachefiles: replace simple_strtoul with kstrtoul in bstop
Date: Sun, 26 Jul 2026 21:25:39 +0300
Message-Id: <20260726182540.40891-5-Akhmad100913@gmail.com>
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
cachefiles_daemon_bstop(). The kstrtoul() function provides
strict overflow checking and is the recommended replacement.

Signed-off-by: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
---
 fs/cachefiles/daemon.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 7cb1a2b19..0afe4288e 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -551,14 +551,19 @@ static int cachefiles_daemon_bcull(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_bstop(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long bstop;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	bstop = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	ret = kstrtoul(args, 10, &bstop);
+	if (ret < 0)
+		return ret;
+
+	args = strchr(args, '%');
+	if (!args || args[1] != '\0')
 		return -EINVAL;
 
 	if (bstop >= cache->bcull_percent)
-- 
2.37.1 (Apple Git-137.1)

