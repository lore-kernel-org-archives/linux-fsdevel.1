Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F55547040
	for <linux-fsdevel@vger.kernel.org>; Sat, 26 Sep 2026 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790388537; cv=none; b=MHjd2ToVREIR7YBBtTMNyeI85U4c0JrN1943XC1EwsTyn/hsqqfmKnpjH3Y7ffIaIt3m7KNkehT9eQgtK2gFDNqU3M+fGrJO0jjwetBDekT+qli3eHQx9gd1OkEiFLHIijZmKzRdYXYhCU0jJMuc3u4TsTrN3qUrcnIk7kN+1LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790388537; c=relaxed/simple;
	bh=Sz3F0/9c/hspLc+ft2ASlOgGf9Cqx1+JIZa5oyLOSZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYfE5noVbptrr2qt1fsk6sALCMYMl7TDIeAhgB4R6WtFdxWH0UCW6L5J9edBIGjdN+IEQeu2lcBNsHkKyKsef9yX2+/fi5STn2PMeIPQ7fKOS6cOXmaRvb2e5ZCxDzYAgKfhmGsa4NKpS5R7oJrSkdk5hVe0OGDmUKWrZ5AAbm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvH3Tgyf; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvH3Tgyf"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b89592d2so737213a91.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 19:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790388535; x=1790993335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zk4olH3xptNmJQK41WU1h1Tdamzx/Da9rId2v3ZsrK4=;
        b=bvH3TgyfvDOVGLufEeDGZ6TwxoDksEcmNO6H3z/+knVZ7Pl1KIifVeOrEcEjm1kBBX
         Xg6Z3X145SK6O4YqbHLwsc9o/RmcdcOlChLHQOOk6q7JKVSEiJ11Z+e4fq4FBM/QEpgm
         w1EH1vxPY7Jy5OJYe059Yh6W9SljnmIqf3tCrRKUBCYvXstSWXq4W44EFIfqhJQQVIqV
         xOCjdOFw5JGa+bJqwe/xUMmCehrMoBnzP873Szl6EZf460yeczQrem8vNmju00X5MZj9
         1TiBVwOjmci5jzhUUMkRoVnnjptf4jijCNu0N2e0A3L8Wyk957wbxo0ZMuHuD1JhM06X
         Sgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790388535; x=1790993335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zk4olH3xptNmJQK41WU1h1Tdamzx/Da9rId2v3ZsrK4=;
        b=vq1kKVXsIPbH1wUM3wnWe1gF8GbxHacSpGAcX2e+g4MOfTHyDYOPRIvEbBtROeYYFb
         oYxYwcKi+dgZBz1+n0c/WcHM7/GeoAkAgbNTNTjSEtLDaekyBV5rbVcf6DAYhmX4OsHs
         bjsV6jQ9jK4NSVwB+gANQshy8eaKa/LDLOtPUB5eQnT8uA1cv3B4DfByQEZUc5UDHDfo
         Wbt1eW/ohy15POMLRMud869kBdJrdFEa26D5SBLr/d/kHEYHlARruYNgRuUFwAHyjlB1
         4e/GO3+t074xyiNvuv8j3djhndj7mdNfuJB5lphb+ulenxjfMGBXMtL9TnzaJT9W44y+
         9RzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbU5cAMv+nQMvglhZpLnGg+AOW/UuPu7uvJlK8+TA63g0425L06pjF4jXHKTbhfbaG9Y7EbwYKtc8ANr+R@vger.kernel.org
X-Gm-Message-State: AFuF++nCTyEgXhnLk+EkHI2Zix5OTZ7jinVZjMqlV+kVitnerh6mc27g
	+XV438X+hyI2iRMeMy6O3PTGeqDNBI91ViAOAJvppLpFm0sxGz0QbNqH
