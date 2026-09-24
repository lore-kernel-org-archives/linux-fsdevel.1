Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02942A168
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289353; cv=none; b=JT7qbiPFuikgJ7abYn5MfCOBkafu+0dPE9maPmYx0v/v4xh2+cP8SnU4AGHWnvsSOJIEOU+9RXgo7bC6SytR5SRy6kWYuyyEpkHv6sO4P0qLnG6WzLvMObrjwsc84+AF3rNE0T/BMcsM32JzkAA58EkdcBY3y7r/uIxjcMwN2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289353; c=relaxed/simple;
	bh=j5ObnphzJNwvyDoyibGCOt2bSwTxfleUJGG4aJQ7GGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MPMFaJOvfKBSL3q2qD1aQxdnD3cPBVXLpcXKBDGqhRF8Q3dIxRWK4ulIHvYweCgTq4i+NDIYbakCwj1aNNvJLXlkbO0BhgNw3Q2ZpUUEMFXn7a//YlSiFUednr0CXwMX9DjQk1TzAUkuye0oqXSY6TAs3UCVc1KKH3ArKaWBFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FIOx8EJK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FIOx8EJK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E068A1F00893;
	Thu, 24 Sep 2026 22:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289352;
	bh=IvsNlbmqQuKwOwxDSTTtb4z/TKZjd0K1O0AqGBLRuXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FIOx8EJKZQwaJiaj5QkNF+y540EB6t9/FWKuirv9UAAtWjplWST8LOgaYLJZ3e5BG
	 kc0dKpH4iK4pdZ9d2fOuibnLbXepEFFLnB0KcNrt4rkMqNbIbFANIKk4FKRtUMfzsR
	 9cbzC8i7n8XD/rwnoIEFU1Zt7ZZbbuK1io9M237ukqdxUXRcz0suR8MmotgLGVKIM6
	 SlktPqAWpBBIuks+OwSRsz9mA6JrFut8k8A5mlrlL+AdpTtdAPy6ols/J1/Y24pTFn
	 s4m9frlvGj4a8pPUq6ycW+W6a4bgI6glgaE/ba3AkoqX1Gw5P5EdF0zC6eEvvRPEWN
	 m0+HSSVCcsXNg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 25 Sep 2026 00:35:42 +0200
Subject: [PATCH RFC v2 2/8] fsnotify: record the superblock a connector is
 accounted on
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-work-mount-knullfs-v2-2-c4aebaa186e9@kernel.org>
References: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
In-Reply-To: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; i=brauner@kernel.org;
 h=from:subject:message-id; bh=j5ObnphzJNwvyDoyibGCOt2bSwTxfleUJGG4aJQ7GGM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtXXqgxmlDj/eHy1N/zs96GbLDac9Jj0l+L05F7btxP
 eDN8+kVTh2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATmW/H8JuF6fmV2XeUtpdl
 rHkUeqk08nDZl7ozJtrz7NhXLV3/dUk8w/8wyzfHVh5Nmqf+xP35eb+HcstXbf8ataDlrOz9xu4
 LpYf4AA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

fsnotify keeps a count of watched objects per superblock so that the
event hooks can be skipped on a superblock nobody watches. It computes
the superblock from the object object it watches via
fsnotify_object_sb().

This currently works because an object's superblock doesn't change while
a connector is attached to it. This changes form some of them. So record
the superblock in the connector when it is created and use
that for the accounting.

No functional changes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/notify/fsnotify.h             | 3 ++-
 fs/notify/mark.c                 | 7 +++++--
 include/linux/fsnotify_backend.h | 2 ++
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 58c7bb25e571..0be351275dad 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -54,10 +54,11 @@ static inline struct super_block *fsnotify_object_sb(void *obj,
 	}
 }
 
+/* The sb the connector is accounted on; NULL once it has been detached */
 static inline struct super_block *fsnotify_connector_sb(
 				struct fsnotify_mark_connector *conn)
 {
-	return fsnotify_object_sb(conn->obj, conn->type);
+	return conn->sb;
 }
 
 static inline fsnotify_connp_t *fsnotify_sb_marks(struct super_block *sb)
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index b2640d836a71..1b6095fcf039 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -425,6 +425,7 @@ static void *fsnotify_detach_connector_from_object(
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
 	if (sb)
 		fsnotify_update_sb_watchers(sb, conn);
+	conn->sb = NULL;
 
 	return inode;
 }
@@ -791,6 +792,8 @@ static void fsnotify_init_connector(struct fsnotify_mark_connector *conn,
 	conn->prio = 0;
 	conn->type = obj_type;
 	conn->obj = obj;
+	/* the object may move to another sb, the accounting doesn't */
+	conn->sb = fsnotify_object_sb(obj, obj_type);
 }
 
 static struct fsnotify_mark_connector *
@@ -953,8 +956,8 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	/* mark should be the last entry.  last is the current last entry */
 	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
 added:
-	if (sb)
-		fsnotify_update_sb_watchers(sb, conn);
+	if (conn->sb)
+		fsnotify_update_sb_watchers(conn->sb, conn);
 	/*
 	 * Since connector is attached to object using cmpxchg() we are
 	 * guaranteed that connector initialization is fully visible by anyone
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 618eed4d6d72..3a9ab9e0104b 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -573,6 +573,8 @@ struct fsnotify_mark_connector {
 		/* Used listing heads to free after srcu period expires */
 		struct fsnotify_mark_connector *destroy_next;
 	};
+	/* sb whose watched_objects account for this connector [lock] */
+	struct super_block *sb;
 	struct hlist_head list;	/* List of marks */
 };
 

-- 
2.53.0

