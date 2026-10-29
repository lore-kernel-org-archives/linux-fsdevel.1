Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793236176;
	b=I66od7cnIn0NBEIy4OjZIybd8zNmD1/GVR4MPpAvwBPRHghEExHxZepI8lb4nvf+2QUi
	 aV1a0odshaylCODy7fhobV+maD+7aLOg8GQu1wkUGNQlQjAxE2JNC5MSDsqbdQcAMmGGI
	 jkGCg/lyiEeKnrpYalG27zHW08P1gd4zGivR7hZ/PLaowRkxNvRnbiU0X65E4OF5yTPLl
	 yZS4+TtEs6wMNCqyrZidWhAAgVgAJUqVJ7XqFr9gyKpkaP8s+uMPw7QARjExMW00mwgPN
	 YKyxdfO4vU8y+amD/9NGa/dodo83nH09VQstxAOKSsULStVfPsTpvMhUxBeG7x0WFXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=alPdAPxXjGahIxU7CmNQ4/gL38O/jMfw9vL2Q530cHo=;
	b=Khwhor39RgYaGcy29RYqhC0hUit4vatS3Z0MCRaxZqGvtM2Gk24TRytoLcWTBBs7Yb2u
	 Mu2/pI0DkGWon/Ky7RbiFx3KYOHwD3UycAiDkg+3exAY7EKPUA88k3C0AON7yBPUfLrWE
	 LAiL0TsdoPMjwoIGiqtdCU7WLPb6vcfJA3f2WPDNPJIIWJX+8MnkSk3K1/rPTETcpz8xy
	 KoWZOJWOuFLFUQMWLmFkS5zWILLelkcLvzji8S9mMXklPoivITD5EJfIdwq9XXPExG4pU
	 LsWQKPwDU79TGtADSqPT0aFPc1DDFQH1T1mDcL/2Y0FxlUCijaD+ylKl42ZRvIENCbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Y27A7FIy;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC4E60A261C
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 01:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC4E60A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Y27A7FIy
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c8fef5ce2so5501166d6.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 18:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793236175; x=1793840975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alPdAPxXjGahIxU7CmNQ4/gL38O/jMfw9vL2Q530cHo=;
        b=Y27A7FIyYDf5cEkQ9M8S5uloGTZkzzsWAJoms/r1Ca6RIcF7zmyZsZwQK+c6ADM4XD
         3kCZH8mzhf74y9mMG5FSgKabdSasKeavKn9EnMbvOERWFjnKK18IREdeq9VVkxXSGMhC
         z178nemeAlyuw7pMOk+CIqtzoFRcfPu5EtN3VNu1tp7g+rPzrysv3BuYQGuSmOK/NQDT
         cd6XJfdQisyFbbYjhQ+hfimDWgoPmT8qcIYXHyl4TB3172xF9Vj9F5ijsoMp3RmUTHpF
         UwF8mNbi7RX1Av8iqdNw3gJJ4ii5hY27GvP9xlwvO4rt9+QrhLfhnNeJzTEgGF7pwHhC
         taCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236175; x=1793840975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alPdAPxXjGahIxU7CmNQ4/gL38O/jMfw9vL2Q530cHo=;
        b=EFHEzrs+lq2pj5FsqTM8qXXpf7hSSDPMTuO8wYKRM9de5Lgw0gVSTKj21qxy+hQ4OL
         g2ok9Zqu9uMJqJYFSJo1tP7N3HiN+x2S6tcCTa+39ByYrhSb2qp0AyqF2eonK/17Coa2
         Mur18Ixnwzis1FrY+0S7pmjjgr/sQWX5MlYuDHBe313fVc3C/q4E/uY1usEtMo3DGAbJ
         J7KuYJBx0m9YoJfKSSuNRzoW3dfRm1zjZDlY7dPt7Q6NzWjJpZv/2up6WzBmBNODVVmr
         BV/QMNh3bgThh3dRB2DjWc/Y/aLFvGvAA7tnttFJVYGyxA2XPLHPQBsITmYAv7tsnbAq
         q+Gw==
X-Forwarded-Encrypted: i=1; AKwUvBzD9sItPZl/21GuBrjbHx0vtzJay/KU8mPxq94+GEtvIiBMVjz85EfyLVv5q0PxUZ91pf9b67jYthglX3gA@vger.kernel.org
X-Gm-Message-State: AFq9FYIHZRC1mmIBPRbYzw8uO6wM8+nGwZX8T9eoZD7jtfk38ejIJwP5
	4HKt/Rj6aawWWTnMCeDzT/8CVaU69co8DeLBIqFBdfq7wdB1WreyuuHBWmo3WAVFNLM=
