Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4201F1F8691
	for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774719457; cv=none; b=r6uHqQ7+fRB0F1PHH5nO/EE72DQOLnjhb0FUfGyF7w9nGgST/qNaPSl43/tr3BxUwTTPV6ZagGEfxP7+mvWElTV9RLS8+LTJX09T1fpU83qdxo3VqouCqvSdOTOsCdWf1jwl8hxLXv2tUiUtqJDbb0kkBlW/PUs9Sq6FTwOpSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774719457; c=relaxed/simple;
	bh=saITh143n5goVoqxHFf64RaqseXoQz5ztjuI1873DXY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=utrcbkIhnWB9R+Eu0XYtmmDECtCgDBEcT1uNmJHlupHHbWTuqrHBwP4LzWvWrwsjq9lWOWmcjCY7vRqZXdlCHZjHAolmK5xKXYEw+yVrpg7YqbkS5myWMIptR4AJPEuMaWneGzjceBCC3C0JRjAq4260WWtOawM7DdF4aWd0Gg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0ctgQz6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0ctgQz6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-486ff3a0fc1so28781395e9.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 28 Mar 2026 10:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774719454; x=1775324254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GiqKUzuLjWLwvp2WlBTPs4nhbibVGRU86wxjVFSVmM=;
        b=G0ctgQz6axvS/BjCXb/GT1y6cQPeKAKHcnL0C0wvFKkW//4SO041XlX+10elABKV7x
         YFUhsGwiXesa1SxY/Q8r13J424sQdavoI0rvahkwIx5IavsrLt7ADDoEVGhRiOakKAiB
         xiNsXaqoMjsMIO5ywldlx807OaWqCuKhlpIIK30AnffYX6YrTOTYdqmCS9WhHhMuWCH+
         pwPmrUhFDH69dabhtiCRkMaXB2UMipgOTqJvnaOZVUhZb+K7YZHYwzvbItp1LRBMnM4C
         yAZuyBtir8mpzoLxP8auCH2+LjyfObyLMvmyOaxDGhMbAUEL7E341UN9Ln5nUXGyM7fU
         dG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774719454; x=1775324254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+GiqKUzuLjWLwvp2WlBTPs4nhbibVGRU86wxjVFSVmM=;
        b=oXDLZj2BonCvNczm+dgrCF+DpjnIaliwilXyLQla/lhJXQ5aGoIPrdIwOnSaF9XbXx
         awAy06mh9fC/kE5KvTuIMxQOgAfM6rdXUwmNArbZyU5fq6TYMtTXOfstK4TZkd283NJt
         VSd31xRxaOZjg/W/WjZrSe3gjk0yg/vgVL87YhFwXFQOoCE3ylzuA3JV/LuqSJ6XLTuu
         jMuv7XHB0HpfE9CH9ybPgKTky68wc3cb12dDyaq4IqlNWsiMtsPWrtTWLfbk9If06ff1
         0Diyw2QjcOBP+qbHBUEE4UOa8kV8Dc++Ya7fVPlsGl2pr1paPD5LunPiFfaiK+CjaF1k
         UiGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2n+Ecw4+zvZ5vqKzRdnv4Nns6svRMtJeps8RLZzPu1m1IZLIrZz3U8u3bpY5pkKgb0Eg4iXkOalrtORKr@vger.kernel.org
X-Gm-Message-State: AOJu0YwRgMnmwATmZ2gWDvhGNnBv6YBrh6pWTPs1RKAfhT2WmTkCojFs
	ickbU71L9BA/P+IAcSRn3cn7JRv2htbBZo/AT0EJ4aDLR8VGO/AUN512
X-Gm-Gg: ATEYQzxr1HKn2fhQ1NfMr0F/9yZ3TZkD5CVWfLjWpevjIkSjl4xhPcwtALDqOLTuAxL
	E0d66NKw0UAUyS8WtnbIwQxuMred6fEYo3VHyATJGACJStUuBWXE58UIj1rzwmn9cHupwPod+Td
	appT991KYOn3VRIGOQnxbrmhmFBtbUT3/NC0vfNtUy3ts1MhyuGHA1vEXzLYqGbSj8iM907gY2O
	2uyxO1UOP67bynuge9omBN4ITu/PWZIIqXY6V4wXhKG1QdQjWVSkQCARhjVvOo4Vfnz5ne2KOI3
	ySbX1OlOcoIiZhN/P5YSmJ98yNbgjT1CiFXsA62yVID8lyggAzL79SpQLekyqlhdRyy5Lz1iyDr
	zWnH+lFUDnu6jdY1/qeu4b9KgoVa7SwdCBTEIBx6yFEFphWTAnsMZJYgIebN09dLVH1g/592J4c
	lg7bJAhvtCanByykT7BH7B4BFemH7yZG0FxS1jUFXAr2fDh/W0rn6lqFIRhYuZudgKsnN+mFqp8
	Q==
X-Received: by 2002:a05:600c:3505:b0:485:4135:5c92 with SMTP id 5b1f17b1804b1-48727c7c6e0mr101567555e9.0.1774719453499;
        Sat, 28 Mar 2026 10:37:33 -0700 (PDT)
