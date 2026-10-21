Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792544224;
	b=Q6HO9h/N792MHcnF97jOE9N6duREXr20kqj1Zmv6FrzxOxfGXzrGy7/8Xb0mPildIGBr
	 954qEXSSq+ADfzItvJEQj+Cu1vVjbwe+zk2SrP9y4iuUSAW5aYpnBnxc8AC9PIlF32nan
	 H7z5+lwDX+TwaU3FuS3wy4sZXTTWB8uJgvm/V7nP5oQVz+Iw+q9jiwVvydx5aOP+V6xVv
	 HZ6dYnzrB2B1xrhyImBd0Wk0BhkkhjKW+WSQp3bKBhH5iwquXT4qdSlUAnNZ3kDE1IldL
	 45K0QC50aW8yqVTUs+LT59Q2sJXEJT3PHQxY9nVu5f5w0IKOyTn+odMcQeltti/djrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792544224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=f/l+Fy2dbzrWLltAcQpERM4Bta0l2qgZ7duYB37iFwU=;
	b=gRKloFHl/26tCHw3NiMbsdvrY7QdP24VDwULm9s5zIfnXVlBtc6ojy1kRCXKFSLFh2g3
	 HrPlhHJhT66CcOjxFU6HUO2cQqKiiaOKVo7T3LS2dEDurvxSe5jDBnLS5dhK+pYJUFgBN
	 5sgtjmvgGIcKAmDCFdrJQGH8ma62k+rfX+zAdSO/n8nVKPXB1wlvCQWe1RVtkXjY2HBFU
	 v6K8IE1fuUyjAxHCHwTdpVZOjABlaHmtU6HzO/ASv+CsI4aNlVuKOPWsSURrkCgJRcSUJ
	 aLB3ZBEyG0IFQhJFhMe9RmExCq7ia88cwpBEcRZzB484GQgaQWnGWeZmRylGN+ZXHJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QCDjDjUR;
	arc=none smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A902E606A327
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 00:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A902E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=QCDjDjUR
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-918f75a68f0so3253046d6.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2026 17:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792544223; x=1793149023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/l+Fy2dbzrWLltAcQpERM4Bta0l2qgZ7duYB37iFwU=;
        b=QCDjDjURquGgZUGctEtWQ9G5jfBJRZmc4AZpl9643n2/4Yy3E6rYFIrJt5abtAJCbi
         Rda9Enn2YELH/xEUTELHIUpdyA7V4egciMTMJTuDxO6SkDGceA/xI4Z8gsfQzbW1wqvV
         CteHLcw9hc+j2Wzmjp4Pvx1VDFAj1WJT0vAXAQLOqmyWtdDEqWRzM6tpyk71L/wzwOQa
         yeDmeY2jy6Jwf5EqqGY3Ncv3x8yRkyf14kRcYOGgAveoW9eNGwo/k7IK3HeT3l1sY3Nd
         iNRw7S4yWSDqhYORp5kfnF/eYvuH+oUXzuRmmfX0TE0gC07sR0BIORCbiSaVVKE2i442
         +jGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792544223; x=1793149023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/l+Fy2dbzrWLltAcQpERM4Bta0l2qgZ7duYB37iFwU=;
        b=bVdNjjO70DUSgPWaHmQ1YJBSM98qkEFWN6Qy87l76nKX5ulw9vyN0mAoR0B0BN6YKq
         u9nuxrgJVTkm9rzMrlNmWl/Hf403w5lprpJ+1qesD5P4m0QA3mfMV/fGfIVL82U2wMlR
         rtOMb+kaTQVBx16Rl4YleX7pVtfxqAiMH1XcXNIXQFEVD3PQPc3Bavm838JWa/L9Sjge
         ZE18p3jufM0YUxCsi/sNuEynI0mSijrBuegDoCZtsN60cD8kFG+zHFen4G0a1mSwJBgK
         emgsHqvjvhCSaT2KemXCgiGIUNZIIUHC/UBW+STRrN2YyWLW59q/bTK/u5RKxm2hsLic
         54mQ==
X-Gm-Message-State: AFq9FYKfcjTdv7VRKO0hYkswfXZCwsFQ/3zv2F9ov+Joa3ODa+nuncgp
	q7SMpsjWlM66EXje0TpMPxQ26gGwGRU6syCU86FvDnHw24lH72BdFtC5MPqXKRXlQ4Y=
X-Gm-Gg: AYBFou36y97c27mI7m7vsyNUgVnukToXCfWysyR52KBfZUVUxv2dTRr1XiTaY/hOp2/
	/DaTZCz8eRchyOQkD8o53sVWh/O+eQvXuOKvGSMlP7Pa9Q87uELozCW9C23DbSdbh+rk3rUHo8O
	m0Lrrex9X/we+DaVUBo5DmxooAqdoZ5iumGEcRDvtkAaAOvYJH6+ps8WXAz2lQNJJbIecuAjTTN
	07VLQmTNZMcn3tjfccJf7ppld10FKiGY1UAIn4cL7lUWDkZXVWAw/5CDqvgBw/UXFmtdC+69z2A
	w2s/5o6Fp4qLkzMoR+z8ZiRkJQ+Vjyv6NK8wzb089bQixzCrM1cG1F3tV2UuqA8YKcsc6kTbKzw
	4xQTdFBF3EJ1PawM8bof5MLTwGnKlMMQu2iIVzlyR5NnzKxcsGd8parz9/DyX9ZQVZ/pAaX8Beo
	V7bQZvBZdTViCHbn74lHJesQQiwdSaBvEaQI6CJiGoC7r1SGGHWX1ADbRGALaXQ/LM4w/LTRn1Y
	aPBt4IsPcjLtF+r/0/raBdkLP77jmkNcZldzaHO8BzzSvjePqAc8l8p3Qfim2t93NNDLIhJ
