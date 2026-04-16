Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA239A05F
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331075; cv=none; b=CCRlqChfLp0m7GnoMfm7Y5A71gKHEWHkfTzRDR8gfpdUUlzMQny7PTq/4AW/pEbJ98Th21M4Q0N8gA5HKgyuVN9og3I2gIajSASJAr9IbFI6/N+cICck3jgYOMD7jmD8WLZAwNh3CNTa7D7X4bYxvhZQCVVA5BMCinX4DOLMxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331075; c=relaxed/simple;
	bh=IseVwA7+nVwl4mmpZkdG3Nk8WxMIL7qMPYSghlTiSAc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=plBL3j784kVF3PQo0DKClg+XbndJyR2mLIEVItCZ4LJPrL/AGdEcwHRgrcHhj7Y1l6gw/+RI021pjxtzKmWPo0PpF9u3PllnThhrH3iEVxcuW4LNzAMot+YI1o3440fC7JPNhbPkbO5K8n1gkKm0ABiKMTM/GTAtc1pJK/qnNNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DP6iFLH8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=XCfnVNkL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DP6iFLH8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCfnVNkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBWYgat9CZjiYcviN78oPc4qkEI83c/hYUCEObNlxbM=;
	b=DP6iFLH8eMpynjbSFm2koywzX67VIv63fdcQQBl4iQ9ETqKikCpKW7nwGVCpkCD1bUvilA
	D6dzzLLmAm4mWfm6KuxDhRlnBIRVRFVrBtFpE/O1XSfQuWezLhowkl3AT4MZc1pMo+MnKf
	J8k7FukeQOlrJ32TT1W4/NOysNpPkhc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-tZbioVyKNX6ih5QKHSy-3w-1; Thu, 16 Apr 2026 05:17:46 -0400
X-MC-Unique: tZbioVyKNX6ih5QKHSy-3w-1
X-Mimecast-MFC-AGG-ID: tZbioVyKNX6ih5QKHSy-3w_1776331066
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d1dea12aaso5689281f8f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331065; x=1776935865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JBWYgat9CZjiYcviN78oPc4qkEI83c/hYUCEObNlxbM=;
        b=XCfnVNkLeJX9ReWTTlTpNiCnZ2MDIKrGXtTKAVKTH0l1JmdjjicXIRZEyvZLoLjVjS
         PjppyEsltSEVh81ITF7pKZ3bFvZNIa+hjpLt9XpI81BWoA64oj3q5YdA6QaqWkYM9CmZ
         kwkczXDBo1StxT9OsVNpZv3EIjzzp7QUISYq2NbymMC6gr/W51HmqAU9rkrAC0G5jvry
         hgUvv3zwr7Ax7T/RJtRdPpMmTQNJdGJ8iHRYi15L91D2XO0xV7FciZa0vzzeVufHZV0d
         m9AchDKpmHD0MSK4SB9chyFahpcengXpV8IhiwPi0owMMoidCydnifANPjwqCcAlXkSQ
         GtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331065; x=1776935865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JBWYgat9CZjiYcviN78oPc4qkEI83c/hYUCEObNlxbM=;
        b=jR6jQivVca3HTfZkGABLDwvg/ZHNP74Z0PVx9wwxN7yRzqg2VEC5emk3Sxuv6Zm2L0
         q5wkZ4WueRbkK1XuNk/L90NilgGgFwz6AqNTqfLZ0eTvmshqh0CG5uyNT4MtyTDx2V4d
         XjqynPgh+ORblibT+irC0t3bl+/0mpTD9Ic/9Ry9H9oGvyl1C4Y0+QdQ9fXpRIr+BFSH
         IoW2GQVICs1km8MjB2zTc85R6kkxMkOx+wAlahFCmkFL1gV1Z+kOUTMPXe017Iivi1fz
         chf3C1xI+awPMv0/gh/lF2j078fUpMN/QHDxkLxUmsbm24kuKMtEy/pS2E+068xn4sVB
         tUWw==
X-Forwarded-Encrypted: i=1; AFNElJ8QASp22QFZYEjFzoP8R29I6dfpG5poe9SiiosKQPpnopuR+MUm/LKPMtt6vKEvzCI4DiDaU4Rho7HQClZe@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9FcEl0BYrx+JuhERxVFWW2RwJSCC4YoPX7lJZoqEC0DOQQnXj
	lUtHWbur7DOBqKrEuIHE4ksGW+QXw56jrZzIQZ0hbvN82VujCZkTCn9hWFHMkaZ9IyXmeTOigEt
	tYGmrsL5DYa5NmWhegeyfE6/NsFiBJV6FPichQzYRjUHqsMNdszy88oeOeWfgtDbbw9wPkHbblm
	o=
