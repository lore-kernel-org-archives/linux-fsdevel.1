Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CED57D201
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790201965; cv=none; b=tS0gRJ3mfFxqct7mfbvJPMiyqAHZVsbXWuPdQUZg03+5U96PaAbYPsuUnzKAulXdvbXN0VgYhhY9U1f7Unl3AljPd7YEeqzkFTQX9Z2S6BjUJaEAvFhjgoOrwEivqWHlzqpvZ3EspspN4kPfCfl94W0I/jPfrTmXV+CFRpicqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790201965; c=relaxed/simple;
	bh=j5ObnphzJNwvyDoyibGCOt2bSwTxfleUJGG4aJQ7GGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H2/tusYnORz56l/UfBoL92PiTObkidJs+8DNqHYnBv4NiIN9MtsDrKDjoqhG4GpoXJTWay7kmilu3Dg/d0YpuxBkRZOuA6fjnL5KvjEpSyIKhe+rM+Nyo0z5ZaXFEXV2Bp9t2W6OTfCMiuJIRfDBmXxfesqndmA1XqPw2SGAgxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip92TXs2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip92TXs2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF0E1F000FF;
	Wed, 23 Sep 2026 22:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790201963;
	bh=IvsNlbmqQuKwOwxDSTTtb4z/TKZjd0K1O0AqGBLRuXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ip92TXs2fx/CHmAT338FoFQEO9OFyKuOsH47uBR7im5jtUgIgu1jKN42w48VvpfXV
	 A3LRpittScwH6iecPF4zd7UZef6opW/DFSYP+4s1+SD2JA1AgHY0jXJybzYAGudrwd
	 CkXp16A/S2jyuqfdx9VzTSAQuutDT2aWdWXqi9QkAyf8/KIUCEpJq1gDu7hskb+crJ
	 b/It4pYbxXNKnqI1cPoNvtCREhUpP2UQCDvfdYSx0hwc8How8GUVP4nyZOnyvysvBd
	 0ph/GBMjUpuIEICHnvOFgW3nTyMX+SO1dmNMNQAuGW6ZQGf4Ds4NVfhmx21mXTXW5T
	 1uXlZlk1CTZAA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 24 Sep 2026 00:18:51 +0200
Subject: [PATCH RFC 2/6] fsnotify: record the superblock a connector is
 accounted on
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-work-mount-knullfs-v1-2-ae89b29f7cb3@kernel.org>
References: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
In-Reply-To: <20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3052; i=brauner@kernel.org;
 h=from:subject:message-id; bh=j5ObnphzJNwvyDoyibGCOt2bSwTxfleUJGG4aJQ7GGM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtCUh+w2SxIadD+O3Fzqky6zzUHnVyFOzN8nN+aRIRE
 LCpw6Suo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ8WxgZFnZvEtjxZv3C2KVb
 mq4/NOiK37w4omb2hsmabDVzf6xduZGR4c1Zbb4zsRludxotbu3n9LZhPynCZXD17COf1b955Ip
 yOAE=
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

