Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C283290A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 14:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102409; cv=none; b=i3fxrxhlzLSOsfBVcbXWOwvJTAvXUXXT8GsdSj+DBQfKXx1QC/Vv9Fe71aOppwY05xbm+aMZnA6KVgt6fme7+7/GZMXxjcZtH//4CuBa1uAOtHK5+DIjDh2aajlo6S5mjoRoq1ylInha4692/V9LmBSUQHulPOuwO1lTCSxcaPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102409; c=relaxed/simple;
	bh=rOJKT/wsUNcrNDJ2kew6fc0ZQxJ8KCuFZWSMgW8pkKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzSInNWod6Dh+QCUWsKXMfhAVinib5+VVxgVjyDITKxlZ9VLmc8UKpAKDGBBsTd79FdHi86GQdUYhiKiBEPJBh9mWRMK0dZF2Oz5Tls5g0H38O+PQIaV0OQWxs9R++qIwMoEBLXTCVTxVziVrpCOZdqxpph27Ch6iqbeduiIKaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQKVNosG; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQKVNosG"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b1bbcf3aso57431825e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 07:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102406; x=1781707206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsVZNKPK+drZis2oPLYZA/Wu0/QBV8WiOVxYgtR13jM=;
        b=HQKVNosGW4EPV8IeMAUcWPDPuLwp3FtJnfq8aZcnFHBcSRo6M7ZSevtsEzIv5TFVgy
         Itl9h1o8PRixl+wFMCofpfDy3JjOnAAbVJBMEdE1fng9pGyfQVzMjF0OmfQT2iq4UZYW
         y6f/lHah3jRinJJvxfXIBBH7lNmGK8b4kRtFcMsjEjbOqu7ApKQRnK6AXpQrD9kmV5jh
         IB1xQzhlIcOAK3LPsGdp1qY/hLwzlcDDPG50MVSUw+3UfsxC23pIJBaK64pho5x1xkL1
         8VvAYUsCa8xkrrh3OZYkGqbqLzYf7xaejY91aTZbDUOZbVfqVZt+CIjKZckwraeBQ6FS
         BF7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102406; x=1781707206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SsVZNKPK+drZis2oPLYZA/Wu0/QBV8WiOVxYgtR13jM=;
        b=Ba5oipRlE29DdBYTJtf2GN/OmQIKoEtIbVJZ/LJteIyIFDOaxx0g8drpz5q1WpXX4J
         J4r9z3obN2bRR4tjEQr3Q7CfBh5hLKk5WBTk0qOC5BtlQfHCSxrZs+kdVGFcCx5OBEYO
         9L98JeBkMAxji6ygf0F75wV9CjE5XcOWWtsvVnTFvDPHLs9dinfVLujAzKmBXSEVfhkS
         iduc+NBE9cL81bA9MQ0tFcNzXSXMrJtddw8S6cj+IThCRo49oThW0d964LAF3D3hXVJf
         JlKKlLbikdXnx/Dgx2aRE7HuSdj+UCaOIKWxcHJyVVm6BaQLll0zHXR8PKUFKrK6Pkxr
         z3qg==
X-Forwarded-Encrypted: i=1; AFNElJ8yBCekd88dmMvnUrs20FQIrb73ODz0yAAY7u0MJw5xen7tUV7oVmQJSQSBB7i94iefzadztn95LPjaca0t@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+T0Zp2xgJMqzvFXG69rmD86mmH47tmG1GbyDf3lWyx/xlwhbY
	mcCi1PMKYRlILgKrvjs/DUv4cZc2mlDC3iua78e8VCb+H5W4kzhqKLKj
X-Gm-Gg: Acq92OEMFZbzMPbp0ITKi9SKfr/gq2GbtB0qeyxyUg3pr+Ln5EZWfvTLmrdtU4K6jqS
	OJhkljnNebQl/sBVxP2kHibXjJyMOGgmMaPEyIxTn/b1MKjc7haCShM8k4xaukRNmrOXCRI4Ai6
	CsePYZJFKqg4v9Vr0K2sOY0wVSxgBlxrCXFb2KJBjp2+TJRmrrEl0v2FPw9lUww47oAuYgD3a8x
	tYPStDNtDqLODinrOQQj4d/H77HtzeycEMV8p5mycGeCXoeNPd8l4dEA3nfUc2447bDdp9IzOIu
	sXZ8ycGoPGfyLo2xFHKvWuXlSGgdy8oCgfAy4dpvuZGJhWHPEyCIKQERkcdk3oz2lT1vI7bxoKu
	yNqJQa9LWhAJdZKgCQTUs6zDXMD+JKIOPM/9xGECmg88P+XQ3T0kdnUkFN3kHLJ44RakbbJLJqI
	DUKuERxtWSFA/3AxWYioLB2M6hrZh7koXA8NuHQ48uVwBrC+JEOix/eIIj0umJBTthXPZS/8+HK
	cm9uWWV8HBM
X-Received: by 2002:a05:600c:3f0a:b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-490d71fa51cmr98145995e9.9.1781102406341;
        Wed, 10 Jun 2026 07:40:06 -0700 (PDT)
Received: from f.. (cst-prg-85-110.cust.vodafone.cz. [46.135.85.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3d663csm631420525e9.11.2026.06.10.07.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 07:40:05 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	adobriyan@gmail.com,
	cuiyunhui@bytedance.com,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: fix ups and tidy ups to /proc/filesystems caching
Date: Wed, 10 Jun 2026 16:39:54 +0200
Message-ID: <20260610143954.34185-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- add missing unlocks in some corner cases
- whitespace touch ups
- s/smp_store_release/rcu_assign_pointer/ [nop, the macro expands to the same thing]
- mark file_systems_string as __read_mostly

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---

Preferably this will get folded into the patch which introduces caching
to begin with, I'm posting a "full patch" just in case a separate entry
is preferred.

 fs/filesystems.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..673a03b5f32b 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -54,7 +54,7 @@ struct file_systems_string {
 };
 
 static unsigned long file_systems_gen;
-static struct file_systems_string __rcu *file_systems_string;
+static struct file_systems_string __read_mostly __rcu *file_systems_string;
 
 static void invalidate_filesystems_string(void);
 #else
@@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string(void)
 	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		if (!(p->fs_flags & FS_REQUIRES_DEV))
 			newlen += strlen("nodev");
-		newlen += strlen("\t") + strlen(p->name) +  strlen("\n");
+		newlen += strlen("\t") + strlen(p->name) + strlen("\n");
 	}
 	spin_unlock(&file_systems_lock);
 
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(void)
 	 * Did someone beat us to it?
 	 */
 	if (old && old->gen == file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		return 0;
 	}
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(void)
 	 * Did the list change in the meantime?
 	 */
 	if (gen != file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		goto retry;
 	}
@@ -321,15 +323,11 @@ static __cold noinline int regen_filesystems_string(void)
 		 * generation above and messes it up.
 		 */
 		spin_unlock(&file_systems_lock);
-		if (old)
-			kfree_rcu(old, rcu);
+		kfree(new);
 		return -EINVAL;
 	}
 
-	/*
-	 * Paired with consume fence in READ_ONCE() in filesystems_proc_show()
-	 */
-	smp_store_release(&file_systems_string, new);
+	rcu_assign_pointer(file_systems_string, new);
 	spin_unlock(&file_systems_lock);
 	if (old)
 		kfree_rcu(old, rcu);
-- 
2.48.1

