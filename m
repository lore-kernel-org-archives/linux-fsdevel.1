Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF81732572F;
	Fri, 12 Jun 2026 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277078; cv=none; b=dJ+PxFJYcNd/lNFNvkDFJsxAhkY+YF2KLP+Pr5/DgSch1jfMQXOYfL4JMJRJiPtWdDlP8Sw75EDh78WCmspFqwP7u74JHceoeTgBqHcFnZlhz1cptLybC+vWiDzTNlrO+ttQRloCiNShmGgp3zskFEUaOu4wMqtocMB2eFL4NdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277078; c=relaxed/simple;
	bh=YQpjw6CjgDHu2GUoQStF+/5VcEjlClUWEhZCLkpTKFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqqlBe61WoSkXVa7tC8hZ7gKKlyxfV6gCnm5O/JAgnfsXjv1GvofLcuJ9mLD9v+Of0XOexVgUhdWcgDu/JAtxHe8tAIgQoTu7oIxxRSYTTyiepq/lSa6lwgDpJaiNPo5sQ+Pb3BApBoQGy+OxPd3kG2HgCqq7rsjjpdLsmH4dLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3OGptMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3OGptMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8223E1F000E9;
	Fri, 12 Jun 2026 15:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781277076;
	bh=YQpjw6CjgDHu2GUoQStF+/5VcEjlClUWEhZCLkpTKFA=;
	h=From:To:Cc:Subject:Date;
	b=T3OGptMi3+PJoxbH6P0uSq3JEuLxUHvZWpXawJ1BJ2rqh57YVpcdzmpN517nW8irj
	 gHKcQx6FPrIQX/l/xiNUwaJLyJDANx6u4tGovBjbGukIYEZS57wtCqBLWE4adMXNN1
	 poPljt42XnL5SL4SzXsuJ2SOx/j+U4vV2HeQkS21SSVTmaHVv8OJrY8ELo06+L5H/R
	 if1c0QQYnkOioBnyEBDC/wdVNg89pm+xl2zw3WFvSGZXLy4aFRqDDFOSpMoypgL1fO
	 C9zgAqOgW/G3fn61qaVjqzoJyvts2cwZ6HCuGWBK94SCLNQnjRU1i+mZhpQxdPhmN2
	 RB3mPxytGlUyg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/16 for v7.2] v7.2
Date: Fri, 12 Jun 2026 17:10:52 +0200
Message-ID: <20260612-vfs-v72-20facee87e19@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6118; i=brauner@kernel.org; h=from:subject:message-id; bh=YQpjw6CjgDHu2GUoQStF+/5VcEjlClUWEhZCLkpTKFA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTpKHbKNJ/qmaHrJfIxnaV+Tnt29sulC8/mrU6NWppTW F17dKN0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETiVzIyXFSXsnH3anqacqm4 iNVm5e386nhrs9n26bvEK/LKK2xKGf5X8k9u9TOcztd68XvCnfXPwk/oPTUx/X+jIC0g9Pdxjbs sAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is the batch of pull requests for the v7.2 merge window.

This cycle is light on new uapi and heavy on infrastructure: a couple
of long-standing scalability problems are fixed and a few pieces of
filesystem behavior that file servers have wanted for a long time are
finally exposed.

Case folding behavior of local filesystems is now exposed so file
servers - nfsd, ksmbd, and user space servers - can report it to
clients instead of guessing. Filesystems report case-insensitive and
case-nonpreserving behavior through fileattr_get and nfsd implements
NFSv3 PATHCONF and the NFSv4 FATTR4_CASE_INSENSITIVE and
FATTR4_CASE_PRESERVING attributes which have been part of the NFS
protocols for decades. Windows NFS clients hard-require this
information for Win32 applications to behave correctly, the Linux
client uses it to disable negative dentry caching on case-insensitive
shares, and multi-protocol NFS/SMB servers need it to participate as
first-class citizens in such environments.

openat2() grows two new flags. O_EMPTYPATH allows reopening the file
behind an O_PATH file descriptor through an empty path string,
removing the detour through /proc/<pid>/fd and the procfs dependency
that comes with it. OPENAT2_REGULAR refuses to open anything but
regular files, returning the new EFTYPE error code, so services can
protect themselves against being redirected to fifos or device nodes.

