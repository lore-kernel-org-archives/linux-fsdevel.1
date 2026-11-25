Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795581463;
	b=EHe8yqF6hvacMWedZcDcKU2AmZuh2UTxpqlujif0z5hw11DeeuXtUrjk2NZl/lAh+1JX
	 onC97QLgek7pCDgm1CjgmZe9oU23nZ/aIc9WkkGcwnP/RGhmYdlMF6cvUNlTYRN/NjYSQ
	 Iqi6t7SVS/QZiYeZFLyNpnboGEeN6aPW0fkvAmJF3d7E4Io24j+2/p46WryKUciFhFeNC
	 zBSMIL3MBgJ4V4vaGe1FcYx71Njr44o8k6KnDM0XD4qgapiHNDE7yfGeClvait1rGvBDm
	 fReseWyygOQAuYwD+GmqgTXrnQSbFZ+NPgmHWEJ/ES7PIZjLR3FlvIave++nANWWj+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795581463;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=WS4GyLqxtWozxg0AR9n0e9WQYqF73LmTiav24dO29H0=;
	b=1JI+jXmED3C1+Y3kq/++w8ihFF2bc8QvAhZ/Quv0cgvo3WmjrK5amqLdkYIzl9016EnC
	 YhkMtTGvSZChjLKtC+wyn4f6t3XD+CVYTtoAR5UI6DRzKBnlhDcWFPg98t7FEdWL0Sw4n
	 fuQNc+iFCT1viy0tapW4ZRIeQTjUUVRutO1Cpx11t+Frt3t13MgDZ0fHGWTS6q5Kuux4u
	 VUGZEjwueXQCu9GRhOvaQtech8HHN+jfJPdz0+XI4AAA9waLSxzojGmymwmbcfmiSALMz
	 SbhlCtLQR0jB1KOAupQzkrqHNoppeSoOEPWf4K6ghKiWcCdAGpm7MWbITd5ljyeBP9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Rxf0ZDrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14280606A332;
	Wed, 25 Nov 2026 04:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Rxf0ZDrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB621F00ADE;
	Wed, 25 Nov 2026 04:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795581462;
	bh=WS4GyLqxtWozxg0AR9n0e9WQYqF73LmTiav24dO29H0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Rxf0ZDrd6KKvkfOwMLrtGNtthslLVhcJMmZm6e2AwnMM0zwW/pxRtpfRjKUQ0AaRE
	 QfLLkKXPNWpT5BrKMnrFA9GiosfyjGTwDw1l418TvUSNwlXeHgX3lhwvd5Ze6VAoEv
	 KnmRT3jx69ySQS9hvEivn6GvKAgj+iKTITTj+fTM=
Date: Tue, 24 Nov 2026 20:37:41 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: syzbot <syzbot+3b8f4ae71137f7af00ca@syzkaller.appspotmail.com>
Cc: adobriyan@gmail.com, brauner@kernel.org, jack@suse.cz, jannh@google.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 sforshee@kernel.org, syzkaller-bugs@googlegroups.com, Marco Elver
 <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in task_dump_owner /
 task_dump_owner (2)
Message-Id: <20261124203741.0eab4c0987ae73f2bcdf5e47@linux-foundation.org>
In-Reply-To: <6b04f2d2.44b41460.34b83f.0037.GAE@google.com>
References: <6b04f2d2.44b41460.34b83f.0037.GAE@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 23 Nov 2026 18:13:38 -0800 syzbot <syzbot+3b8f4ae71137f7af00ca@syzkaller.appspotmail.com> wrote:

> syzbot found the following issue on:
> 
> HEAD commit:    4843f6873f7c Merge tag 'sysctl-7.04-fixes-rc4' of git://gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=149a7363580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=886d2ddd2d6b664e
> dashboard link: https://syzkaller.appspot.com/bug?extid=3b8f4ae71137f7af00ca
> compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/9b25bc73ef7f/disk-4843f687.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/acc9d8469c04/vmlinux-4843f687.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/83adc8d7ee5c/bzImage-4843f687.xz
> 
> AI-generated root cause summary:
> During concurrent VFS lookups of the same `/proc/<pid>` dentry, `lookup_fast()`
> invokes `pid_revalidate()` without holding any inode lock (including in RCU-walk
> mode). `pid_revalidate()` calls `pid_update_inode()`, which calls
> `task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid)`.
> `task_dump_owner()` performs plain, unsynchronized 4-byte writes to
> `inode->i_uid` and `inode->i_gid`, causing concurrent writers across CPUs to
> race on the same `struct inode` fields.
> 
> full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=3b8f4ae71137f7af00ca
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3b8f4ae71137f7af00ca@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KCSAN: data-race in task_dump_owner / task_dump_owner

