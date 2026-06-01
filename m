Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9A43BADA5;
	Mon,  1 Jun 2026 13:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322239; cv=none; b=iD4W1FvvOUyEm+s5rpHA2TaMzbq96SFEPkwkG9V/h6iuO8uL0vA9G/85o/Ib8v9L8bjEuvgMvOxGIgOYbz7YKJ9VfLuYtXZK9jPACbGe2PwO7fTdT4RIXlCUDbm91iVJqjLLw0KmsI4cR9Mc8DfUZZxOrTfxvx63k19QDzN7UpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322239; c=relaxed/simple;
	bh=piQMn1e6FaWg5N5YyNpDLQ+CLvrL1afyXNBbQ5NJvPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jodfAZBfZNsfee2sS7A5HQ7PjeZl5svbKM1rv5DgRZXvqMi1NgNyrvFXolyNnVZbLarPd6q8tC0Z7Q/KU9ZlA6XdZ2FOXBqBEnqW3k9jFsF2BoSzb65uXVHDq9h5dRmXi3QjEa8QqC54/yipm0uEDTQCi0dEkGa+hFhIIirMuCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBO+ATgg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBO+ATgg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5051F00893;
	Mon,  1 Jun 2026 13:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780322238;
	bh=lP8OEgQM5WpZ3TOFDqqMlVW2UDNnbc/Kdkkhd8jbQeM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=dBO+ATggiG7i6Gqbs4BC2koSaI34cjBXvAaePvMFxmzJDmwclb3yQlmZtV13NuEKq
	 rravWdbKT3aYxi0/kkJX9p7MDQXSMOu5F+ViO81FATVMmdQhqBfxtD/vgKP4FtAooU
	 KIJlgWE9ysv75AqLQ7SENGy4cHS5B9icRHNqkZo0e07g2KeoZcT9vUmKGitQCbTghv
	 l0pW0zF5Fr60q2Zlb5GwgSajNc4shHrzCpybbo35z0MCemyTKmSkzyuqwKqNbzNyxp
	 XYm4qxV4KJvaJxm/BApCsMShaH4IQiSnwk8ZhsxaJIp5TSCCIDyi905rMZZ5/3KiZ0
	 Or3a92+NzjDFw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 01 Jun 2026 15:56:43 +0200
Subject: [PATCH RFC v4 10/25] btrfs: use scoped_with_init_fs() for
 update_dev_time()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260601-work-kthread-nullfs-v4-10-77ee053060e0@kernel.org>
References: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
In-Reply-To: <20260601-work-kthread-nullfs-v4-0-77ee053060e0@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.16-dev-fffa9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1471; i=brauner@kernel.org;
 h=from:subject:message-id; bh=piQMn1e6FaWg5N5YyNpDLQ+CLvrL1afyXNBbQ5NJvPc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTJ9i8zPL7G/nBPgmPz5Y+37+lJ21duublV8pVQwrXt7
 EHORcmrO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyOYLhn13SnR398sf7K3W1
 C3jKd2XP87eX0un8lymTsvtQ7BoeY0aGid6ryjklZ87geH/5BZfKGd55Z/avf1PWfnfTyrTcRW4
 nmAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

update_dev_time() can be called from both kthread and process context.
Use scoped_with_init_fs() to temporarily override current->fs for
the kern_path() call when running in kthread context so the path
lookup happens in init's filesystem context.

update_dev_time() ← btrfs_scratch_superblocks() ←
btrfs_dev_replace_finishing() ← btrfs_dev_replace_kthread()
← kthread (kthread_run)

Also called from ioctl (user process).

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/btrfs/volumes.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a88e68f90564..967a1fab5c96 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -12,6 +12,7 @@
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
 #include <linux/namei.h>
+#include <linux/fs_struct.h>
 #include "misc.h"
 #include "disk-io.h"
 #include "extent-tree.h"
@@ -2120,8 +2121,16 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 static void update_dev_time(const char *device_path)
 {
 	struct path path;
+	int err;
 
-	if (!kern_path(device_path, LOOKUP_FOLLOW, &path)) {
+	if (tsk_is_kthread(current)) {
+		scoped_with_init_fs()
+			err = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	} else {
+		err = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	}
+
+	if (!err) {
 		vfs_utimes(&path, NULL);
 		path_put(&path);
 	}

-- 
2.47.3

