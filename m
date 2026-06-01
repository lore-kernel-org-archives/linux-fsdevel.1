Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BB93BED0C;
	Mon,  1 Jun 2026 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322249; cv=none; b=p84QY42IXMxCyRFmR3D5kacDkOZPpe/PUdYNwCSO5vsAmo1bf6qdRUmO6YVZ00rDpPRTzS9cGUxEuT8VhgMZjPXaQme8Nnu4Ka0q4dzZrgDdj2wfYslWNiT6xK+D+uEuom73tFJUxWdurgIxQAkeoVDDuqWDu87tS7Q0wFqnRrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322249; c=relaxed/simple;
	bh=8SLXrhoIMGIaz1xqqZxoXl2iwestckttTp9nrhw8q70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVsnhcVy9H0f/dDPdwL2gLrNk16fGVbAczveLAIAI2Xl/oHW70UoOeoK7j7UaluziQfERIJ6AV136PT4Wc8+JeszVdyDSmYVT/Eo7tp9nO/vKfU/YD0Evv7GlhK8Sty/rHBG2prOby6Z+j9o8XQ9MH0RREXiZiXWx9T3FcMsJjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxIJ5O7x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxIJ5O7x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD9C1F00893;
	Mon,  1 Jun 2026 13:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322246;
	bh=p76gCw+S1n1N+NZo4ifCYkHbPBzsw18bGb+unwz6cmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YxIJ5O7xffteISWEf7eS9K4RaVuGg3fhSyjjRur57R8RMTSHFqqmxaBu95buhDBAO
	 l6iOw475TPOgclqJ97AjZVOQRO24w9O485wG3c3nMUKaI+DlqAvatf+IajEN8pGYB2
	 jU1CJs4aiDAFD4jdttiBokUhbXw0RL2PsqwIijcFsNVMhZT+q1WsD71XsIUZgTBMFR
	 EebqM9a9FQENcWVeM5k5s5p+833Td2VC+rdcR1N1PUQ9qRDjzkuOAk/14PNIJbs7V+
	 tnwP62616+yxg8EFRILv6csQihiHgYwYxJiPL9J2xv7sXN0TNUjrhcOV/ojrfdlUxH
	 8pgre4LOezKCA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:47 +0200
Subject: [PATCH RFC v4 14/25] ksmbd: use scoped_with_init_fs() for
 filesystem info path lookup
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-14-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8SLXrhoIMGIaz1xqqZxoXl2iwestckttTp9nrhw8q70=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i+7uOWx2Iuc2ZG7zC5++zRR+ZXy7+/rX7LPkPS9v
 aHx7DvBnx2lLAxiXAyyYoosDu0m4XLLeSo2G2VqwMxhZQIZwsDFKQATWbmWkWHfXCVtzr+x0vkP
 kv823hQWfOqjYOC0nWGeoVf7v/D0J/sYGXrkr+53ynJ4tmQ/v4OHSGPYP+uwZSrmhnuenFTgr20
 M5gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call in smb2_get_info_filesystem() so the share
path lookup happens in init's filesystem context.

All ksmbd paths ← SMB command handlers ← handle_ksmbd_work() ← workqueue
← ksmbd_conn_handler_loop() ← kthread

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/smb/server/smb2pdu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 21825a69c29a..7ef7b79867db 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -9,6 +9,7 @@
 #include <net/addrconf.h>
 #include <linux/syscalls.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include <linux/statfs.h>
 #include <linux/ethtool.h>
 #include <linux/falloc.h>
@@ -5507,7 +5508,8 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	if (!share->path)
 		return -EIO;
 
-	rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
+	scoped_with_init_fs()
+		rc = kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
 	if (rc) {
 		pr_err("cannot create vfs path\n");
 		return -EIO;

-- 
2.47.3

