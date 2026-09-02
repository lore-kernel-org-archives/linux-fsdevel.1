Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3F4A8FED
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364744; cv=none; b=THpUh9/vz87GXA+rbXwYKBVIKqLYAra5ywm1QyZfvuvHrGqfvIDTecMgZyoJfeNh3BrfZLcTtYkp6ObQD0CnFQdaeP8Qxj85egkoPhjWElsJGe7MqeZLF5PfuoSH/GVWzpt9GyGVoQnup+2xeJX8BK5Xw971B6WCVLfYMiEDkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364744; c=relaxed/simple;
	bh=wKCIo2/iv+ATKh+ra+13Iau6Vg/q30quAr0WWOyc3iA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etec4W9smyTFZcFZs0n6aR82cW+PrwEtxO4fLv2lvwDcFiA+vcr7BJUedI8En7jR+JNyXy6Pex2LZsKhizlE1NGXLdznpvjsAedmmsA8zPaK8eyq3X2bwc4vVHnI6ppFCMEQRHMLUNLkyOmRV+UI/zrXJbGxc6n+lC2VVvah/xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qrw0vXJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qrw0vXJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B1A1F00A3A;
	Wed,  2 Sep 2026 15:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788364743;
	bh=ZAiiboJFHSG4fuEUCcduEV0leriS0GUovnD5xCFYBQE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qrw0vXJY/kgDxNr0+KPjQgpTC2O3MJwlg916Y3CEs2SwQkb8Eq3V/NFlUcp+Q4fnq
	 RA81X20ApZs6xgQuxj55mD4pVOGXCwNt1V65Ae8NBYbrkRJiE18sFq5wpzC1GLZ89w
	 4Mhtoi5h7wz1I2KMINaT3pT5N1Vi2nbHVv1iT1YUjySMtteiNvsMfeTy04yiR0o/eT
	 G8WV1cODx5L4cmtN2w0nOfmvJMVTtJh+iBcoyHgX1SOLPeSUZfHni1+JFj8I5qXq71
	 A40TX8RuwcRE1+C/TA0tLP+KJNWydW2dUyuGFllZtzDxbCEGfJNHgjCnRHWZ3Aqgjn
	 eNKpHpC+R73/A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 02 Sep 2026 17:58:27 +0200
Subject: [PATCH RFC v2 09/16] fs: make close_files() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-work-coredump-unlock-self-v2-9-1bece368cbb1@kernel.org>
References: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
In-Reply-To: <20260902-work-coredump-unlock-self-v2-0-1bece368cbb1@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2693; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wKCIo2/iv+ATKh+ra+13Iau6Vg/q30quAr0WWOyc3iA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTNcF/hUMW7yGqrUtde+eXdh8vfHM02FOhYmisabrVBs
 /6yp3Z8RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERepDAy/I0xzOMLWFQ1ufZ/
 xYGi873eES9vuL3RSH43Z/LvMl+hEwz/bCv/LEr3TTsqu9BtlxCroXSFUsP+8spTNzi6RQ7fuVX
 ACAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When the last reference to a descriptor table is dropped close_files()
closes every file but punts the actual work to task work. For an exiting
task that task work only runs in exit_task_work().

Before commit 4a9d4b024a31 ("switch fput to task_work_add") fput() was
synchronous everywhere and exit released its files in exit_files().

The deferral made fput() safe from any context. And exit_files()
offloaded to task work as a side-effect. And that has downsides.

Oleg and Neil noticed that some time ago. A task that exits with a big
descriptor table ends up queueing a very large number of files on task
work. That walks the task work list under ->pi_lock and costs a lot of
atomics too.

Let close_files() close right away. The walk puts the last references
through filp_close_list(). If it's the last reference it places them on
a private list and drains it through fput_list(). Note, this keeps keeps
the exact order the deferred path had. Every filp_flush() first and then
the final __fput()s in the reverse order task_work_run() giving the same
ordering even.

Every put of a dying table is synchronous now:

- exit_files()
- copy_process()
- close_range(CLOSE_RANGE_UNSHARE)
- unshare(2)
- exec

Kernel threads don't own a file descriptor table and exec already splats
where they to exec. kthreadd and every kthread share init_files and
init_task pins that forever.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 185de8deb39d..47ce844be95b 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -489,7 +489,7 @@ int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 	return 0;
 }
 
-static struct fdtable *close_files(struct files_struct * files)
+static struct fdtable *close_files(struct files_struct *files)
 {
 	/*
 	 * It is safe to dereference the fd table without RCU or
@@ -498,6 +498,7 @@ static struct fdtable *close_files(struct files_struct * files)
 	 */
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 	unsigned int i, j = 0;
+	LLIST_HEAD(to_close);
 
 	for (;;) {
 		unsigned long set;
@@ -509,7 +510,8 @@ static struct fdtable *close_files(struct files_struct * files)
 			if (set & 1) {
 				struct file *file = fdt->fd[i];
 				if (file) {
-					filp_close(file, files);
+					filp_flush(file, files);
+					fput_close_list(file, &to_close);
 					cond_resched();
 				}
 			}
@@ -518,6 +520,7 @@ static struct fdtable *close_files(struct files_struct * files)
 		}
 	}
 
+	fput_list(&to_close);
 	return fdt;
 }
 

-- 
2.53.0

