Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD28C416853;
	Fri, 16 Oct 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145646; cv=none; b=jbqfFMHkXRgsd4Qi8nRDG2D6gsKVgk2N1YN5WvRlLQ6AqVxZMPS64Ugp8fsoIqEqYJYpFu4GAlZFxp3P4bp1Uq02dQ3pxyNv9D1F5ga+kz0nLFqP+Be6xbiRcmBCYblVGUJ3ABcvZ7n7vwUvcA2rn2pA47b/0o+dEQPqkVvFjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145646; c=relaxed/simple;
	bh=tKfn716cXNF8cVTlb7mqh7tKgPs6n2TVap2tkVo4jOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YnELsAFPF6P52912TiUPQW/Ui4CKPAUjB0ocsqk461xu8ZkwJ15uot3AX8QoLWlvXLU+ZJDegR2RykVfYskdwL9DH+z9FOKJia6Eu7MkFjkaPjDqHpqg0R4c9pC5zBsCS6cahcaUf/oblv46EqSgYRMBlGODQH7bdxIhLeTF5rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLtAQRdG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLtAQRdG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068601F000C5;
	Fri, 16 Oct 2026 10:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145644;
	bh=tKfn716cXNF8cVTlb7mqh7tKgPs6n2TVap2tkVo4jOo=;
	h=From:To:Cc:Subject:Date;
	b=bLtAQRdGFZu4iKIwPOKy/QMk3sERZ6G/ZPCgbx+E0mW3xg86laYSf7N4RBM0a0Hqy
	 rsq3py2rNWLZRTHHGpek+yWrc6+aLLTa+UeNy5us18yED9GMwu6rViNy11wQYN8eUf
	 54YkfxVFuPtyYK/wjXoeyqqcCEdbQ5wPTPpUO0wEkR760MabYucLYxtvBoJj8/Ya5u
	 +mE1UK2lE5gPK37gP8uSD3A+68u4bpTX21hQiFVEQuIk6E4TtKrd8rlklHWNGoq5rh
	 v9LloB7k+2TRiNrJH11Owfg9JfEMiI9q2ZxmgMKV33k53S2eCIO37FWHMiPu4AxJ21
	 VLJ47DgEYzSZQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 00/19 for v7.4] v7.4
Date: Fri, 16 Oct 2026 12:13:45 +0200
Message-ID: <20261016-vfs-v74-41eaf6c4712c@brauner>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6899; i=brauner@kernel.org; h=from:subject:message-id; bh=tKfn716cXNF8cVTlb7mqh7tKgPs6n2TVap2tkVo4jOo=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRd/HGP6/7ypPiUcgWVMm/pKcUevUkzuu6bBf9a6tehe qxDSWFtRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERmBDL8Fbp7O263ccrN6Q+a yh9UPvgSGen/rEmlWafqfLUxx43WeIZ/eo+eHLbkPXondN1n1f3HD134zpBx4+aLD6V9Ns1ec/M f8wEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is the batch of pull requests for the v7.4 merge window. So I took
the insane decision to follow-up LPC with a vacation and now I'm
creating PRs next to a pool. So fsck me for great timing. This should
hopefully explain why there's some delay in response time. The other
half is that I'm getting carpet bombed with subtle bugs and I'm trying
to fix them systematically. While LLMs are great at finding sh*t they
certainly do still suck at coming up with architecturally clean fixes.
90% of the proposed "fixes" are utter garbage.

Anyway, on to the content:

This cycle is heavier on uapi than the last two. close_range() grows
two flags, the coredump socket protocol learns records, sparse dumps
and per-request memory type selection, open_tree() gets a flag that
container runtimes need and af_unix sockets can hand out thread
specific pidfds. The rest is the exit, exec and coredump paths getting
a lot of attention, kernfs scalability work out of Meta's fleet and a
few treewide conversions.

Closing files is synchronous now for close_range(), exec and exit.
Every final __fput() of an exiting task used to be queued on task work
and run from exit_task_work(). For a large descriptor table that is a
cmpxchg() and a TIF_NOTIFY_RESUME test-and-set per file and then a
second pass over every struct file that isn't cache hot anymore.
close_files(), close_range() and close-on-exec flush and put each file
inline the way close(2) does. Tearing down 1M descriptors goes from 429
to 306 ms on exit and from 471 to 325 ms on execve(). That is a 16-21%
win or 40-150 ns per closed file. The spufs coredump support, the only
reason do_coredump() unshared the descriptor table, goes away as part
of this.