X-Gm-Gg: AeBDieudu1SRD5eH5i7tjDBUleZEhsQizDr8uOqkabayOhu6C1TGbP63CFVNvFphGIO
	j+FMz4+CvgkQuk3K4YxWfHQi5jf2R9Ldjcu2/GGHE5zQwkTIgUl0NEawydGokqQAALgVIMsoA2/
	vOdK8sCQ7W6kT/M4WwWWCyzPa7MbB/2/mnx71yu2ST8y8qLpX7Qn7R52JTnjwzsJiM98B/Ex75X
	/aeFLoGjoK0p783ZrdcS2ityH4Qcfb4yNnfbdHWsK2zl52g2f1u0/Nga7GdniN7nv+r6grZPpSd
	twi/l+8baE8rbR3DB69yRHsgHvWAPTklM+rRj6VHXQRhCL3g2mShJZziQ2MOCvVTqMK4ZMLAHKv
	zrYVEE6kJIRKqnkOrVljEN56OM7xRXA4p1vCu9LCeYHeScNwlAiazBMRNom6nFSw3/wJzfMLM81
	dqjWOveg==
X-Received: by 2002:a05:600d:d:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-488d67df531mr280497675e9.3.1776331065273;
        Thu, 16 Apr 2026 02:17:45 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:485:40db:d40c with SMTP id 5b1f17b1804b1-488d67df531mr280497315e9.3.1776331064829;
        Thu, 16 Apr 2026 02:17:44 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:43 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 32/32] fuse: simplify fuse_dev_ioctl_clone()
Date: Thu, 16 Apr 2026 11:16:56 +0200
Message-ID: <20260416091658.462783-33-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416091658.462783-1-mszeredi@redhat.com>
References: <20260416091658.462783-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't need to check if the new device file is already initialized, since
fuse_dev_install_with_pq() will do that anyway.

Make fuse_dev_install_with_pq() return a boolean value indicating success so
that fuse_dev_ioctl_clone() can return an error in case of failure.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 6fbe6084c5ae..25c5c853a791 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -453,12 +453,15 @@ struct fuse_dev *fuse_dev_alloc(void)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc);
 
-static void fuse_dev_install_with_pq(struct fuse_dev *fud, struct fuse_chan *fch,
+/*
+ * Installs @fch into @fud, return true on success.  "Consumes" @pq in either case.
+ */
+static bool fuse_dev_install_with_pq(struct fuse_dev *fud, struct fuse_chan *fch,
 				     struct list_head *pq)
 {
 	struct fuse_chan *old_fch;
 
-	spin_lock(&fch->lock);
+	guard(spinlock)(&fch->lock);
 	/*
 	 * Pairs with:
 	 *  - xchg() in fuse_dev_release()
@@ -473,16 +476,16 @@ static void fuse_dev_install_with_pq(struct fuse_dev *fud, struct fuse_chan *fch
 		 */
 		fch->connected = 0;
 		kfree(pq);
-	} else {
-		if (pq) {
-			WARN_ON(fud->pq.processing);
-			fud->pq.processing = pq;
-		}
-		list_add_tail(&fud->entry, &fch->devices);
-		fuse_conn_get(fch->conn);
-		wake_up_all(&fuse_dev_waitq);
+		return false;
 	}
-	spin_unlock(&fch->lock);
+	if (pq) {
+		WARN_ON(fud->pq.processing);
+		fud->pq.processing = pq;
+	}
+	list_add_tail(&fud->entry, &fch->devices);
+	fuse_conn_get(fch->conn);
+	wake_up_all(&fuse_dev_waitq);
+	return true;
 }
 
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_chan *fch)
@@ -2283,15 +2286,13 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	if (IS_ERR(fud))
 		return PTR_ERR(fud);
 
-	new_fud = fuse_file_to_fud(file);
-	if (fuse_dev_chan_get(new_fud))
-		return -EINVAL;
-
 	pq = fuse_pqueue_alloc();
 	if (!pq)
 		return -ENOMEM;
 
-	fuse_dev_install_with_pq(new_fud, fud->chan, pq);
+	new_fud = fuse_file_to_fud(file);
+	if (!fuse_dev_install_with_pq(new_fud, fud->chan, pq))
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.53.0

