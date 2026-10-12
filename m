Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0853A4274;
	Mon, 12 Oct 2026 22:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843072; cv=none; b=Q662XoGD1w+ngJoSyi4/l0H+fqN6KnTJQ2rYQxD8AyrxC7gRI8lac56x/XdqKFV2CCpFsrLo9So/rcJ+Cx75hPSVftGO/gXuj3XQ2q6qBNI2iUKyiiFzfZ1BwpTv4+x2Msgh+qjbDmfONB5uq5VcNumij++GK9Z7ePi1F1WXUpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843072; c=relaxed/simple;
	bh=bksFGfEDrozSoZ9v+0FB9O5aot1sV20LxU7XlaPZvA0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=d2D0YDpsLZ44N0Lu4k/AWTyu7BxTrZvIf4o9w2eETsLaZSAQsM1BCfkeGfIVgBWH+C2URUrNwrB8ip9wcxbG/clqr3t33cSC4IbC1Qdjq7AUhKd492qOI2qB9gmVlYC2pyWAZ9EBMsvm5K2EN1b50ad81tZrGtNDpa2WsooU4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtJMI7aD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtJMI7aD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A485E1F0089B;
	Mon, 12 Oct 2026 22:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791843071;
	bh=F/nB0b7iIIZPPXyn2au+ed4yDsbSjxgGaRt5ADQqJWk=;
	h=From:Subject:Date:To:Cc;
	b=VtJMI7aDajLMTCCK7X+a2p9viHMcZDd/ABT4Q46kRbTGvQUx4v9YbkGyzM+OpJCCn
	 /GzHpNjShqM39UDTrzwu8AoErTb/bTTQE5HufVOqKz79FhOUlA9EmRIURkv+iBa19w
	 huU6qMSL2xStrCm92AGpqTLgHbgFLbhoggOvwcUcwyCH5N6uMaZnUpSXEPwPr2fsZ1
	 hgzpzQdNIXHBEI7XmWNH8SVri8uiPIwgr326PiH7i+PQgE2silrd9fnym5sx6tM9pd
	 sFhn6ZqV58cJ58AGeZj7M/1sl0jGYAAu9ZPNyLYuLQDYX03rAw0rNM5ZFgE/gukcfm
	 uugjFJBTrj/HA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/2] fs: don't let idle threads pin the initramfs
Date: Tue, 13 Oct 2026 00:11:05 +0200
Message-Id: <20261013-work-fs-idle_fs-v1-0-2063d1bcb5aa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2M3QrCMAyFX2Xk2pa2lIG+iog0XeKq0knjz2Ds3
 deqV4fvJOdbQKgkEjh0CxR6J0lTrmB3HcQx5AupNFQGZ1xvjXXqM5WbYqn1nc41ERn3vfGDZw9
 19SjEaf4aj6cfywuvFJ9N0z4wCCksIcexVU2oWfRfqNsZ1nUDUJTbz5oAAAA=
X-Change-ID: 20261012-work-fs-idle_fs-bbfb9604d4f4
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2921; i=brauner@kernel.org;
 h=from:subject:message-id; bh=bksFGfEDrozSoZ9v+0FB9O5aot1sV20LxU7XlaPZvA0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdjfozPXkJl/Ys3puKXEfer33Q4RNoe9L55Eyrb/+v/
 FULiD/d3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRKSyMDA29cp8cVYIDzqwO
 3DjXniX6mcfn29UeEuZHJ19OPndqqSnD/6QXd5Z5XVvMVPDq58x5md9dxR4e6z9zRPs6w4Ywpdh
 IC24A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Since v7.0 nullfs is the real rootfs and userspace can pivot_root() away
from the initramfs and unmount it. systemd does exactly that and the
initramfs is supposed to be freed afterwards. But it isn't (cf. [1]).
The unpacked initramfs stays around forever. It shows up as Unevictable
in /proc/meminfo with ramfs and as Shmem with tmpfs. In the reports
that's between 70MB and 150MB.

Two things keep it alive and neither is visible from userspace:

(1) On v7.0 to v7.2 devtmpfsd unshares a copy of the initial mount
    namespace which since nullfs contains the initramfs mount. It
    doesn't show up in /proc/<pid>/mountinfo because it's below the
    thread's root. That's already fixed in mainline by commit
    66d2faeccbff ("devtmpfs: create private mount namespace").

(2) On all kernels since v7.0 the idle threads of the secondary cpus
    are forked from PID 1 and each of them gets a private copy of the
    fs_struct of PID 1 with the initramfs as root and pwd. Idle threads
    aren't on the task list so pivot_root() never moves them over to
    the new root and they never exit. With a single possible cpu there
    are no such idle threads which is why booting a VM with -smp 1
    hides it.

This series fixes (2) by letting the idle threads share init_fs like
init_task already does. The first patch turns the umh boolean of
copy_fs() into flags. The second patch is the actual fix and carries a
reproducer.

systemd could go back to emptying the initramfs when switching root like
it did before nullfs and that's what [2] does. But that only frees the
contents. The mount and the superblock stay pinned. And I don't think
userspace should have to do that. With nullfs it's supposed to be able
to just unmount the initramfs and be done with it.

We could also teach chroot_fs_refs() about idle threads. But they are
kernel threads and have no business holding a reference to the root of
userspace to begin with.

Of the stable kernels only v7.2 is affected and the backport looks
different there. PID 1 still shares init_fs with all kthreads so passing
CLONE_FS in fork_idle() is enough. It also needs 66d2faeccbff which
applies cleanly.

I've tested this with the reproducer from the second patch and with a
systemd 262 initrd on 4 cpus. On vfs.fixes about 170MB stay Unevictable
after switching root and with this series they're freed. Same for the
backport on v7.2.

[1]: https://github.com/systemd/systemd/issues/43911
[2]: https://github.com/systemd/systemd/pull/44144

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (2):
      fs: pass flags to copy_fs()
      fs: let idle threads share init_fs

 kernel/fork.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)
---
base-commit: 19cd109ac4ab4b0dece4ebfbf3ab0532cc5cb505
change-id: 20261012-work-fs-idle_fs-bbfb9604d4f4

