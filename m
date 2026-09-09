Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC6576EBE
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 15:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969196; cv=none; b=oRES9dKvOotEyMIcL31l3bB28EMvyNmvs684ERwJTesMhAdgnKfTR7Sxb8xDvM21CTBx1tpi40wdFRrr7i5P6vUS6xMAB35INwWxKXurgtzzBTHS28zJMtkKvdPQkv9Fa/j05wR2RiqZXB1+FrXBWlaxx9neMbqlb4vZ/3ba2T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969196; c=relaxed/simple;
	bh=BxmrRb0CB66X0HQ4w5uiLfoptNUbXk+Fh3pJpm9s9oI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aznNhSD+I9Xujn7O/aZ+pWV7JzL3EPx1eusKCld2uHBWQRVlVdae3qPr0HuNb5QngNEqYzjBVSWIsqRmq3Y+xhXvjhJTe/ft0gINqoF4XJZKv/IlpRnlzT+CnoY8HD0NhP+nivy0YeDAzEJFpqKvJ0ElEDLAgfvBmkS/Drskk9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk+DrVkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk+DrVkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C501D1F00A3D;
	Wed,  9 Sep 2026 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969195;
	bh=5liB7M42gh8JOTQxmIg5mhz/jxgFPQTQG1fTo/z8xd0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Zk+DrVkUMeqM/POSTFKz1r+wKa7dhOUDP6EMWstHZ/BJPNfpavuoTWJB4FeG/kd+x
	 BfztGGG/Auhu+41Dm4UsFnQ9cLwbHUhkck3s7LDQjWp0PTLSeCANtv21I2nvfdAbHK
	 CQqnZpPnSxwd9K6osTWX1qnqYFaFwf6AX00L8tFSqcdNY+IePYr1x8njZJB8IHciVi
	 pDz5sbntCsj/u34fh/TklxxWzDOU58yKpthQqrbAUbQBaFzn2EE9PfIMAslLDyMURd
	 RGbhqaVbtD7AEO9Adu432sbcb7H+1j6UN8H0GtNgQRLhyo16ZYUAl/wEG0t6mo7JzN
	 RQ4mH07jJNR7A==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 17:52:49 +0200
Subject: [PATCH RFC v3 06/15] fs: make close_files() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-coredump-unlock-self-v3-6-04f907687563@kernel.org>
References: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
In-Reply-To: <20260909-work-coredump-unlock-self-v3-0-04f907687563@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BxmrRb0CB66X0HQ4w5uiLfoptNUbXk+Fh3pJpm9s9oI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtbLgq9qEhTEZH4c0ype1+THNarZccm2ksF172qzD5T
 cyPfTfXdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzEkYPhf6wkg1uED5/dU941
 z5m2mf6ubE7Zqpf/el6u2zfDpPogLkaGd65tjDM75t14o3b78au0bR8a3jU4lLrlrOq0WTL3y8Z
 5vAA=
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
work. That leaves a list for any later task_work_cancel() to search
under ->pi_lock and costs a lot of atomics too.

Let close_files() close right away. Flush and put each file inline the
way close(2) does. The final __fput() runs during the table walk now
instead of from task_work_run() in exit_task_work(). One difference is
the order: task work ran the final __fput()s in reverse and now they run
in table order.

Every put of a dying table is synchronous now:

- exit_files()
- copy_process()
- close_range(CLOSE_RANGE_UNSHARE)
- unshare(2)
- exec

Kernel threads don't own a file descriptor table and exec already splats
were they to exec. kthreadd and every kthread share init_files and
init_task pins that forever.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index a527183dc664..b7deb4e634c1 100644
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
@@ -509,7 +509,8 @@ static struct fdtable *close_files(struct files_struct * files)
 			if (set & 1) {
 				struct file *file = fdt->fd[i];
 				if (file) {
-					filp_close(file, files);
+					filp_flush(file, files);
+					fput_close_sync(file);
 					cond_resched();
 				}
 			}

-- 
2.53.0

