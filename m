Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048AC43C054
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585311; cv=none; b=eOmlHh0ZUIzd3/1BKqD8zy5vET3UtwtU0o2VMrTVMTFxyvt3Ieqr7WyjHwiPZoJqBTHxOVxgmXApzOQAF9Z8Aa7kdU+Q1k+iTQYE/BYiSFwkbVKsZBC0OfuOKnGqHiGrPUg2ykUOEcS9fQZTp3tfApYB9pBtw8n6ApbH2UVIq4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585311; c=relaxed/simple;
	bh=jRFAUthIbKJEOo4sBGKfAsFM+aWU2G3GmVRrwXYxTbQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mo9AFsssmL1mqi0sDgPakKe7FG9m3OXfTpnFaJ/LOQprfT6SacV4BhEaTcoc/euJD8rQUEdbefrCPZQzFWqLKpzL3S1PVvVVgITk8DZTKjNIiEknDWXjKlPsmTXzigVxErn2INB8JIfNCJpDmN/UCN23sIpIFWvbmNy9H4vWiBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNkwZ5Dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNkwZ5Dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD4A1F000E9;
	Mon, 24 Aug 2026 15:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585308;
	bh=YnDg5AeFpPzuJGecatZ8PXuBEM66Z1QobUqrD7uYcnc=;
	h=From:Subject:Date:To:Cc;
	b=hNkwZ5DrWnOWuZA/zRD7cOSmVN1kDINNkc0BWvsMeiuXZwvMUSdHjAueOAnUw706R
	 fou8ONdVqbtDWrWJcwr00/S/Hn57iOVpUL6K/JCCiQ30JD21G2cNOSmoWwp+5QKN0O
	 1W0+AiDdHsRft9wNdBV0/jGHu2ol+i4w/zMIVr7FPA1LPoJwfirf3AzH1dEPXZWi+0
	 6Rk7tpBozPlW9m9HMh4Bs4EBG1BNDaBSmTo2vwZtmIAu1CLsQBkecgvMt7duhJcWqe
	 yA7wTk6+QJC/NMKfyQJJ6SRthWMErlI6aly7iTCgijD5az4zEs3pAG2K14YhXbrkKv
	 HhIZ0ons390pA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC 0/7] coredump, files: exit files on request
Date: Mon, 24 Aug 2026 17:28:14 +0200
Message-Id: <20260824-work-coredump-unlock-self-v1-0-48fd1cca7eda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/zXMQQ6CMBQE0KuQv/Y3pRosbk08gFvjoi0fqWBLW
 lETwt1tJS5nMvNmiBQsRTgUMwR62Wi9S6HcFGA65W6EtkkZBBcVl2KHbx96ND5QMz1GnNzgTY+
 RhharrZK1rEsh9xzSfwzU2s/PvsD5dITrWsZJ38k8s5pnWkVCHZQzXa6yz/4+W32WfZaHsCxfi
 TRRIrMAAAA=
X-Change-ID: 20260824-work-coredump-unlock-self-63a898912870
To: NeilBrown <neil@brown.name>, Oleg Nesterov <oleg@redhat.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Xin Zhao <jackzxcui1989@163.com>, Mateusz Guzik <mjguzik@gmail.com>, 
 Jeff Layton <jlayton@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-362b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4080; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jRFAUthIbKJEOo4sBGKfAsFM+aWU2G3GmVRrwXYxTbQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT1JEvevHMvxVL6t2fD4UqFhvuyvxqavj4qajl4Iydob
 0p5gWRURykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERMFzH8s1sStEV+h/Eflw3z
 27Kk1uWHhaq6fJh9tP4hr/aB5QXPHBn+J92UdVnfceSJ34vz+222mh4OTRQqv/Vm4bz3eQXSi95
 8ZwEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

We've had quite a few proposal for exiting files before generating the
coredump (see [1]-[8]). The various proposed solution were quite
unacceptable. So I took some time to look what a _remotely_ acceptable
version of this could look like. Here it is.

The first patch is somewhat unrelated but without it the code would have
to become so ugly to the point of being unacceptable so it's a stylistic
prerequisite imho.

In the first patch we make exit_files() synchronous and stop shunting
all files onto task work only to run task work right after. For tasks
exiting with a very large file descriptor table this means getting rid
of _a lot_ of cmpxchg()s and hammering on task->pi_lock. The cost of
this was mentioned in various threads over the years. I found at least
recent comments by Oleg and Neil.

So let close_files() close right away. No locks are held, the path
already sleeps, close() does the same thing already. Kernel threads can
just keep deferring. ->flush() and ->release() now run before exit_fs()
and disassociate_ctty() which should be fine.

The other half is adding support for coredumps to switch to an empty
file descriptor table before generating the coredump. That requires a
bit of synchronization but I think I got the basics down.

A new COREDUMP_CLOSE_FILES extension that allows a coredump server to
request that the thread-group close all files before generating the
coredump.

The coredumping thread allocates a new empty file descriptor table. It
then wakes all threads in the thread-group and tells them to switch to
the empty file descriptor table and get rid of the old one. They report
back once they're done.

So that handles most cases where locks would be held for an unreasonable
time until the coredump is generated but since files can be shared
between completely unrelated processes that's not a guarantee and we
can't give one. But it solves the reported issue without resorting to
even grosser hacks.

Link: https://lore.kernel.org/20260618030700.2511668-1-jackzxcui1989@163.com [1]
Link: https://lore.kernel.org/20260618150301.3226517-1-jackzxcui1989@163.com [2]
Link: https://lore.kernel.org/20260619122419.3954581-1-jackzxcui1989@163.com [3]
Link: https://lore.kernel.org/20260624145552.70143-1-jackzxcui1989@163.com [4]
Link: https://lore.kernel.org/20260630075604.52533-1-jackzxcui1989@163.com [5]
Link: https://lore.kernel.org/20260804001703.1340667-1-jackzxcui1989@163.com [6]
Link: https://lore.kernel.org/20260807040124.1706927-1-jackzxcui1989@163.com [7]
Link: https://lore.kernel.org/20260808052732.2589657-1-jackzxcui1989@163.com [8]

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (7):
      fs: add filp_close_sync()
      fs: make close_files() synchronous
      fs: add switch_files_struct()
      coredump: s/startup/done/g
      coredump: add COREDUMP_CLOSE_FILES
      tools: sync coredump.h header
      selftests/coredump: test COREDUMP_CLOSE_FILES

 fs/coredump.c                                      |  18 +-
 fs/file.c                                          | 152 +++++-
 fs/file_table.c                                    |  53 +-
 fs/internal.h                                      |   3 +-
 fs/open.c                                          |  39 +-
 include/linux/fdtable.h                            |   5 +
 include/linux/sched/signal.h                       |   5 +-
 include/uapi/linux/coredump.h                      |   8 +
 kernel/exit.c                                      |   7 +-
 tools/include/uapi/linux/coredump.h                |   8 +
 tools/testing/selftests/coredump/Makefile          |   4 +-
 .../selftests/coredump/coredump_close_files_test.c | 592 +++++++++++++++++++++
 .../coredump/coredump_socket_protocol_test.c       |   6 +
 .../selftests/coredump/coredump_test_helpers.c     |   3 +-
 14 files changed, 832 insertions(+), 71 deletions(-)
---
base-commit: 5870ce43c013ad564b3b83bae330b160e056df67
change-id: 20260824-work-coredump-unlock-self-63a898912870

