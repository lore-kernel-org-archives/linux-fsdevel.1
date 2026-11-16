Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824515;
	b=UN9qQQh+BCFcPU88obgp88QIgubNFDu6/JZ3OnuL4O5l0Yp2ZOngU6tNnS9OSRTrtnv0
	 xI8zlwjfNUpgsI2pMtS3LZQZrhtARIQx8pAnMW+ED1MaYc2cLoZ4z2lnVc7/dt0bfkLSq
	 GHbL0lriDOvuOq6y24ppnzYUp4wC5VP3gax4N2l/udC3cXd7G8pIa7OVEyMj7ErTtvkMZ
	 31uYf3a/57pHhLT7wALCyAQdDXIJSK68t2jc2X9M6c6MiSpV0xqI/Dw96vgJVGssqw/Et
	 9rLJw1aMg8ZldwIKu4SHbw7pVD8a7dgsYE7nHIX/PyViMKQUdeMB3V2GtDvnDMNjbLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824515;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fs2TY9KUSe9qhQmUoFf2CzU4kU5d/ayf9q/EM0cvmYA=;
	b=Q3a8zX5M8R1KPOGFvewBYBNbWpkMrs+l6TrXYxYgUoKHWq5dGPQnkZfsUa3CdetGNerT
	 kL503S+ORncT5Y7X/T2VaOhP8+aFyTSr99Nc9joIdIdCTtOg59glLtxVgwUhUyzZToQDe
	 bqPq8MizW6H0uzieEYzzqrv56lExrC9DLOSwBVH8zd80I9mD1TngEkHnMyZi9TkIXokKV
	 iuNZvLqjCiBFS6UEu08DnbPbOPW053VbKMxG8L+F3RDhJ4st1283BCcfSZd+vY2VS09kP
	 SqnXG+pslqrj5aLct+I0gMWost7AaM8loA7w9vpaAS3fZX0il1xWYWAdwkrOJCWn97Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G12BKPSA;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB52606A33B
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AB52606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G12BKPSA
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso25115075e9.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794824512; x=1795429312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fs2TY9KUSe9qhQmUoFf2CzU4kU5d/ayf9q/EM0cvmYA=;
        b=G12BKPSAtE/jQt9P/CAWiwgAvbvawUunvssMMW/QGhaX/xm16bPDTzSCpS80xCYiko
         5B9sN+baxG5tIyg3NoPQEhEdYTvlK/Q7HOktO4sQXruWbgJWBuOn9N+ZN0W5EbwLJIIL
         me67DqtGeXV9bDOTCQX2Ea3uLD9CBaTN17calg5eTS70OCEkOMIjkvPYJzlsUsTHow36
         ErxYRgUm2tRKZSn0xiSruYsC7WCov3Aco2cvK8QHqksbm0EBJblbJtDAXcZXv4PLTqob
         ry7mKXeDSJdQVzhj6Uj+CbOGdGE5QlzV7DI6mJ46TjzmCY6ZlrPimDsVfZNycfEtxyV0
         beWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794824512; x=1795429312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fs2TY9KUSe9qhQmUoFf2CzU4kU5d/ayf9q/EM0cvmYA=;
        b=NCojLH3txFuNQV/Wpr1whR0XSgIvPJ+k0nSOBR4DvDUkDT2DMCOakX54ezNsBfS39S
         g5xcfkytcXb/sWVpOaLHfUS6rWpMBbFzujVrvmbLNgbkO5wkIcwpxJsLaHx8Zsj7Sx7A
         k4c37DU9BWS4HvO2u4Xa+sxQIMpT+JpFv+IWlWqKwvLxqeWjTTqLJuRS+lQsyWPRXijZ
         np4uWsMibKtWFYSquyczMbny5JahyCnq/EUcP4x88ZXX1byj+bEOLgqvAkFcA+yQVMGf
         w0neEDBPTWjLMRR+Hz5CmPsDSdlNXb/pl9qVNyG2u93Qm/uF5U9bTuzmdSoiTLbMTjhl
         ojTQ==
X-Forwarded-Encrypted: i=1; AL+hErHHFgioI4d9wloQA9PXo6Y5tsUPTgfyl3mQiuJIAMPs3HYxFkSn9y92hzDf82VkboPQ4sE3RPSEZz002SU9@vger.kernel.org
X-Gm-Message-State: APuU4Z/V4yheZqdi/jW87ktN8CfGsjeOlUNxF/rGf3KnsQhwbOjoEyZy
	0ggvBK+EpCnywKhZyft8CYiBo5rinTbZdiyXpcWRSYe0q8a1Euf4xRmm
