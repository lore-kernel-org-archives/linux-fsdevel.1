Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972226;
	b=mMvonAj2XMp//5JtxIhEEbX7m1PJbUahKEtFjidEIev24UxPHeLrEIwyg16B99ItDl6W
	 LN/NOsZqQzIm24M4x6jQiD/PWoxQqbz194S2wTCvYJobqsjKGhtIv8P05KzTYeHIztKdH
	 0PUJvEFb5qvplzeryRtoSR0vqoKpJkivuiDzM0Ievb2UxdJYD4FLyOjCjD/CshBnS8LB8
	 buDQBbNVyOs4XtIofgP05ppJTTAuICjA759tehMPFoPuS0oRzbP5PAXIOUu4/FMAT9rqn
	 ghh5yMYRxfe2P7eMML6jIOh9HPWmNAqzTZ7SIwbpvu+RkKtaj1f6SDZ/cTfYm52uyHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=e50fdLujD19GXFsNWyHjjIS2DU+IkUb9BQTJ0ZpFODI=;
	b=Vn1p7kBPbqBmYFBq8eoCF4mXfMcnk7eZlAqZ4Vnq3h5lddv2NYLtPk7GsrpeNx17GCX3
	 8A5iBWi3/dZSBup79TDBInxWfNwGRogxxPD9t0PauAgC9nlRZlenKbb5d0xq9Tr58JzPv
	 mtNP1uy7/UPfmqOjCz0Qw/oSBTchQcZJydZuoU5ib3V4fvJmbZNsIHuuebk5sQt4igEJ9
	 w05zkIV1ZrSqoPY0kAe3IQhm8R1pen8FkyGCxBM4kW7yNsxrhHG8Psd1Y2MZeLNot+4OY
	 y3kwB2DRTbQGo8LiTFRx5gBqqQwjyhVrIrDWXz8wY0lQV8knrtsfIKjmZ9JVsStyJcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eiK+teLW;
	arc=none smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E856C606A332
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Nov 2026 13:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E856C606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=eiK+teLW
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-536717a4d83so4811501cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Nov 2026 05:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793972225; x=1794577025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e50fdLujD19GXFsNWyHjjIS2DU+IkUb9BQTJ0ZpFODI=;
        b=eiK+teLW5U077y8fZowXrErpg3IOeqOdtbFsavI+Xq9f2dZZuoZstcoyUwh1TwtA7b
         aLfgkuNBSimCLrAFos+JTCHCXIFHolSRaqDFLZFl8kWyRaunoYDfbmOvEv1fWd+EeG3c
         YwJuTBKR8v+V9MDzEXXDw6tsGffdk6AjF6Fi8z+m3l4Q18gGNRflYmIAZuc6cSqQqrrY
         yYglR6MQ59b5+/SJp9V6pyRMCB16zOuQkJgCqjjRe3HeSOAB0JFJN330syaL11syO+kE
         j/UUI95BiFoH9Z75LbmZPNSdAZfZqA/ChynismTTa2Dhie+HD6ktUw5nlz73gPlz8py8
         jY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972225; x=1794577025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e50fdLujD19GXFsNWyHjjIS2DU+IkUb9BQTJ0ZpFODI=;
        b=Wbd84c1f+XaWDmG/EGm0k4w7CjK7tyjEAUMOFGryNmV1ch9eBwxSVGua8/Sh65JCOW
         czwRX/IWqNNRROQus1iLwX1kL15PAe4LzZW3CjNyLeOKKFWvDhkh49AT3UsNWSJpUXV+
         rashX5mVM4+WNo8dSmjoW7pbloanmhDHQcOy+MvyoP9luyqlGkhQZ7ss7iWEwenDdnmN
         IXQVkttjnXdD3BSfhSxMwW84WO7ch6LrOCrhRKvi6Ji5XjnsEaWgpF5VPSRV3kecP/K9
         LQMOwmcWHcbZT/n6Grrz9zGaOxwfksozP5DoDgqpXdHAGj8NQofZq7SuDTP1wkejkkv9
         ITEQ==
