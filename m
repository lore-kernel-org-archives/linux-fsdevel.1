Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601244;
	b=H2OLhpQ3GUnotrJfHMv2BsEntjanwbP/Rfu8iMacvN4dbe3597nn+F4KnMkL3zBq8QhJ
	 qU08ovNU5A1WA/6CKuEKYDkXhhnvLuzbgVUH/v7Fr5W4gc24RCrNrKS3jV9eaKrm1qWrq
	 WIJOtl/ha4m4MPp1c4FOM3gGZocLlfl2pCPt+2cstooeRSRT00NIafP/jP9I+O/yu+pvu
	 quErlNVRCBL/0PSjWadytJ8WXJ6PIeLeaMACu4+PjngIdfX717gsb+6kTvWJXMdHqJOEo
	 1mzyPPzWOhA4pm4WbaKOckRhZVYpvTODxnNOLDcpOverfggW+pxzcoxvGofywZ/aABA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zFBriUSj9bytcNqXsJKDPqvc2LC0Mk+ZZy+OgWQQbzs=;
	b=0W5hQJJek9polrx0VneanNeGYcIrx62xN7X1rcGEWmFCqgjYErG5k/NMsirzwgEQ0du6
	 FTeOu3Q3z8g22MICT0JGyJpuF+EDSxzcjna9901thxGbUj0WOKkiszPvEZBBoYXZkRdIg
	 tIY2aZPD0nRF0GqqRKZkdrowGJqHLHYp9xp7FNmdJ0WDoLxouFX2ScI9C2NmfPL0o3sAj
	 g/+JbRJDrJ5MnwKrAVBVBZLjUETyKqWMJn7Cw1A3AV1Mkw9xMQfm0gkdLNKQIz/qwcRwC
	 DroJqV5J0W2ET4FoxP/Hm82He5DbZdqFVf536rfIGth0gB//TVrO3k30k0x/2UbK0oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=aHs6VCx4;
	arc=none smtp.remote-ip=209.85.222.182
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A142C606A31D
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 16:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A142C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=aHs6VCx4
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f20b304c0so107099185a.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792601242; x=1793206042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zFBriUSj9bytcNqXsJKDPqvc2LC0Mk+ZZy+OgWQQbzs=;
        b=aHs6VCx4/D1CrwXv9YuCgzl1EKrTdhoAHn2kKKyNDMogiNXGXxhXk4rKQScS++NU0D
         u05nXlhZOI0zRR8ZhOkGyk7qERZkoKVKgH3XhBxiRKfdxprVmgXBk7/el3Ns/ZVZ+E1c
         M8Tv8MmxIfwqnyK0a31DkupsGm9YsQepI3RDi+HIsdS4Xasx+zquMF2sZGHC2uSkkxfs
         wLL5+t2M6gggzABXxzQs2uXmK6Lj3IVHu0PBTspLAT3Lwt9akv7tt4FXn0DiKKHqJYjL
         ymf+p0rhJLzont7GYEvovEQGtP5iXleHUGUurAXmLWHBcmPVkreJIAEj7Wiy2g3n731r
         ix7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601242; x=1793206042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zFBriUSj9bytcNqXsJKDPqvc2LC0Mk+ZZy+OgWQQbzs=;
        b=BHknIrA7OcCD1ACcczuXoPT5HX+i6SHNrYfZriWuBI5Kg6Um9Z5ikOtWazPOBW97dh
         xlbVBWARNYDVYGcW90J7r7Cu+OcoHpZCZ8DRCe30dVxESRr60TwI46UvDq96vc0758J/
         lU5wMcQ0JfyE23NMEXbqiLaDfyzA9i2jimzdlGX+rXslUS3jipOvT9p2cs+kw/waXmQ9
         o0eYcDUfI2u3lNxRWbyrkfcozqMn/qvpo78Z4GCTMRl3dFeMBMl/qkajMGFjhtccsmsR
         /Kdyf8pQdEN6EgqMYT/5wDPNlFG0uISNl9ecS/4oustNiaOBgsG1qHdKZc93KzgHiIg9
         PDHA==
X-Gm-Message-State: AFq9FYJjDpI/5gaEFB9AepkUr2Sq24ZJdbdwKkddIIkiUmcack/7E8OM
	LN8NmrAIEwQRRuhom1Vfw7SvO88hI/XXPxLMxw8/d2mtFdMHNwOOHQNI9CS5PR63oK4=
