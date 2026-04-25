Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298E637CD3A
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 18:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777142575; cv=none; b=SyEt0lV8QNMeQ/agw/UHxTD8mMC6UOB8LvVvxXn22ktV07r2LrVwYKT1ixBdc7kFdKvgaZsz+qF2XVVaGvsYvSpre8RI19kyFzbP8H5fDzApJwRXsEFB4hoATcQzDhNL9oRltWCfi3emXU/xMeMg8fB6fdP/MtPIPzcUJk8G19Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777142575; c=relaxed/simple;
	bh=sbgyC0F1QWWxsqlHMSvDUx3fIhaVIHxnzkP3GsRbJtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7zj3+93/AC50MSwuDEjmLYnrxGDjRui6pWiNwcp6QT+U4m7ursnXrWDf2tcjvpL7RyVbEbAUUL45giBFDyW0580aOQKeLA8INOjCPfvAOUPDqJ4zsZZMUSyWCBb9jjHZNSH22sXCbJJ/9HlvdqCqlaCXw/h3IxAvc/8FK62OkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mg3SoQKp; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mg3SoQKp"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae1255a90bso6770525ad.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 25 Apr 2026 11:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777142573; x=1777747373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozsUMKbqTO/Xk5E69vfQ7nhFZDCs1d2jRIQqTzB9tKU=;
        b=Mg3SoQKp3Zya2ZB9/NL/Vdf/F2LXWV35L0/g4BV+Vv1tX1B5nQa48JJYlT09idTZeH
         PKgJzzK8WdfFOy+valuQt0IbyRRBBI51Sz344zykfwZTAbA8P4n0tDAtyCiAWODfr9xO
         GjAsS/5NzXIUXZqSzFNVOeFFJJART8ss6iK5RdnWuD5pHiu4pcBkXbx3IOQdyBbZGmHN
         0wIyBIIJ1HQsOJJrw0ymxTtHyycwxwqzuCh8DnHLqhE2WQP69L6R2iptvVXGGBiB49kU
         wPEEC235TCkZp27Sgh6GHDUdrqn1GCA4Z71g+vhIRe9j47PmWBnMRof5WbFGe7oZ+TQA
         CpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777142573; x=1777747373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ozsUMKbqTO/Xk5E69vfQ7nhFZDCs1d2jRIQqTzB9tKU=;
        b=EYsM3EmDWmraCH6GJReIkdCNXLBPK5F4a3WqklZV8L5hkHejUV/e1uk+GbCKXnsWnT
         TxreqK3v3wKf7zhp9n9rQog6Anpma3QWqNiCEiTIuNVKFmmr3Kr72AUqA3N6ae5V8QTl
         5JTgmKLK04S6uo7/BZrZLI/3BEYUXPN7cpN+36YhJqoCJBFp7FARIR+ilOUZj7EtiQDM
         pxt4oZm22mld5wORCBFvGiJ+APgfCX5PqhGDPV9K+S6G0gBaoMB+NTY58A3+v/HKmN36
         Dk7TWMY9Nepz56PtflAHS+du19HJV+1uOnf08JYhtVCTQzANk5bbcuOU2IdIlA+A54is
         mj/Q==
X-Gm-Message-State: AOJu0YzvQlbYFXh1G9wzRyEWVMoqMIhWQm/FrBu6J8elfLNbAt/7Fmet
	KE/tgpaKAE7VxNJ2U4uBYQF9IGVH+HsIyJ8VKehfRUPAaueFflAHq8Ce
X-Gm-Gg: AeBDievtloViwBc6Gy4DoI4EM/dBq0rElxXkeABowNEa4QrQKkQ2he97Lg55JxS3X/+
	t/v7Js4n0fhPHJXHKcClomACbBY31oJ27mnyTYUIJsmsPcVkgoIa4QGHVE2xN4l5qZkv9s1ILL5
	dURIBPqKYe56BjfTVOMblBoHJDL7in7xU0gQsVfEtregPjXEbxvQ7R5i1dnqEXm8wu2iKJE8Y0X
	voh/w9qZhdCMWjNNMEkdTfpXroqgFZho1P1kINAVVTEad+xHByQfIPqSdYK4obNf3Zb4PwnrjK1
	PCYCEO+zJrry+U8uwPcGm8GO4vZEJXuv7I6Zs9ipD+vHHQ4HdRnBKX+mSO/ffoUNuM5L72RF309
	ZqcX7eM/D+iE5jm1felzaDAalE+nLSEhayknmQbVnSOqQVWmF5Wh/K6XZTtejhu4JKPz5tiUDuo
	2y1t8wNHH6ZdSgePqFd6ne7oYE86w=
X-Received: by 2002:a05:6a21:7001:b0:3a3:1814:20a2 with SMTP id adf61e73a8af0-3a3181421d7mr8896061637.5.1777142573521;
        Sat, 25 Apr 2026 11:42:53 -0700 (PDT)
Received: from ser8.. ([221.156.231.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebba485sm33975874b3a.38.2026.04.25.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:42:53 -0700 (PDT)
From: DaeMyung Kang <charsyam@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	DaeMyung Kang <charsyam@gmail.com>
Subject: [PATCH 2/2] ntfs: fix WSL symlink target leak on reparse failure
Date: Sun, 26 Apr 2026 03:42:43 +0900
Message-ID: <20260425184243.116396-3-charsyam@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260425184243.116396-1-charsyam@gmail.com>
References: <20260425184243.116396-1-charsyam@gmail.com>
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

