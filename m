Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6D74FB9A7;
	Mon, 12 Oct 2026 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791843078; cv=none; b=J0E2SOSFjDbAgZnLpbf5GPFIuPS83n23lvWMxJJqodXlnT0pp1gXf56IGzke/z3yBB/OM/CbYlbsyfiHBnL8yzZLgR/gNioZpj+FQKE/QXOugpq5p2io+KGh1JCDIHfpJbDwbh76/9WcP43YqfxKwMMSOZPi32eozViZghuIlpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791843078; c=relaxed/simple;
	bh=jxAcG16H7BPLXrjlLImhRydrV1xSJXJLDb0CyhAAXao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eoBcV9dfWsQfUYM8s7XDUyebIpimvpso5iNi2+NHgOr3p8jnmPLZ7iYuPUH5V1p14l7hsscgn6vmVkUoEE2MTguVIV7wjUjkSaWyexnqQ7f3xqVMtI477XlDK2alJjCWV8CInBwMraBnO3KEy7516GrFkADZbNky2BuTKr0ZsqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7aKEpBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7aKEpBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C470C1F0089B;
	Mon, 12 Oct 2026 22:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791843074;
	bh=mmJCs8pUUEFyRvDi5ZQsIBbdA8anzKn0SyPw/hG1EjA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=d7aKEpBmi1lJe2Uk0lWiIEvMGbZTWkPmhTxxgs3h776/S9386KHh3f12wtdhAlaXi
	 WEUy3G/zWIlIqxYkk1Z/pfE6JcTo0yAZ1MSepSmS/4v+yWs5O7a4k+knu3Z12jQcmn
	 Q8jj7OWZ75eHePXMx7Kw91W2xGYGZWeKOpxd22HiU+0b3teu44nlFNzgDDZt9vTWW2
	 iZeTgwK8Sg/3g4Jmm/eimwTPFXhHVX44bNloWT/nsycpbZliSlheV/akQtDQhd7GQp
	 QeSaSAAn8XBsDLqZxRQZBWsqf96N+kaymXAUFge1sZZzWWbWsX8o3TNAqXCRXuVw6C
	 5aWLvC/CtgAUA==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 13 Oct 2026 00:11:07 +0200
Subject: [PATCH 2/2] fs: let idle threads share init_fs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-work-fs-idle_fs-v1-2-2063d1bcb5aa@kernel.org>
References: <20261013-work-fs-idle_fs-v1-0-2063d1bcb5aa@kernel.org>
In-Reply-To: <20261013-work-fs-idle_fs-v1-0-2063d1bcb5aa@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
 linux-kernel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jxAcG16H7BPLXrjlLImhRydrV1xSJXJLDb0CyhAAXao=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSdjfpTUbF3G5/nxMhlB+3P35af5u+mcudkb/CuqaU9/
 X/aq6bt7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIj2MM//MEzVzv2y8ozBFf
 5fbEVaCmz05f0dB5CsfajxcfCLROz2D4w3H0WbJhTuZk5ronUcZ7XmsyuM3WXNxZ+thk8z9t7Z4
 MFgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

With nullfs as the real rootfs userspace can pivot_root() away from the
initramfs and unmount it:

    chdir(rootfs);
    pivot_root(".", ".");
    umount2(".", MNT_DETACH);

That's what systemd does and the initramfs is supposed to go away at
that point together with all the memory it uses. But on every machine
with more than one possible cpu the initramfs superblock stays around
forever (cf. [1]). With ramfs as rootfs the unpacked initramfs shows up
as Unevictable in /proc/meminfo, with tmpfs as Shmem, and it is never
freed. In the reports that's between 70MB and 150MB.

The idle threads of the secondary cpus are created by fork_idle() from
smp_init(). That runs in kernel_init(), i.e., in PID 1, after
init_userspace_fs() moved PID 1 from nullfs into the initramfs.
fork_idle() doesn't pass CLONE_FS so each idle thread gets a private
copy of PID 1's fs_struct and with it a reference to the initramfs as
root and as pwd.

pivot_root() relies on chroot_fs_refs() to move everyone whose root or
pwd is the old root over to the new root. Idle threads aren't on the
task list though so chroot_fs_refs() never finds them. They never exit
either. So they keep the initramfs mount and with it the superblock
alive for good. I overlooked this when I added nullfs. Before that the
rootfs could never be unmounted anyway so it didn't matter what pinned
it.

Idle threads are kernel threads and init_task, the idle thread of the
boot cpu, already uses init_fs. So let the idle threads of the other
cpus share init_fs as well instead of copying PID 1's filesystem state.