close_range() gets CLOSE_RANGE_EXCEPT which makes it operate on all
file descriptors outside of the range and CLOSE_RANGE_CLOEXEC_ONLY
which closes only the close-on-exec descriptors in it. Together they
let a task between clone(CLONE_FILES) and execve() shed everything
except for a window of descriptors in one call and nothing outside of
the window is ever referenced by the child.

The coredump socket protocol learns to send a coredump as records. A
server raising COREDUMP_RECORDS gets a header in front of every chunk
and an explicit end record. With COREDUMP_SPARSE holes cross the
socket as a bare header saying how many zero bytes were skipped. A
process with 128 threads sends 1424153 bytes for a coredump of
1075150848 bytes since all the thread stacks are 8 MB reservations
that are nearly all holes. COREDUMP_MEMORY_TYPES lets the server pick
what memory to dump per request instead of relying on the static
coredump_filter of the crashing task.

TIF_NOTIFY_SIGNAL can no longer interrupt work that can't be restarted.
It is used to kick a task out of an uninterruptible sleep to run task
work but the pipe and socket paths a coredump goes through check
signal_pending() deep down and bail. So a crashing process with
io_uring requests in flight lost most of its coredump.
PF_NO_NOTIFY_SIGNAL sections modelled on memalloc_nofs_save() fix that
for coredumps, the smb send path and the pid namespace reaper. Looking
at the coredump code with kres and TLA+ also turned up a UAF when
releasing parked threads, shared signals retargeted to the dumper that
truncated cores, io-wq workers that could join a thread group a
coredump was already tearing down and an SQPOLL deadlock when a user
worker ends up as the dumper.

kernfs loses most of its kernfs_rwsem contention. The semaphore is per
kernfs root so sysfs and cgroupfs each have one for the whole machine
and rwsems don't let readers steal the lock once a writer is queued.
So one cgroup creation parked every daemon polling cgroup files in
uninterruptible sleep for minutes, oomd and below among them. Dentry
revalidation runs under rcu now, readdir drops the lock across
dir_emit() so a fault into reclaim can't hold it, and notification
delivery, open node allocation and renames stop sleeping under it.
Read acquisitions under churn drop from 48.6M to 1.3M and path walk
throughput improves 35-53%.

The buffer_head write completion handlers stop clearing BH_Uptodate
when a write fails. The buffer still holds exactly the data the
filesystem asked to be written and claiming otherwise made the retry
WARN, re-read the stale on-disk copy over the good data and leaked an
inconsistent state through the folio lock. Every consumer is moved to
BH_Write_EIO. This also let jbd2's shadow buffers point at memory
outside the page cache and removed b_page.

struct mnt_idmap is const throughout the tree now. A mount's idmapping
is immutable after creation so this follows the struct cred model all
the way down into every inode operation, the LSM hooks and the
filesystems, and nop_mnt_idmap and invalid_mnt_idmap live in rodata.

iomap gains lazy bounce buffering for checksummed reads. XFS bounce
buffered every direct read on a device requiring stable pages. Now the
read goes to the user buffer first and only a checksum failure reads
again into a bounce buffer. That branch is shared with the block tree.

Neil's preparations for changing directory locking are in. The goal is
to lock the dentry rather than the parent directory. d_splice_alias()
handles hashed dentries, d_alloc_trylock() and d_duplicate() are added,
LOOKUP_SHARED tells ->lookup() how the parent is locked and the
in-lookup state is tracked by lockdep. Mateusz also removed a spurious
dentry reference cycle on open which is a 39% win in will-it-scale.

Cachefiles can now cache files that are written once sequentially
without asking the backing filesystem with SEEK_DATA/SEEK_HOLE before
every read, and netfslib drops the writethrough code and makes the
deprecated PG_private_2 support opt-in.

open_tree() gets OPEN_TREE_DROP_MNTNS_MOUNTS. A recursive clone picks up
mount namespaces pinned below the source and attaching that inside a
namespace created with OPEN_TREE_NAMESPACE fails with ELOOP since the
new namespace is younger than everything else. crun hits this on every
Ubuntu host because snapd pins mount namespaces under /run/snapd/ns.

af_unix sockets return thread specific pidfds via SO_PASSPIDFD_THREAD
and SO_PEERPIDFD_THREAD so a coredump server can get a handle on the
thread that is actually writing the dump. That branch is shared with
net-next.

Smaller items include the removal of bfs, binfmt_misc only accepting
punctuation as the delimiter of a register string, uid_map and gid_map
writes rejecting values that don't fit in a u32 instead of truncating
them, __counted_by_ptr annotations with KUnit tests for struct fdtable
and struct uid_gid_map, a simplified FD_PREPARE(), get_tree_super()
for erofs's shared superblocks, and the usual pile of fixes and
selftest work.

Thanks!
Christian
