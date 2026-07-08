Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F422459C5
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783516018; cv=none; b=nc3LfkyK88Ek1hEnNCRklmKNMkfBlaq8jqfxlnYxB2xoMtgqZmZu1x+7Nc1ARsrvIIhbEN6TFzDpvghgaJQi+J+GMobzNJQT4ZLeDFk0TF8TBA20tg2nhhReg4gsLtBbWbhabeNyn/FidhRv5yLk9f6A9MwISVUIP+9wfP3l9ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783516018; c=relaxed/simple;
	bh=fwy5fO/V7JapY3djJy0QpJK55av6p74lqWx9juegZb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GaiGU0fdFj0NuIDJ/BfahYsM9DCyrjCuhTkyBjpubaH6ISfpu6xKL5TeVkZZL49NGb04RJZ88w7USN+1BAbRaerI0rGcnR+WtXpUdOcCxdl31jbG22AyLEC7/t5BHj3etZwMPAjeR36SgxZRw06FpEbXgURFtlIt8miGBOXMblM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSOvkRcM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSOvkRcM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc80b585bfso5715495ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783516017; x=1784120817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4H65Jt0qaP5+omtTAiQmAVRn7+xFeblOteKrGy1TQnM=;
        b=CSOvkRcMXhUHnEhDGDHuduJOOu4EVjJ3hstSvMx2oqSw1BdEhYqOtZ6FQWIF7H+jwx
         XAhE5e6pKGAQxrAr1/ejju3zcO5HtMyM9XMf5nlZBrCFDUVkYvWCHFojKuwH9bQn84ZU
         JXuQNjRUrqJtULVKwZVxXTFD1FBcJy7LQcW24Ho3mkMqyc7r12VaXOx3Ekz7PK7bzWzn
         rxdRydBVwak4bgojx8oHbaWCxFzJ3iqqkhLltfLJe3v1Cu1VevNOaOhrkJZiUiGHxPGJ
         V06gYgCINOavao86itgPaP3KPJ9I+YszPS2TYyZ6zcJjfkMh70WAPuc+k7hhfMzAuDUa
         OPEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783516017; x=1784120817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4H65Jt0qaP5+omtTAiQmAVRn7+xFeblOteKrGy1TQnM=;
        b=bFv55weim0Ykrf/dRw9Wz+jDX1xfr+rkIMrz/xFcV42b9wIqGcMEEkK3w/uBYUiyPa
         v04LxcRIjCBYkmpgC+eLkHZEEvmV6mKLUGmvqPamjuEkmC0Y5/3eThtTa9RZB+hYHpCh
         kUm5UogP+0Xjzb1dhdTuvLRqQyPFeRYdp8SW6WHmR4Nvrr/Es8G+UVjJ8H2iV4TtHEIB
         25jxdhY+8sOB6yw1EqUOm6/mPNQZpMPX2UVmGPSmgLfAuaT0AuIqqXGGEpdp/aqBnCBh
         mbfnyxht3Z3FSJQiPuo0zrKdPp1lOiAQ49l/achUP8Kdbzj4hoNFpO+MpbW71m2TNnww
         0w+Q==
X-Forwarded-Encrypted: i=1; AHgh+RpFgqyVGLoAaDR+JGjGQeq95eVSFX6a/waAeEeo9z/I/oDTq+26BI5i9zs6Z3utsTsyhY3zEMeX6wunoobr@vger.kernel.org
X-Gm-Message-State: AOJu0YyvYTx1xJWxGFZjZWEqkXXepfY9C5IwBCWVwS7rTyCwPhxx51R5
	FEcnZf7PIcnASkITCwTD1VaxL1FqoA0fVdsboT7evKGVOCW/zJG+6TMR
X-Gm-Gg: AfdE7ckK9+2LS4g2/ajdco24i2v9Z3FLuRaOw0vPLWcDHD23VvcBkeKK6e/0vf4V8/N
	lhC727ug/oWMk9eh8H3l0vwPutqzqXdTwggHaOnlM9QF7LvvayoX/GMRi4cLP1duDrYLKizDeMy
	B4rJVqP1vdq+uGbhJmUuIgYiSVT+G5iOcx0wVQq6Q7nm7SRsHip6/z0HqTx37EGdtUz/kLO1etf
	3VbdzzItsDpNT92uWBetSgWlmwhtqgzpnZJCoz+/tlnmaXcg4MKjUbW+9zL7s+50qe3WDCOUKUN
	/5H1UtnaaPitUhf9QL+8zXkLHZXcYbf8EB+x5mRF/ZoEfuOBCRUEBM97IGReL657aCR6a3AwOOn
	QuiwMZ8yNLmFixuZ85moDQ3XalSq91DeaHzBSFACVcNnJHMSUfdbeo/OqeRJdiI2ZXi/J5Z0Lso
	D8fwfAUyC65g==
X-Received: by 2002:a17:903:3903:b0:2cb:14b3:4cfe with SMTP id d9443c01a7336-2ccea582ae2mr27025425ad.45.1783516016527;
        Wed, 08 Jul 2026 06:06:56 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccf5a4fa46sm2927725ad.30.2026.07.08.06.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:06:55 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jann Horn <jannh@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Subject: [PATCH] fhandle: handle detached mounts in capable_wrt_mount()
Date: Wed,  8 Jul 2026 21:06:48 +0800
Message-ID: <20260708130648.767811-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The change referenced by the Fixes tag protects the lockless read of
mount->mnt_ns in may_decode_fh() with an RCU read-side critical section.

That prevents the namespace object from being freed while it is being
used, but it does not guarantee that mount->mnt_ns is non-NULL. A mount
can be detached concurrently after is_mounted() has checked the field and
before capable_wrt_mount() reads it again.

If capable_wrt_mount() observes the detached state, it currently
dereferences the NULL namespace pointer while passing mnt_ns->user_ns to
ns_capable().

Treat a detached mount as not capable for this permission relaxation and
return false when the RCU-protected mnt_ns read yields NULL.

Fixes: 40ab6644b996 ("fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 fs/fhandle.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 1ca7eb3a6cb5..d9de7210a411 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -295,6 +295,9 @@ static bool capable_wrt_mount(struct mount *mount)
 	 */
 	guard(rcu)();
 	mnt_ns = READ_ONCE(mount->mnt_ns);
+	if (!mnt_ns)
+		return false;
+
 	return ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
-- 
2.43.0

