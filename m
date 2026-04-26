Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F482820A9
	for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 04:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777176165; cv=none; b=czQFtgecSVN618ufaC8Or3oq29+yZxV7YjFa2O9+K0N87wAU0sa+g7HhqR2UfXEFPnwtchOVK2JcgWGgOvlbaO1BBoKXa43Q7VpkWhz3cdmgmQeuFdR1fuHAG4O+Q5WTIH9yAb4PSthJuPq6ifghPp50UjsIH0/MMVXEzTVUthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777176165; c=relaxed/simple;
	bh=sbgyC0F1QWWxsqlHMSvDUx3fIhaVIHxnzkP3GsRbJtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YD3eUM7Qa1AImGppTTCKBBkdMZSGXDixMZQ3zdKs8GKbmjXUwLn6XE4dOWshq6uKXe+1bOlmvEYuaNTGWU8Nn87rndA9r8Kt9JKDTI+RCqeTUAnR2a9zFkvuY6w6hqfiZXiITaTsl4uGU/sXawm+30+C9reScsvmUnBeP5sFutw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUFMMIiy; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUFMMIiy"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b95a78a11dso655495ad.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 21:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777176163; x=1777780963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozsUMKbqTO/Xk5E69vfQ7nhFZDCs1d2jRIQqTzB9tKU=;
        b=WUFMMIiyXyKI9wQgnAXw9ooFu/3F6XHH2x9tzWu97ISKWoXU2bZ7NYPWJxYq1Ott/Q
         L3hx6DaAK1EE8HRLwth+pcaNRYomEobV3/+x3xf6EytuQPQuRc0y86Eu7iL8hK3ed6t6
         Z0Be4QaY5KEe51iIJNL8cXBwWbQk5EpHp7ERj7zUgWjH0aUggUF9QmCw3pUZkYNqfTi+
         xWNH4zlgVu0E1EbjeAIdV8P1IZL6YyOOHPgIfYwHHHgBgJeFQ8NgmQ3MqmvFCosYAj5K
         nilWfwgx+z/We/Ugm8OJt6pzdCySE1r9wTj6tfBVUFv2BRs7YoVRQam4iktSnpsBz7kz
         Imkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777176163; x=1777780963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ozsUMKbqTO/Xk5E69vfQ7nhFZDCs1d2jRIQqTzB9tKU=;
        b=gsw6BQFx6YQtJjbjZn6pxSRISGxnA4zb6Nn1NtVLG0MnUYAJoJMFzR8lW612AXzUXr
         AVQUr6ZK+rrLg3UeTLtNJPEtoN6xsTmXzmBt2YNHrSDbTJZ9veZdOQyGI3vBNnaQUsea
         ULZssGqre1DcURg6YPA5yC7AE1WJD+dRtadDP3Xjy7mBUlusPQbkoshLYaS5N/IwWAdm
         TrowHqErdZ9aA9s+92FEsgWcGx3y8LIOp4xrwlJ8iUjZvjX4kKIMBBPDJGe2XInE++ec
         XYZXYS2nSIGd9LWCqR85cxtBO0OpWmfFq6REtE9xEaqCzu/dnt4lnlLwp6z7sD/vMzB6
         cKMA==
X-Gm-Message-State: AOJu0YyJf9pBgUJ7WZj0kqOAYV9mn+c4sm8B7qSeIhzx9txEl4TdhiDp
	7kqWa0A18qLTrk7cmV0sHjz50jF+qV+z0V9PbjgLbByi5wcL8jxArci5
X-Gm-Gg: AeBDietg+cL5Jp78XRAEhi5i1ZFNHLaoyLpuvB7l+XUbdoTYGOo4wvru3Rb76ZTOj8D
	NkVYuWi4FyuxMCRaFjythqYnwSyOhxTklu+TtWSsH5W3BA08+xjVxaAunEsULJQbQv5P+nwwj9J
	0SnefkpVFjoEK7DFRSyahUxZROZM3Qu14q4CAmq3rXfAp93hlBu38Ur5CCBU02nQmXDnp5GwUYA
	vizWFVLpfmRjro3uxTFxAqO6q9nFevq8UdF4Ori1SGrHtYbJ0hpI5jhu49K6mxBekrfP61OdEBS
	O67FaBTrT1KbZtm/5tuyS7+2XgoWhYlTkTXF00vi0yKrZGf2ixtzgaHRRnlYR1/fmGL7iHgUzj7
	/+t4wR7ue4DbtkwD2MQucoGetA7ClPZDsudG4NUHGgZmK99Bc6qaunH/zdVViFIl2+dvzPO48nP
	5UjqIKmmOYfuDevJWcinXhVn/vlpI=
X-Received: by 2002:a17:902:8d82:b0:2b0:606b:6fc5 with SMTP id d9443c01a7336-2b5f9f7bc6emr145486155ad.3.1777176163267;
        Sat, 25 Apr 2026 21:02:43 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0c17esm265149125ad.41.2026.04.25.21.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 21:02:42 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH v2 2/2] ntfs: fix WSL symlink target leak on reparse failure
Date: Sun, 26 Apr 2026 13:02:32 +0900
Message-ID: <e59d3bc4a15adbf6c227a0c62f81362aac8be383.1777175371.git.charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1777175371.git.charsyam@gmail.com>
References: <cover.1777175371.git.charsyam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntfs_reparse_set_wsl_symlink() converts the symlink target into an
allocated NLS string and transfers ownership to ni->target only after
ntfs_set_ntfs_reparse_data() succeeds. If setting the reparse data fails,
the converted target is left unreferenced and leaks.

Free the converted target on the reparse update failure path. Use kfree()
for the other local failure path as well, matching the ntfs_ucstonls()
allocation contract.

Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
Signed-off-by: DaeMyung Kang <charsyam@gmail.com>
---
 fs/ntfs/reparse.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs/reparse.c b/fs/ntfs/reparse.c
index 8f60ec6f66c1..74713716813f 100644
--- a/fs/ntfs/reparse.c
+++ b/fs/ntfs/reparse.c
@@ -505,7 +505,6 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 	struct reparse_point *reparse;
 	struct wsl_link_reparse_data *data;
 
-	utarget = (char *)NULL;
 	len = ntfs_ucstonls(ni->vol, target, target_len, &utarget, 0);
 	if (len <= 0)
 		return -EINVAL;
@@ -514,7 +513,7 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 	reparse = kvzalloc(reparse_len, GFP_NOFS);
 	if (!reparse) {
 		err = -ENOMEM;
-		kvfree(utarget);
+		kfree(utarget);
 	} else {
 		data = (struct wsl_link_reparse_data *)reparse->reparse_data;
 		reparse->reparse_tag = IO_REPARSE_TAG_LX_SYMLINK;
@@ -528,6 +527,8 @@ int ntfs_reparse_set_wsl_symlink(struct ntfs_inode *ni,
 		kvfree(reparse);
 		if (!err)
 			ni->target = utarget;
+		else
+			kfree(utarget);
 	}
 	return err;
 }
-- 
2.43.0

