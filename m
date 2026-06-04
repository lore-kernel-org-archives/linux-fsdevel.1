Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CAC3264D5
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588704; cv=none; b=IQnwW75J4ln7zebML5kRgdeLJ834wvlU88SEX0LU7trekUg/lJNJc1bDjFlzrLUfJpQGOldTjPYZlKcmNBBSC3z1KFCZ9t9r9JNeSOjBLDhSw3rMCUrwA9DwPKoa/1PHgu0HmMAAUFRm03aya2bQXCv6vznGTY0UUUX+2mIS/GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588704; c=relaxed/simple;
	bh=CG4tYKE/ZDtEvhTjWK4OQ+Pk+mMRQbkaM8xxSMWv8lU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QwGtV6k+8Lcimcyv0c+vuby25vZNQ7s2Uui8hSA6b8IT2bUarCFicQdcC0cvsKoRH5vwN+mzXHgn2Al1j5wkjZG1SCrNj+RPxSpwS788YqP8JRn9jC23V8qpIH+vwbcD1yCrVPBRFlViDGuI2ME4uqBTavt37Il/AWm+M8Log8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fJqRJg3l; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fJqRJg3l"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso93175e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 08:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780588702; x=1781193502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pqw6xFqYHfbtPS2lscmy3UHUr79W7GtUNGneEf+7Bf4=;
        b=fJqRJg3l1bU+Nf4xgAugLcVG/ajXDWvTJ1gKmne2CWgvXFNwtqpCKgV9vU0w2fGhZR
         fsMwh6btn9HKQMABdn4pRJS7EPi3eyBpjEdbcoFtCr9yCIP6CjCBF4mtuqWDK5uIbOGy
         vee3rDhJzW1oFmFS4LtYIoO11F++5G4I/S5BdEpS7v9pTw6Do/gTOxRlek/4Q6W4tnEl
         RDgz/t/bX5p+gGKa04KtK02AEITk2ptbpxCRF8kQ5dEcREKY2o3Op7cnLNUVwZ6kiTPa
         RyP1wp6LwDWDOlYTuheo0B1iwk2fTdjlbjkNWyKIpjhozqpSUbCxHzs6B55b5uyT/T5E
         ftQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588702; x=1781193502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqw6xFqYHfbtPS2lscmy3UHUr79W7GtUNGneEf+7Bf4=;
        b=GmlNObS2cxKL41DjM3U5enZeianHSPeZYOVRLxl89QBMs8GhaGzDkrd+P2ZFSReiih
         lmFg0ikp3ziyZqROT18AvjOtdpz5XuD9//TIp4gVDwSgy7ATM8JD2bL8ey+4KflUxQJE
         p5JJZSRVrtafDkrpdKXLYAJxRm88LHF3EUrKBWjRTP7IRkrrsy1TDrqGICV3YTH7/koR
         jznrIYmtynjXpB9FVrQF0xTXBNkq1TlFKSZQbH3xrpLgLOQGumVFos/nmN1/6gnSL6gg
         HwqdmaqfaGt7bkCXy9NHC19w28X4kGQJdbz6ShsbrtOANCoOi7YBxuF7TvBe8Hr6Wwxd
         NpOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8F7OaX0hpkxeu/GZzd0f6gWilFkWxuCEn8pAfX/qJThW7jKj6h5ZlAfrjzzqwqI0BpdyHn7jzCR+yWNitq@vger.kernel.org
X-Gm-Message-State: AOJu0YwzS2JCMn3RuexlSPI/tCERY390KVgvr8f6piMoR23k9toRR8Fa
	AhGHmENSUZ7+CoXnsU55dCq1Ay2p4PGrng0OdFi/jZ2Bh4FNLzYH71SmfzTGpzVl5Q==
X-Gm-Gg: Acq92OFL10SgJY6NcPHo+G1r+9pqVN2rYiB1fpKcSWuG9yOP3gSlhgA3vpLFMTL4QBX
	f48MHbtoqssb6W+2LyH5ZEMj3RwVTWm0tRz2s2FESyR4Y/KxH/vvCOR49NOxEbuuOrEGz6x0MIp
	9HVCcEqfEes+nF9jTmMPu3EnAZqwdQpfO1vh3t7oSCdSa7hm2C/Xf8n2dFn0zD8myHshAOTDV4M
	yv2ByhGN1T418lQksl1mW7qpBue3MRfPHIpz8YWls7IIs4uITMexdYevL2seoJbGwI/FkwO0aoS
	caIqXoX9+iJ8i9KRZUoa9aUOo0ogTPoNirsodJYGTndlZSTusZPYLssVV1X76XuNuv3aP3BcTMI
	mqcHrorxwEyneh8sLPFtyr5woBUCKJMhSYop0b8C+3MqzoIChDMdsSiE5cm/4fzROefaz5SF9k+
	Q5hZabAjjhf5Zjtb+cGrhjBLJCd980+Fq6+CjSpoWNWATvkAlgZHlsyQdOjDpbhQ==
X-Received: by 2002:a05:600c:68d5:b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-490bd7e523bmr950095e9.7.1780588701225;
        Thu, 04 Jun 2026 08:58:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:5de2:6c77:4bc3:b0dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f344762sm19004407f8f.23.2026.06.04.08.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:58:20 -0700 (PDT)
From: Jann Horn <jannh@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fixup! proc: protect ptrace_may_access() with exec_update_lock (part 1)
Date: Thu,  4 Jun 2026 17:58:06 +0200
Message-ID: <20260604155806.1402880-1-jannh@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fix two test breakages in tools/testing/selftests/proc/read.c:

 - The test requires that readdir() on directories in procfs does not fail
   when running as root.
   Restore the previous behavior where /proc/$pid/map_files/ simply returns
   an empty directory if the process has no MM.
 - The test requires that any directory in procfs has "." and ".." entries.
   Restore the previous behavior where, even if a task has no MM,
   /proc/$pid/map_files/ still has "." and ".." entries.
   (This now differs from previous behavior in that even if the caller does
   not have permission, they still see "." and ".." entries; recreating
   the old behavior exactly would make this code unnecessarily complex.)

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202606021924.b6d8a0c2-lkp@intel.com
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ef2f59461374..5042f14d24f3 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2399,16 +2399,19 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	if (!task)
 		goto out;
 
+	ret = 0;
+	if (!dir_emit_dots(file, ctx))
+		goto out_put_task;
+
 	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
 	if (IS_ERR(mm)) {
 		ret = PTR_ERR(mm);
+		/* if the task has no mm, the directory should just be empty */
+		if (ret == -ESRCH)
+			ret = 0;
 		goto out_put_task;
 	}
 
-	ret = 0;
-	if (!dir_emit_dots(file, ctx))
-		goto out_put_mm;
-
 	ret = mmap_read_lock_killable(mm);
 	if (ret)
 		goto out_put_mm;

base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8
prerequisite-patch-id: 0000000000000000000000000000000000000000
prerequisite-patch-id: 7c4ef33778ceb9b6e644d78c5be66b99c0c77d51
prerequisite-patch-id: bd555aff354c96a946f72e56d5d55eecc33a7b47
-- 
2.54.0.1032.g2f8565e1d1-goog

