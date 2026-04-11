Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15A1F4C96
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775912109; cv=none; b=cAHh/AvOAHRwJfIxWnn8V8Fjtx/gBCUxFHHxjbuixgE/IpRvEV0rMo5GDDCCgm46IBAJ55+HJEY34VYG403bWKFGZ/l+jqCZNAna94PM6VBLPZiqEG0jIBODcRG252geRaquqCuYtBfrFEo9+pPLqOfGNRP7IhA0H0+cJqhHwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775912109; c=relaxed/simple;
	bh=vBPOS+Mzqd0qYklI1rlLeYg1G4n0LqVG0JMrgPezwfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IJ656ZEJn/Q0Zt+VBiJBEeMCCuIkCk1rICTzDF/o80w0wlZl1eDOfVbqOlGDg230H6Z4fRkJuPEyu80twvPns7kcRD881FXcNwILCTTGDwf0/azPTn0mRcmV9o9OY/u0k4Xqn6BlX5TtRzPpmznM3fk8aSttpQaSiwzowAevehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeWNeaGc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeWNeaGc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ad135063so27926845e9.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775912106; x=1776516906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1sk4BS+NYYx5pChD5+U+ftGqCpaMePJhg1hk3GmMPw8=;
        b=JeWNeaGcVEuMVVFQYis1gFrR6mqYj/vk3CTyHh6QeeTVifUoZlEAhrH/Suea+3aL1s
         5fUhWs89pOHBqehrz0GVfmJImtGM/+Jr4cJrBxEC4ctDEXI+VAxxXF3PkOBaJfBoKfuR
         g/8zsEQLzhRhgkqoKBj75gWStKNlVorHWAJ6+fgyhealNUSILcWJAFqJ+RA595mYDQxJ
         cuZcApIg7HxnhcBzmwd9j4anVkOyNqNYTp1J7WZd3al+iEVGwba5+9OOw78+LuU7zc6Y
         2m0ycQxHYgDYtxcBeQtFLwxMJ+O9r+lDYRaoC9mKv7CFzGTZZDDNGclTwNfs+VnE7lNb
         WWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775912106; x=1776516906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1sk4BS+NYYx5pChD5+U+ftGqCpaMePJhg1hk3GmMPw8=;
        b=A7Hvp+q58xCNLuz0EeBBAnpYrXcujqI2fO4biLJJwHTSeUL++lw2kXaptQKVOKb0e/
         O7zdLVyCnAdYIz1ml74vWHe595gzwNJM1aAnq0KwiWo+1JYMqGtIpzcbXCkbZXTbQMFN
         UwuFVWNB9+OJ/G7iHdRj3Z+y3Pg5q4lJSUe8LE+zX0MjEwzOzytsJpKI52izLPP2nH1B
         lnasDSvnX6bmBdwuV06laMMQmKPQCMTXt0W59yxn/pkYAZZAYuI2AEHXosBA1I/eW7+p
         79GecvF0QVbnmhRa3kKoJ1GteqYRYzwCR6vfbAX3dXbx/Dbxe+bNd3uX7/wv/8MbzGAB
         XyvA==
X-Forwarded-Encrypted: i=1; AJvYcCXh0nbYiaFMXBOoUfGCk5kU3Am9kuMrVv1Tou1+42kPa549GTL7+19pXkCQ93dAaPtRcuhb2uPHqjGXlt2u@vger.kernel.org
X-Gm-Message-State: AOJu0YxQYnwyU+I4kV7ucpOz+G2QjxmppKb0SLm+xwGR8yhzPxx+Cw/W
	Nh40GdNrI2QwYW3U3qJJP6tzb2TGnA5eMrVf/IjYnQMcQ4uKSUYckBZt
X-Gm-Gg: AeBDies8+R5Uf3PawgJ5J5EPn8CQvTZXdFmjv4GonXRBdTDiz66a+b3OtWZlDONVD5N
	XINxOh5YZm0Ugk9ULlgcTc0Tv9xAtw3EXSRfR2wFqfTVKSf7+uNcW8TA2oTQF8M60rr5jgxfaCo
	LfzYNF58J9DAwOCEofIubFC/AxHhnQW/bh3A5nDH/klUlXv2kI3NmQvVKnhgL5qt4/+NWgI+N0q
	yhluSZp/Qtag/vAV6sJ3JJRUanBYIl01vG7d9gXa8JHwGwCTVN4tqaduaOFa6UnWSfrtTVIBhNE
	UNU/3v79ypKRQH9mPYMgKgnbgNvj3LV+woOFD5XlBch4ss29FNNKP87W9zN0ewO5IAbirTVqd5v
	AzG7DZ46//DjN0RO1U4vDXenqplNFRLutI4qwn6wa49j3rGmjeCRW7BhM5PPs3dfMiFBqrxdfXS
	RU2uHvezf6KwXCT3DI/rkstnl6nDCrn8nd
X-Received: by 2002:a05:600c:35c7:b0:483:64b4:79da with SMTP id 5b1f17b1804b1-488d68b27d6mr98565045e9.26.1775912105614;
        Sat, 11 Apr 2026 05:55:05 -0700 (PDT)
Received: from localhost ([87.254.0.141])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm15877244f8f.4.2026.04.11.05.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:55:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yangtao Li <frank.li@vivo.com>,
	linux-fsdevel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hfsplus: remove xattr error message
Date: Sat, 11 Apr 2026 13:53:38 +0100
Message-ID: <20260411125338.165758-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When exercising hfsplus with the stress-ng xattr stressor a large
quantity of somewhat unhelpful error messages "hfsplus: xattr exists
yet" spam the kernel log. Remove these.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/hfsplus/xattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index c70bb6f494b2..e10e1d8a5862 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -301,7 +301,6 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 	if (!strcmp_xattr_finder_info(name)) {
 		if (flags & XATTR_CREATE) {
-			pr_err("xattr exists yet\n");
 			err = -EOPNOTSUPP;
 			goto end_setxattr;
 		}
@@ -348,7 +347,6 @@ int __hfsplus_setxattr(struct inode *inode, const char *name,
 
 	if (hfsplus_attr_exists(inode, name)) {
 		if (flags & XATTR_CREATE) {
-			pr_err("xattr exists yet\n");
 			err = -EOPNOTSUPP;
 			goto end_setxattr;
 		}
-- 
2.53.0