X-Gm-Gg: AYBFou23cdxf9uXqy1fjKcAeRgDMduVOmR3vLvNu9iMl3bdyty8l5zNPjxaqA5xaJib
	eRy5ch/if3VmIhRcdaBwJ4nneJ2IXJU7XuagIJhV3jZYhMgwLS22Y/xw39BcmRSZeNasGa7qots
	Vezzt80WpLwUb1MLD7Z82s7z9aiJAOVcB2ja5hyZVkxNCG6aBe3NvoLqzhfQFoovlhlqtLKIb5g
	qpI7GCuu0zNuSMWnG1GeEm/J3jg0/QSFDcFpIodJv4k34XLGwHV/RW6lue4lyV+rKOZPrsAro1o
	VTMwHZLNc2VroPDmQTL3ppOkN664+4z36PldHQgO3Xl2fghAYn+3q9cRjFUF6BTqsGH5G+2sC2y
	mNetK3VE4PzhKeyhhZsKUk7FNNzZmDCXATeiMA43kZ30kgbQcVPiASnJHi9I10aphHYPnXgJYwP
	ZxmNXbw6FnLC3MQDE+fChgDqLZEinT6x4PuTe0481f4yU1FhLKhQXlc3yrpkos9zVlolneGuLPj
	l2e4q24xstvhddK98T/nNHhaSeM228iJBNu5dipsu7ukPEH/j4uLVGL8arAglo7lhUwUh+y
X-Received: by 2002:a05:620a:839b:b0:93e:71b8:584b with SMTP id af79cd13be357-93f57f1bebbmr523838185a.34.1792601242445;
        Wed, 21 Oct 2026 09:47:22 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f56c70057sm296429385a.5.2026.10.21.09.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:47:20 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 16:46:57 +0000
Subject: [PATCH 1/5] fs: make a mount waiting on another mount killable
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
Message-Id: <20261021-b4-super-lock-unborn-v1-1-0265eddb6dee@toxicpanda.com>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792601235; l=7064;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=oem0YxBi5Eqp9PUi52iiFFznMlUh5YRAVDQEB/+TxY4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMkuwwamzhYpn8RQ+vOMsZ5agAs1ZX9jNKXTypdi+WoDT2A5/3+QK/viTg/6jJzLh/Y2XdlhOih
 U/hT5+Oykqg8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A superblock is put on the lists by sget_fc() and becomes usable when
vfs_get_tree() sets SB_BORN, after the filesystem has read what it needs
from its device or its server.  If that doesn't answer, this takes forever.

Somebody else mounting the same thing finds that superblock in sget_fc()
and waits in grab_super() for it to be born, to share it, or to die, to
make its own.  It has to.  But it does so in super_lock(), which can't be
killed, so one stuck mount collects every later attempt.

mount(2) and fsconfig(2) can fail at this point, as they already do when
they are killed while waiting for a superblock to die.

Add super_lock_killable(), in which both the wait for SB_BORN and taking
s_umount can be killed, and use it in grab_super().  It tells a superblock
which is going away from a wait which was cut short, so it returns an int:
0 with the lock held, -ENOENT, or the error from the wait.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 114 ++++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 32 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 36fdf88ef88e..7164c92fe70e 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -62,6 +62,13 @@ static inline void __super_lock(struct super_block *sb, bool excl)
 		down_read(&sb->s_umount);
 }
 
+static inline int __super_lock_killable(struct super_block *sb, bool excl)
+{
+	if (excl)
+		return down_write_killable(&sb->s_umount);
+	return down_read_killable(&sb->s_umount);
+}
+
 static inline void super_unlock(struct super_block *sb, bool excl)
 {
 	if (excl)
@@ -94,28 +101,14 @@ static bool super_flags(const struct super_block *sb, unsigned int flags)
 	return smp_load_acquire(&sb->s_flags) & flags;
 }
 
-/**
- * super_lock - wait for superblock to become ready and lock it
- * @sb: superblock to wait for
- * @excl: whether exclusive access is required
- *
- * If the superblock has neither passed through vfs_get_tree() or
- * generic_shutdown_super() yet wait for it to happen. Either superblock
- * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
- * woken and we'll see SB_DYING.
- *
- * A superblock which is being shut down is not waited for, see
- * super_wait_shutdown() and super_wait_shutdown_killable() for that.
- *
- * The caller must have acquired a temporary reference on @sb->s_passive.
- *
- * Return: The function returns true if SB_BORN was set and with
- *         s_umount held. The function returns false if the superblock
- *         is being shut down or SB_DYING was set and without s_umount
- *         held.
+/*
+ * Returns 0 with s_umount held, -ENOENT if the superblock is going away, or,
+ * if @killable, the error from a wait which was cut short.
  */