X-Gm-Gg: AYBFou1dpp8bWh8HrSmH1/TBfyyomNYzlo3vASktdTLXIysnGeEvUVF5cE8p5ZbLJse
	FV3RJtc5Pc5wxsrFyrkZhZI1PFurZD3uEka5UUo19OS/2U4qLYGTkSGhZ5fr/DDtYGaV8xQoE4F
	bLPRuOZwflxkct3r3SqfOQCnumAVixIuk+1ObIF3V6ir9QPcnSQCZ3oWn4B7+1SFcFNQyuw9sSX
	wY395jZ+QWjLei8SbOvf4hsc6iuICTw0WaoG9ice7jJPXEGEQrrNZ2Aqpp7c1RpAndn6tI7dgtU
	inYGo/VffLy7vSYTSPHNCa0DXG+MDDEHy3EJOr2hnbxc0YD8lfIGaQYjpTvTHtZ76cgyyTX63b6
	yv93whWljItwlJQT0YGVFdwLCiC0hQveME9zwK/u6rGoTooMqatETH/7ZIvBSjOz+FXFvdRhm/H
	BnufeX2oILh9P5Yurb3W93Oj0Xlz7xfTxynZQnpxet+tSNRpTrT1sazh5hMXFDS1S5nP9GV0z9h
	Reu0HvuzuftmuP841Yv8ecqA6hA/0sn8LA9po2+MKX4R2PpOeocLN+5c8glQ3S1yeorZrxl15rw
	E2PYfOw8t1g2jqhflqATeNPlLvZsHWwvj53T1k5zLc+/M/t+MlgXNfogvunv+ApRG8E=
X-Received: by 2002:a05:6214:1948:b0:91c:776d:ad6 with SMTP id 6a1803df08f44-91c7d1bef65mr68881276d6.35.1793236174969;
        Wed, 28 Oct 2026 18:09:34 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c54cbdsm145465936d6.26.2026.10.28.18.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:09:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 29 Oct 2026 01:09:17 +0000
Subject: [PATCH v2 03/10] ovl: mark the overlay inode dirty on modification
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-b4-ovl-containerized-sync-v2-3-4e9f08e4a052@toxicpanda.com>
References: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
In-Reply-To: <20261029-b4-ovl-containerized-sync-v2-0-4e9f08e4a052@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793236165; l=6348;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=vsMkfyL72EXpC6suYcXchhMOoYi+rLin9VKSUHZtqNc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLbBsd6fAEZF88xpS8Y3amu37VVEnbmtfzLQZK9yChq1bDLj90fJPYDFN1PKN0aiMXxC4GKG3qu
 naqg1TP8bfQQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

To sync only what was written through an overlay, we have to know which
upper inodes were modified through it.  Mark the overlay inode dirty when
its upper inode is modified, which puts it on the dirty list of the
overlay's bdi.

Nearly every modification ends in ovl_copyattr(), so do it there.  Copy up,
the data copy up of a metacopy inode, atime updates and shared writable
mappings do not, so they mark the inode themselves.

Do not mark an unhashed inode.  __mark_inode_dirty() would set its dirty
flags without queueing it, and every later call would return early.  The
inode of a lower hardlink is unhashed until ovl_inode_update() hashes it.

Based on work by Chengguang Xu.

Link: https://lore.kernel.org/r/20211122030038.1938875-1-cgxu519@mykernel.net
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/copy_up.c   |  5 +++++
 fs/overlayfs/file.c      |  7 ++++++-
 fs/overlayfs/inode.c     |  4 +++-
 fs/overlayfs/overlayfs.h | 20 ++++++++++++++++++++
 fs/overlayfs/util.c      | 14 +++++++++++++-
 5 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e963701b4c87..40486d2a4b30 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1122,6 +1122,11 @@ static int ovl_copy_up_meta_inode_data(struct ovl_copy_up_ctx *c)
 	ovl_clear_flag(OVL_HAS_DIGEST, d_inode(c->dentry));
 	ovl_clear_flag(OVL_VERIFIED_DIGEST, d_inode(c->dentry));
 	ovl_set_upperdata(d_inode(c->dentry));
+	/*
+	 * The data was written to the upper inode, and there may be no later
+	 * write that would mark the overlay inode dirty.
+	 */
+	ovl_mark_inode_dirty(d_inode(c->dentry));
 out_free:
 	kfree(capability);
 out:
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 7433220d4ad6..53c5131a0482 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -472,8 +472,13 @@ static int ovl_mmap(struct file *file, struct vm_area_struct *vma)
 		.cred = ovl_creds(file_inode(file)->i_sb),
 		.accessed = ovl_file_accessed,
 	};