X-Gm-Gg: AYBFou0ATraYuH7BiIWOAWsw5+Bvs+hxJHocpzqLV9BUTCvvYjUjlI3nVeXBgeNUXPf
	hMNUmR7hnZpWxYw3D+95mHTVsJgn7rC79snOGpeQfTOfaet+vhxVevXCzdEaX2/YxmG9Q2HRBfn
	jekZ9J7hldXj0XcYmuY1FUzaCH/tC3bXybI+YQTvZbvh1ZGZounQOI360yhg3fDZdiATQ99O8B2
	3u53TvjfgDrGKHVVlsHrOVkb7zIqaI2ytXDhwRrOtENe3xgy0vfdwsWvchkOomlNfz7jOKJc1NL
	mGVqfRX3a/qzhzCRR3HBy8cvJrje0ENupFlBBJK/l1aqgp5rBBBWBH/kNifp3fMI0o6BQaKdMKa
	mIWnkq2xI/U2p9KnX74jRubm1ASvrQF0CoNX5kdyNRpbZZS5Tynd/1spKSncKJwEw1kFHPrNnha
	NZYR4lBmHP1ZXm7cNWrn6OrVkr64rlJeh0+UxZi4jcCHVwQrdGrOCYH42wrtKmpvfmi0Zvnayrg
	mpm+PYOLFyIIifRFkgL+Lair9hjLTcAr8T7SjHyDOGWrTsYzWEJAPFRdQVUuMq/47AHfE3ekznX
	acwWVkzR7Bg3LXEJAIRICrnwwj7fZP3MeLtvZkI1Q4zAulPPMlaV+EWFrmZCNp1lwqYFNw==
X-Received: by 2002:a17:90b:4403:b0:3a0:cb2a:b501 with SMTP id 98e67ed59e1d1-3a0cb2ab99cmr1819581a91.11.1790388535229;
        Fri, 25 Sep 2026 19:08:55 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976cacbesm13252595a91.13.2026.09.25.19.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 19:08:54 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: jack@suse.cz
Cc: amir73il@gmail.com,
	repnop@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fanotify: report names longer than NAME_MAX
Date: Sat, 26 Sep 2026 10:08:51 +0800
Message-ID: <20260926020851.2938961-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fanotify keeps the length of a reported name in a u8, so it drops any
name longer than NAME_MAX and warns:

  WARNING: fs/notify/fanotify/fanotify.h:217 at fanotify_handle_event+0x2e82/0x39f0

Such names are legitimate on some filesystems.  vfat mounted with utf8
takes up to 255 UTF-16 characters, which are up to 765 bytes of UTF-8,
and FUSE accepts names up to PATH_MAX - 1.  readdir() and inotify report
them in full.  fanotify sends the event without the name, and for
FAN_RENAME it trips a second warning in copy_fid_info_to_user(), after
which read() fails with EFAULT and the event is lost.

When syzbot hit this, Jan suggested accommodating names up to PATH_MAX
[1], the limit readdir() already applies to a name
(verify_dirent_name()).  Store the name lengths as u16, which keeps
struct fanotify_info at 8 bytes, and drop without a warning only names
of PATH_MAX bytes or more, which no path can refer to.  An event with
such a name can exceed a page, so allocate name events with kvmalloc(),
as Jan also suggested.  Names up to NAME_MAX are reported exactly as
before, and the record format is unchanged: an event with a long name is
just longer.

Link: https://lore.kernel.org/all/20241112115059.ecvomkalee5m4i4i@quack3/ [1]
Fixes: 2d9374f09513 ("fanotify: use macros to get the offset to fanotify_info buffer")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---

Tested in a VM with KASAN, lockdep and kmemleak: on vfat (utf8), names
of 258 to 765 bytes now arrive with their name, including FAN_RENAME,
for root and for an unprivileged watcher; FUSE names up to 4095 bytes
likewise, also a FAN_RENAME between two of them.  With kvmalloc()'s
kmalloc() attempt forced to fail, the events arrive intact from vmalloc.
No warnings.  The LTP fanotify and inotify tests give the same results
as before (fanotify20 skipped in both).

