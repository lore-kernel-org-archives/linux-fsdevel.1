Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6A84963A6
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944511; cv=none; b=evuGtK42TuQBX2WDS7duysUh/tSLdwdAng+N7YQ8TtfAuQiOXfrnM2BuF7DzhyBoyPUsYRt0RSqAIVQSXDZRc0N0LLry5e/H53PVZSApe9LtXXPH6nredB9ybi615lt+Ib0vYvw/Nrzy87CZ4f2M9lEEwTl1lB9L8Qtvi3fRgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944511; c=relaxed/simple;
	bh=8FHBC5gbFeIC4E/lA238Bv5TaDRS4lUM54i1wq/3L1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q9VK8Bnfs5dW+RN+e80Qyv4M2SQ+h1+z+gkBHk+9fX6KTC7ApauBJlLolHrqnPwDuftMP7MVLXRMznCOUbsNrKzrYZa8a/eN+dBXletEJvq5xj6oRHd8CVfMHvolksmPj2ieZuogUZVamzx3XOt9vxUUBHpmoQM7TV82UWEZSi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=i21l73xr; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="i21l73xr"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8692be1cda4so95648b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1788944505; x=1789549305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=i21l73xrU1JcJWRHJZzhcaeSRm8nFycZx6beX8G1uwxlOwoojRkfTGCKbbWCPLP3SX
         m5x97TCh2sdiNd3dlrh2WjDHfeojBXrZh9FIBrGOUCCTTpUsh+RluCiWo3E4Wk+hwJEW
         BWq4DHpSXLT1SIja1wzaBTE4x65I74ev+ui+MCPfO8c7pbmDaSpKuiSMB8pEXQUrW7Gv
         ZAQ6BjAgJZuwqLjqwCS+KNvpf/9zUvJV8Kmx65qr4DmYOqz7PqtClI5wY5uz3IVKjEcJ
         93sYdyHLd4qbrnNdUZ8hPpSHAIHDSZ0aSizGxtJmfIWjZ52t/KAJO2wwqn9dk48ANlfg
         cdrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788944505; x=1789549305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zE9gpwYGcyFTdwIyA0S+65+Mdt3hWydj4aldKyaFgJI=;
        b=AytWMMdNRZUJvV/Y8dzdCSR3IOQ0NTz4a6nepsrFEFGQ3seP6RWy/f8dt7BGrLGDL1
         Lg054Xq95wG/YlJfiqBbVLTF1mthreSZsRXlvfVy7gQ+edLbAKsvtqZF/+eo6Lbx5YbA
         Men2cYxJy253NCOXOJt0v0fAyRfmlZvxZY2zwrkGcvyY5KadV+SNovcuO1nn7GDhiZ55
         soauamMFs7LJh/ju2aIOUIwSZqRGcyU78/CRzItwFxAuH3AI3Lxmu9jPQcqQx+1qEAiJ
         K0NXDyS0DfNXizDEfmecPU4/wwBflhRBoZuRcUmLjsdSNT25nG3wLcohy4shCVt4v0x7
         heiw==
X-Forwarded-Encrypted: i=1; AKwUvByuVSmhHAqgOmPgTqlcfWs1eZm8U3W1qJ6ToGSNxvbqhKAY6sNV27KvdveF7mGl4eB/UrPddZMPGlGjZ3vo@vger.kernel.org
X-Gm-Message-State: AFuF++nXwydPQxUhuoMFOs0aXAF/lszK7Aj1ldkiREeN+oXpIWnJEnil
	MnnVk+EqI1AJGZnpZvvAs5TBRh+XhIfgWNMm/E0qMTt9x5Zj2+yLz7yebDmGemUPMUU=
X-Gm-Gg: AYBFou1YtFYRcrmzH5mmlemhBvkgu7IIfOf7bMknzZSvN39DylrLz+gm2On3ADG7DKj
	AY/VoCO/Jqro4DmgzOHrqK0ESUQeNV2hFQ2J/BaQ8jHg9DyTD8z/Gv0kQsqStgmp1wUsQuIk0vY
	97lS8slFKmhd+7kVx5NVZyUM5kzZjkAVJWSpERKmm49tm8Pca7wyBcfP507BoCRHFCfWV+66ClO
	WXJSXJ8YgG6fMpR3CMnhS/DSZAtiofR463YCvm3Ni8xjINikdL8w0s8C1B9aUV1/zbJp8aV9I2i
	4FxpYY6nFLH1sGdsSc7WRArDWTfvAs6mZ0lcsNooVcA9uNxV3U5pxV4lIzZCXFsEJ8sQOhoqxVz
	cCDB6N9bxW+FzffYik+VYQi9WhMu02Cg2Tt+TVVSr8e7rnxm9HP84/ur0sic9/TW+X4UZix7CWs
	6PJ4259y/mS1xH9RgYXf/8huFwbquJczaJbogMZr7gLDAzZYCgb4Di9RJFuj+M3xaNedNdr07lx
	Qw=