Yes.  This was reported in 2019(!).  Alexey had a patch, kicked it
around for a while with Marco and Dmitry but nothing came of it:

	https://lore.kernel.org/all/20191020173010.GA14744@avx2/

It is a somewhat significant problem - I was able to demonstrate tasks
getting EACCESS when opening their own /proc/<pid> and AppArmor getting
stale inode owners.

A simple patch which takes ->i_lock in a few places fixed all that up,
but the performance costs were pretty horrid.

Clever AI figured out how to fix that with a seqcount_spinlock_t and
the results are good - non-contended accesses slowed down 3-5% and
heavily contended accesses became 20-30% faster than current mainline.

This all passes everything I could throw at it.  Two patches below. 
Comments?


From: Andrew Morton <akpm@linux-foundation.org>
Subject: proc: serialize task owner lookup and inode updates
Date: Mon, 23 Nov 2026 20:59:01 -0800

A task which has just changed its credentials can be refused access to
its own /proc/<pid> files when another process looks up the same files
at the same time.

To demonstrate: a task sets its euid to 1000, makes itself dumpable and
opens its own /proc/<pid>/environ (mode 0400), in a loop.  Two other
processes stat() that file.  Under QEMU the open() failed with -EACCES
twice in 128,000 attempts.  With a 300 microsecond delay added between
task_dump_owner() reading the task's credentials and storing the result
it failed 87 times in 82,653 attempts.  With this patch it did not fail
in either test.

This happens because revalidation of a /proc/<pid> dentry reads the
task's owner and then writes it to the inode's i_uid and i_gid with no
serialization.  Two lookups of the same entry can do their stores in
either order, so an owner which was read before the task changed its
credentials can overwrite one which was read afterwards.  The inode then
has a stale owner until the next lookup, and a permission check which
uses it gets the wrong answer.  The two fields can also be taken from
different credentials.

KCSAN reports the concurrent writes.

Alexey Dobriyan proposed locking the stores in 2019 [1].  Marco Elver
pointed out that taking the snapshot before the lock still lets an old
snapshot overwrite a newer one [2].  Dmitry Vyukov showed AppArmor's
permission check being given a stale owner [3].

Hold i_lock while both obtaining the task owner and updating the inode.
Do this for the ordinary proc entries, fd entries and map_files entries.
Also serialize the mode updates in the first two paths.

Link: https://lore.kernel.org/r/20191020173010.GA14744@avx2 [1]
Link: https://lkml.iu.edu/1910.2/05407.html [2]
Link: https://groups.google.com/g/syzkaller-bugs/c/mzwiXt4ml68/m/GuAUQrWtBQAJ [3]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: <syzbot+3b8f4ae71137f7af00ca@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=3b8f4ae71137f7af00ca
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>
---
correctness testing:

Tested proc-serialize-task-owner-updates.patch with fresh A/B kernels
in two-CPU x86_64 QEMU guests. A had the patch removed; B had it
applied. Both used the same 2 ms delay after an old root-owner
snapshot to make the race reproducible. No performance testing was
done.

A task changed its effective UID to 1000, made itself dumpable, and
repeatedly opened its own /proc/<pid>/environ while two other
processes statted that path. A returned a spurious EACCES on 5 of
100000 opens; B returned none on 100000 opens. There were no other
open errors.

AppArmor's common_perm_cond() read a stale root owner for the task's
proc inode 5 times on A and none on B during 100000 accesses per
kernel. This reproduces the stale-owner read raised in the 2019
discussion. Ordinary procfs, fd, and map_files checks passed on both
kernels.

The patch prevented the observed false userspace EACCES and stale
owner reads under the same race conditions.

performance testing:

