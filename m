Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA3519914
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 16:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750275; cv=none; b=tUyH47EHV0pxGtDQzd9Xgg8hNl1k8QM8csc4gUYqT0Ko+fUfquh2nyPr2ooBBp7roOAazLV/rKu0YituCGkBMYrLXgfWtuFY3lBYfQqT3Rpvt9zsIj2gCrdihAadQVurIcEhiHivegtnWE5tIcOqV08u6afCH8g5tKwHVA7KWnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750275; c=relaxed/simple;
	bh=PJZCqNz/EWydbRV7255ZT5ETxs8mwt5+88gHtRiMO/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jr84FfHCxMloJDr6vh0WOVo4GVWhXHO8oP2Cu16r33VvCdBKuA9GkHYz/IepHwzNwmJAmls1iY9CKnS4Aqhf0gQB7YFuaIzguezAobZl1g4Bj5S6vNJFBtMsHdvHabdo8855AOtVuGAbeUEH5+l8/ZxxDRMlUYYmv8PHIJOLN/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUpzv/yh; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUpzv/yh"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so12464955ad.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789750273; x=1790355073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MfsShWeiS4tZlSkNs80JEvfqVPZ9mGtd0aKlxlb8/So=;
        b=YUpzv/yhKsqRHI4/ibSJEZu4BqSN4HkqPCyqrLiBFYbiC56WrdMjhoCU5mVE0kVbIH
         LqXdi+ADbK85xG+s9cMp2HUsd/6Evu3v0qdUXLv5sBebSTbyWVYtYJqlmp/3YT4TblZG
         yvYyWIHQ+QjDnRSSYYWOUX1nEXatLfkF53yGYwlEx0VgD+YJCVxbTGal2N6nc9IKWYgA
         5QvQbm0JsBq4lDZ4johrDgVqT+yBRCp0IBBlooNHxsDLwtJGjvBfA9FCjra5A58jJqJi
         2xbTPWhk2/QGSMvQMvd5UuvAaJNpvCe8vIumEbXzeRIMios4ksgQcxmI/IrfRDJkNMlp
         N8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750273; x=1790355073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MfsShWeiS4tZlSkNs80JEvfqVPZ9mGtd0aKlxlb8/So=;
        b=lC0U+j0qkDu6omzIKr2DXz4stsIShLU+Q7y2/lo4RRfhGehYj1rZgRZ4gXwnR/reKJ
         k2/FpqWDrDFzgqC5C180XZ5mAl6H6x2NNFyu/VWIv8rnE8ZMrawR2ceTfniaux3bPqnd
         k3bTnjKqA2aDj/jorCjySjpgpD5hR4ZkSVfLAVDIHatGnBzrYiX4IKMc9s7Nnug6YNwY
         Lh/zcR/xb2QnTcKqfoV6dearBZKfhoRq53kh7E72YGObshEyj6uygMUR5bzqSadIJrCR
         hC4rNALvxBfQ20icau+d9bGfsh1wMyVDXGuDWM97mRRBPJ24Xjn56ZRVCHyEuY+7Kwpw
         b3VA==
X-Forwarded-Encrypted: i=1; AKwUvByhlGZPGqu/XvPOWp2HyNw24aiVqBVSzUyznIxKeCS6lhCH0+t9ZsbTlNtkqmX+Xxkh7+Sr6EOXJ4wS4AYf@vger.kernel.org
X-Gm-Message-State: AFuF++neeISW65Zg5mB8ae/3STFBbFS96FirptyyKfSZ4mR9wPZ+TZEG
	ac9VGZ9ybWbUZgOhrOjqT43WRLZ0iht5B0JusBEtmyOJn9yyLqfoGiGu
X-Gm-Gg: AYBFou0wuI+yegE8nHcpE4hOAgdaf7j61n/samtic+TyfskwX7hZo1RR1CsM266ruph
	005PV7rhvWG4tLY2O+dWsDmifkEyEeDBwDFJPTU1W5LP+tiUtDT/moSDLarbMM8hUnfntQNDDmj
	nvmiQv8wFWnF/XDeNxUWW2btKNoDQjS4U4sko+8bW/EH1ReY86G+t3PRxrYHKmPF1l3O2kxwAZD
	elGrZZ9RAbd0wqSjQ931pvbFpC/JpjBvcWqJiPVi8ectVE04iZC2F9lxR/Bvj0DUokz6Wh7r1gy
	8LsRq7OtG02Wmm0i7KEsZQJEMeGx3eCGIIvQyetKtCruyZs0ayRlnCteihh8UJmtwAIDkbIRX2C
	9297ZHC+KanLyuafcMj3XLONSYiqT5jxeB6KZb2CTfmkloWk0o+RJEdKpdtkjNNUYiPUOxbODKX
	/yV4DU/5/0QOT0Q6dh16vzXNJuQ7FN24+tFOmc1eU5FFmUNOJ5FrZhgQ/rVaX9+I25
X-Received: by 2002:a17:903:1b47:b0:2dd:ad74:ac24 with SMTP id d9443c01a7336-2ddb1be939emr75755475ad.31.1789750272857;
        Fri, 18 Sep 2026 09:51:12 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddba2a8c5dsm9630595ad.29.2026.09.18.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:51:12 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fs: remove unused vfs_empty_path()
Date: Sat, 19 Sep 2026 01:51:03 +0900
Message-ID: <20260918165105.1013792-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit e896474fe485 ("getname_maybe_null() - the third variant of
pathname copy-in"), vfs_empty_path() has no callers.

So remove it.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 include/linux/fs.h | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 05d05bb9c951..ef8eb5af06c5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3653,23 +3653,6 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
 extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
 			   int advice);
 
-static inline bool vfs_empty_path(int dfd, const char __user *path)
-{
-	char c;
-
-	if (dfd < 0)
-		return false;
-
-	/* We now allow NULL to be used for empty path. */
-	if (!path)
-		return true;
-
-	if (unlikely(get_user(c, path)))
-		return false;
-
-	return !c;
-}
-
 int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter);
 
 static inline bool extensible_ioctl_valid(unsigned int cmd_a,
-- 
2.43.0

