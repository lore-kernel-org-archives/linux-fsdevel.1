Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91200363C6C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777050310; cv=none; b=ke3SxYaQHFvZto0ddOimB+Bi3DBATm9Orvio8jIWkhcwtAy82T+BdQCfGhUJ8VAAcMDXJLW3B7F0bCSaa/cYY6/QpM9mn8M4lz5lCqbHLGGAL5BOsme18kZeg3SmyZnY3Pg59pP1nKkK8VliAAwi1JyMOTyh6rrkFbQDmDf9tvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777050310; c=relaxed/simple;
	bh=c0UHyR8efpaF68TLYBKNO+AHCjcewOdWJQp2qnKd+vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuwgKKRUAsGCnESyQeyhR+TkA2ytQ/N3s0K5MAwgBYB9c35zn7p1OQ8pA9GkymuJVyB6bxu9Tpv8VM3kgq9Ohp9u0XwC+VzLWNKse5p7G9zMhWRvvoUcpzRagRi7cl19zjU0zVP7uMMIGlPlSNbBg8xbEf18vKcgCKQtyaX6Rtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXdzyFeQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXdzyFeQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so11218883a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 10:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777050307; x=1777655107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nM1ZJUZHjnzw+DrmUde+4f7rxToYL2Yn+5wRLvYYyrE=;
        b=BXdzyFeQJZec+u5GIdgCcjydcZWEz5sQGk010x6M4Z8ysN0C1tfrt9wLD2XX8vkKXU
         0CpbOXR6sodQwanek+29ho9wUPmqFxVRjuiVCDXES9Ke4pkAJam6gCv48zDhC5wLaQUg
         sxrBbmEoE5Z0LkVVAkl7oekUttDS3c64Poef5fp0xy/XVlfKVDy0ehbyoHYtAfzUspgb
         TELZAoVDzA84PMFTWOV9EhnkzC02LMQ79zTn7E/dXYAqOVmx2zx4vAfpvVru0EkPTEpn
         5uD4aWTlV5E2DxbC9L7pbP79QnvUVpJ+z796WNGxr/g4InuPbwLBredLhqam8Lc22sek
         5DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777050307; x=1777655107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nM1ZJUZHjnzw+DrmUde+4f7rxToYL2Yn+5wRLvYYyrE=;
        b=FV31sCqgK4TpXjw2lT8AX8XupzI5CQVIXaN1vU1oczbZURH1bIM05WDh+9oIl0Or4w
         GuoKqruNe8zMicg7K0xWdGPcayNerGP570VNswUOoegGnEj1DzpPI1Je4an5wRH7YC17
         qX8+YSuW9+zWfeApko5lK1Vpo01tS5LBp14SnMOBzFMEv6bLgFw7VFjZqtQvadmN2AkE
         lMt2POgKvqumpWyb1iwp+4U0sQvyRoRcN+HQ5pEXnF42kVM2JmnXOnAL3SkDo9SSqRIz
         rGDZjHbnCJGE2pSdkRJLzPFSqM8FFujIHqrAaPTL5hGeOMEy+rXshOCVWoiieIG388WW
         Mikw==
X-Forwarded-Encrypted: i=1; AFNElJ+scBq/sc7bq0VKFPOuSgcq46xNuEXkEm3eVv35h8EUuNvrU4dKq/WxUJYoXBoRER/SzXVJLo2ARzVvhqfm@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4nBYDy8zofs2r7uOkeKuy6oNhxx9a0bSuioxNlYh7bzmNL0pc
	fTYYcN755CAnPvUoywx+MnVew9dlgG3wv4Q3Mh1+7vj1Sj3dVox3ylBZNo1IT/3fGdU=
X-Gm-Gg: AeBDievCBy5nuZEMlolujvexZoNnNBHs6m09oKAX87nyaVuWgQBlsaaUC579ymdotld
	SDFf1W1tmJmI/DFECQOXMRvzbSgUox3u8pt5oiGC7qnGOEXldM7EnyWQRT2U3Nc7/CvBBlBKVYF
	8fO7eZmSnJMGLyhIS4exgQOxqE6Io4Cpd2k/Xi6ATC071cuVyKOiR2Pv/vP96dPXt0cI/uCeFJ1
	1qK7yJw4j81MlhQwtUnLM6ktdzSk/MgICl9eu0fczDL+7nHUlOwDEZLkvq/UJxpCliJGvzazc7W
	e5L271skWrFqjQJ6nweRW4fSHeJYvtloxM/QF6DWKGx2IgRANqq7hTkSCmE0RH8MO9fd+YVIjej
	3wysC3UnfcYpHwSSDY4xjHntmj8i3t6EK8OZK54dqOqjg2HndokHsbel1u02NqduuD1Msw3lt+m
	OOZKJsOje4KMCIDLsR/bEWca1JfU/kJeNK3xVngoIQvfsQIA79eZ7rDepokWQhFhm9jaAeQWaAT
	FW7dGcAiQ5gaHtcJxV0SAgPLl2J/Hc3ifw6KrA=