Received: from f.. (cst-prg-89-171.cust.vodafone.cz. [46.135.89.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722be608bsm226605195e9.0.2026.03.28.10.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 10:37:32 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] fs: hide file and bfile caches behind runtime const machinery
Date: Sat, 28 Mar 2026 18:37:28 +0100
Message-ID: <20260328173728.3388070-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

s/cachep/cache/ for consistency with namei and dentry caches.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file.c                         |  2 +-
 fs/file_table.c                   | 31 +++++++++++++++++++------------
 include/asm-generic/vmlinux.lds.h |  4 +++-
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 384c83ce768d..2c81c0b162d0 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -200,7 +200,7 @@ static struct fdtable *alloc_fdtable(unsigned int slots_wanted)
 	/*
 	 * Check if the allocation size would exceed INT_MAX. kvmalloc_array()
 	 * and kvmalloc() will warn if the allocation size is greater than
-	 * INT_MAX, as filp_cachep objects are not __GFP_NOWARN.
+	 * INT_MAX, as filp_cache objects are not __GFP_NOWARN.
 	 *
 	 * This can happen when sysctl_nr_open is set to a very high value and
 	 * a process tries to use a file descriptor near that limit. For example,
diff --git a/fs/file_table.c b/fs/file_table.c
index aaa5faaace1e..c40ec1be2899 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -30,6 +30,8 @@
 
 #include <linux/atomic.h>
 
+#include <asm/runtime-const.h>
+
 #include "internal.h"
 
 /* sysctl tunables... */
@@ -38,8 +40,10 @@ static struct files_stat_struct files_stat = {
 };
 
 /* SLAB cache for file structures */
-static struct kmem_cache *filp_cachep __ro_after_init;
-static struct kmem_cache *bfilp_cachep __ro_after_init;
+static struct kmem_cache *__filp_cache __ro_after_init;
+#define filp_cache runtime_const_ptr(__filp_cache)
+static struct kmem_cache *__bfilp_cache __ro_after_init;
+#define bfilp_cache runtime_const_ptr(__bfilp_cache)
 
 static struct percpu_counter nr_files __cacheline_aligned_in_smp;
 
@@ -74,9 +78,9 @@ static inline void file_free(struct file *f)
 	put_cred(f->f_cred);
 	if (unlikely(f->f_mode & FMODE_BACKING)) {
 		path_put(backing_file_user_path(f));
-		kmem_cache_free(bfilp_cachep, backing_file(f));
+		kmem_cache_free(bfilp_cache, backing_file(f));
 	} else {
-		kmem_cache_free(filp_cachep, f);
+		kmem_cache_free(filp_cache, f);
 	}
 }
 
@@ -234,13 +238,13 @@ struct file *alloc_empty_file(int flags, const struct cred *cred)
 			goto over;
 	}
 
-	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
+	f = kmem_cache_alloc(filp_cache, GFP_KERNEL);
 	if (unlikely(!f))
 		return ERR_PTR(-ENOMEM);
 
 	error = init_file(f, flags, cred);
 	if (unlikely(error)) {
-		kmem_cache_free(filp_cachep, f);
+		kmem_cache_free(filp_cache, f);
 		return ERR_PTR(error);
 	}
 
@@ -268,13 +272,13 @@ struct file *alloc_empty_file_noaccount(int flags, const struct cred *cred)
 	struct file *f;
 	int error;
 
-	f = kmem_cache_alloc(filp_cachep, GFP_KERNEL);
+	f = kmem_cache_alloc(filp_cache, GFP_KERNEL);
 	if (unlikely(!f))
 		return ERR_PTR(-ENOMEM);
 
 	error = init_file(f, flags, cred);
 	if (unlikely(error)) {
-		kmem_cache_free(filp_cachep, f);
+		kmem_cache_free(filp_cache, f);
 		return ERR_PTR(error);
 	}
 
@@ -295,13 +299,13 @@ struct file *alloc_empty_backing_file(int flags, const struct cred *cred)
 	struct backing_file *ff;
 	int error;
 
-	ff = kmem_cache_alloc(bfilp_cachep, GFP_KERNEL);
+	ff = kmem_cache_alloc(bfilp_cache, GFP_KERNEL);
 	if (unlikely(!ff))
 		return ERR_PTR(-ENOMEM);
 
 	error = init_file(&ff->file, flags, cred);
 	if (unlikely(error)) {
-		kmem_cache_free(bfilp_cachep, ff);
+		kmem_cache_free(bfilp_cache, ff);
 		return ERR_PTR(error);
 	}
 
@@ -593,14 +597,17 @@ void __init files_init(void)
 		.freeptr_offset = offsetof(struct file, f_freeptr),
 	};
 
-	filp_cachep = kmem_cache_create("filp", sizeof(struct file), &args,
+	__filp_cache = kmem_cache_create("filp", sizeof(struct file), &args,
 				SLAB_HWCACHE_ALIGN | SLAB_PANIC |
 				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
+	runtime_const_init(ptr, __filp_cache);
 
 	args.freeptr_offset = offsetof(struct backing_file, bf_freeptr);
-	bfilp_cachep = kmem_cache_create("bfilp", sizeof(struct backing_file),
+	__bfilp_cache = kmem_cache_create("bfilp", sizeof(struct backing_file),
 				&args, SLAB_HWCACHE_ALIGN | SLAB_PANIC |
 				SLAB_ACCOUNT | SLAB_TYPESAFE_BY_RCU);
+	runtime_const_init(ptr, __bfilp_cache);
+
 	percpu_counter_init(&nr_files, 0, GFP_KERNEL);
 }
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1e1580febe4b..4f8e734c4336 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -975,7 +975,9 @@
 		RUNTIME_CONST(shift, d_hash_shift)			\
 		RUNTIME_CONST(ptr, dentry_hashtable)			\
 		RUNTIME_CONST(ptr, __dentry_cache)			\
-		RUNTIME_CONST(ptr, __names_cache)
+		RUNTIME_CONST(ptr, __names_cache)			\
+		RUNTIME_CONST(ptr, __filp_cache)			\
+		RUNTIME_CONST(ptr, __bfilp_cache)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
-- 
2.48.1

