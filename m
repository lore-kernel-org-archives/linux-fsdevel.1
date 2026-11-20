Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182159;
	b=hizW95gjRP8wmnNghRNz9mnTfj1bGsYvZn+KPCkukJouVsMnurZh7yV0tdurZHeDhFv+
	 mbFqyKe5vUAkT7Zffq785CKBud5J0Oq2z5iGJhQoGA5pkV7aUmmuj6sHsflPTcSeAX9Mh
	 SAxtiwZfOAKmcKVMwNxr0jahgkjRNtdxgIZOuprngjujxjvYS8YJS0XqmZGcF9Egv9v7F
	 X06mOv/bJSmsInXKKetc+tbSX7POUXpzzBV8LjgESRjt7V/o0lWxUsyNfJRFRJxziLXy1
	 j3Engl8jflk1w064tcg80B7ukKyLFtExHfJqtig/xxnbEJKHK4eYWAO/ruhDee9q/0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182159;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=HpEeM9v9uPq3z/TDaX86swVoOCfhYmVoaoGwpnzpfrY=;
	b=oq9haCuZp6fa3tk8fxkDppu/REJj5u4k4WHgEMNnFeOdTBIKA1fImv4cMXv3u3N5mbuO
	 UOjWeoQj6p6pN74vzUWA2EGWXzDkOQjYJebKw0u0FKbctNN/M1bC6g0SBLA34L1iKzvpU
	 us/PlskESDsfWLbH1tsIn5tV2I2IY+SPYsV8XJxJnFA9d42nN/biAL5dK83TMlpH30F/M
	 rPfsFmivAP3LJNp27fwHnco5D1uAPdQ/PTaUyVrCYXArhoSrX7MmC1tat25ICOxkx8cNK
	 fQOF1EQCISYPwXIvVfH/5LUa1qkfeUJICovgVr8/IesmGbsO2mm0PqZI0LVgQOAhZRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxKjanWM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DB606A333
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxKjanWM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D3E1F000EC;
	Fri, 20 Nov 2026 13:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182158;
	bh=HpEeM9v9uPq3z/TDaX86swVoOCfhYmVoaoGwpnzpfrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jxKjanWMnXDDySlRMAZSi1CbsPnP9bd1DrZouEcSxL2M4GMSUwo79IXgce7mfiKnz
	 kVlb9FXdhqoKFkOcCwE6aStkJGJCF6vtaVlneqxOT3/BhUsZdrKNhjgXbNgdatp74V
	 b2hY3pSvqcpVg9q2E8igmGkq3Qol0bUlZgVc4sLHEFf23Ikg6GGMiEXf+ArkO6NJa6
	 cYNdgq6hWKr5+rfes8ZIQ8p2ovzhGiklfyOu9itsE7pbj/cK8ozF84RZQiT5B2MUDM
	 u1FEk96jh3bSeA8xwWgh1QXRktQ8R50IrjQoDiEPXqe3pDW07w3A3US2LMvzuLFNvz
	 2ujV69qet72Qw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 20 Nov 2026 14:42:11 +0100
Subject: [PATCH 3/3] pidfd: restrict pidfd_get_task() to the caller's pid
 namespace
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
Message-Id: <20261120-work-pidfd-pidns_visible-v1-3-0e82d08469ae@kernel.org>
References: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
In-Reply-To: <20261120-work-pidfd-pidns_visible-v1-0-0e82d08469ae@kernel.org>
To: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>
Cc: Oleg Nesterov <oleg@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jiwoo Kim <arpe1618@gmail.com>, Chen Linxuan <me@black-desk.cn>, 
 linux-mm@kvack.org, "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-04696
X-Developer-Signature: v=1; a=openpgp-sha256; l=2678; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yYLCei2hd6WAKtp3LPJuTk/v4Dt+/iYgb76wg9LAdOA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQz+DkwvLz8r6N2uv+lJfJ6xWUqF3tWmgpnF917olsp0
 MXTsrqoo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMYEO4OAVgIk8fMTKs/LXNOkFgxvl9qZy5
 /SaHnkSl2R5+ZyYfv9JQ8FqF6uQZDL+YtzzbucGin2lzlM2G/9XrN9rzXp/97ZFWgUSK0d2zcZI
 MAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Similar to the pidfs ioctls and pidfd_getfd() let's require that the
target of pidfd_get_task() is visible in the caller's active pid
namespace. The callers of pidfd_get_task() are process_madvise() and
process_mrelease() and both act on the target's address space.

Currently, a task can receive a pidfd for a process that it can't see
in its own pid namespace, e.g., via SCM_RIGHTS or by inheriting it
across setns() and fork(). process_madvise() only gates access on
ptrace_may_access() and process_mrelease() has no permission check at
all beyond requiring that the target is already dying. So both work on
processes the caller can't even name in its own pid namespace. That
doesn't make a lot of sense and it's inconsistent with the rest of the
pidfd api which refuses to hand out resources of invisible tasks.

Return -EREMOTE just like PIDFD_GET_INFO, the namespace and task path
ioctls, and pidfd_getfd() do. It's distinct from all errors that
process_madvise() and process_mrelease() return today, so userspace can
tell that the process exists but lives outside of its pid namespace.

PIDFD_SELF_THREAD and PIDFD_SELF_THREAD_GROUP aren't affected. They
refer to the caller itself or to its thread-group leader and
copy_process() refuses CLONE_THREAD if the new thread would end up in a
different pid namespace than the caller. So the check is only done for
real pidfds.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/pid.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 72b98d0f35ab1..530aa93d6fdb5 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -636,9 +636,11 @@ struct pid *pidfd_get_pid(unsigned int fd, unsigned int *flags)
  *
  * Return the task associated with @pidfd. The function takes a reference on
  * the returned task. The caller is responsible for releasing that reference.
+ * The task must be visible in the caller's pid namespace.
  *
  * Return: On success, the task_struct associated with the pidfd.
- *	   On error, a negative errno number will be returned.
+ *	   On error, a negative errno number will be returned. If the task
+ *	   isn't visible in the caller's pid namespace -EREMOTE is returned.
  */
 struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
 {
@@ -660,6 +662,10 @@ struct task_struct *pidfd_get_task(int pidfd, unsigned int *flags)
 		pid = pidfd_get_pid(pidfd, &f_flags);
 		if (IS_ERR(pid))
 			return ERR_CAST(pid);
+		if (!pid_in_current_pidns(pid)) {
+			put_pid(pid);
+			return ERR_PTR(-EREMOTE);
+		}
 		type = PIDTYPE_TGID;
 		break;
 	}

-- 
2.53.0