X-Received: by 2002:a17:907:97d4:b0:bad:5231:d5c with SMTP id a640c23a62f3a-bad52310d9fmr255298966b.47.1777050306500;
        Fri, 24 Apr 2026 10:05:06 -0700 (PDT)
Received: from localhost (2001-1c00-570d-ee00-4aab-734a-1928-df3f.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:4aab:734a:1928:df3f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451cdd2b8sm808965366b.25.2026.04.24.10.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 10:05:05 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 01/10] fsnotify: rename fsnotify group flag macros
Date: Fri, 24 Apr 2026 19:04:54 +0200
Message-ID: <20260424170503.2096847-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424170503.2096847-1-amir73il@gmail.com>
References: <20260424170503.2096847-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use more explicit FSNOTIFY_GROUP_FLAG_ prefix.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify_user.c | 2 +-
 fs/notify/group.c                  | 4 ++--
 fs/notify/inotify/inotify_user.c   | 2 +-
 fs/notify/mark.c                   | 2 +-
 include/linux/fsnotify_backend.h   | 4 ++--
 kernel/audit_fsnotify.c            | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index ae904451dfc09..49531a4fe71de 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1682,7 +1682,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 		f_flags |= O_NONBLOCK;
 
 	CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER);
+				     FSNOTIFY_GROUP_FLAG_USER);
 	/* fsnotify_alloc_group takes a ref.  Dropped in fanotify_release */
 	if (IS_ERR(group))
 		return PTR_ERR(group);
diff --git a/fs/notify/group.c b/fs/notify/group.c
index b56d1c1d9644a..cf445e270ba6a 100644
--- a/fs/notify/group.c
+++ b/fs/notify/group.c
@@ -145,8 +145,8 @@ static struct fsnotify_group *__fsnotify_alloc_group(
 struct fsnotify_group *fsnotify_alloc_group(const struct fsnotify_ops *ops,
 					    int flags)
 {
-	gfp_t gfp = (flags & FSNOTIFY_GROUP_USER) ? GFP_KERNEL_ACCOUNT :
-						    GFP_KERNEL;
+	gfp_t gfp = (flags & FSNOTIFY_GROUP_FLAG_USER) ?
+		    GFP_KERNEL_ACCOUNT : GFP_KERNEL;
 
 	return __fsnotify_alloc_group(ops, flags, gfp);
 }
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index ed37491c16189..3b59340284922 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -657,7 +657,7 @@ static struct fsnotify_group *inotify_new_group(unsigned int max_events)
 	struct inotify_event_info *oevent;
 
 	group = fsnotify_alloc_group(&inotify_fsnotify_ops,
-				     FSNOTIFY_GROUP_USER);
+				     FSNOTIFY_GROUP_FLAG_USER);
 	if (IS_ERR(group))
 		return group;
 
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index e256b420100dc..961475090f088 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -908,7 +908,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 
 		if ((lmark->group == mark->group) &&
 		    (lmark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) &&
-		    !(mark->group->flags & FSNOTIFY_GROUP_DUPS)) {
+		    !(mark->group->flags & FSNOTIFY_GROUP_FLAG_DUPS)) {
 			err = -EEXIST;
 			goto out_err;
 		}
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index e5cde39d6e85d..87524706792e7 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -232,8 +232,8 @@ struct fsnotify_group {
 	enum fsnotify_group_prio priority;	/* priority for sending events */
 	bool shutdown;		/* group is being shut down, don't queue more events */
 
-#define FSNOTIFY_GROUP_USER	0x01 /* user allocated group */
-#define FSNOTIFY_GROUP_DUPS	0x02 /* allow multiple marks per object */
+#define FSNOTIFY_GROUP_FLAG_USER	0x01 /* user allocated group */
+#define FSNOTIFY_GROUP_FLAG_DUPS	0x02 /* allow multiple marks per object */
 	int flags;
 	unsigned int owner_flags;	/* stored flags of mark_mutex owner */
 
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index 711454f9f7242..82216887a19b2 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -184,7 +184,7 @@ static const struct fsnotify_ops audit_mark_fsnotify_ops = {
 static int __init audit_fsnotify_init(void)
 {
 	audit_fsnotify_group = fsnotify_alloc_group(&audit_mark_fsnotify_ops,
-						    FSNOTIFY_GROUP_DUPS);
+						    FSNOTIFY_GROUP_FLAG_DUPS);
 	if (IS_ERR(audit_fsnotify_group)) {
 		audit_fsnotify_group = NULL;
 		audit_panic("cannot create audit fsnotify group");
-- 
2.54.0