Note that kernels before 7.3 need a different backport. There PID 1
still shares init_fs with all kthreads so passing CLONE_FS in
fork_idle() is enough. They also have a second pin: devtmpfsd unshares
a copy of the initial mount namespace, initramfs mount included. That
was fixed in commit 66d2faeccbff ("devtmpfs: create private mount
namespace").

Reproducer, as /init in an initramfs together with a 128MB ballast
file, booted with root=/dev/sda to get ramfs and with -smp 4:

    // SPDX-License-Identifier: GPL-2.0
    /* initramfs /init: switch root like systemd, check the old root */
    #define _GNU_SOURCE
    #include <fcntl.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/mount.h>
    #include <sys/reboot.h>
    #include <sys/sendfile.h>
    #include <sys/stat.h>
    #include <sys/syscall.h>
    #include <sys/sysmacros.h>
    #include <unistd.h>

    static void meminfo(void)
    {
    	char line[256];
    	FILE *f = fopen("/proc/meminfo", "re");

    	while (f && fgets(line, sizeof(line), f))
    		if (!strncmp(line, "Unevictable:", 12) ||
    		    !strncmp(line, "Shmem:", 6))
    			fputs(line, stdout);
    	if (f)
    		fclose(f);
    }

    int main(int argc, char *argv[])
    {
    	struct stat st;
    	char dev[32], buf[32];
    	unsigned int maj, min;
    	int fd, in, out;
    	long r;

    	if (argc > 1) {
    		sleep(2);
    		meminfo();
    		/* ustat() only finds live superblocks */
    		r = syscall(SYS_ustat, (unsigned)atoi(argv[1]), buf);
    		printf("initramfs superblock %s\n", r ? "freed" : "pinned");
    		fflush(stdout);
    		sleep(1);
    		reboot(RB_POWER_OFF);
    	}

    	mount("proc", "/proc", "proc", 0, NULL);
    	mount("devtmpfs", "/dev", "devtmpfs", 0, NULL);
    	/* drop the fds console_on_rootfs() opened in the initramfs */
    	fd = open("/dev/console", O_RDWR);
    	dup2(fd, 0);
    	dup2(fd, 1);
    	dup2(fd, 2);
    	close(fd);
    	setvbuf(stdout, NULL, _IOLBF, 0);
    	meminfo();

    	stat("/", &st);
    	maj = major(st.st_dev);
    	min = minor(st.st_dev);
    	/* new_encode_dev(), what ustat() expects */
    	snprintf(dev, sizeof(dev), "%u",
    		 (min & 0xff) | (maj << 8) | ((min & ~0xffu) << 12));

    	mkdir("/sysroot", 0755);
    	mount("tmpfs", "/sysroot", "tmpfs", 0, NULL);
    	mkdir("/sysroot/proc", 0755);
    	mkdir("/sysroot/dev", 0755);
    	in = open("/init", O_RDONLY);
    	out = open("/sysroot/init", O_WRONLY | O_CREAT, 0755);
    	fstat(in, &st);
    	sendfile(out, in, NULL, st.st_size);
    	close(in);
    	close(out);

    	mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL);
    	mount("/proc", "/sysroot/proc", NULL, MS_BIND | MS_REC, NULL);
    	mount("/dev", "/sysroot/dev", NULL, MS_BIND | MS_REC, NULL);
    	chdir("/sysroot");
    	if (syscall(SYS_pivot_root, ".", ".") || umount2(".", MNT_DETACH))
    		perror("pivot_root");
    	execl("/init", "/init", dev, NULL);
    	return 1;
    }

Before:

    Unevictable:      131812 kB
    Shmem:                 0 kB
    Unevictable:      131812 kB
    Shmem:               792 kB
    initramfs superblock pinned

After:

    Unevictable:      131812 kB
    Shmem:                 0 kB
    Unevictable:           0 kB
    Shmem:               792 kB
    initramfs superblock freed

With -smp 1 the superblock is freed without this patch as well.

[1]: https://github.com/systemd/systemd/issues/43911

Fixes: 576ee5dfd459 ("fs: add immutable rootfs")
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/fork.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 947136cdd115..33760ece3bb3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1621,6 +1621,7 @@ static int copy_exec_state(u64 clone_flags, struct task_struct *tsk)
 
 enum copy_fs_flags_t {
 	COPY_FS_UMH	= (1 << 0),
+	COPY_FS_IDLE	= (1 << 1),
 };
 
 static int copy_fs(u64 clone_flags, struct task_struct *tsk,
@@ -1640,13 +1641,14 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk,
 		if (current->nsproxy->mnt_ns != &init_mnt_ns)
 			return -EINVAL;
 		fs = userspace_init_fs;
+	} else if (flags & COPY_FS_IDLE) {
+		fs = &init_fs;
 	} else {
 		fs = current->fs;
 		VFS_WARN_ON_ONCE(current->fs != current->real_fs);
 	}
 
 	if (clone_flags & CLONE_FS) {
-		/* tsk->fs is already what we want */
 		read_seqlock_excl(&fs->seq);
 		/* "users" and "in_exec" locked for check_unsafe_exec() */
 		if (fs->in_exec) {
@@ -1655,6 +1657,7 @@ static int copy_fs(u64 clone_flags, struct task_struct *tsk,
 		}
 		fs->users++;
 		read_sequnlock_excl(&fs->seq);
+		tsk->real_fs = tsk->fs = fs;
 		return 0;
 	}
 	tsk->real_fs = tsk->fs = copy_fs_struct(fs);
@@ -2304,7 +2307,9 @@ __latent_entropy struct task_struct *copy_process(
 	retval = copy_files(clone_flags, p, args->no_files);
 	if (retval)
 		goto bad_fork_cleanup_semundo;
-	retval = copy_fs(clone_flags, p, args->umh ? COPY_FS_UMH : 0);
+	retval = copy_fs(clone_flags, p,
+			 (args->umh ? COPY_FS_UMH : 0) |
+			 (args->idle ? COPY_FS_IDLE : 0));
 	if (retval)
 		goto bad_fork_cleanup_files;
 	retval = copy_sighand(clone_flags, p);
@@ -2676,7 +2681,7 @@ struct task_struct * __init fork_idle(int cpu)
 {
 	struct task_struct *task;
 	struct kernel_clone_args args = {
-		.flags		= CLONE_VM,
+		.flags		= CLONE_VM | CLONE_FS,
 		.fn		= &idle_dummy,
 		.fn_arg		= NULL,
 		.kthread	= 1,

-- 
2.53.0

