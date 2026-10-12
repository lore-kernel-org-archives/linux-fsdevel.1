Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47DD37B3FE;
	Mon, 12 Oct 2026 15:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819580; cv=none; b=Z8tayCvUVyThr5rPSgqHbsRSHNerggAZlIkoBO4U+RkHZXOlVKOuZiO6PuEntVU6MVwhB5KTJE7Y8KSze/V1Yaej9SLth0Z/gUvTQubzET4L3Ug4agHA/Ku6GHUhsnfLwMvuTv6HbDWvLaV1jmppRa+d9F8ULWOMIl/y82HnWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819580; c=relaxed/simple;
	bh=4/sDsGSIkUEP/1Atp9xrOz+SjCDC0VErDMKeibkVy+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LwlvamLizdEtcticK9OHZoGG0ETN+2L/n4GIRMVDJR8FZfTAwqFS7vFFwH4otkSOYZXwzRncKGOvTTNhNg6qy4ZWPbX94HETsKWH8/fqvFgjFgcGlPikwArQjdWF8ciZxlkx1L1LdISRIlZk/Zq+ZK9qn0NH6t9rdZdSXYPZJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR93iQUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR93iQUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06621F0089D;
	Mon, 12 Oct 2026 15:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819579;
	bh=tWjogGY32H0KUdkD/f6sAWnuGNTtzQDEehMGU9sahVk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UR93iQUSBANI61O+bfHZL0BI+rcZWLtVwV700I7vZKzrWTvQcjRydHmrYTHhU+/xH
	 xkj+lz0VqUChpiS5r1NnIAuDmtSlIc3MdP0McFvKUlFv2FV+04qg59+YufaROHNOaJ
	 nfjNSbad85ztIgzbezFJbL+VW2gVIMmSAUvatP280YqNmwx4YL7v+UazpM5DkzKyhl
	 p+KaojTz3Bu1jq7kR9adaMQuzFOPPZDLRY7CsI/Q1+LOwqZlH6tliipzaeaSUguJQE
	 dRd9tjAoRWNM4HuhTaZY3kTGC1BETsQY94+vLdbBCZCtuclFKzlwmbyy0xs56RAAj3
	 HG0cCtW3tCQ2g==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Oct 2026 17:39:18 +0200
Subject: [PATCH 5/9] fs: port kern_unmount{_array}() to mntput_unmounted()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-5-43f60221a7d0@kernel.org>
References: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
In-Reply-To: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4/sDsGSIkUEP/1Atp9xrOz+SjCDC0VErDMKeibkVy+A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a/dcrh4qTObu2ytYtnEn08mbXxVv/7oZs+Np/pOp
 nZrmzeFdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzE7zDDX+nji5/pfJwge62v
 PMFfNePEvC9f447GB9v8mFW+b2pibw8jQ4eC4+dkgQOaH+tKJkxsUjj57uX72bOdVI+dlrbpzta
 cxw0A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

kern_unmount() and kern_unmount_array() follow the same protocol as
namespace_unlock(). They clear ->mnt_ns, wait for a grace period and
then put the mounts. So port them to mntput_unmounted() as well and let
kern_unmount() go through kern_unmount_array(). A mount that nobody
else holds is now put without waiting for a grace period.

Note that a mount that is still held now waits for an expedited grace
period. kern_unmount() used to wait for a normal one. Callers of
kern_unmount_array() may pass NULL entries so skip them explicitly.

Overlayfs unmounts its layers through kern_unmount_array() on every
umount. With the previous patch and this one mounting, statting and
unmounting an overlay in a loop (8 threads, 20 s) goes from 292k to
528k-544k operations.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/namespace.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 435e5f6db880..af36cce922a2 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -6600,23 +6600,23 @@ EXPORT_SYMBOL_GPL(kern_mount);
 void kern_unmount(struct vfsmount *mnt)
 {
 	/* release long term mount so mount point can be released */
-	if (!IS_ERR(mnt)) {
-		mnt_make_shortterm(mnt);
-		synchronize_rcu();	/* yecchhh... */
-		mntput(mnt);
-	}
+	if (!IS_ERR(mnt))
+		kern_unmount_array(&mnt, 1);
 }
 EXPORT_SYMBOL(kern_unmount);
 
 void kern_unmount_array(struct vfsmount *mnt[], unsigned int num)
 {
+	HLIST_HEAD(head);
 	unsigned int i;
 
-	for (i = 0; i < num; i++)
+	for (i = 0; i < num; i++) {
+		if (!mnt[i])
+			continue;
 		mnt_make_shortterm(mnt[i]);
-	synchronize_rcu_expedited();
-	for (i = 0; i < num; i++)
-		mntput(mnt[i]);
+		hlist_add_head(&real_mount(mnt[i])->mnt_umount, &head);
+	}
+	mntput_unmounted(&head);
 }
 EXPORT_SYMBOL(kern_unmount_array);
 

-- 
2.53.0