+	int err;
 
-	return backing_file_mmap(of->realfile, vma, &ctx);
+	err = backing_file_mmap(of->realfile, vma, &ctx);
+	/* Stores through the mapping go straight to the upper inode */
+	if (!err && vma_is_shared_maywrite(vma))
+		ovl_mark_inode_dirty(file_inode(file));
+	return err;
 }
 
 static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 63906b3dafcb..9a4bf7c2502b 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -587,6 +587,7 @@ int ovl_update_time(struct inode *inode, enum fs_update_time type,
 			touch_atime(&upperpath);
 			inode_set_atime_to_ts(inode,
 					      inode_get_atime(d_inode(upperpath.dentry)));
+			ovl_mark_inode_dirty(inode);
 		}
 	}
 	return 0;
@@ -898,7 +899,8 @@ void ovl_inode_init(struct inode *inode, struct ovl_inode_params *oip,
 	oi->lowerdata_redirect = oip->lowerdata_redirect;
 
 	realinode = ovl_inode_real(inode);
-	ovl_copyattr(inode);
+	/* Nothing was changed, the inode is only being looked up */
+	__ovl_copyattr(inode);
 	ovl_copyflags(realinode, inode);
 	ovl_map_ino(inode, ino, fsid);
 }
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index aa6c2d005a40..101de0dd07d8 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -680,6 +680,25 @@ static inline bool ovl_tracks_dirty(struct ovl_fs *ofs)
 	return ovl_upper_mnt(ofs)->mnt_sb->s_bdi != &noop_backing_dev_info;
 }
 
+/*
+ * The upper inode was modified through this overlay.  Put the overlay inode on
+ * the dirty list of the overlay, where syncfs() and unmount find it.
+ *
+ * Do not look at the dirty flags of the upper inode here.  They are cleared
+ * when the writeback of the upper inode starts, not when it completes.
+ *
+ * Do not mark an inode that is not hashed.  __mark_inode_dirty() would set its
+ * dirty flags without putting it on a dirty list, and once the flags are set,
+ * later calls return early.  The overlay inode of a lower hardlink is unhashed
+ * until ovl_inode_update() hashes it, and ovl_inode_update() marks it after
+ * that.
+ */
+static inline void ovl_mark_inode_dirty(struct inode *inode)
+{
+	if (ovl_tracks_dirty(OVL_FS(inode->i_sb)) && !inode_unhashed(inode))
+		mark_inode_dirty(inode);
+}
+
 static inline bool ovl_should_sync_metadata(struct ovl_fs *ofs)
 {
 	return ofs->config.fsync_mode == OVL_FSYNC_STRICT;
@@ -877,6 +896,7 @@ bool ovl_lookup_trap_inode(struct super_block *sb, struct dentry *dir);
 struct inode *ovl_get_trap_inode(struct super_block *sb, struct dentry *dir);
 struct inode *ovl_get_inode(struct super_block *sb,
 			    struct ovl_inode_params *oip);
+void __ovl_copyattr(struct inode *to);
 void ovl_copyattr(struct inode *to);
 
 /* vfs fileattr flags read from overlay.protattr xattr to ovl inode */
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 521717209b2e..f32202500b3d 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -604,6 +604,8 @@ void ovl_inode_update(struct inode *inode, struct dentry *upperdentry)
 		inode->i_private = upperinode;
 		__insert_inode_hash(inode, (unsigned long) upperinode);
 	}
+	/* The copy up has written to the upper inode */
+	ovl_mark_inode_dirty(inode);
 }
 
 static void ovl_dir_version_inc(struct dentry *dentry, bool impurity)
@@ -1492,7 +1494,7 @@ int ovl_sync_status(struct ovl_fs *ofs)
  * map any lower or upper inode owned by id 1001 to id 1000. These mapping
  * helpers are nops when the relevant layer isn't idmapped.
  */
-void ovl_copyattr(struct inode *inode)
+void __ovl_copyattr(struct inode *inode)
 {
 	struct path realpath;
 	struct inode *realinode;
@@ -1516,3 +1518,13 @@ void ovl_copyattr(struct inode *inode)
 	i_size_write(inode, i_size_read(realinode));
 	spin_unlock(&inode->i_lock);
 }
+
+/*
+ * The attributes are copied because the real inode was modified through the
+ * overlay, so this is also where the overlay inode is marked dirty.
+ */
+void ovl_copyattr(struct inode *inode)
+{
+	__ovl_copyattr(inode);
+	ovl_mark_inode_dirty(inode);
+}

-- 
2.55.0