-static __must_check bool super_lock(struct super_block *sb, bool excl)
+static int super_lock_common(struct super_block *sb, bool excl, bool killable)
 {
+	int ret = 0;
+
 	lockdep_assert_not_held(&sb->s_umount);
 
 	/*
@@ -125,16 +118,28 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	 * and it can be a long one: the filesystem is written out first.
 	 */
 	if (!atomic_read(&sb->s_active))
-		return false;
+		return -ENOENT;
 
 	/* wait until the superblock is ready or dying */
-	wait_var_event(&sb->s_flags, super_flags(sb, SB_BORN | SB_DYING));
+	if (killable)
+		ret = wait_var_event_killable(&sb->s_flags,
+					      super_flags(sb, SB_BORN | SB_DYING));
+	else
+		wait_var_event(&sb->s_flags,
+			       super_flags(sb, SB_BORN | SB_DYING));
+	if (ret)
+		return ret;
 
 	/* Don't pointlessly acquire s_umount. */
 	if (super_flags(sb, SB_DYING))
-		return false;
+		return -ENOENT;
 
-	__super_lock(sb, excl);
+	if (killable)
+		ret = __super_lock_killable(sb, excl);
+	else
+		__super_lock(sb, excl);
+	if (ret)
+		return ret;
 
 	/*
 	 * Has gone through generic_shutdown_super() in the meantime.
@@ -143,11 +148,54 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
 	 */
 	if (sb->s_flags & SB_DYING) {
 		super_unlock(sb, excl);
-		return false;
+		return -ENOENT;
 	}
 
 	WARN_ON_ONCE(!(sb->s_flags & SB_BORN));
-	return true;
+	return 0;
+}
+
+/**
+ * super_lock - wait for superblock to become ready and lock it
+ * @sb: superblock to wait for
+ * @excl: whether exclusive access is required
+ *
+ * If the superblock has neither passed through vfs_get_tree() or
+ * generic_shutdown_super() yet wait for it to happen. Either superblock
+ * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
+ * woken and we'll see SB_DYING.
+ *
+ * A superblock which is being shut down is not waited for, see
+ * super_wait_shutdown() and super_wait_shutdown_killable() for that.
+ *
+ * The caller must have acquired a temporary reference on @sb->s_passive.
+ *
+ * Return: The function returns true if SB_BORN was set and with
+ *         s_umount held. The function returns false if the superblock
+ *         is being shut down or SB_DYING was set and without s_umount
+ *         held.
+ */
+static __must_check bool super_lock(struct super_block *sb, bool excl)
+{
+	return !super_lock_common(sb, excl, false);
+}
+
+/**
+ * super_lock_killable - killable super_lock()
+ * @sb: superblock to wait for
+ * @excl: whether exclusive access is required
+ *
+ * Only for callers which give up altogether when they are killed.
+ *
+ * The caller must have acquired a temporary reference on @sb->s_passive.
+ *
+ * Return: 0 if SB_BORN was set and with s_umount held. Without s_umount held,
+ *         -ENOENT if the superblock is being shut down or SB_DYING was set,
+ *         -EINTR or -ERESTARTSYS if the task was killed.
+ */
+static __must_check int super_lock_killable(struct super_block *sb, bool excl)
+{
+	return super_lock_common(sb, excl, true);
 }
 
 /**
@@ -674,25 +722,27 @@ EXPORT_SYMBOL(deactivate_super);
  * sb->kill() and be marked as SB_DEAD.
  *
  * Return: 0 if an active reference could be acquired, -EAGAIN if the
- *         superblock is gone and the caller should look again,
- *         -ERESTARTSYS if the task was killed while waiting for that.
+ *         superblock is gone and the caller should look again, -EINTR or
+ *         -ERESTARTSYS if the task was killed while waiting for either.
  */
 static int grab_super(struct super_block *sb)
 {
-	bool locked;
 	int ret;
 
 	refcount_inc(&sb->s_passive);
 	spin_unlock(&sb_lock);
-	locked = super_lock_excl(sb);
-	if (locked) {
+	ret = super_lock_killable(sb, true);
+	if (!ret) {
 		if (atomic_inc_not_zero(&sb->s_active)) {
 			put_super(sb);
 			return 0;
 		}
 		super_unlock_excl(sb);
+		ret = -ENOENT;
 	}
-	ret = wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DEAD));
+	if (ret == -ENOENT)
+		ret = wait_var_event_killable(&sb->s_flags,
+					      super_flags(sb, SB_DEAD));
 	put_super(sb);
 	return ret ? ret : -EAGAIN;
 }

-- 
2.55.0