X-Gm-Gg: AYBFou1v+Kl9cflsG3QVSUQmtHtsS1zNNzhNIU89No+5StPja3oRznDy7q19sFmVuBW
	CytiCT8E5AcvbxG7DCzxDtrFvQHU4GVX6afqgx0wKSQoyu05Y2BNpi5HJBDz3XpxtU+0QqqCY9a
	RLwQXBX9SBA88Rexr6pjMIzvooLzEiM1SXKrAf3HaM4F5Or2rgYWqVO81J/fguFBmP/211Jc/Yt
	CQSeERmBqnKcbxsaKcX2hmQtIR3qxrVEVzmZpvabsARRtD2uCQH/InQBHHosawS15y2GbUojsCk
	0CYNlwlVZCY+92tGSY2edz2LU/4KFzda7EJdHbI1ODQMPNjiOvo8e3wSs4bdNyXKdzPy0FMDrqV
	moD2yyjmG4tISkUat19a9BqMpTo9FG+LTic3pq0jFAkVUhRyMrEjz3bOyE7iE8lpzMDjlgyRLfR
	ClH7j1/1XxIo/yKZ/cV6wR52J2JpJMWXr9/W5EAamFAo32lU3xAHPDAnDVrosBhpdYfSbdnS3j0
	i7u5pRsuOq+/IFnOgTgf6XsG+zi1vjQkaYzk5vlBEQJLDzKhJqlJt+C9bD2Bi+Nt+p9dkKiskab
	my9o0M6IAqZeyKqfhKwLdA==
X-Received: by 2002:a05:600c:6096:b0:4bb:5de1:e923 with SMTP id 5b1f17b1804b1-4bb5de1f26dmr155965845e9.4.1794824512214;
        Mon, 16 Nov 2026 02:21:52 -0800 (PST)
Received: from fedora ([5.131.7.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb6caae30csm98804795e9.2.2026.11.16.02.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 02:21:51 -0800 (PST)
From: Petr Vaganov <petrvaganoff@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Petr Vaganov <petrvaganoff@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Su Hui <suhui@nfschina.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.12] fs/stat.c: avoid harmless garbage value problem in vfs_statx_path()
Date: Mon, 16 Nov 2026 17:21:29 +0700
Message-ID: <20261116102130.80651-1-petrvaganoff@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

commit 0fac3ed473dd2955053be6671cdd747807f5e488 upstream.

Clang static checker(scan-build) warning:
fs/stat.c:287:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  287 |                 stat->result_mask |= STATX_MNT_ID_UNIQUE;
      |                 ~~~~~~~~~~~~~~~~~ ^
fs/stat.c:290:21: warning: The left expression of the compound assignment is
an uninitialized value. The computed value will also be garbage.
  290 |                 stat->result_mask |= STATX_MNT_ID;

When vfs_getattr() failed because of security_inode_getattr(), 'stat' is
uninitialized. In this case, there is a harmless garbage problem in
vfs_statx_path(). It's better to return error directly when
vfs_getattr() failed, avoiding garbage value and more clearly.

Signed-off-by: Su Hui <suhui@nfschina.com>
Link: https://lore.kernel.org/r/20250119025946.1168957-1-suhui@nfschina.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Fixes: 98d2b4308197 ("add unique mount ID")
Signed-off-by: Petr Vaganov <petrvaganoff@gmail.com>
---
 fs/stat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/stat.c b/fs/stat.c
index 80344764a329..5aa8f296e8ee 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -253,6 +253,8 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 			  u32 request_mask)
 {
 	int error = vfs_getattr(path, stat, request_mask, flags);
+	if (error)
+		return error;
 
 	if (request_mask & STATX_MNT_ID_UNIQUE) {
 		stat->mnt_id = real_mount(path->mnt)->mnt_id_unique;
@@ -274,7 +276,7 @@ static int vfs_statx_path(struct path *path, int flags, struct kstat *stat,
 	if (S_ISBLK(stat->mode))
 		bdev_statx(path, stat, request_mask);
 
-	return error;
+	return 0;
 }
 
 static int vfs_statx_fd(int fd, int flags, struct kstat *stat,
-- 
2.55.0

