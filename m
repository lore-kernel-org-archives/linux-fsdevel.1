Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE334A012A;
	Mon, 12 Oct 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819576; cv=none; b=qhgyj34yfW/KnqvOx75rp5oMo5LBRaxCrK4D1DFtkiv1QTkhGVI+KB92nXLs4adVkc6xeyZJNP5U0539AUYlJfmWcif6HZPMVxAbySl/LDbBpiO6/vFKX+LhjNIsOTduD47ad80DR5rHBAt+UQAf/6yT6j5er9xWMqvvlEfTRPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819576; c=relaxed/simple;
	bh=mc1VF7g+wjrq2ZdMkcPnTSysmFAUyTvd+w5KL6uTkW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVQXDn+n+0rhGKGqMZyTTLVrEl4i46hBX2k5JWipYAH6Ig0lS3Dhbfdmfdklx4roMFyndSQ2x+h0fmGh4WKADmkqaJ2DysThgd8WPZmYh7LA8RWZ36NpAauZ6p7svUiMDyL2vbqWqbFvasVjYHxISumoZchN4IRb8ilQ87ZTlzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQGxKlTi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQGxKlTi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11BC31F0089D;
	Mon, 12 Oct 2026 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819574;
	bh=EOrTlcvnTIC4mmAUCESwXwKwrbBRZ+T8tpjwIbL9K1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DQGxKlTiOXNF2sknBnpmpQoregdfaPQ6Oihjn3H43vOb3A1r9oAFMeJI65X3rqd2N
	 ldROD/Z7WAb4RZvk+UE61bNfpOOJQ4r9KSQFvK50wGKHowLgpVJjVNF6GqXBRfJL0D
	 NmCifSBVz/cgaKFRp76axJKnry/8kHUxIbS/Ciq6hqKoa9n2OlBjfCtu7EZ/J/AO4c
	 KB+2D5v9x+i3pwPI+M9VBLvWU43tZGR+eX7b1gXs8vDhFU3EDa01PrMm6DPYBhZk4y
	 tPlUvxz5Aez4VQtOfEvjimNjDoX0bHfg1T4niWQcRTzuneWxoHpor6NAK/vbX2zn6a
	 YIL8UN3fu36vQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:16 +0200
Subject: [PATCH 3/9] fs: drop the caller's umount(2) reference under
 mount_lock
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-3-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3248; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mc1VF7g+wjrq2ZdMkcPnTSysmFAUyTvd+w5KL6uTkW8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a+dscHbQkq2RNluYaKhTteEy6oGDNVsixODFv589
 SHldmBaRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETMuhj+x/puFV33YzfDsVcf
 5C+3sundKt74XZK7/sbv6xMjGv1+7mNkaNNj2DaPLdD3au9DwSzHNSsuV8473pAq53yNubPqS/d
 uBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The mount umount(2) was called on has at least two references after
umount_tree() has finished:

(1) the caller's path reference
(2) the mounts own reference

Currently path_umount() drops (1) after do_umount() has returned and
namespace_unlock() has already put (2). Instead, let do_umount() take
over the caller's reference and drop it under mount_lock right after
umount_tree(). In the common case this brings the count down to the
mount's own reference and namespace_unlock() can take advantage of that
in follow-up patches. If do_umount() fails the reference is dropped
after the locks as before.

While at it, convert do_umount() to guards.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index eacf181298d9..8c6673bd8c03 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1502,6 +1502,8 @@ static void mntput_no_expire(struct mount *mnt)
 	mntput_no_expire_slowpath(mnt);
 }
 
+DEFINE_FREE(mntput_no_expire, struct mount *, if (_T) mntput_no_expire(_T))
+
 void mntput(struct vfsmount *mnt)
 {
 	if (mnt) {
@@ -1935,8 +1937,10 @@ static int do_umount_root(struct super_block *sb)
 	return ret;
 }
 
+/* Unmount @mnt, dropping the reference the caller holds to it on every path. */
 static int do_umount(struct mount *mnt, int flags)
 {
+	struct mount *ref __free(mntput_no_expire) = mnt;
 	struct super_block *sb = mnt->mnt.mnt_sb;
 	int retval;
 
@@ -2003,37 +2007,36 @@ static int do_umount(struct mount *mnt, int flags)
 		return do_umount_root(sb);
 	}
 
-	namespace_lock();
-	lock_mount_hash();
+	guard(namespace_excl)();
+	guard(mount_writer)();
 
 	/* Repeat the earlier racy checks, now that we are holding the locks */
-	retval = -EINVAL;
 	if (!check_mnt(mnt))
-		goto out;
+		return -EINVAL;
 
 	if (mnt->mnt.mnt_flags & MNT_LOCKED)
-		goto out;
+		return -EINVAL;
 
 	if (!mnt_has_parent(mnt)) /* not the absolute root */
-		goto out;
+		return -EINVAL;
 
 	event++;
 	if (flags & MNT_DETACH) {
 		umount_tree(mnt, UMOUNT_PROPAGATE);
-		retval = 0;
 	} else {
 		smp_mb(); // paired with __legitimize_mnt()
 		shrink_submounts(mnt);
-		retval = -EBUSY;
-		if (!propagate_mount_busy(mnt, 2)) {
-			umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
-			retval = 0;
-		}
+		if (propagate_mount_busy(mnt, 2))
+			return -EBUSY;
+		umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);
 	}
-out:
-	unlock_mount_hash();
-	namespace_unlock();
-	return retval;
+	/*
+	 * By definition the caller's reference isn't the last
+	 * one, so drop it.
+	 */
+	mnt_dec_count(mnt);
+	retain_and_null_ptr(ref);
+	return 0;
 }
 
 /*
@@ -2117,12 +2120,12 @@ int path_umount(const struct path *path, int flags)
 	int ret;
 
 	ret = can_umount(path, flags);
-	if (!ret)
-		ret = do_umount(mnt, flags);
-
 	/* we mustn't call path_put() as that would clear mnt_expiry_mark */
 	dput(path->dentry);
-	mntput_no_expire(mnt);
+	if (ret)
+		mntput_no_expire(mnt);
+	else
+		ret = do_umount(mnt, flags);
 	return ret;
 }
 

-- 
2.53.0