I compared kernels without and with the patch in matched x86-64 QEMU
guests with 64 vCPUs, two NUMA nodes, 8 GiB RAM and KASAN disabled.
A local test program repeatedly called stat() on proc files. The
figures below are median calls per second from five paired runs.

Operation                              Without patch    With patch    Change
64 threads: /proc/thread-self/stat       7,275,026       2,381,957      -67%
16 processes: same /proc/PID/status      3,803,871       1,434,726      -62%
64 processes: each one's own status    117,886,249     113,369,302       -4%
64 concurrent ps -fe runs                     652             652       ~0%

The patch substantially reduced lookup throughput when callers
contended on the same proc inode. The separate-inode test was about
4% slower, while ps -fe showed no measurable change. A 128-vCPU guest
showed a 77% loss for concurrent /proc/thread-self/stat lookups.
These VM results do not establish the cost on a 128-CPU physical
machine or under PREEMPT_RT.

 fs/proc/base.c |    4 ++++
 fs/proc/fd.c   |    2 ++
 2 files changed, 6 insertions(+)

--- a/fs/proc/base.c~proc-serialize-task-owner-updates
+++ a/fs/proc/base.c
@@ -2029,9 +2029,11 @@ int pid_getattr(const struct mnt_idmap *
  */
 void pid_update_inode(struct task_struct *task, struct inode *inode)
 {
+	spin_lock(&inode->i_lock);
 	task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
 
 	inode->i_mode &= ~(S_ISUID | S_ISGID);
+	spin_unlock(&inode->i_lock);
 	security_task_to_inode(task, inode);
 }
 
@@ -2210,7 +2212,9 @@ static int map_files_d_revalidate(struct
 	mmput(mm);
 
 	if (exact_vma_exists) {
+		spin_lock(&inode->i_lock);
 		task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
+		spin_unlock(&inode->i_lock);
 
 		security_task_to_inode(task, inode);
 		status = 1;
--- a/fs/proc/fd.c~proc-serialize-task-owner-updates
+++ a/fs/proc/fd.c
@@ -127,6 +127,7 @@ static bool tid_fd_mode(struct task_stru
 static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 				fmode_t f_mode)
 {
+	spin_lock(&inode->i_lock);
 	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
 
 	if (S_ISLNK(inode->i_mode)) {
@@ -137,6 +138,7 @@ static void tid_fd_update_inode(struct t
 			i_mode |= S_IWUSR | S_IXUSR;
 		inode->i_mode = i_mode;
 	}
+	spin_unlock(&inode->i_lock);
 	security_task_to_inode(task, inode);
 }
 
_




From: Andrew Morton <akpm@linux-foundation.org>
Subject: proc: don't lock task inodes whose owner has not changed
Date: Tue, 24 Nov 2026 15:50:00 -0800

"proc: serialize task owner lookup and inode updates" takes
inode->i_lock on every lookup of a /proc/<pid> entry.  In a 64-vCPU
guest that cost 67% of the stat() rate when 64 threads used
/proc/thread-self/stat, 62% when 16 processes used one
/proc/<pid>/status, and about 4% when 64 processes each used their own.

The owner of these inodes is recomputed from the task on every lookup
but it almost never changes.  So compare first, and take the lock only
when there is something to store.  A lookup which finds the right owner
and mode already in place now writes nothing to the inode.  The code
before either patch stored them on every lookup, so lookups of one
inode from many CPUs no longer share a dirty cacheline at all.

An unlocked comparison on its own does not work.  If a task's owner
goes A, B, A then the inode can show A while a lookup which saw B is
about to store it.  A lookup which compares, finds A and returns is
then overtaken by the stale store, and the task can again be denied
access to its own files.

So updates are now made inside a write section of a new per-inode
seqcount, still under i_lock, and they read the task's credentials
inside that section.  The comparison is a read section of the same
seqcount.  It waits for an update which is in flight, and it is only
trusted if no update started while it ran.  Every later update reads
the task after the comparison did and cannot store anything older.

security_task_to_inode() is called on every lookup, outside the lock,
as before.

With a 300us test-only delay between an observer reading the owner and
storing it, a task which sets its euid to 1000, makes itself dumpable
and opens its own /proc/<pid>/environ was refused 8 times in 126,196
opens and 6 times in 121,218 when the update was skipped after a plain
comparison.  With this patch it was not refused in 102,762 and 102,671
opens.

The seqcount fits in existing padding: struct proc_inode stays at 632
bytes on x86_64.

Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Jann Horn <jannh@google.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Kees Cook <kees@kernel.org>
Cc: John Johansen <john.johansen@canonical.com>
---

correctness testing:

I tested "proc: serialize task owner lookup and inode updates"
(proc-serialize-task-owner-updates.patch) together with
"proc: don't lock task inodes whose owner has not changed"
(proc-dont-lock-task-inodes-whose-owner-has-not-changed.patch).

A had neither patch; B had both. Fresh x86-64 QEMU guests used four
vCPUs and two virtual NUMA nodes. The ordinary A/B kernels had KASAN
and lockdep enabled; a separate matched A/B pair used PREEMPT_RT.

A task repeatedly changed its effective UID between 0 and 1000, made
itself dumpable, and opened its own /proc/<pid>/environ while two other
processes looked up its proc entries. The same test-only 300 us delay
after reading the task owner was present on A and B.

                         A, neither patch       B, both patches
Ordinary kernel          104 / 434,042 denied   0 / 365,377 denied
PREEMPT_RT                52 / 306,797 denied   0 / 271,267 denied

On A, open() sometimes returned EACCES after the task set its effective
UID to 1000 and made itself dumpable.  This reproduces the stale-owner
permission failure addressed by the patches.

Function tracing also confirmed lookups through pid_update_inode(),
tid_fd_update_inode(), and map_files_d_revalidate().  Additional B
diagnostics reached a seqcount read during an update, a read that needed
retry, and the path that avoids an inode write.  The tests changed fd/40
between read-only and write-only files and exercised lookup during task
exit.  No KASAN or locking warning was found.

SELinux was disabled, and KCSAN was not run. The A/B results establish
the effect of the two patches together, not each patch separately.


performance testing:

I compared three kernels built with the same configuration and compiler:

  A: neither patch
  B: "proc: serialize task owner lookup and inode updates"
     (proc-serialize-task-owner-updates.patch)
  C: B plus "proc: don't lock task inodes whose owner has not changed"
     (proc-dont-lock-task-inodes-whose-owner-has-not-changed.patch)

Each ran in a separate 64-vCPU, 16-GiB QEMU guest with two virtual NUMA
nodes. SELinux and KASAN were off. A local test program repeatedly
stat()ed, opened, or readlink()ed proc entries with concurrent workers.
Each figure below is the median of three 3-second runs, in million
operations per second; brackets show the range.

Operation                         A             B             C       C/A
64 threads: thread-self/stat   7.42 [7.37-7.45] 2.31 [2.30-2.48] 9.00 [8.92-9.24] +21%
16 processes: one pid/status    3.83 [3.82-4.07] 1.48 [1.47-1.52] 5.05 [5.04-5.20] +32%
64 threads: self/status stat    1.96 [1.91-2.05] 1.83 [1.81-1.88] 2.05 [2.04-2.11]  +5%
64 threads: self/status open    1.28 [1.26-1.31] 1.22 [1.21-1.22] 1.25 [1.24-1.26]  -3%
64 threads: self/fd readlink    1.21 [1.21-1.22] 1.22 [1.21-1.32] 1.35 [1.30-1.36] +11%
64 processes: separate pids  120.11 [119.39-120.27]
                              115.43 [114.86-115.61]
                              113.05 [112.62-113.15]                         -5.9%
1 thread: thread-self/stat      1.32 [1.31-1.32] 1.29 [1.28-1.29] 1.28 [1.28-1.29]  -3.0%

The second patch more than recovered the large shared-inode throughput
losses introduced by the first.  The separate-pid test remained 5.9% below
A, with non-overlapping ranges, and the one-worker result was just over 3%
below A.  Repeated "ps -fe" runs were essentially unchanged at about 52
calls per second on all three kernels.

The timed tests totalled 198 seconds.  These are guest measurements; they
do not establish the cost on bare metal or PREEMPT_RT.  The ps run did not
include thousands of background tasks.

 fs/proc/base.c     |   65 ++++++++++++++++++++++++++++++++++++++-----
 fs/proc/fd.c       |   20 +++++++------
 fs/proc/inode.c    |    1 
 fs/proc/internal.h |   29 +++++++++++++++++++
 4 files changed, 100 insertions(+), 15 deletions(-)

--- a/fs/proc/base.c~proc-dont-lock-task-inodes-whose-owner-has-not-changed
+++ a/fs/proc/base.c
@@ -2024,16 +2024,64 @@ int pid_getattr(const struct mnt_idmap *
 
 /* dentry stuff */
 
+/**
+ * proc_task_owner_valid - does a task inode already have the right owner?
+ * @task: the task which @inode describes
+ * @inode: a proc inode which takes its owner from @task
+ * @dump_mode: the mode to pass to task_dump_owner()
+ * @mode: the mode which @inode should have
+ *
+ * Lookups recompute the owner of a task's proc inodes from the task every
+ * time, but it rarely changes.  Check for that without writing to the
+ * inode, so that concurrent lookups of one inode do not contend.
+ *
+ * An unlocked comparison alone is not enough.  The inode may hold the
+ * right owner now while another lookup, which looked at the task before
+ * its credentials last changed, is about to store the old one.  Updates
+ * are therefore made inside a write section of proc_inode.owner_seq and
+ * read the task inside that section.  If no write section overlapped this
+ * check then every later update reads the task after this one did and
+ * cannot store anything older than what was found here.
+ *
+ * @dump_mode and @mode may come from an unlocked read of @inode->i_mode.
+ * Its file type never changes and its permission bits are only changed
+ * by the updates which this function checks for.
+ *
+ * Return: true if @inode needs no update.  If false, the caller must
+ * update it between proc_task_owner_lock() and proc_task_owner_unlock().
+ */
+bool proc_task_owner_valid(struct task_struct *task, struct inode *inode,
+			   umode_t dump_mode, umode_t mode)
+{
+	struct proc_inode *ei = PROC_I(inode);
+	unsigned int seq;
+	bool same;
+	kuid_t uid;
+	kgid_t gid;
+
+	seq = read_seqcount_begin(&ei->owner_seq);
+	task_dump_owner(task, dump_mode, &uid, &gid);
+	same = uid_eq(inode->i_uid, uid) && gid_eq(inode->i_gid, gid) &&
+	       inode->i_mode == mode;
+
+	return !read_seqcount_retry(&ei->owner_seq, seq) && same;
+}
+
 /*
  * Set <pid>/... inode ownership (can change due to setuid(), etc.)
  */
 void pid_update_inode(struct task_struct *task, struct inode *inode)
 {
-	spin_lock(&inode->i_lock);
-	task_dump_owner(task, inode->i_mode, &inode->i_uid, &inode->i_gid);
+	umode_t mode = READ_ONCE(inode->i_mode);
 
-	inode->i_mode &= ~(S_ISUID | S_ISGID);
-	spin_unlock(&inode->i_lock);
+	if (!proc_task_owner_valid(task, inode, mode,
+				   mode & ~(S_ISUID | S_ISGID))) {
+		proc_task_owner_lock(inode);
+		task_dump_owner(task, inode->i_mode, &inode->i_uid,
+				&inode->i_gid);
+		inode->i_mode &= ~(S_ISUID | S_ISGID);
+		proc_task_owner_unlock(inode);
+	}
 	security_task_to_inode(task, inode);
 }
 
@@ -2212,9 +2260,12 @@ static int map_files_d_revalidate(struct
 	mmput(mm);
 
 	if (exact_vma_exists) {
-		spin_lock(&inode->i_lock);
-		task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
-		spin_unlock(&inode->i_lock);
+		if (!proc_task_owner_valid(task, inode, 0,
+					   READ_ONCE(inode->i_mode))) {
+			proc_task_owner_lock(inode);
+			task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
+			proc_task_owner_unlock(inode);
+		}
 
 		security_task_to_inode(task, inode);
 		status = 1;
--- a/fs/proc/fd.c~proc-dont-lock-task-inodes-whose-owner-has-not-changed
+++ a/fs/proc/fd.c
@@ -127,18 +127,22 @@ static bool tid_fd_mode(struct task_stru
 static void tid_fd_update_inode(struct task_struct *task, struct inode *inode,
 				fmode_t f_mode)
 {
-	spin_lock(&inode->i_lock);
-	task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
+	umode_t mode = READ_ONCE(inode->i_mode);
 
-	if (S_ISLNK(inode->i_mode)) {
-		unsigned i_mode = S_IFLNK;
+	if (S_ISLNK(mode)) {
+		mode = S_IFLNK;
 		if (f_mode & FMODE_READ)
-			i_mode |= S_IRUSR | S_IXUSR;
+			mode |= S_IRUSR | S_IXUSR;
 		if (f_mode & FMODE_WRITE)
-			i_mode |= S_IWUSR | S_IXUSR;
-		inode->i_mode = i_mode;
+			mode |= S_IWUSR | S_IXUSR;
+	}
+
+	if (!proc_task_owner_valid(task, inode, 0, mode)) {
+		proc_task_owner_lock(inode);
+		task_dump_owner(task, 0, &inode->i_uid, &inode->i_gid);
+		inode->i_mode = mode;
+		proc_task_owner_unlock(inode);
 	}
-	spin_unlock(&inode->i_lock);
 	security_task_to_inode(task, inode);
 }
 
--- a/fs/proc/inode.c~proc-dont-lock-task-inodes-whose-owner-has-not-changed
+++ a/fs/proc/inode.c
@@ -59,6 +59,7 @@ static struct inode *proc_alloc_inode(st
 		return NULL;
 	ei->pid = NULL;
 	ei->fd = 0;
+	seqcount_spinlock_init(&ei->owner_seq, &ei->vfs_inode.i_lock);
 	ei->op.proc_get_link = NULL;
 	ei->pde = NULL;
 	ei->sysctl = NULL;
--- a/fs/proc/internal.h~proc-dont-lock-task-inodes-whose-owner-has-not-changed
+++ a/fs/proc/internal.h
@@ -8,6 +8,7 @@
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/refcount.h>
+#include <linux/seqlock.h>
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/binfmts.h>
@@ -120,6 +121,7 @@ union proc_op {
 struct proc_inode {
 	struct pid *pid;
 	unsigned int fd;
+	seqcount_spinlock_t owner_seq;	/* see proc_task_owner_valid() */
 	union proc_op op;
 	struct proc_dir_entry *pde;
 	struct ctl_table_header *sysctl;
@@ -137,6 +139,31 @@ static inline struct proc_inode *PROC_I(
 	return container_of(inode, struct proc_inode, vfs_inode);
 }
 
+/**
+ * proc_task_owner_lock - start updating the owner and mode of a task inode
+ * @inode: a proc inode which takes its owner from a task
+ *
+ * The task's credentials must be read after this, so that updates are
+ * applied in the order in which they looked at the task.
+ */
+static inline void proc_task_owner_lock(struct inode *inode)
+	__acquires(&inode->i_lock)
+{
+	spin_lock(&inode->i_lock);
+	write_seqcount_begin(&PROC_I(inode)->owner_seq);
+}
+
+/**
+ * proc_task_owner_unlock - finish updating the owner and mode of a task inode
+ * @inode: the inode which was passed to proc_task_owner_lock()
+ */
+static inline void proc_task_owner_unlock(struct inode *inode)
+	__releases(&inode->i_lock)
+{
+	write_seqcount_end(&PROC_I(inode)->owner_seq);
+	spin_unlock(&inode->i_lock);
+}
+
 static inline struct proc_dir_entry *PDE(const struct inode *inode)
 {
 	return PROC_I(inode)->pde;
@@ -265,6 +292,8 @@ int proc_nochmod_setattr(const struct mn
 extern void proc_pid_evict_inode(struct proc_inode *);
 extern struct inode *proc_pid_make_inode(struct super_block *, struct task_struct *, umode_t);
 extern void pid_update_inode(struct task_struct *, struct inode *);
+bool proc_task_owner_valid(struct task_struct *task, struct inode *inode,
+			   umode_t dump_mode, umode_t mode);
 extern int pid_delete_dentry(const struct dentry *);
 extern int proc_pid_readdir(struct file *, struct dir_context *);
 struct dentry *proc_pid_lookup(struct dentry *, unsigned int);
_

