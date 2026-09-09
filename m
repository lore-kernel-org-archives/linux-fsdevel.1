Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB0495021
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944507; cv=none; b=ow+mR2tsBSo2+0AFekA8IluDvDlT7S527Zk54i7jaDxeDvB/WLVOFuDEbKDh6b9FiC5BC55c6Y74HvWGUnT3K3x8gVaN1OTLrlHhCwDjWb53epbDQ5W2Ypox0SXjt1+hlIAp024VRodivxTfOBJ2rOXeh3J93NGcD7PU3wG82AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944507; c=relaxed/simple;
	bh=HwU/ru9C3cqaYxeWB4WaVZIJTnLTox6zR3se4so5PpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWRNLXOuyyXsAG4wmpaTzIc0LHGWUzyYksFszK9a+YyK3aHoLlX+lt30po0U0xl2u5yl1TI3rqcoFlNnjRsRNkkjehMiX4BqbWToc8lushPIAEtUt96fOe+LeQVjCWZuHiTh0GleOMqBk3UXn08IjStu7tPnxgMQG78fWKgI270=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KL2027V9; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KL2027V9"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39266382df6so4590498a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944498; x=1789549298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=KL2027V9YOnRIa4PkvyslozEpZUCxcFH7DsIdWihAoKngcCiEE8maQwCxRfzGVnlTh
         BL7GwAmWBwfFsrrW1tF5NLs0JNoBrVmuyebQl4PbMMyhx7BZIzcALc1gcjrJZMXV58Ty
         JGawQespAdSlHTw7fheI7FU/pr0tGvGKNeeT0ExhR3c06793uYql87FhCADxfCX8r+sr
         ilRF8IgE0FRaT4mxX6q08tL4nLSKMeRbfCGvJ9+6vRhe0e7Lhj6VVq7DUhGclAmd7DmN
         jdy9lZQk0kaJzC65vn8KdGUrbdjRth1jvbbcrEXmbql6l9S+7R4ziGLtAM/Yh9izSZHG
         YmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944498; x=1789549298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fnw+bbx2n8GI1P1qJxz04Evujcp+PRs2H97tReO8VaY=;
        b=lqkiosnHvZvGH91MRvdJftfXN7tN5CEaY8sexSx5MRj/aSOb+OtCLL1RDpzH1+cVb6
         z+1bjc7ZLXQ2/vLugkeEcbGMrGjDeORHLW+fd+9ebRyMqcqXhf01C+Ys9jqtKNyl4N/S
         AmkNYWpMXrVA+ge41F8fu8vwawSru+7lL5qIG1lUCcoCt0fATGYfqiOIPwm2bhHEEdXh
         9nn6M/IoyMEB00WUZNXDINQjjTmEQ/lnIQUxlBUPTW7i2y2bFhslHhu0RNzgzwysFPj2
         B7tNmzRoaROM2Z0pqFfiS6HAQYq9dvTaw58w6rRhWQoAefE1M9y8xsgOeuPEcZPAZHON
         OEWQ==
X-Forwarded-Encrypted: i=1; AKwUvBxwRcc7teFr+13RwXNeQQg8VHjc8dq9RYq7kRkwZHrCff7bysE/mAyOWiQO8RlM22+O6o5KCDGE1myP1+01@vger.kernel.org
X-Gm-Message-State: AFuF++kQhNYnFlz1dIjGSFgis/WMtEpUFdasD8EQnUduyMj7tr5nsUTK
	Vw+ElrhwHLs/h9SBlEj3doYZzQQ7vqfW02AosDfE6AcieIQdWXCG0fsxkLAJPqnwrBs=
X-Gm-Gg: AYBFou3cDF0Rd0uHTnWOwL3b4/ZMGS4s/LB8UXn5CfoxYhQtxWC7P2ets1kM63ZL8oZ
	0wAv/4fb6TNxyJao7YqNvCwRc+2A6cC9x5keC+s/tRKoGoLNAc1a4LaPUakuVIfxnooG71IU1vV
	cfBc50sbIsBdWl7UvDkKzOSTaWBICFKGQdD2ssGDlj7D6xl21h8KDVEUPzyVH94I5nhN08frL3D
	U82/fIopeUa5uc6yx28eKM1po17pCH5tZW+0Bax+mRPUAYF8V8kjHgkR0L1B8JOTOV/hl3q0fTa
	hAJkTQ7vzEE6sb6vkSGar0fWMw1EyXtSenwruS0C5xp40Cd3zrNN1Dl1Q1j0hjhxy+iaMR31Ab6
	yWqfKslNoJ3qnvGHVH2BodGKKple9dDnsa3TcmqhLdsZendWzSP46mrwito5DVJMgYlFELlaeWU
	YUZnFiTct05mq9lWiFH/5Fg5Isyr2D6vo4I4fvljo/48SgTkRW8Jml03OkG8IuVcLxkrJqYfscm
	0//
X-Received: by 2002:a17:90b:1343:b0:398:d93a:b343 with SMTP id 98e67ed59e1d1-39b26123302mr60180972a91.3.1788944496615;
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
Received: from localhost ([106.38.226.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39bac3a2809sm4683088a91.10.2026.09.09.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:36 -0700 (PDT)
From: Julian Sun <sunjunchao@bytedance.com>
To: linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-security-module@vger.kernel.org
Cc: jack@suse.cz,
	agruenba@redhat.com,
	mic@digikod.net,
	gnoack@google.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	aleksa@amutable.com,
	legion@kernel.org,
	djwong@kernel.org,
	ebiggers@kernel.org,
	sandeen@redhat.com
Subject: [PATCH 5/7] gfs2: use sb_for_each_inodes() for cooperative eviction
Date: Wed,  9 Sep 2026 17:01:10 +0800
Message-Id: <20260909090112.790006-6-sunjunchao@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260909090112.790006-1-sunjunchao@bytedance.com>
References: <20260909090112.790006-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert gfs2_evict_inodes() to sb_for_each_inodes(). Take and drop the
inode reference within the callback, with iput() outside the list lock,
to retain cooperative eviction. The iterator preserves the walk position
and removes the need for toput_inode.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 fs/gfs2/ops_fstype.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 718e0da7dfce..acdbf9ca44a3 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -996,7 +996,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 		switch (token) {
 		case Opt_jid:
 			ret = match_int(&tmp[0], &option);
-			if (ret || option < 0) 
+			if (ret || option < 0)
 				goto hostdata_error;
 			if (test_and_clear_bit(SDF_NOJOURNALID, &sdp->sd_flags))
 				ls->ls_jid = option;
@@ -1719,6 +1719,19 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static int gfs2_evict_inode_iter_cb(struct inode *inode, void *unused)
+{
+	struct super_block *sb = inode->i_sb;
+
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
+
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
+	return 0;
+}
+
 /**
  * gfs2_evict_inodes - evict inodes cooperatively
  * @sb: the superblock
@@ -1741,31 +1754,10 @@ static int gfs2_meta_init_fs_context(struct fs_context *fc)
  */
 static void gfs2_evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *toput_inode = NULL;
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 
 	set_bit(SDF_EVICTING, &sdp->sd_flags);
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		if ((inode_state_read(inode) & (I_FREEING | I_WILL_FREE | I_NEW)) &&
-		    !need_resched()) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	sb_for_each_inodes(sb, INODE_ITER_NORMAL, gfs2_evict_inode_iter_cb, NULL);
 }
 
 static void gfs2_kill_sb(struct super_block *sb)
-- 
2.39.5

