Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C85849EC73;
	Mon, 12 Oct 2026 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819569; cv=none; b=gRWmpHwZ+9W+fvPIev9iqZ0MH6/5w5ePQKgN8l6NoGEMtSU2901zvcDNGC60RdIxCJQ+SnaA+QuMBcYp5cK3yp1F2PrtT9XgKhpLPVWpdzCPwSaTyfbdGBGNAJE1FE2642ifIZrTdldHqKskkTzSUoVJ6O8spgDAzoduk533nsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819569; c=relaxed/simple;
	bh=lY3NeJUAwbfxYOHwgXB8i3VJrftrt0tWOoNdT1M1KS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FDEd6+wKMzvzsVIKOvfA9co2uFeh7be1pgIQgPEhhdVrvsDAHGADhwqyYGvS/YP5cW8bNXsd8p3J8lgafwS50LNKz0XBnXqBSccGjch7acCYjBAr0/kG/YhFsMCDJsrCLZIyqlnCJyacUBIbr1svY69gFhJ2y7JGRooPwQ5FlAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBxAKdDy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBxAKdDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11DEC1F0089C;
	Mon, 12 Oct 2026 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819567;
	bh=+yax7j88qMloccy+x1mhLxEKpC9UQXnFyb9ne9vR688=;
	h=From:Subject:Date:To:Cc;
	b=HBxAKdDycpY+loeT9ocZnMt7hJseB8Y5ns2bfVM86wWm0GpYN1zFp7fN06KPYPVcg
	 iv1oU1CD7DPBDhmGQiCNMyoi3p5m5/3WOoBdWOfJ6EYzQj9eghRCayFXV5MP9cb9D1
	 FcMoUny4qwFRpWarfnNItsFjeqwJ44A2FPyz5ugjMNs1+fOhGXZV0HQxpXteHIfkVI
	 Al8vGjLKFn/t14W57mA5WdQw8RHjkeS6cmolpIZZnvRsmh/xutqP/hCmSeFicud3Q0
	 AqUEK2uyQJpc3+eqw3XDsOBGOkLVZwMNRLvrP1hW/cIROSoAOAlYLU0cE0ci+bv6Qs
	 ZV8ef+A8lArEQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/9] fs: unmount without a grace period when nothing else
 holds the mounts
Date: Mon, 12 Oct 2026 17:39:13 +0200
Message-Id: <20261012-work-mount-gp_on_demand-proposal-v1-0-43f60221a7d0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/02N4QqCMBRGX0Xu7+6YQzJ7lRDZ3E1XuY1NKxDfv
 c0I+nk+Ps5ZIVIwFOFcrBDoaaJxNkF5KKAfpR0IjU4MgotjyXmDLxfuOLnFzjj4ztlO0yStRh+
 cd1E+sK5PnIuq0o2QkDQ+0NW898Sl/XJc1I36OXvzQ8lIqIK0/ZinXGB7gf0X2K/A8h+27QOgO
 fcavAAAAA==
X-Change-ID: 20261009-work-mount-gp_on_demand-proposal-77800244d92a
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Paul E. McKenney" <paulmck@kernel.org>, NeilBrown <neil@brown.name>, 
 Alexander Larsson <alexl@redhat.com>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, lkmm@lists.linux.dev, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7668; i=brauner@kernel.org;
 h=from:subject:message-id; bh=lY3NeJUAwbfxYOHwgXB8i3VJrftrt0tWOoNdT1M1KS0=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd+a99NIPhtkrCXs+jMTdebNXYabXReH+d0fvLl3ryJ
 px/1MJk2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRpzoM/11t13y+tP/P+xQD
 /dcXpx0I83FrPV2sNu1xS9Tqo4tjV91hZGj6yhh583Hu8T/7Zn0zrla6e+HXLb11kfNXbXjBNXX
 a3MnMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

namespace_unlock() waits for an expedited grace period every time it
puts a batch of unmounted mounts. The RCU delay was added for lockless
path walk in 2013. The fast path of mntput_no_expire() started relying
on it in 2018 and Neil made it expedited the same year because 5000
umounts took 100 seconds otherwise.

An expedited grace period IPIs every CPU. On a 64 vcpu VM that's 20 to
30 microseconds per namespace_unlock(), two thirds of tearing down a
single detached mount. On PREEMPT_RT or with rcupdate.rcu_normal=1 it's
a normal grace period of 6 milliseconds and podman run --rm pays 14 of
them per container.

People have tried to get rid of it before. There was a series to hand
lazy umounts to a workqueue. It was dropped from 6.16 again after LTP
found loop devices busy right after umount -l and mkfs corrupted an ext4
image that a kworker was still tearing down. Returning from umount(2)
before the filesystem is gone is a uapi change, lazy or not. I also
tried sampling the grace period state in umount_tree() and polling it in
namespace_unlock() but the two are only microseconds apart. No gain.

