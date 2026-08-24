Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F401343C079
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585318; cv=none; b=K2mC1FWg8bqi4AoGIDgWDpEi5hnajbeQ8ZiXMRST1k1HDN3+2gShuHSZg4FkcnNmrbaxdOI6geIuv50WXbAf3HtRQwF++agYZf/diVriQ3u7oBR5Dr7B4EZpMWxZ/QIchSygGpwTWfzqQsUSUlT7KiqXvk9oNyNHM6zPpQLazjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585318; c=relaxed/simple;
	bh=SiVulM2EVk9i2q31i5Cf70og4WQ/X2eLYO88DgPGbLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpX6oqygrSYWbmReb7BC1mlsV5+cjHicxTPUaJ/2nuBoYG/wnBrRp/6Qmd/LJ90lj2APzBB6iH5Hib6YDG8LbSc8jtERESA2it2HB4+Sr/pWN7E5n69Ae135Qo/Jd4svFKaRhhprxdOMZH9E3IggVLLhY2aje/IMsQ8IDDwWEw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtlarWql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtlarWql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF42F1F00A3D;
	Mon, 24 Aug 2026 15:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585313;
	bh=OWPxZa5C2kVeDcWhBu69xugYJxMwiQgZUGry7ZGcevE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gtlarWqlA0kCLTudUK6i/eGUkovNiArEzPX8TYNDW1UCnGoQ7BAtLLx6d3EW7CWKe
	 5QgXgleeL/Ei4Od8V+ItJ9CN0BgOV+KnH7gKZs01tNVdHwiM8My2NOO5dcLq35EBQM
	 mw/cDaSLVzjPO7NfoXHlvymGO/oZLGxk4DhS8e0GlyaLSWqgPLQF0qjieAuS3QPZ26
	 88ezmghIi90I8ey82kv6O0hUbJ3WApsdLxed34VgZ0lTNNhGcQP2BwqHxX8uJsOX/b
	 +vVB+ZtTn0HsAh0AdUUhfOFPhGxO04no/gMw9jeqkmKl5rVosmpO4DNzrT/cqAuanw
	 hkJMwCX9HWwlA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 24 Aug 2026 17:28:16 +0200
Subject: [PATCH RFC 2/7] fs: make close_files() synchronous
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-work-coredump-unlock-self-v1-2-48fd1cca7eda@kernel.org>
References: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
In-Reply-To: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SiVulM2EVk9i2q31i5Cf70og4WQ/X2eLYO88DgPGbLM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEtdVL/zz0Jr+4XJ8a2L153ZVn1n4a/Fvq+UtNZHP
 162p7D8b0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEwtgYGdb6+b3lV04wTKgq
 jJ2iF+t5a7l3v2g367+eCftOnH/r/4SRYenVn6un/Z4mebzAmf/XrjVSJjsvPl2/s9S+d+3aK7k
 bGzgB
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
work. That walks the task work list under ->pi_lock.

Note, today closing the files runs after exit_fs(), disassociate_ctty()
and exit_task_namespaces(). So ->flush() and ->release() get a task that
has already lost its fs, its namespaces and its controlling terminal
even though the files were closed long before that.

So let close_files() close right away. No locks are held, the path
already sleeps, close() does the same thing already. Kernel threads can
just keep deferring. ->flush() and ->release() now run before exit_fs()
and disassociate_ctty().

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/file.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 628ca07dc4b1..e2d4b72c2e26 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -480,6 +480,11 @@ static struct fdtable *close_files(struct files_struct * files)
 	 */
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 	unsigned int i, j = 0;
+	/*
+	 * A kernel thread that might be needed to make progress on some
+	 * umount must not run __fput() itself, see __fput_sync().
+	 */
+	bool sync = !(current->flags & PF_KTHREAD);
 
 	for (;;) {
 		unsigned long set;
@@ -491,7 +496,10 @@ static struct fdtable *close_files(struct files_struct * files)
 			if (set & 1) {
 				struct file *file = fdt->fd[i];
 				if (file) {
-					filp_close(file, files);
+					if (sync)
+						filp_close_sync(file, files);
+					else
+						filp_close(file, files);
 					cond_resched();
 				}
 			}

-- 
2.53.0

