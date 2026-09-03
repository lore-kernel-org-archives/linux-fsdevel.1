Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460E3630AC
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Sep 2026 10:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430748; cv=none; b=f9Y2ITjH1p97qV9Aeq8PEVPg4YO/8dPxGrWKnnMSAM8rCqd4Ija5ndwPjm6DGRxnwwZJNkwVdssl1s9/L5v60bZvUiC5IDo38jFti0kqYC3SLgjbl99IovVWVp0bs5DrD8h1mS7PUnCy+pcLjAaZ22iF00vM6JFimwx8GFzK7M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430748; c=relaxed/simple;
	bh=yxEvLgeO6a234EkG6hRn5dBYg7psMeXo/zcDkO3QmOw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KMyMStJ42CFocdbxGpppEid3ten7hjGTx8HyGGPFSkVbCsR+o8C1C7Hmal33nTL5hri9vieSrhqb66MpTIIetHz2zPaloBrMy44H6iSRLHO0deMKjp0fR4d1KqAWTU9jzSGL/dua1iRC7HP81d4GBcXGRIpEPCdJdElst8BYooo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSXaBLSz; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSXaBLSz"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so15167955e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Sep 2026 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788430735; x=1789035535; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lx0TtCbif7K35p3AIaJIf+dt4oCHY15FJPpSmftqgMg=;
        b=ZSXaBLSzyB2Mzc34gN9A3xi1Ie+VIGc38y7YtKXM2GKS5+srtgYaCDZU0uGA+keW9R
         QDLnqNRaZ7j63x6mlZYNfmllMJfI0FqelqnPG+Ae73nFhL8s7/cqEteO9S2rDg/ASemw
         btiMzTjt4tIqfRm+9c8LSnyTOSNB+ncSQedhdaOTNWUwYvAyC2h9bTt1HVj4R3hxZ0vL
         bSTt5y8/eTi/WZH3FEsa++bf+xwSKBsRISGWAN8nV2C2N3NHAKKhIoGSKJpR8t2IBWXq
         0jCfOEUh85NL+dB2SihCOLVwE7DT9SiP35wBXc4wIn7yDtzXZ9wfDtadgEo+1GH7JHup
         6Gng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430735; x=1789035535;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lx0TtCbif7K35p3AIaJIf+dt4oCHY15FJPpSmftqgMg=;
        b=bY0tXaH8TJLtPVWYAK4e285ZqRi2/ShnsB1d+FjSGnVkySZE7hyJ/8nYFrvWd5oxF9
         OCQr6HJVedkNvXX802MmfxNsQAGpcSt4p7deM0FxMsOaMKuIKtrT7992hxkKACx4rcwt
         tgY+8Chfnet8upOtevAeYJwhlmBaOcxMC6j4nihhJkKa8LW/0piuCPdW9j2DG+rx05Ik
         EExTYLNRaD+LJk6/rSI+A6hDD9VJp0s55H0D7YrsA1cbkOYjtLh2nhBOYsnihgA1ddrS
         bh+rWnKa4HWhfpXLoqXADNqFLVEiDabRAzZFUj6bCatKexCvlQYAemhySg0eaTFXVYLe
         a2TQ==
X-Forwarded-Encrypted: i=1; AKwUvByNGOe0HQM7PHHH2+pqqNO2Z6UvuUebVfR54N+6ni9x5GrELHv60obdru0eKmPVJqHutEcCcNcuwgzHcz24@vger.kernel.org
X-Gm-Message-State: AFuF++k0QnVef9wMiyp5IwQs6/LkXEtPvx/LSt8BstrD3dgB4DV96rns
	MobKr5Y/KvYBI4W4YtGZ7gIz1Yil5YFn827AMnaseFDDzuRoDtHVFwugINTgSPmw66yi97ktKTg
	ApQ==
X-Received: from wmby2.prod.google.com ([2002:a05:600c:c042:b0:499:b692:b246])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:5489:b0:499:4e47:eaf2
 with SMTP id 5b1f17b1804b1-49ce58092a6mr171429625e9.6.1788430734709; Thu, 03
 Sep 2026 03:18:54 -0700 (PDT)
Date: Thu,  3 Sep 2026 10:16:38 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260903101843.3462767-1-elver@google.com>
Subject: [PATCH] once_lite: Simplify condition handling and fix context analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	Jan Kara <jack@suse.cz>, Timothy Day <timday@thelustrecollective.com>, 
	linux-ext4@vger.kernel.org, Theodore Tso <tytso@mit.edu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When WARN_ON_ONCE() wraps a conditional lock acquisition (such as
down_write_trylock()) on architectures relying on DO_ONCE_LITE_IF()
(e.g. arm), Clang's context analysis (Thread Safety Analysis) failed
with a false positive:

  fs/ext2/xattr.c:825:6: error: rw_semaphore 'EXT2_I().xattr_sem' is not held on every path through here [-Werror,-Wthread-safety-analysis]
    825 |         if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
        |             ^

This happens because DO_ONCE_LITE_IF() branches on __ONCE_LITE_IF()'s
return value (__ret_once), creating an intermediate branch merge point
where the lock may or may not be held depending on whether the once-flag
(__already_done) was already set. Because the merge branch condition is
__ret_once rather than the trylock predicate (__ret_do_once), Clang
cannot reconcile the lockset at the branch merge points.

Fix it by refactoring __ONCE_LITE_IF() into an unconditional
__ONCE_LITE() primitive and redefining __ONCE_LITE_IF(condition) as:

  (unlikely(condition) && __ONCE_LITE())

This simplifies the implementation, short-circuits evaluation so that
__ONCE_LITE() is not called when the condition is false, and ensures
that DO_ONCE_LITE_IF() only enters __ONCE_LITE() when __ret_do_once is
true.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/all/20260903072759.GA1750084@ax162/
Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/once_lite.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/once_lite.h b/include/linux/once_lite.h
index 236592c4eeb1..5e2b67039aaf 100644
--- a/include/linux/once_lite.h
+++ b/include/linux/once_lite.h
@@ -10,19 +10,21 @@
 #define DO_ONCE_LITE(func, ...)						\
 	DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
 
-#define __ONCE_LITE_IF(condition)					\
+#define __ONCE_LITE()							\
 	({								\
 		static bool __section(".data..once") __already_done;	\
-		bool __ret_cond = !!(condition);			\
 		bool __ret_once = false;				\
 									\
-		if (unlikely(__ret_cond) && unlikely(!__already_done)) {\
+		if (unlikely(!__already_done)) {			\
 			__already_done = true;				\
 			__ret_once = true;				\
 		}							\
 		unlikely(__ret_once);					\
 	})
 
+#define __ONCE_LITE_IF(condition)					\
+	(unlikely(condition) && __ONCE_LITE())
+
 #define DO_ONCE_LITE_IF(condition, func, ...)				\
 	({								\
 		bool __ret_do_once = !!(condition);			\
-- 
2.55.0.970.g62bdec98f9-goog

