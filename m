Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793376743;
	b=hJXF2phD1VEoZXu01QvptkqenoREq0BQqtqSZdSAn0bm3N6daS8T8T43ozSibjsIiHX6
	 3V8lUvr+sccYAdk4ctVO8ZC64I4cEZNdaZ2YdF1+17x+04HIMRNudsaDGPXBYtzlwOGhF
	 nLLIBMVdO7+0bxKKvRnUBoM8OCMGVVn1SvTcYh/1eXCw7DAMUv2DOal9/hax9dUTkKUNa
	 E230RzMdjCpJ0htuKdqTnbPQWEct6cOqeSpgUyfvVFtxah3Y3n0g7ZjBCvqJAtxzSyP0v
	 qRMqpPGAHiEVz0RtFWDSOcbOhmhlL0I9tXn9NSfvpe6gxBAgngMVAydamUNZzebTyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793376743;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7u7M9JEnbRAJQKbKUeIa4F0OjhIyk7SXf55UOfYdbC4=;
	b=5MJa9t8HMwg0lK1ZjwmMVtTlsWZcG+5Nep4yugR30UjcshDHAOyNcK05sA/yxLJD8hBP
	 jpBOTI5mIbFWqlfXCrYP1UyWa+avNB4jkPNf/9Q5JeEbj8CL1ECQnrfNWIDQnOkDOua47
	 iz+ub1x2fTpWY3hgzxzgO6FFyU9dINF6L9dzhDV6UfBP9qL86rb3FFHCLfRZTOEsIUFDq
	 zXZ3VkzepO2xrAnVTU2KZN2Re3luZRjKCdJ6D5zE1982QPQGdTB8KjBj2CI6jBNB6skTj
	 px9nTIye9ozzsqE9Ndg+picWTuvoSBrbblgOvrL0dKcrFRJFRvTqMfoR/X1Q/QW+WOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8B6y7E4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0B606A320
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Oct 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8B6y7E4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C28D1F00A02;
	Fri, 30 Oct 2026 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793376742;
	bh=7u7M9JEnbRAJQKbKUeIa4F0OjhIyk7SXf55UOfYdbC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=f8B6y7E4gJiOLqAH7FBiMCBix98+fBfrAi2EnIOSpopK4gcuQmnHsch99/x+kaUo/
	 S3X4mpxtnD4sbmmVPWa90AWLoWPNXac7ChefDFlplgdNrEqQVR69gqUU/PuSPukScg
	 DXogkpC06h12R5eqr0qr+febPa3+4zk7z2Mp5K8eiTdpbpPDRTOkUsRuXnZhoFlSqu
	 00I5DTDnsD3wzXLJF94LSJOZifin5rFNJDJiXFRcJkmBWaAKEDdXRyxCdif0j3Lo6Z
	 9bFoyqcU6VpLxaTNWhJDXYoAIMYrmDkaQhtXqKIREcCOL285zea+T5AwDpkBTKC/Jz
	 WrnXxDJeWL2XA==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 17:11:55 +0100
Subject: [PATCH 3/7] proc: stop fdinfo files at a privileged execve()
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-procfs-ai-fixes-v1-3-772392d3ccfd@kernel.org>
References: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
In-Reply-To: <20261030-work-procfs-ai-fixes-v1-0-772392d3ccfd@kernel.org>
To: Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2676; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ocl9TNSQ4buVinTKFkU7vg8ELnQWGIad1nU0x+T04fM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9OXhXgKUr4WbsoclL3W9eLZx+nv1I9KXvs/g1FaW/V
 0rN+LXrWUcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEMrYxMkzMXSG7+sQO3f+2
 e+Xe6rQ7LE5JNpR7t17nVvrftiWcfzYy/HeLvP8ulldwconjqtPmNwOu6HAceBzOt+JUNI/rz+L
 NCrwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

/proc/<pid>/fdinfo/<fd> checks PTRACE_MODE_READ in ->permission(), i.e.
when it's opened. The file it describes is looked up in the task's file
table on every read. So a file that was opened before the task executed
a set-user-ID program keeps working afterwards:

  observer, uid 1000              target, uid 1000
  f = open("/proc/<pid>/fdinfo/5")
                                  execve("/usr/bin/su")
                                  fd 5 = open(something as root)
  read(f)
    pos, flags, mnt_id, ino and ->show_fdinfo() of su's file

->show_fdinfo() shows, among other things, the targets of an epoll
instance, inotify and fanotify marks and the state of an io_uring.

Use the exec id helpers and hold exec_update_lock until the file has
been looked up. Reading a file that was opened before an execve() now
fails with -EACCES if its opener has no access to the new program.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: 2793274298c4 ("add file position info to proc")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/proc/fd.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 839c984e1699..e13015a17898 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -24,7 +24,7 @@ static int seq_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = file_inode(m->file);
 	struct files_struct *files = NULL;
-	int f_flags = 0, ret = -ENOENT;
+	int f_flags = 0, ret;
 	struct file *file = NULL;
 	struct task_struct *task;
 
@@ -32,6 +32,13 @@ static int seq_show(struct seq_file *m, void *v)
 	if (!task)
 		return -ENOENT;
 
+	ret = proc_exec_id_lock(m->file, task, m->private);
+	if (ret) {
+		put_task_struct(task);
+		return ret;
+	}
+
+	ret = -ENOENT;
 	task_lock(task);
 	files = task->files;
 	if (files) {
@@ -50,6 +57,7 @@ static int seq_show(struct seq_file *m, void *v)
 		spin_unlock(&files->file_lock);
 	}
 	task_unlock(task);
+	proc_exec_id_unlock(task);
 	put_task_struct(task);
 
 	if (ret)
@@ -75,7 +83,7 @@ static int seq_show(struct seq_file *m, void *v)
 
 static int seq_fdinfo_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, seq_show, NULL);
+	return proc_exec_id_single_open(inode, file, seq_show);
 }
 
 /*
@@ -110,7 +118,7 @@ static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= single_release,
+	.release	= proc_exec_id_single_release,
 };
 
 static bool tid_fd_mode(struct task_struct *task, unsigned fd, fmode_t *mode)

-- 
2.53.0