5.15.y fails the same way (the same warnings and EFAULT on 5.15.221),
and the patch applies there and fixes it.

Honza, on the msdos report [2] you pointed at the filesystem, and msdos
now rejects such names (9d7ed813ee5f).  vfat cannot do the same without
making files that other systems wrote unreachable, and FUSE allows them
by design.

[2] https://lore.kernel.org/all/3kzvlb3wpzbg6k6ttzp6rh2cfmz3hmmmlisgxjn5u4xmaaqibm@qkre7flkhejl/

 fs/notify/fanotify/fanotify.c |  4 ++--
 fs/notify/fanotify/fanotify.h | 20 +++++++++++++-------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index a208a7ec1692..c8289aa8a70a 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -656,7 +656,7 @@ static struct fanotify_event *fanotify_alloc_name_event(struct inode *dir,
 		size += FANOTIFY_FH_HDR_LEN + dir2_fh_len;
 	if (child_fh_len)
 		size += FANOTIFY_FH_HDR_LEN + child_fh_len;
-	fne = kmalloc(size, gfp);
+	fne = kvmalloc(size, gfp);
 	if (!fne)
 		return NULL;
 
@@ -1050,7 +1050,7 @@ static void fanotify_free_fid_event(struct fanotify_event *event)
 
 static void fanotify_free_name_event(struct fanotify_event *event)
 {
-	kfree(FANOTIFY_NE(event));
+	kvfree(FANOTIFY_NE(event));
 }
 
 static void fanotify_free_error_event(struct fsnotify_group *group,
diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index 3710543dbf82..4aad60d2aaf5 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -43,9 +43,16 @@ struct fanotify_info {
 	u8 dir_fh_totlen;
 	u8 dir2_fh_totlen;
 	u8 file_fh_totlen;
-	u8 name_len;
-	u8 name2_len;
-	u8 pad[3];
+	u8 pad;
+	/*
+	 * Deliberately not limited to NAME_MAX: some filesystems return longer
+	 * names (vfat up to 255 UTF-16 characters, as Windows allows, which is
+	 * up to 765 bytes of UTF-8; FUSE up to PATH_MAX - 1), and readdir() and
+	 * inotify report them in full. Only names of PATH_MAX bytes or more,
+	 * which no path can refer to, are dropped.
+	 */
+	u16 name_len;
+	u16 name2_len;
 	unsigned char buf[];
 	/*
 	 * (struct fanotify_fh) dir_fh starts at buf[0]
@@ -168,7 +175,7 @@ static inline char *fanotify_info_name2(struct fanotify_info *info)
 static inline void fanotify_info_init(struct fanotify_info *info)
 {
 	BUILD_BUG_ON(FANOTIFY_FH_HDR_LEN + MAX_HANDLE_SZ > U8_MAX);
-	BUILD_BUG_ON(NAME_MAX > U8_MAX);
+	BUILD_BUG_ON(PATH_MAX > U16_MAX);
 
 	info->dir_fh_totlen = 0;
 	info->dir2_fh_totlen = 0;
@@ -214,8 +221,7 @@ static inline void fanotify_info_set_file_fh(struct fanotify_info *info,
 static inline void fanotify_info_copy_name(struct fanotify_info *info,
 					   const struct qstr *name)
 {
-	if (WARN_ON_ONCE(name->len > NAME_MAX) ||
-	    WARN_ON_ONCE(info->name2_len > 0))
+	if (name->len >= PATH_MAX || WARN_ON_ONCE(info->name2_len > 0))
 		return;
 
 	info->name_len = name->len;
@@ -225,7 +231,7 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
 static inline void fanotify_info_copy_name2(struct fanotify_info *info,
 					    const struct qstr *name)
 {
-	if (WARN_ON_ONCE(name->len > NAME_MAX))
+	if (name->len >= PATH_MAX)
 		return;
 
 	info->name2_len = name->len;

base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
-- 
2.55.0

