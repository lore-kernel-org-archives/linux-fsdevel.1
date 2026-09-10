Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD2038F651
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055316; cv=none; b=ImJkQtSjqsYqzVNGxdp/6HehkQ4KcerXkktVqojIRKipBpzgWHbGy1IdGEztpbDkNcy1fRIspjMNbbocdINnrLJfg0UCl6FuVqpNCJjM1wrOjjV0/8gIWvk5DoLVKkQgi5nZrS95e/3UID0qsSPvIhpWgZeyjFWxR6dEBeguYSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055316; c=relaxed/simple;
	bh=WpzIlflEMWvj+Qd4SSaIOZD2XYyWa0sGibldfMZ6wDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QTjsJ4WkF/m7SmNKLeyP2yDte1zVBQ7fjJYu9uNrjcmiY8Thk4XByqeFOfg486qFMZLhraYgSC7PeNzil5YQ0Ga8IyJFiRLEwIzjJxOLwTIny5uoct1rCm3AxPL1v0v7d96Kc1dUHqwnX0O17rULiazyJW+zivBQEYb3hxLJyuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMECpcxl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMECpcxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FF31F000FF;
	Thu, 10 Sep 2026 15:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055315;
	bh=uesR11+EtfZPTXzXdufMhenveKJrzFSw9lgGYQqmnYY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=UMECpcxlQXcKYarppl6iSOZehHGNBoUZJazM0MwCdMunkewP2xepUn8q82IpjiOf+
	 JvYUJcmqML06wTtz6kFfKiwB1jnrUsNEnSj6fRzVxxhffu6zca4zjZcz4J48oaDgxd
	 8vfA+Dv3pQmQStAbvxbPY00dDsH121G3gCfBGFNUM1GL8RD8rcPPRLsksXUbpZZXNq
	 9Cfg3m+3tJv2raOKumbllKKx0ojQ0wZf6WyZEEEuHlr+1HQ3wmjeckL+Go/uFCVsOJ
	 ZleIuSuaqVN7FLfbfhrVgtjRIPPN/92KxNxkSCeaelRXOzeMkVEvLxzt6W95fbxXR7
	 qZqu8hUvklm2Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 10 Sep 2026 17:48:04 +0200
Subject: [PATCH RFC v4 06/18] fs: make close_files() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-work-coredump-unlock-self-v4-6-a5c1800dc930@kernel.org>
References: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
In-Reply-To: <20260910-work-coredump-unlock-self-v4-0-a5c1800dc930@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Xin Zhao <jackzxcui1989@163.com>, 
 Mateusz Guzik <mjguzik@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2221; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WpzIlflEMWvj+Qd4SSaIOZD2XYyWa0sGibldfMZ6wDI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtumg7QXsmd+VhO1np9Lz9Ls++fru301fovGHBtrbA8
 3f2Lw2R7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIpA0jw56EPSfrLYL+NUfv
 f37sVML/TguXF1Gvw7Yd59TWOLSe4yIjQ/v0nZenF/O1xp3U8KpO/f14j+eN/1Pf5x6xW/k6Um7
 ZJh4A
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
 fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/file.c b/fs/file.c
index 636a87e527b3..b2b466dce7fb 100644
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
@@ -509,7 +509,7 @@ static struct fdtable *close_files(struct files_struct * files)
 			if (set & 1) {
 				struct file *file = fdt->fd[i];
 				if (file) {
-					filp_close(file, files);
+					filp_close_sync(file, files);
 					cond_resched();
 				}
 			}

-- 
2.53.0

