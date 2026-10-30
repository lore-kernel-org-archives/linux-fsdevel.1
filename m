Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376749;
	b=Z1MlObyj6eR+IQgck96IFrGUcAi4Ep1ITkUrGs3p8jWBgvqp4179wI+r/2vUA1an0jCH
	 hM4AJZL5d+yQLCHl1YhB+H27mcOqqb0MvsXYMwzvB8Kb1Wpm4Dx7vvhkEbzI6oyfSHFmV
	 7nyTNm4a7H8/fAghpjo/6P3ruy7TiixtV7kMtOXUudcZBxS5iSqifv0EFjrUGQC9Rvdel
	 ZFs7CRVGI4ey6PaDpt/creL4SqeRH8H8CLDIKaa8ppNR6xzGzxh2amzBPu6qSlDyxqls9
	 F3sc7lWa+t2KK7K73J9Lus53RRXwuEjQYUfModLScpQVLvrSMujjs+3iA3tg26QcMWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376749;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=L5gOnIs3WIknmdIl5AiK/b7Iwl3zjI98oZR00ihYED8=;
	b=Hvav1QBtuNgDPq4EYKAv9LfiVkWcMizAns3ICyBrYCIphySdmAZmFj3UUja1NAP7+3Gh
	 H35r8ItrD1GTXZWsv8rHgHdg/sjxrJmpQIOe4OWU2ZXU49/wPTnJmMm2fGQL+pTIOOkE6
	 f1x6wHvQby80qLpXMPMIUsZvQoCBhQk2p5lktyg9pzN1ZqAW5vt1l4dLX2C/sbJzg8LLh
	 OuoxvqrdlMmdtI7+VIEi9u2f5k9ASqPddM+0SG2N65Ntn3AA4fOZFyMheUmxkRaUUpA2F
	 hK/65ADmR2qj0QL5pa5NozbWaeoG77ZkfTOY82eBdMHGWFbenh9/v4XAc2jREE8YoiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IToKdPai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349C606A326
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IToKdPai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C781F000C1;
	Fri, 30 Oct 2026 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376748;
	bh=L5gOnIs3WIknmdIl5AiK/b7Iwl3zjI98oZR00ihYED8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IToKdPaiyw6LW5f5D97Y5Nw6jXYrw8StSlahhDoh2ugLzBGVXlKJarmNfReHU3ulz
	 9oTSXUAtuGQcOHCx/eQtybDWUGV2p9eeOl6ZX4n17sCyipGpVsjfCd8fEp8/wN3evY
	 f6gYQyMedByfl2XRDi6Mzpl+8z5kWDSPz/SaIBGfxVELgqNqjIMR/jk+tCRFAz+d/T
	 OnjJFK6rvNBxrvbhkVOd6m+dOrWRFcL6i5ZY6Ydtg2O2Re420Po+lw26TImaLzguzN
	 h/hZ0cQI43+tQ/GBhivHR/2fqjUn6AzeX/aj3OYp5VDO40YlVPo6LcfB28JXxK2hWT
	 PDKdcK1pMQ1kA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:11:58 +0100
Subject: [PATCH 6/7] proc: refresh the owner of fd/ before checking access
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
Message-Id: <20261030-work-procfs-ai-fixes-v1-6-772392d3ccfd@kernel.org>
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CRdcpzPrcG66AAGhvQ4skZHOFeqTqvkbBHlUHDsg3vM=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGrkwd2iPgg2+xzgZmJOhx0Ea1PX0taOIF12K6LoNAs5T0LdY
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmrkwd0ACgkQkcYbwGV43KLo9gEAjReQ
 EZMQFS3FF2pZzQhOLC89EnPKtEMwfvfbBjw0GcwBAKe91jrvLxRKWm9Qe9aFzgiZuAABwLPZfk/
 ANXeJQYAP
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

/proc/<pid>/fd and /proc/<pid>/map_files are mode 0500 and belong to the
user the task runs as, or to root if the task isn't dumpable. The owner
is stored in the inode and only brought up to date by pid_revalidate(),
i.e. when somebody looks the directory up by name. A lookup that starts
at a descriptor for the directory checks MAY_EXEC against whatever the
inode says:

  observer, uid 1000              target, uid 1000
  d = open("/proc/<pid>/fd", O_PATH)
                                  execve("/usr/bin/su")
                                  opens its files
  fstatat(d, "5", AT_SYMLINK_NOFOLLOW)
    fd/ still belongs to uid 1000
    succeeds if su has descriptor 5 open,
    st_mode tells how it was opened

That works until somebody walks through /proc/<pid>/fd by name. The
links themselves are checked on their own, so what is behind the numbers
isn't at risk.

Refresh the owner in proc_fd_permission() under RCU, the way
pid_revalidate() does it. Let the task itself in first, there's nothing
to refresh for that and /proc/self/fd is what nearly all lookups are
about.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/fd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 2d51344267ee..09ca4a5916d3 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -348,25 +348,25 @@ static struct dentry *proc_lookupfd(struct inode *dir, struct dentry *dentry,
 
 /*
  * /proc/pid/fd needs a special permission handler so that a process can still
- * access /proc/self/fd after it has executed a setuid().
+ * access /proc/self/fd after it has executed a setuid(). A lookup that starts
+ * at a descriptor for the directory skips pid_revalidate(), so refresh the
+ * owner here.
  */
 int proc_fd_permission(const struct mnt_idmap *idmap,
 		       struct inode *inode, int mask)
 {
 	struct task_struct *p;
-	int rv;
 
-	rv = generic_permission(&nop_mnt_idmap, inode, mask);
-	if (rv == 0)
-		return rv;
-
-	rcu_read_lock();
-	p = pid_task(proc_pid(inode), PIDTYPE_PID);
-	if (p && same_thread_group(p, current))
-		rv = 0;
-	rcu_read_unlock();
+	scoped_guard(rcu) {
+		p = pid_task(proc_pid(inode), PIDTYPE_PID);
+		if (p) {
+			if (same_thread_group(p, current))
+				return 0;
+			pid_update_inode(p, inode);
+		}
+	}
 
-	return rv;
+	return generic_permission(&nop_mnt_idmap, inode, mask);
 }
 
 static int proc_fd_getattr(const struct mnt_idmap *idmap,

-- 
2.53.0

