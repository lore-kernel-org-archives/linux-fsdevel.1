Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14280421F1F
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973349; cv=none; b=Cz9ayAkIaQLyJ86I2csNWWkEzoUeVWuxF71U/ofRNSpZNztWYWk6wFDrcVww6+4EvoH8uolxY62zgMxM5RU++6CAL3YIwjEWcKnRs5NbfVXrZZ29tOrM1XJPSvDQhEfYeEyXtp95cKdcfOCk64/SLOiZvkjmi2scqg26VcWnBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973349; c=relaxed/simple;
	bh=COKwH1VH8BuYCRynamMlTkaMzJ4AGwGGF/sBUjJNvDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SKvxGujHDJ0OLF23mkZhhsaNvZHZOS15k4GwefI7+gMzq13TG/rm6OrT8aBpsLNMYCB0UjU8awwnAMXZMlBj07z29RCHQWWmwaVXXIgIcXKMhLddVbYCn+eItZW21rI+WufprNgA1qJs80EC+qoj0ZvDzFyK1Z5Wxwt5cgqClUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nK5JtmnB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nK5JtmnB"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-487035181a7so39643175e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774973346; x=1775578146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBIfgeXR6ZzaVZZprJJKEW+34xpz6VJfBbaNi9NqWK8=;
        b=nK5JtmnB2FXyfa2L0bE/B/3tio3FiGu8WV0PuplkSKPBQDNwQHVKow5li07CJZ+cc9
         rN5RMWv9ApX/2EIUdGHR5dv5jPzke0XGJ3AysFzvuGo/jRCHAQeCNjxmujtuXYpcPIBt
         MKasM7D3O8KD2R74blP/kHYc5j32dASuafkoJ4SauKKyU5EP8vGyEGSV2/kA0Zfdm4Tw
         6CVf6nraoBXJDFi1dNpsaPHFR0+fXvXuNbuwf6N/IlpEgAmubGV/sf4NAxsmxxPr773N
         q9yx09yIfDOQ5zEMUgOZEtpqq2+Lci8RUHIhkLjwoOIwDCWIExTxqokrMeOWIu2Hqgv0
         JQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774973346; x=1775578146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jBIfgeXR6ZzaVZZprJJKEW+34xpz6VJfBbaNi9NqWK8=;
        b=VA/RzY8wkcieclkNXv6LZBWmMTHVO0pEYzRvSNw65ej+XdrjPxngBUPXQBZKmBUxcU
         dIGtt/i9aTTVWKXCvvhpRx87Y8kTlFv0H/dXkASjIinIRlToMkUy17rJlKFrsi5PmtUK
         IRF72PlzqyN9VdN0Z1AjAh3IxsSm0ywAWH4VYHjk8LzP1/wxP1jOiPZUfsZxGUxrXnXP
         qS0e5GAUPn+A7KoTF9hb0yaS+eDy8JUynDpotNxY0BvAtrFCdy/HOWPQnhJ9rEQClXoZ
         7WavM4ZfRnEdz6nU4PxirMgBrQPTvUqM7V/DdncQVggR8B3CwabFf9D155NCvCEWbAS1
         qbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbqC+0yJvfb4ryIeRDEU9v0vXDz3Sk+FfvcHx7Ufq+c2lXoUZdxkuQ+hd7PTiiSExZi2TBDRef+FYuxJ2z@vger.kernel.org
X-Gm-Message-State: AOJu0YzzcO63Lxjm9Rk+XQkLbAi0ogDJBQkDbLSd6HZMN+O0Ke9IG20v
	uZW22cuWs24/qNJ0lDEG07xg/slYBGDkUAF1Hlapv7upJLhAMY8gbh0o
X-Gm-Gg: ATEYQzwRb8O1vwRNjX+BZXymt/1Wy7oz52eZW2XXYk+CJds6vJzx//wwQqDNmuvC3Z2
	km135VuJoxap76e8/rO0Vfar1f53GT4tRIYvu/b/oahSDPCUjPSJxoKX9e65fQtAbGoc74JRN80
	WhwDifYDbj6pR3OH/rYS7u20/L/D5GlLXE6og0gsBD3ZSbzP+XCu8UktfXY+RZKwuzJr/1gI6U8
	+tbaY+9sPzEOh6o02hkPYGpKpp28cSzFyrenM4plgIc0JRLH1KdgYzl33B0xxRvnP9Fw8o8ACuV
	LqA8SkBswnPHs7Uw5QPU6Oxwg7SYs7ncvKQM9uOlTuBLMGjKBQwPCMZUd/kMqvMDpa7/JMyx+jp
	rZ0HJRqXOZGwP+7ZOvXkNbaovx5T+vn4yk7JnSRxC6ikDP9C5JixDjkS4ib2ohZ/f4mXWw8NkMZ
	UpXV4vILARO/4wFqUSecqZuoFQu7GYpsFGwqGwN3YAIQWs0GHdNA/72ZXYhh+JxZ5Y+SITZAMIt
	w==
X-Received: by 2002:a05:600c:4f91:b0:486:fb69:4960 with SMTP id 5b1f17b1804b1-48727edde49mr274770515e9.19.1774973346275;
        Tue, 31 Mar 2026 09:09:06 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21e3602sm28792632f8f.4.2026.03.31.09.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:09:05 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v5 2/4] fs: relocate and tidy up ihold()
Date: Tue, 31 Mar 2026 18:08:49 +0200
Message-ID: <20260331160851.3854954-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331160851.3854954-1-mjguzik@gmail.com>
References: <20260331160851.3854954-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The placement was illogical, move it next to igrab().

Take this opportunity to add docs and an assert on the refcount. While
its modification remains gated with a WARN_ON, the new assert will also
dump the inode state which might aid debugging.

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1f5a383ccf27..e397a4b56671 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -522,15 +522,6 @@ static void init_once(void *foo)
 	inode_init_once(inode);
 }
 
-/*
- * get additional reference to inode; caller must already hold one.
- */
-void ihold(struct inode *inode)
-{
-	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
-}
-EXPORT_SYMBOL(ihold);
-
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *wqe,
 					    struct inode *inode, u32 bit)
 {
@@ -1578,6 +1569,17 @@ ino_t iunique(struct super_block *sb, ino_t max_reserved)
 }
 EXPORT_SYMBOL(iunique);
 
+/**
+ * ihold - get a reference on the inode, provided you already have one
+ * @inode:	inode to operate on
+ */
+void ihold(struct inode *inode)
+{
+	VFS_BUG_ON_INODE(icount_read_once(inode) < 1, inode);
+	WARN_ON(atomic_inc_return(&inode->i_count) < 2);
+}
+EXPORT_SYMBOL(ihold);
+
 struct inode *igrab(struct inode *inode)
 {
 	spin_lock(&inode->i_lock);
-- 
2.48.1