So let's elide the grace period when it isn't needed. Since commit
7eb84d54fac5 ("fs: don't let a migrating task hide its reference from
do_umount()") the per-cpu count is split into gets and puts and the
puts are summed first. A count of exactly one under mount_lock after
the mount has left its namespace can only be the mount's own reference.

A holder's get is counted whenever its put is. A walker's increment is
either counted or the walker sees the seqcount change and backs out
under mount_lock where it finds MNT_DOOMED. And nobody can find the
mount anymore. So we drop the reference and finish the mount off right
there. Everything else waits for the grace period as before. The fast
paths of mntput_no_expire() and __legitimize_mnt() don't change and
nothing changes for userspace.

For that the caller's umount(2) reference has to be dropped under the
mount_lock hold that unmounted the mount so the peek finds the mount's
own reference alone. The peek also has to be the last put.

Taking the grace period away exposes filesystems that unknowingly relied
on it for whatever they touch in rcu path walk (but rest assured that
the bug is reproducible outside of umount(2)). The first patch fixes
overlayfs. ext4, ntfs3 and the unicode map of casefolded filesystems are
broken without this series already because a chdir() out of a lazily
unmounted directory drops the last reference without a grace period too.

The ipc namespace is now freed with kfree_rcu() because free_ipc()'s
grace period also covered the lockless lookups of the namespace tree.

Dropping the explicit smp_mb()s that mnt_get_count() made redundant is
already in vfs.fixes (cf. [2]). This series doesn't depend on it.

A reproducer can't really exercise this so the formal side is heavier
than usual:

- a TLA+ model of a two-mount batch in 62 configurations where every
  mutation found its bug
- 20 LKMM litmus tests, 18 of them added under
  Documentation/litmus-tests/fs/. Every shape the series relies on is
  Never and every barrier mutation is Sometimes.
- the same tests under the AArch64 and POWER models and klitmus7 on
  x86, except the three late walker tests
- a Dartagnan harness of the C that agrees with herd7
- TLA+ trace validation of ftrace traces from the selftest and stress
  runs

All of it is in:

    https://github.com/brauner/linux-formal
    kernel/mount/gp-on-demand-proposal/

umount-bench in kops/s, median of 15 runs on a 64 vcpu VM, base against
the series, with 1 and 8 workers:

    mode               base            series            delta
    mountumount        26.1 /  75.4     57.1 / 125.5    +118% / +66%
    dissolveone        38.2 / 108.5    170.6 / 173.4    +347% / +60%
    dissolveflat       15.5             22.4             +45%
    dissolvechain      15.7             22.4             +43%
    nsdeath             6.15             7.10            +15%
    detachlocked        2.72             3.22            +18%
    lazytree            2.93             3.11             +6%
    held modes         level, +1 to +4%

And scaling with the vcpu count, single worker, median of 9:

    vcpus            1     8    16    32    64   128   256   512
    mountumount    +30%  +44%  +63%  +92%  +83%  +93%  +71%  +75%
    dissolveone    +86% +130% +183% +293% +224% +242% +155% +149%

Above 64 vcpus the per-cpu sums start to dominate a namespace death so
the multi-mount modes only gain 10 to 27% there.

With rcupdate.rcu_normal=1, the RT case, podman run --rm in an 8 vcpu
VM goes from 124 to 93 milliseconds and the 14 grace periods per
container become 9. With expedited grace periods it doesn't move.

[1]: https://lore.kernel.org/r/20261009-work-fixes-rcu-v1-0-7446d2d335e6@kernel.org
[2]: https://lore.kernel.org/r/20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (9):
      ovl: free the ovl_fs after a grace period
      fs: split the final put out of mntput_no_expire_slowpath()
      fs: drop the caller's umount(2) reference under mount_lock
      fs: unmount without a grace period when nothing else holds the mounts
      fs: port kern_unmount{_array}() to mntput_unmounted()
      selftests/filesystems: check that unheld mounts are gone after umount
      Documentation/litmus-tests: add the mount reference count tests
      ipc: free the namespace after a grace period
      ipc: unmount the mqueue mount with kern_unmount()

 Documentation/litmus-tests/README                  |  95 ++++++++
 .../fs/mnt-gp-sees-fastpath-put-nogp.litmus        |  75 ++++++
 .../fs/mnt-gp-sees-fastpath-put-sync-rcu.litmus    |  73 ++++++
 .../fs/mnt-gp-sees-fastpath-put.litmus             |  79 +++++++
 .../fs/mnt-holder-get-before-put-getsfirst.litmus  |  63 +++++
 .../fs/mnt-holder-get-before-put-nomb.litmus       |  62 +++++
 .../fs/mnt-holder-get-before-put-nowmb.litmus      |  62 +++++
 .../fs/mnt-holder-get-before-put.litmus            |  73 ++++++
 .../mnt-kern-unmount-gp-sees-fastpath-put.litmus   |  70 ++++++
 .../mnt-kern-unmount-holder-get-before-put.litmus  |  60 +++++
 .../fs/mnt-sum-misses-fastpath-put.litmus          |  69 ++++++
 .../fs/mnt-walker-bail-sees-doomed-nolock.litmus   |  89 +++++++
 .../fs/mnt-walker-bail-sees-doomed.litmus          |  95 ++++++++
 .../mnt-walker-get-vs-seqcount-no-outer-mb.litmus  |  92 ++++++++
 .../fs/mnt-walker-get-vs-seqcount-nomb.litmus      |  92 ++++++++
 .../fs/mnt-walker-get-vs-seqcount.litmus           | 102 ++++++++
 .../fs/mnt-walker-late-sees-new-pwd-nomb.litmus    |  89 +++++++
 .../fs/mnt-walker-late-sees-new-pwd-nowmb.litmus   |  88 +++++++
 .../fs/mnt-walker-late-sees-new-pwd.litmus         | 103 ++++++++
 fs/namespace.c                                     | 219 +++++++++++------
 fs/overlayfs/ovl_entry.h                           |   2 +
 fs/overlayfs/params.c                              |  29 ++-
 include/linux/mount.h                              |   1 -
 ipc/namespace.c                                    |  17 +-
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   2 +-
 .../filesystems/mount_cycle/unheld_umount_test.c   | 262 +++++++++++++++++++++
 27 files changed, 1974 insertions(+), 90 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261009-work-mount-gp_on_demand-proposal-77800244d92a

