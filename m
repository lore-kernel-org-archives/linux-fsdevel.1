Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E343B6C05;
	Wed, 20 May 2026 08:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779265024; cv=none; b=ZhQrCc09lscBUiUJmFlrnI5RPK1CJYPd5EhWJouJVnOaM7FnBNU710NcypZ3DcXYp9WsZIuz6+3WM6NzCmcFgdtlg5cXJ9ZlLAsyAVkPajHqK3AMXE3poUdPaAV8aM7NTi0WoyRhG+hlDTVs6qQ2a75Y9VzW+AW0Tmqv/l+65X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779265024; c=relaxed/simple;
	bh=hEOV+xLBzps7dK3nmv8ZLA62uaADwLGePclh0jyux6c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T60Hm6jmLoeBBtzXHGg+/XTu0KDh5wLO/1lbO6gVAJGN+BtWfVYXrXMGffM5z5D5U9mGPfd87f+ptoJ90XIc3On7CNqkrCuNWU4qq2dAQfpeojtKCMbgNl7760G2OBQfr5rTmK126ssOFQX3H4/lwlsanIXnUwu5cGJuiRL+RV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqzKajWH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqzKajWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81EC1F000E9;
	Wed, 20 May 2026 08:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779265022;
	bh=B/xV4OqGJtER2rnDgnxjP8aamK2J2sLdEwWrq99mTmY=;
	h=From:Date:Subject:To:Cc;
	b=UqzKajWHqb+6PNHvtRHuQeSe8iOoOZzqLEdnXrPTAqA3hGUeymQaHg0i5K5u0go9p
	 zbIjI/a6QEmNpZgB5cNrIU4YFQSM8+O/npiPsiDCqudjuHZ4XwhB3hLu30SW7dWf90
	 d3XUT1/DvDA0p1BHHZBqLb7BKcQqIcrZ1UpUy9+eR3m5ylvYXJWu//dKzbujmLli84
	 m1rG6gVNRi3KYtbqSLX9FK4TdPCTKdIbAZQq7WQoc9fWoqhxvwXHG5Gyz2Ajqvwuc3
	 24NMAL1wu6N2MmAP5nfg0eMFhP8u+z15BEtGUFxxAhaVggOqgWds2GT9frkLX7ZWcC
	 YffZu/xlBm2uw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 20 May 2026 11:16:51 +0300
Subject: [PATCH] init: do_mounts: use kmalloc() for allocations of
 temporary buffers
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-init-v1-1-aaf2ebac5ad9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPJtDWoC/yWMQQ6CMBBFr0JmTWOZtCR4FcOiU0cZNcV0gJgQ7
 m6ry/fz3t9BOQsrnJsdMm+iMqcCXdtAnEK6s5FrYUCLvfVojSRZTOcxDG5wPaOHor4z3+Tzu7m
 Mf9aVHhyX2laDgrKhHFKc6kTuRK85PuE4vpBa+waDAAAA
X-Change-ID: 20260520-init-152a94946e25
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Mike Rapoport <rppt@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3243; i=rppt@kernel.org;
 h=from:subject:message-id; bh=hEOV+xLBzps7dK3nmv8ZLA62uaADwLGePclh0jyux6c=;
 b=owEBbQGS/pANAwAKATkDhibLDv2RAcsmYgBqDW35bx0+sRUhpBsEehlgNGBwsmYfYqIoq3ABv
 O4XWrYEypeJATMEAAEKAB0WIQR45VhVpZkvn3TRr+k5A4Ymyw79kQUCag1t+QAKCRA5A4Ymyw79
 kbGbB/4olTVytxkGtnPOlA/z35C0vEnA3naWGyc2qN34UaPtYTSoLiSwyrtQtQTMq/MK8A/rQ1N
 nX0NIRc/DnbSHUPwcvZLQQ2LGDCljYAYCwi4eag5gZ8W3Mhhvlei3BkUfTZLEzR/wVvbiE4Llyj
 gSA15MND7ShHWLKMgHjpGaocJlKQhnP93ZThTCI8mWZXIijk1Nd0hDIdWHo0praoy/oku5dnTnu
 gFzZAqi4oGBKOC+//pCQBFP9/hAzX1Q+T5edvKZOelDcHejrU6a9SnzWrLbsdtaM1zqoHO/SQxY
 2IONtVb9Xex0o2D94jZsrG7q0wOA46yjFppAogstvdNEN0vr
X-Developer-Key: i=rppt@kernel.org; a=openpgp;
 fpr=B8E96E880C4A40C3C1255AA8C532392DE6DA7CE9

Several places in init/do_mounts.c allocate temporary buffers for
filesystem names or options using __get_free_page() or alloc_page().

Usage of alloc_page() APIs is not required there and only creates
unnecessary noise with castings or conversion from struct page to void *.

kmalloc() is a better API for these uses and it also provides better
scalability and more debugging possibilities.

Replace use of __get_free_page() and alloc_page() with kmalloc().

While on it, add a check for -ENOMEM condition in mount_root_generic().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc:

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/init
---
 init/do_mounts.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 55ed3ac0b70f..95e0b3a0f711 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -143,16 +143,14 @@ static int __init do_mount_root(const char *name, const char *fs,
 				 const int flags, const void *data)
 {
 	struct super_block *s;
-	struct page *p = NULL;
 	char *data_page = NULL;
 	int ret;
 
 	if (data) {
 		/* init_mount() requires a full page as fifth argument */
-		p = alloc_page(GFP_KERNEL);
-		if (!p)
+		data_page = kmalloc(PAGE_SIZE, GFP_KERNEL);
+		if (!data_page)
 			return -ENOMEM;
-		data_page = page_address(p);
 		strscpy_pad(data_page, data, PAGE_SIZE);
 	}
 
@@ -170,19 +168,20 @@ static int __init do_mount_root(const char *name, const char *fs,
 	       MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 
 out:
-	if (p)
-		put_page(p);
+	kfree(data_page);
 	return ret;
 }
 
 void __init mount_root_generic(char *name, char *pretty_name, int flags)
 {
-	struct page *page = alloc_page(GFP_KERNEL);
-	char *fs_names = page_address(page);
+	char *fs_names = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	char *p;
 	char b[BDEVNAME_SIZE];
 	int num_fs, i;
 
+	if (!fs_names)
+		panic("VFS: Unable to mount root fs: not enough memory");
+
 	scnprintf(b, BDEVNAME_SIZE, "unknown-block(%u,%u)",
 		  MAJOR(ROOT_DEV), MINOR(ROOT_DEV));
 	if (root_fs_names)
@@ -242,7 +241,7 @@ void __init mount_root_generic(char *name, char *pretty_name, int flags)
 	printk("\n");
 	panic("VFS: Unable to mount root fs on \"%s\" or %s", pretty_name, b);
 out:
-	put_page(page);
+	kfree(fs_names);
 }
  
 #ifdef CONFIG_ROOT_NFS
@@ -343,7 +342,7 @@ static int __init mount_nodev_root(char *root_device_name)
 	int err = -EINVAL;
 	int num_fs, i;
 
-	fs_names = (void *)__get_free_page(GFP_KERNEL);
+	fs_names = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!fs_names)
 		return -EINVAL;
 	num_fs = split_fs_names(fs_names, PAGE_SIZE);
@@ -360,7 +359,7 @@ static int __init mount_nodev_root(char *root_device_name)
 			break;
 	}
 
-	free_page((unsigned long)fs_names);
+	kfree(fs_names);
 	return err;
 }
 

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260520-init-152a94946e25

Best regards,
--  
Sincerely yours,
Mike.