X-Forwarded-Encrypted: i=1; AKwUvBznNCyE3ynSdpnxmpLc2cVFqelOvsr/vlmHcI4Z6rCaXG5/yY2gDj8c9HbEzwhOxK35QMqYqtc0DnKEkL09@vger.kernel.org
X-Gm-Message-State: APuU4Z91YDZf5RFlTt69SJ6aUiRYRcE7yn08ckAWaYKg5NqPfhlF5sJG
	CJ+quRJfkelf79/kPS4Zo9i2U16g3/yKKOGY2uPuCThj/uoCAkyhrr3i/FbJzoW7JHkKooP0Pqm
	EB277gdvhxw==
X-Gm-Gg: AYBFou0qEOAzqcDNLiAl7kI5idWSxpoAJkKsrIPTxA1/GwpaDg+ZqLhJUImvT4c1Ahw
	D8/9qzy2v8yiCo5jgjTnH/kNtv+raLaWNnWzRjCJzVr72LpU/VnnbnYOKiMDudQPZaNA3hz1nkD
	lqWaCaJzdCiEJNrRSBCwIJPPzerr/qrAyGSh178XfISdaWdZ63P7zIkN4A0a+7+1Osxfa2VVYXH
	LguArubvdl6prXMhQ47ceuFbtK/DKekFanIImvLs2QW87e8y2HuogeqZgVa9RIpn3MN3OSM0lov
	myPLMq9/oLxWJ4RDKKjLRNdTlqJJhgciqF9W1ZJj0SOqZVolh08ACzCAofo59Y4zEJTgotrBh/q
	hYEUnVpHHApSKyB9OAhjhiFcMDv4wpFWJrh1NQatAlhq8I64A6470j5TIu589L+HJypJKd+MT4C
	I4LIg5Ciy1TJNoroJrBqSVcZOsAJjivvmlVhW9+/dtjIFQ5v5fWEQ6vJylyTJBOeL/CurvegqLA
	Np7N1yKpXSai/nsRMfeKBsYJ0U7fy9lHZx5XtZolAsWliw4j7ASH4E4LcN2Ohg3BUCYkFO8Q6mO
	CpfGO+D9X7fifE2tvsuLwPS4/EpGyMGFJfmsFgMwNt8tMQ==
X-Received: by 2002:a05:622a:5c1a:b0:536:5e62:4647 with SMTP id d75a77b69052e-54e13098132mr42234321cf.16.1793972224813;
        Fri, 06 Nov 2026 05:37:04 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e270179f0sm20539301cf.26.2026.11.06.05.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 05:37:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 06 Nov 2026 13:36:46 +0000
Subject: [PATCH v4 4/8] ovl: mark the overlay inode dirty on modification
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
Message-Id: <20261106-b4-ovl-containerized-sync-v4-4-6ddde0b7dd8a@toxicpanda.com>
References: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
In-Reply-To: <20261106-b4-ovl-containerized-sync-v4-0-6ddde0b7dd8a@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793972217; l=6376;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=TU06+rREPT1daQiI8+LqLuaKoTaGv9ykYfd+dewLeWw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPJMikO87ALC9liebhoY3ZY7b+zm/iAQdQ2PXnZhu0U66qRi7laEa/opwe4eWk91UL1bM2yNvCN
 I3ceFKkfZkgM=
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
index 5b1a097ce543..5a1479863a6f 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -691,6 +691,25 @@ static inline bool ovl_should_sync_upper_fs(struct ovl_fs *ofs)
 	return ovl_should_sync(ofs) && !ovl_tracks_dirty(ofs);
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
 /*
  * To avoid regressions in existing setups with overlay lower offline changes,
  * we allow lower changes only if none of the new features are used.
@@ -878,6 +897,7 @@ bool ovl_lookup_trap_inode(struct super_block *sb, struct dentry *dir);
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