X-Received: by 2002:a05:6214:c88:b0:91b:5d39:e145 with SMTP id 6a1803df08f44-91c12f3e4c6mr9642536d6.58.1792544222603;
        Tue, 20 Oct 2026 17:57:02 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10c3b500sm11596586d6.35.2026.10.20.17.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 17:57:02 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 00:56:38 +0000
Subject: [PATCH 4/5] fs: don't sleep on s_umount of a superblock being shut
 down
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
Message-Id: <20261021-b4-super-lock-dying-v1-4-2b35e86706ff@toxicpanda.com>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
In-Reply-To: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792544204; l=3950;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=QpMNlbQDw7A3trBZOrUgix5MhZvB66B7kwe/i702fNk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHCN27hnDE0SxN9Wjz0bzU5o2aa3F12UQg7N0AP9PjiVscoxWl0S8ms8CrmOutSHIoFDCSHgBxS
 U4u6p1/fEJgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

A slow unmount holds up tasks which have no business with that filesystem.

deactivate_locked_super() drops the last active reference with s_umount
held for writing.  generic_shutdown_super() then writes the filesystem
out, evicts its inodes and calls ->put_super(), and only after all that
sets SB_DYING and drops s_umount.  On a slow or unresponsive device this
takes minutes, or forever.

super_lock() doesn't take s_umount if it sees SB_DYING, but for the whole
of the above it isn't set yet.  So whoever walks the superblocks sleeps
uninterruptibly on s_umount until the unmount is over, then finds SB_DYING
set and is told that there is nothing here for them.  One stuck unmount
this way takes along, among others, every

 - sync(2)
 - write to /proc/sys/vm/drop_caches
 - quotactl(Q_SYNC) without a device
 - quotactl() and ustat() on that device
 - BLKFLSBUF on that device

The outcome of that sleep is known when it starts.  s_active reaches zero
only under s_umount, s_umount is then held until SB_DYING is set, and
nobody gets a new active reference once it is zero.  Check s_active first
and fail right away.

super_lock() and what is built on it are local to fs/super.c, so its users
can be listed.

Those who need the unmount to be over wait for that on their own since the
previous three patches:

 - sync(2) and BLKFLSBUF, which can now be killed while they wait
 - the emergency sync and remount, from a workqueue
 - fs_bdev_freeze(), fs_bdev_mark_dead() for an orderly removal and
   filesystems_freeze(), for which nothing changes

sget_fc() waits for SB_DEAD in grab_super().

freeze_super(), thaw_super() and the second super_lock_excl() in
do_thaw_all_callback() are called with an active reference held and never
see such a superblock.

That leaves drop_caches, quotactl(Q_SYNC) and delayed_superblock_init() in
selinux through iterate_supers(), cifs through iterate_supers_type(),
quotactl() and ustat() through user_get_super(), fs_bdev_mark_dead() for a
device which is already gone, and thawing: fs_bdev_thaw(),
filesystems_thaw() and the emergency thaw.  They have nothing to do on a
superblock which is going away and promise nothing about it.  They carry
on with the next one as they always did, only sooner.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/super.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 9baaaa3256b2..9f76b399f3fb 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -104,16 +104,29 @@ static bool super_flags(const struct super_block *sb, unsigned int flags)
  * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
  * woken and we'll see SB_DYING.
  *
+ * A superblock which is being shut down is not waited for, see
+ * super_wait_shutdown() and super_wait_shutdown_killable() for that.
+ *
  * The caller must have acquired a temporary reference on @sb->s_passive.
  *
  * Return: The function returns true if SB_BORN was set and with
- *         s_umount held. The function returns false if SB_DYING was
- *         set and without s_umount held.
+ *         s_umount held. The function returns false if the superblock
+ *         is being shut down or SB_DYING was set and without s_umount
+ *         held.
  */
 static __must_check bool super_lock(struct super_block *sb, bool excl)
 {
 	lockdep_assert_not_held(&sb->s_umount);
 
+	/*
+	 * The last active reference is dropped with s_umount held, which
+	 * stays held until SB_DYING is set, and there is no getting a new
+	 * one.  All there is to find at the end of that wait is SB_DYING,
+	 * and it can be a long one: the filesystem is written out first.
+	 */
+	if (!atomic_read(&sb->s_active))
+		return false;
+
 	/* wait until the superblock is ready or dying */
 	wait_var_event(&sb->s_flags, super_flags(sb, SB_BORN | SB_DYING));
 

-- 
2.55.0