X-Received: by 2002:a05:6a00:909a:b0:857:7317:cff1 with SMTP id d2e1a72fcca58-8616a168525mr51310976b3a.18.1788944504640;
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
Received: from localhost ([106.38.226.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-868d1e4ff97sm483493b3a.17.2026.09.09.02.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:01:44 -0700 (PDT)
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
Subject: [PATCH 7/7] landlock: use sb_for_each_inodes() when detaching a superblock
Date: Wed,  9 Sep 2026 17:01:12 +0800
Message-Id: <20260909090112.790006-8-sunjunchao@bytedance.com>
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

Convert hook_sb_delete() to sb_for_each_inodes() and release each
callback's inode reference outside s_inode_list_lock. This removes the
prev_inode reference used to preserve the walk position while retaining
the synchronization with release_inode() and the final wait for pending
inode releases.

Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
---
 security/landlock/fs.c | 150 +++++++++++++++++------------------------
 1 file changed, 60 insertions(+), 90 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 30aa6ce13590..3dcde8cbfb6a 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1369,110 +1369,80 @@ static void hook_inode_free_security_rcu(void *inode_security)
 
 /* Super-block hooks */
 
-/*
- * Release the inodes used in a security policy.
- *
- * Cf. fsnotify_unmount_inodes() and evict_inodes()
- */
-static void hook_sb_delete(struct super_block *const sb)
+static int hook_sb_delete_inode_iter_cb(struct inode *inode, void *data)
 {
-	struct inode *inode, *prev_inode = NULL;
+	struct landlock_object *object;
+	struct super_block *sb = inode->i_sb;
 
-	if (!landlock_initialized)
-		return;
+	if (!atomic_read(&inode->i_count)) {
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
 
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		struct landlock_object *object;
+	rcu_read_lock();
+	object = rcu_dereference(landlock_inode(inode)->object);
+	if (!object) {
+		rcu_read_unlock();
+		spin_unlock(&inode->i_lock);
+		return 0;
+	}
+	/* Keeps a reference to this inode until the next loop walk. */
+	__iget(inode);
+	spin_unlock(&inode->i_lock);
 
-		/* Only handles referenced inodes. */
-		if (!icount_read_once(inode))
-			continue;
+	/*
+	 * If there is no concurrent release_inode() ongoing, then we
+	 * are in charge of calling iput() on this inode, otherwise we
+	 * will just wait for it to finish.
+	 */
+	spin_lock(&object->lock);
+	if (object->underobj == inode) {
+		object->underobj = NULL;
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
 
 		/*
-		 * Protects against concurrent modification of inode (e.g.
-		 * from get_inode_object()).
+		 * Because object->underobj was not NULL,
+		 * release_inode() and get_inode_object() guarantee
+		 * that it is safe to reset
+		 * landlock_inode(inode)->object while it is not NULL.
+		 * It is therefore not necessary to lock inode->i_lock.
 		 */
-		spin_lock(&inode->i_lock);
+		rcu_assign_pointer(landlock_inode(inode)->object, NULL);
 		/*
-		 * Checks I_FREEING and I_WILL_FREE  to protect against a race
-		 * condition when release_inode() just called iput(), which
-		 * could lead to a NULL dereference of inode->security or a
-		 * second call to iput() for the same Landlock object.  Also
-		 * checks I_NEW because such inode cannot be tied to an object.
+		 * At this point, we own the ihold() reference that was
+		 * originally set up by get_inode_object() and the
+		 * __iget() reference that we just set in this loop
+		 * walk.  Therefore there are at least two references
+		 * on the inode.
 		 */
-		if (inode_state_read(inode) &
-		    (I_FREEING | I_WILL_FREE | I_NEW)) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
+		iput_not_last(inode);
+	} else {
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+	}
 
-		rcu_read_lock();
-		object = rcu_dereference(landlock_inode(inode)->object);
-		if (!object) {
-			rcu_read_unlock();
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		/* Keeps a reference to this inode until the next loop walk. */
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(inode);
+	spin_lock(&sb->s_inode_list_lock);
 
-		/*
-		 * If there is no concurrent release_inode() ongoing, then we
-		 * are in charge of calling iput() on this inode, otherwise we
-		 * will just wait for it to finish.
-		 */
-		spin_lock(&object->lock);
-		if (object->underobj == inode) {
-			object->underobj = NULL;
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
+	return 0;
+}
 
-			/*
-			 * Because object->underobj was not NULL,
-			 * release_inode() and get_inode_object() guarantee
-			 * that it is safe to reset
-			 * landlock_inode(inode)->object while it is not NULL.
-			 * It is therefore not necessary to lock inode->i_lock.
-			 */
-			rcu_assign_pointer(landlock_inode(inode)->object, NULL);
-			/*
-			 * At this point, we own the ihold() reference that was
-			 * originally set up by get_inode_object() and the
-			 * __iget() reference that we just set in this loop
-			 * walk.  Therefore there are at least two references
-			 * on the inode.
-			 */
-			iput_not_last(inode);
-		} else {
-			spin_unlock(&object->lock);
-			rcu_read_unlock();
-		}
+/*
+ * Release the inodes used in a security policy.
+ *
+ * Cf. fsnotify_unmount_inodes() and evict_inodes()
+ */
+static void hook_sb_delete(struct super_block *const sb)
+{
+	unsigned int flags = INODE_ITER_NORMAL;
 
-		if (prev_inode) {
-			/*
-			 * At this point, we still own the __iget() reference
-			 * that we just set in this loop walk.  Therefore we
-			 * can drop the list lock and know that the inode won't
-			 * disappear from under us until the next loop walk.
-			 */
-			spin_unlock(&sb->s_inode_list_lock);
-			/*
-			 * We can now actually put the inode reference from the
-			 * previous loop walk, which is not needed anymore.
-			 */
-			iput(prev_inode);
-			cond_resched();
-			spin_lock(&sb->s_inode_list_lock);
-		}
-		prev_inode = inode;
-	}
-	spin_unlock(&sb->s_inode_list_lock);
+	if (!landlock_initialized)
+		return;
+
+	sb_for_each_inodes(sb, flags, hook_sb_delete_inode_iter_cb, NULL);
 
-	/* Puts the inode reference from the last loop walk, if any. */
-	if (prev_inode)
-		iput(prev_inode);
 	/* Waits for pending iput() in release_inode(). */
 	wait_var_event(&landlock_superblock(sb)->inode_refs,
 		       !atomic_long_read(&landlock_superblock(sb)->inode_refs));
-- 
2.39.5