exec gains a per-task task_exec_state structure holding the dumpable
mode and the user namespace captured at execve(). Both used to live on
mm_struct which exit_mm() clears long before a task is reaped, so
__ptrace_may_access() and several /proc visibility checks misbehaved
for zombies - denying legitimate access to non-dumpable zombies that
were running in nested user namespaces. exec also stops tearing down
the old mm while holding exec_update_lock and cred_guard_mutex, so
execve() of a large process no longer blocks ptrace_attach() and every
exec_update_lock reader for the duration of the teardown.

The VFS prerequisites for directory delegations land: lease holders
can opt out of having specific directory change events break their
delegation and fsnotify grows the helpers nfsd needs to drive
CB_NOTIFY callbacks from inotify watches in a future cycle.

Acquiring an inode reference becomes lockless as long as the refcount
was already at least 1, so only the 0->1 and 1->0 transitions take
inode->i_lock anymore.

The race between cgroup_writeback_umount() and inode_switch_wbs() that
could trigger "VFS: Busy inodes after unmount" and a use-after-free on
percpu counters is fixed, and the global serialization in the umount
path is replaced with a per-sb counter. Umount latency under cgroup
writeback churn drops from ~92-138ms p50 to ~5-8ms p50. Writeback also
learns to track dirty RWF_DONTCACHE pages per bdi_writeback so the
flusher can be kicked in a targeted fashion, improving uncached write
performance.

b_end_io is removed from struct buffer_head. The completion path loses
an indirect function call, struct buffer_head shrinks from 104 to 96
bytes, and a corruptible function pointer in the middle of a writable
data structure goes away. All in-tree users are converted to the new
bh_submit() interface.

fs/eventpoll.c is extensively documented and refactored. The
invariants the recent UAF fixes relied on were nowhere written down
and had to be reverse-engineered, so they are now codified in source,
long function bodies are split into named helpers, and the per-CTL_ADD
scratch state moves off file-scope globals. epoll also gains a
file-based control interface so io_uring can stop supporting nested
epoll contexts, and a long-standing race that made epoll_wait() report
false negatives with a zero timeout is fixed.

The simple xattr infrastructure moves its hash table into a
per-superblock cache and handles lazy allocation internally instead of
burdening every caller. On top of this bpffs gains support for
trusted.* and security.* xattrs so metadata like content hashes or
security labels can be attached to pinned objects.

iomap brings the vfs infrastructure required for fs-verity support in
XFS with a post-EOF merkle tree, stops pointlessly zeroing the iomap
on the final iteration which improves polled I/O IOPS by about 5%, and
introduces the IOMAP_F_ZERO_TAIL flag needed by filesystems with a
valid data length like exFAT and NTFS.

The string emitted from /proc/filesystems is pre-generated and cached
and the filesystems list is RCU-ified. The file is read by libselinux
and thus by a surprising number of programs; open+read+close goes from
~440k to ~1.06M ops/s single-threaded and from ~600k to ~3.3M ops/s
with 20 processes. procfs mounts with subset=pid are exempted from the
full mount visibility checks, unblocking procfs mounts in rootless
containers, and most ptrace_may_access() users in procfs now hold
exec_update_lock to avoid TOCTOU races with concurrent privileged
execve().

pipe writes pre-allocate pages outside pipe->mutex so readers no
longer stall behind a writer doing direct reclaim under the mutex,
improving throughput by 6-28% and up to 48% under memory pressure.

sget() is retired with the last users converted to sget_fc(), and the
exportfs support for block-style layouts is cleaned up in preparation
for multi-device filesystem exports.

Smaller items include a fix for the bpf dentry xattr kfuncs with
negative dentries, per-instance lockdep classes for rhashtable, fixes
and new helpers for the copy_struct_*() machinery, set_blocksize()
error handling for a pile of legacy filesystems that crashed when
mounting devices with sector size > PAGE_SIZE, SB_I_NOEXEC and
SB_I_NODEV being set by default in init_pseudo(), honouring SB_NOUSER
in the new mount API, a SOFTIRQ-unsafe lock order fix in fasync
signaling, an FS_USERNS_DELEGATABLE flag to unbreak delegated NFS
mounts in containers, documentation with guidelines for submitting new
filesystems, and assorted selftest fixes and cleanups.

Thanks!
Christian

