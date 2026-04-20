Received: from sg-3-112.ptr.tlmpb.com (sg-3-112.ptr.tlmpb.com [101.45.255.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BE383C6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Apr 2026 06:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776667973; cv=none; b=AKdmfX8LcPFM4zkE7FKdv1Ale6E5IaX9dljpYdHRljJwHvkJRJ09hBrJiP75EEjiR8w076LE8Z7uz+Sd/1RRPmHeHuqkzcArqje4pA3G2SrBp7GhVJsAjk7blSJoGqthXBbbn4nqEX3lDWcbOizE216nFb7+RwWsdTR8nytqss0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776667973; c=relaxed/simple;
	bh=pavoO37i1SKmjdbOAE0iftAZavH7SSQTPrORawD4nxQ=;
	h=To:Content-Type:Message-Id:Mime-Version:Cc:From:Subject:Date; b=PdZ61E6ZH9g4TrkNJJA+zogkdRrQFobiCk8VGb4wWLBSbcTGZEa6P2l1hoLJcVdvoRJLRc/WOWiBX3tDkIBj6XoUglhrBTw22tCQlPZseWSYFtRzELRiYgI73iHnp1FNuuNyajS9u0qlXqg6dBF5KdGFlrOw0nimEqW9aODL9fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hyxA7gvS; arc=none smtp.client-ip=101.45.255.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hyxA7gvS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1776667919; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ln230kM4eq7LG2lL4bouy4pz9BbnkdyPfzGh/zRUZks=;
 b=hyxA7gvSC4UmMcoyMMX3YU3o9+9y1FK4RQu5MYxU9axMJ9u4+EC9nKYnTDxmVdaFBEPprD
 bkw31x81J775g1iAqm2qrDB2QI5R9fIFk1afEoUNzL9fzfsZXgRhXTEr2tkgVFjmeGB4eO
 sEM9VIjFnaN2h9xrZv/wvdzihNv3xdfzZ9W0mMmS/ltA6xGX3CJ+OfvD/+RVnZCar8Otjf
 ohGLdZWuUtoXCqpsaU7/LfxRPflWjoXcYFySudYdIYRJAVDuPOU7mAnQ8Yty7K2YxDRy8K
 F0o9ZhPa9ltWhvhfARr8pYImmrV6lHfU4lop8+KE8WtOWlO52JeFFlnM8ZNNNA==
X-Original-From: Xin Yin <yinxin.x@bytedance.com>
To: <jan@kara.cz>, <amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260420064727.1760604-1-yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Xin Yin" <yinxin.x@bytedance.com>
From: "Xin Yin" <yinxin.x@bytedance.com>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+269e5cd0d+153485+vger.kernel.org+yinxin.x@bytedance.com>
X-Mailer: git-send-email 2.20.1
Subject: [PATCH] fsnotify: fix inode reference leak in fsnotify_recalc_mask()
Date: Mon, 20 Apr 2026 14:47:27 +0800

fsnotify_recalc_mask() fails to handle the return value of
__fsnotify_recalc_mask(), which may return an inode pointer that needs
to be released via fsnotify_drop_object() when the connector's HAS_IREF
flag transitions from set to cleared.

This manifests as a hung task with the following call trace:

  INFO: task umount:1234 blocked for more than 120 seconds.
  Call Trace:
   __schedule
   schedule
   fsnotify_sb_delete
   generic_shutdown_super
   kill_anon_super
   cleanup_mnt
   task_work_run
   do_exit
   do_group_exit

The race window that triggers the iref leak:

  Thread A (adding mark)              Thread B (removing mark)
  =E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80              =E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80
  fsnotify_add_mark_locked():
    fsnotify_add_mark_list():
      spin_lock(conn->lock)
      add mark_B(evictable) to list
      spin_unlock(conn->lock)
    return

    /* ---- gap: no lock held ---- */

                                      fsnotify_detach_mark(mark_A):
                                        spin_lock(mark_A->lock)
                                        clear ATTACHED flag on mark_A
                                        spin_unlock(mark_A->lock)

    fsnotify_recalc_mask():
      spin_lock(conn->lock)
      __fsnotify_recalc_mask():
        /* mark_A skipped: ATTACHED cleared */
        /* only mark_B(evictable) remains */
        want_iref =3D false
        has_iref =3D true  /* not yet cleared */
        -> HAS_IREF transitions true -> false
        -> returns inode pointer
      spin_unlock(conn->lock)
      /* BUG: return value discarded!
       * iput() and fsnotify_put_sb_watched_objects()
       * are never called */

Fix this by capturing the return value of __fsnotify_recalc_mask() and
passing it to fsnotify_drop_object() after releasing the spinlock, which
is the same pattern used in fsnotify_put_mark().

Fixes: c3638b5b1374 ("fsnotify: allow adding an inode mark without pinning =
inode")
Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
---
 fs/notify/mark.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index c2ed5b11b0fe6..cc93fcc2c5a9c 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -283,6 +283,8 @@ static void fsnotify_conn_set_children_dentry_flags(
 	fsnotify_set_children_dentry_flags(fsnotify_conn_inode(conn));
 }
=20
+static void fsnotify_drop_object(unsigned int type, void *objp);
+
 /*
  * Calculate mask of events for a list of marks. The caller must make sure
  * connector and connector->obj cannot disappear under us.  Callers achiev=
e
@@ -292,15 +294,19 @@ static void fsnotify_conn_set_children_dentry_flags(
 void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
 {
 	bool update_children;
+	unsigned int type;
+	void *objp;
=20
 	if (!conn)
 		return;
=20
 	spin_lock(&conn->lock);
 	update_children =3D !fsnotify_conn_watches_children(conn);
-	__fsnotify_recalc_mask(conn);
+	objp =3D __fsnotify_recalc_mask(conn);
+	type =3D conn->type;
 	update_children &=3D fsnotify_conn_watches_children(conn);
 	spin_unlock(&conn->lock);
+	fsnotify_drop_object(type, objp);
 	/*
 	 * Set children's PARENT_WATCHED flags only if parent started watching.
 	 * When parent stops watching, we clear false positive PARENT_WATCHED
--=20
2.20.1
