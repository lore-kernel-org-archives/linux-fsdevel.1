Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223F23D6CCF
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786613678; cv=none; b=umSp93/Jq8ZkWmi7DgL9O6WqpK0qiwovL9ceCTaxhjnTY62brnjI+QUbyLio4T1UCK3pPkIlPhxjCXfKW+m4Y1o4JaRzXAQzuhD/SU3/auLMlXAh0Y0eLsxzIOrANiQnHI0E20GVKkBldaUBwdOhAdmOqKqah2j8Vb7uY6F2YIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786613678; c=relaxed/simple;
	bh=BuN15nwLV/e7ON4/iGwoHuE9MjVm+4prWVv1roSu89E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EqTbXSyIJOgtU7Tr3STQnrdpBTdh3xq+9+0kxAcMOgpIowwd8YXY4fnxXHf7eX/imYz/Mc/eKjIZ06q2t7XCTwFOWZHqyXjeFIQk23hXicxCC9AUHIE215goHIHfcuCiZsCrmJJIkIUKv4EQnOLF3u8cbnYKATFGF6+dP5YmeyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWxxFN2F; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWxxFN2F"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38759bcd877so661609a91.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 02:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786613668; x=1787218468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lPwh50hsT8qfoA9SIVp0tNvb2I/e3xd4Ee2ZvpwWHfE=;
        b=oWxxFN2FfzTM+h6jh/XcP8j4yZCInxo5FCbkGz2QeWB2lpcI1Tn2Hz3JuA4Mvc+VEO
         YO2N+buYE7Jbga4UVa01K+yRADt6k068LMKDSxNzQTAhCcGLiqfxPvQer90CGGQE2Xy9
         f8O/97nnDHfXMQcwYZZiFhEvFynehhWmb+4bPEfLzxhs8MR8Oud7ieU/58Ee7wcdMKMk
         W73RT6IMWcQfiAF7OKnMg0I2GmqXx1N5sZlIvuRZ30iLXAMR/5bmYcjsvIO0YdenCb3P
         hsBjpwWC16HmPHNZMWb7IMnQDEuWd3DUq9zbmuY2Aq87n/LrFOY0og7hBV5+DDUiAqVK
         4JyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786613668; x=1787218468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lPwh50hsT8qfoA9SIVp0tNvb2I/e3xd4Ee2ZvpwWHfE=;
        b=n/F2reBRT4rh5okW6QyMAcb1QTj6T2nqfIDQ4ce1sASXMVSh96z4fnqUU0fRtb2eHT
         N937Mj+Mo91y8IRVWaL9Tq702KTNEpOEqR9nN4LhjtFjLPlYKTavEpxSD4oOcpUUghGO
         hA5i4PxLev7uynyMacOGLIbJ+6m0YcIy3Fv1aLw09GfhQRI6ceqPEO6OiPL1oLxZPSl8
         nScL8olDyMH6DY0+W+3DxxbkYqf+kEnyQwzcx3QBVMmPeTOsCqxrZtGKGHHPp9bYE8eS
         9P2K4aKEYYMtQg95rkZAmmlxgZv6vfaVAkS5O8U3EOQ3ZytyWYlCZtdKq6J4W8ZP/5T2
         rqeg==
X-Forwarded-Encrypted: i=1; AHgh+Rp0uto/Eyf6GfXsndeAzav/MNZXUo/ZgKI9Ct4iGprfJz0RD0axS/QhQLeSwzTtAMfN9u8f/9Q8Qgy7zwqs@vger.kernel.org
X-Gm-Message-State: AOJu0YwihRo/lxasQ66zPJdnVILi8ctLixY0q8rfcY9ThPgerNKHpgsF
	DOjY50kFuVQVOYdWK5WaRuFu/VNl6ocDmNbxx0A9ysA2woIaHFO8zlDw6Gmp43TH
X-Gm-Gg: AR+sD13HnlQwnbcaI4Xo71sXGFiQIU7DenoXJcx7iwQT9yzUqSVY75nLHBVAj1Pa2S/
	wAHNO+KYXI63mhezmZ7eJh73NIcdS5zj937j34PHb+7Vx30WRlsQGqJqE+/eNI6MgS1/7bh+XjO
	jdjo4dfbMWh526vRfwcJY49zOsijB1oMbv+M3Ta1U61f9zF5CPDGyvquzBp/znrWRHiuyf9Qmhi
	WxIu+yz3PMU51JO3XF/YI4xtYfs4rXr2xXj4HJ4b//7K3jpxWYMZiLonM7uZZu/9NawnvVfU34s
	lLTTyFtgjVSERwod2TkEpVQp3+IGEVgwHkfSNHz3EiwSIJXw1h3ahHnQeciQf6cSkyi54E4wHfx
	tLggRPjFArd44D5HrCSEcPKFno1Myxwa5x5DtisNlv09oehHN5w2nP0CqufHyqPyuiEkkcipLDG
	RT41V2c5hREwgXglQ8wjnK8fVAuvNnmVTmpgIBNvm0ZpwbI3FxfWVpc14TFZKgt6f1vGYRB3FHm
	ENmT+cUPJmcNopbN7R8NjdxmccidSB0fJAqLxOQoaUJCeMpHCIHYb1gYW0d+hIJdZleGqXTHakw
	yQ==
X-Received: by 2002:a17:90b:35cc:b0:393:19a3:4e5 with SMTP id 98e67ed59e1d1-3931e2c75admr5732194a91.16.1786613668289;
        Thu, 13 Aug 2026 02:34:28 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:94:ab62:887d:e555:df21:3318])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141310397dcsm4853040c88.14.2026.08.13.02.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 02:34:27 -0700 (PDT)
From: Manush Prajwal <manushprajwal555@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Manush Prajwal <manushprajwal555@gmail.com>
Subject: [PATCH] fs: fix comment typo in bpf_fs_kfuncs.c
Date: Thu, 13 Aug 2026 15:04:04 +0530
Message-ID: <20260813093404.1278-1-manushprajwal555@gmail.com>
X-Mailer: git-send-email 2.46.2.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix "Rmove" -> "Remove" in the kernel-doc comments for
bpf_set_dentry_xattr_locked() and bpf_set_dentry_xattr(). No
functional change.

Signed-off-by: Manush Prajwal <manushprajwal555@gmail.com>
---
 fs/bpf_fs_kfuncs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index f1863a891d..e8a5a4cffe 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -235,7 +235,7 @@ int bpf_set_dentry_xattr_locked(struct dentry *dentry, const char *name__str,
  * @dentry: dentry to get xattr from
  * @name__str: name of the xattr
  *
- * Rmove xattr *name__str* of *dentry*.
+ * Remove xattr *name__str* of *dentry*.
  *
  * For security reasons, only *name__str* with prefix "security.bpf."
  * is allowed.
@@ -303,7 +303,7 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *dentry, const char *name__st
  * @dentry: dentry to get xattr from
  * @name__str: name of the xattr
  *
- * Rmove xattr *name__str* of *dentry*.
+ * Remove xattr *name__str* of *dentry*.
  *
  * For security reasons, only *name__str* with prefix "security.bpf."
  * is allowed.
-- 
2.46.2.windows.1

