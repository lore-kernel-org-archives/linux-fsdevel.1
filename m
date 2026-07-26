Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F0242A82
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 18:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785090369; cv=none; b=fGN7WijZWkSgsvzKxtFWf9Lc7jY6rBZwD4zxVQj8OqCeGbHzDNE49gCGgnKONnBgX6Qu1TK5lxTFq60RqsUCzasSOq5RgTwwNCWFjEHbbwGdI39JFdkQpWQwPHx6z0/KymqUz0ew1XQFFADiYdBAU8EVpxFZISezmatdFotf294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785090369; c=relaxed/simple;
	bh=MxOMHjImyE7uUfMWIgez19036HD3uQVR6FoTYu4j+hU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NthX6Vlj+VHslBJ4dmDqIKIdd7uBzbAbCxE7BcScWgX1HafG6Xe79YZmGcHs3xTRE0PIX7XabswsYUkx6WFJxb81Q9bpkuY1OF0ur8RbIg8ZFcq0DB8DH2RmAALEMTPkiyJ2XuX1Fy4WwY36wLU4qliJBLa7FspUUpeRXgOrPvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DaaL7V+Z; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DaaL7V+Z"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c7ce122c7so16424861fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 11:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785090365; x=1785695165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJBBUsjmdda+lwqOwSeo4SklctqG7WiAFGlcsxrTHCM=;
        b=DaaL7V+ZMsEJF057EQaTTA3XgCt9xDDhThXoaz/Nj3cPaBYa+jJTBdd/E/M4FO8DYj
         7X3yGQ4/Lr2Ic1dyWLaE7EcIM/anRq70Ywyfu7qvv0DHAiFDw1Nv2kHycxyI43ljOaE/
         F6z6IFeKGteqYKaqZzbN6yPGM5YCHM9Jm6iNCCYED4MleAf7gPYD6PVm2nT6lywEQJOQ
         AAYb7IGHNH27UpbyUQy6tDad3o/0eItaoB4pdqc1P0TN3pQrxdgRs+xE6KMeBp5sTh+9
         WVW9VKvTY9ZgnlKXTuUT4HqItP0Pv/0lTwUsdcFV0cfsIxAlLir5M+vvchNT3+MHKQ4V
         y/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785090365; x=1785695165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CJBBUsjmdda+lwqOwSeo4SklctqG7WiAFGlcsxrTHCM=;
        b=sbiLNMpPTfRJ/rMdKcInqUZU9n02t91quy0CoQiXK1A0EHgkpXENkX/73PTWZF6CPw
         S+SDbt7b7dXdxl82MFXgJoFBCobbHbWHyGnVTqMJaFq1G2hYRiFxJ0dbOEAFW1fnlp8s
         tBj79FAM63WDgkVpx9o2HnL3va8z28H4ZWsv4/NS5FKP1iFS+DD7YsyGowwHcxyA1Jud
         xL5r13Kr16DWTnRmQNrH0aK+IzXTi65GbIWXkO0waDKGiwCJyfCrACDNZm0btcMfCCzu
         cypo3fXgWU2swwcbBEmdsmBGT08Cc5hDP0uJqwHA1RSsKeWqx04XulQ8JzSg3vHmIXcM
         joLw==
X-Gm-Message-State: AOJu0YxvU3fiBS8DzQHwjggQT7FKJLyf46PN33Z6z5WVAe68Jc+RKtnV
	5C1qKsgff20yLDqQa2FBAkbvKUsLI/+2oPrbDvWAujbTv0j6hSp+xEMXtKGx0EuxMZs=
X-Gm-Gg: AR+sD119uh9Hh0erpk8HSpgIh5/CVdn2JT0pWEUA2UpWDzAV5mFTxnByNuWu3tot/uE
	bkKFgVP1nKcKbD5SOe0HPvjPdILkWLzcaTESGpkyKhIoABTLBkx+5s6jnvLD19tuWeMhfEEtJ4w
	j4hZ7zrgwDSbd9pacYbSSrzXw1EHhpli9FPWYr9n61JHLg4Z6ejsjq6NCis08zMalGOUUL01c/8
	yC/pWj4DWgj5BNKeDpFTayIi1JxgQpuF8RCoN0vdYP5Twl9SYvwAoFiDbv2oIKZUh80TA9oT1Jr
	DWZxYAjlFjM4TIhXc9P7HRsiae++qRXbP2TWk1a9Hju7WqBZR5LlhxLrvyLcDWmpXzsh7AXcbf8
	a2SBN5qSzQup144clwnWL6k9ed2U+a9barh3gKqNfOgzRr5xJ8uMON4defJaxMEGz7La+RBLsjd
	fjFP9yL6lG7/AdQiqkBNZeF+dRxEo=
X-Received: by 2002:a2e:ab89:0:b0:39b:374a:afad with SMTP id 38308e7fff4ca-39f2891a88amr10317851fa.29.1785090365172;
        Sun, 26 Jul 2026 11:26:05 -0700 (PDT)
Received: from localhost.localdomain ([78.156.235.247])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39f2224c91csm9231761fa.31.2026.07.26.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 11:26:03 -0700 (PDT)
From: Akhmad <akhmad100913@gmail.com>
X-Google-Original-From: Akhmad <Akhmad100913@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-fsdevel@vger.kernel.org,
	dhowells@redhat.com,
	Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
Subject: [PATCH 3/6] fs/cachefiles: replace simple_strtoul with kstrtoul in brun
Date: Sun, 26 Jul 2026 21:25:37 +0300
Message-Id: <20260726182540.40891-3-Akhmad100913@gmail.com>
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
cachefiles_daemon_brun(). The kstrtoul() function provides
strict overflow checking and is the recommended replacement.

Signed-off-by: Akhmad Zubairugadzhiev <Akhmad100913@gmail.com>
---
 fs/cachefiles/daemon.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/daemon.c b/fs/cachefiles/daemon.c
index 67c5b16bb..fd97195ec 100644
--- a/fs/cachefiles/daemon.c
+++ b/fs/cachefiles/daemon.c
@@ -493,14 +493,19 @@ static int cachefiles_daemon_fstop(struct cachefiles_cache *cache, char *args)
 static int cachefiles_daemon_brun(struct cachefiles_cache *cache, char *args)
 {
 	unsigned long brun;
+	int ret;
 
 	_enter(",%s", args);
 
 	if (!*args)
 		return -EINVAL;
 
-	brun = simple_strtoul(args, &args, 10);
-	if (args[0] != '%' || args[1] != '\0')
+	ret = kstrtoul(args, 10, &brun);
+	if (ret < 0)
+		return ret;
+
+	args = strchr(args, '%');
+	if (!args || args[1] != '\0')
 		return -EINVAL;
 
 	if (brun <= cache->bcull_percent || brun >= 100)
-- 
2.37.1 (Apple Git-137.1)

