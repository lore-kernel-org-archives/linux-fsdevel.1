Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0F2408031
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 22:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289350; cv=none; b=DeBU8hRKQSsEIXxEUDLR+b9Ruyhhtf5igsG5uHsPyHazK5zdsLkE/GzMEuFn34+QbinqTX4mfLm0Xz08VsLExAYEG5QPRuBVeyFUrEsfiXJQ3Rd91StcKJ352HF/h8QdHbHEnIJVyYDWs3kPR1lcKkA92mRKF2MSrge78eZ3ZLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289350; c=relaxed/simple;
	bh=VkuZfoMYEKg1+rHFTm8uyVoikAb+qkmFSDxXEnG83Oo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kP/O4xXi1HPMeOrb02kLemKrTEQUwjnb0hZdb8FzGKk6NU6hm0NWVsWz2fAMGXBumPyxx4Qh3X9zEn0prkNjIgQ7xx4XD6CrDUqaKAwjT1XIeswCeldXkRcStq8jfX19EJ/1fpFosAMS1vHyqj2+CcaY1Sr/4cqAzCslI0OJoXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BpL2K7LQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BpL2K7LQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C331F00893;
	Thu, 24 Sep 2026 22:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790289348;
	bh=OtAhIlpeX1/xj+9NfWWOjw03XYTeZZzR/sUZSD9Ouxw=;
	h=From:Subject:Date:To:Cc;
	b=BpL2K7LQbroACNrBQ0xonf6TNZeDI3PlSS9YhXE9LzMcIqPdG1E96aBSXsgfDz21/
	 Z6fs18H+b2CSYQ/qszJdDtf/7ESDcKb9OQl3WlTNFkOHa3Ny6C86F4MzwUAWtT9Lik
	 xziXXUFPWiiFALtGg9GJdAilc8F0ojxXvHFo7jbsFenLKo6RqgRjl72M6rgCKv0/6Z
	 EtMPM14MSXhhc8TGjH6csiQESaIW+sPgQeiO0fhkc5YOtbR5lnoYhobo+Tv46fqB5h
	 8r1dNZtowlBOOE4jLyQT7jggShMGGL4fIu1l4LFT6tcTw69+UYZyTipgb35IeCG3as
	 zzvZcf9rbtheg==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH RFC v2 0/8] namespace: prevent UMOUNT_CONNECTED reference
 count cycles
Date: Fri, 25 Sep 2026 00:35:40 +0200
Message-Id: <20260925-work-mount-knullfs-v2-0-c4aebaa186e9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBREr0L+2jZQCIorExMP4NawaMsHKtiaF
 lBDuLu0snQ5k5mXN4NDq9DBMZrB4qScMnoNbBeBbLlukKhqzcBilscFS8nL2I48zKgH0umx72t
 HsopzkaEo6jiH9fi0WKt3gN7gejlD+SvdKO4oB4/zM8EdEmG5lq2vPJgGMN3A1C/8slVuMPYTJ
 KckYDef7J/PlJCYcDwUghX1Xor01KHV2FNjGyiXZfkCPeW3uvYAAAA=
X-Change-ID: 20260923-work-mount-knullfs-4daab4eb9f06
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=6593; i=brauner@kernel.org;
 h=from:subject:message-id; bh=VkuZfoMYEKg1+rHFTm8uyVoikAb+qkmFSDxXEnG83Oo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtXXrAdoGqZqOm/AG7D8t5RZ4cjEnpq2O8zZPZsG2Bb
 7Gn6C77jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInM2srIsMtkudu9G54t8bY7
 WoOaDs1Y7b0/M/ppyW+hJW8uTP3slc7I0BFfyNja8Sp9dySb6k3Za9dmS5VaMl7n7mNR+vRlLUs
 TFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Have barf bags ready, please. Afaict, UMOUNT_CONNECTED as implemented
allows for the creation of reference count cycles. Here's a simple
example:

  mkdir /x; mkfifo /ready /go
  unshare -m sh -c 'mount -t tmpfs tmpfs /x
                    truncate -s 8M /x/img; mkfs.ext4 -q /x/img
                    dev=$(losetup -f --show /x/img)
                    mkdir /x/mp; mount $dev /x/mp
                    echo $dev > /ready; read r < /go' &
  read dev < /ready
  rmdir /x
  echo > /go
  wait
  losetup -d $dev
  losetup -a

Take a directory /x on the host, create a new mount namespace, mount a
tmpfs on /x, use a file on that tmpfs as the backing file for a loop
device, mount that loop device on that tmpfs. Now rmdir /x on the host.
This will lazily unmount the mount on top of /x in the container with
UMOUNT_CONNECTED. Once the namespace exists nothing references the mount
anymore. Now the tmpfs is pinned by the backing file of the loop device
and the loop mount is owned by the tmpfs superblock.

Fun fact, such cycles can be formed by at least the following
subsystems and I have added reproducers for all of them:

(1) a loop mount P from an image on a tmpfs next to it, so that P's
    death shows as the loop device giving up its backing file

(2) autofs with a FIFO on P as its pipe, zram with a device node on P as
    its writeback device, both on a minix image since vfat has neither

(3) ecryptfs with its lower directory on P, under a passphrase token
    added to the session keyring

(4) binfmt_misc in a new user namespace with an 'F' interpreter on P

(5) a fuse server that answers FUSE_INIT with passthrough on and
    registers a file on P as a backing file

(6) zloop with its zone files in a directory on P

(7) a mass storage gadget on the dummy UDC with its LUN file on P,
    mounted from the SCSI disk the gadget shows up as

(8) md with a RAID1 of one loop device and its bitmap file on P, which
    skips while SET_BITMAP_FILE has no way to succeed

(9) rmdir of P's mountpoint from the parent, then the child exits, then
    the device must be free and LOOP_CLR_FD must release the file

I have explored various solution and have branches for most of them. All
suck ass. Highlights include to port everything to use private mounts
similar to what overlayfs does. It's ugly as fuck and it needs a
side-channel to communicate to umount that the underlying thing like the
loop device is still in use so we don't cause spurious EBUSY errors.
It's really not nice.

The underlying mechanism is UMOUNT_CONNECTED (MNT_LOCKED falls into the
same class). With UMOUNT_CONNECTED an unmounted mount stays attached to
its parent. This is used to protect revealing the underlying mount and
is a non-negotiable security mechanism. So now the parent owns that
mount and is put on the parent's final mntput(). That moves it to
mnt_stuck_children and ultimately it's cleaned up by cleanup_mnt().

The fact that ownership of the child mount gets transferred to the
parent turns every reference from a child's superblock back to one of
its ancestors into a cycle.

Don't let the parent own the children. A mount that stays attached
keeps its own reference. namespace_unlock() drops it parents first.

A subtree that nobody refers to now also collapses exactly like a
disconnected one.

So, the problematic case was always a mount that loses its last
reference while it is still attached. That can reveal the covered
directory and that's caused fun exploits. UMOUNT_CONNECTED was always a
sucky mechanism imho.

Instead of that, when a mount loses its last reference but is still
attached to its parent we know that it is a UMOUNT_CONNECTED or
MNT_LOCKED case. Don't take it out of the hash. Instead make it a nullfs
mount. It's an immutable directory that is part of no namespace. Let
that nullfs mount be owned by the parent and put by the parent's final
mntput() the way locked mounts always were.

Ownership can't form a cycle anymore. A vacant mount is pointing at
knullfs. That's nullfs instance that can't go away and doesn't have any
child mounts whatsoever. Nothing leads from a vacant mount back to any
other mount.

Any lookup that still reaches the parent now finds an empty read-only
directory at the mountpoint. Creating anything in it fails with ENOENT,
like every lookup in nullfs does.

The only visible change is for a locked mount under a lazily unmounted
one. It used to stay alive and traversable for as long as something held
the parent. Now it is released with the umount when it isn't referenced
anymore and an empty directory takes its place. What it covered stays
covered either way.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Changes in v2:
- Don't take unnecessary references and simplify freeing of vacated mounts.
- Link to v1: https://patch.msgid.link/20260924-work-mount-knullfs-v1-0-ae89b29f7cb3@kernel.org

---
Christian Brauner (8):
      fs: refuse fspick() on internal superblocks
      fsnotify: record the superblock a connector is accounted on
      fs: put the old fs_struct before the old namespaces in unshare()
      namespace: drop the file's reference first in dissolve_on_fput()
      namespace: prevent UMOUNT_CONNECTED reference count cycles
      selftests/filesystems: check that a loop mount below a dead mount is released
      selftests/filesystems: check the two-step cycle over crossed loop images
      selftests/filesystems: check that the holders let go of a dead mount

 fs/file_table.c                                    |    3 +-
 fs/fsopen.c                                        |    3 +
 fs/mount.h                                         |   13 +-
 fs/namei.c                                         |    4 +
 fs/namespace.c                                     |  186 ++-
 fs/notify/fsnotify.h                               |    3 +-
 fs/notify/mark.c                                   |    7 +-
 include/linux/fsnotify_backend.h                   |    2 +
 kernel/fork.c                                      |    9 +-
 tools/testing/selftests/Makefile                   |    1 +
 .../selftests/filesystems/mount_cycle/.gitignore   |    2 +
 .../selftests/filesystems/mount_cycle/Makefile     |    6 +
 .../filesystems/mount_cycle/loop_cycle_test.c      | 1225 ++++++++++++++++++++
 13 files changed, 1422 insertions(+), 42 deletions(-)
---
base-commit: 2d2a2d7aa98741b58f54cacc99b52024e4d865f9
change-id: 20260923-work-mount-knullfs-4daab4eb9f06

