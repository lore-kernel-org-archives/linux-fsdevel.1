Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66ED2FE07D
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950476; cv=none; b=FbVA3c1k4k0mUuEvvD2xz5cQYQPtk2clMCjvJUjhmZIv2VWdebu/eZMDZ0OKTaOOcSa+ytOLbqI8Q2zY2jRKU1YmRv0pausGISTzH7EN4mxj2tIggOH3fZ6Yng3ZIAiWUtoSJps1l7pnvid10vNRIAHSQhhIRC3Q7/KPdbjbNG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950476; c=relaxed/simple;
	bh=5MZ6/GXepeEqyZK5VUBvVBXRH6vAYoKtok5t9ebCl64=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=buOerEpmPWrLcUWfPx1h0CxMgmbpfUWHHL/RidPqK1/nDtqBfB7t797ni9lhrj68AoFQrZDhDHhVaTZu728jOJez/qEpzLrF1COl7cPDJZLTGeSBp3ng1vmJubPiQ+xge9JNmYvU/bPFqoKRtfDy+E292x9qfJx9wGnOcc0vyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfUcrSFt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfUcrSFt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E401F000FF;
	Fri,  2 Oct 2026 14:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950474;
	bh=WbrVaIWa8pGJW80qrGIOJhkjqSK+yC+dVe0R3YErg9I=;
	h=From:Subject:Date:To:Cc;
	b=lfUcrSFtrAOJMe9cjH1KbyOV9wLPNroyKrO+uPDG55JwvGoiNHuJziNFArpZc7oP+
	 o7TIBqs5rF1F3uPgmy4zhC4bHbYTYO1XI8Wdy21P4yOKY+tIWWMyvSPBuyGzvKIpOm
	 Jw3dDTG1ZYalDXCZTH1hWL31leW10JLlHSyJuV2q5N/x1Y4aFuRtrFoqfEydEtct4u
	 h+vltNajbTV5YJX/CzdpWEpHMV8s0unBbSicIh8rIIc/qrTz8nYCS99mW8nE72cr4q
	 S+4YAWPQoR+nwj/Z4F7tKqysAKCFMDxbpRogEQ8OBmMs4PIauHmAgNXqn8yZZnF1u5
	 pHcCYjT94GQiw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/3] namespace: rework connected mounts
Date: Fri, 02 Oct 2026 16:14:26 +0200
Message-Id: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMSw7CIBCA4as0s3YIkFijVzEuBpxaNIIZ+jBpe
 ncBl/88vg0yS+AMl24D4SXkkGIJc+jAjxQfjOFeGqy2vdHa4prkhe80xwl9WljQGW096+P5RAT
 l7SM8hG8jr7d/59k92U/VqReOMqMTin6soyqqJqomqrqHff8B+NMe1ZwAAAA=
X-Change-ID: 20261002-work-mount-cover-b102ce0597aa
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=5332; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5MZ6/GXepeEqyZK5VUBvVBXRH6vAYoKtok5t9ebCl64=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3+N2ZvMDFd5pDGmO1aYOJ1/FLZ+07eDGaIsPX7m5O
 K26OtVOdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkuTEjw4GzJWad75ND6tny
 am+5el3UEV3ya/3LB0J3evftDdbMWs7IsCz56NrSe3VfJyZUXhZRX1+wOMG8t/Pbprb77FkvRSZ
 bcAMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This is a simplified version and doesn't require vacating existing
mounts and doesn't require such heavy machinery.

UMOUNT_CONNECTED as implemented allows for the creation of reference
count cycles. Here's a simple example

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
UMOUNT_CONNECTED. Once the namespace exits nothing references the mount
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

The underlying mechanism is UMOUNT_CONNECTED (MNT_LOCKED falls into the
same class). With UMOUNT_CONNECTED an unmounted mount stays attached to
its parent. This is used to protect revealing the underlying mount and
is a non-negotiable security mechanism. So now the parent owns that
mount and is put on the parent's final mntput(). That moves it to
mnt_stuck_children and ultimately it's cleaned up by cleanup_mnt().

The fact that ownership of the child mount gets transferred to the
parent turns every reference from a child's superblock back to one of
its ancestors into a cycle.

Don't keep the child attached at all. What the parent needs is that a
lookup at the child's mountpoint keeps finding some mount, not the child
itself and it's not a guarantee we have given really.

When an unmounted mount would have stayed attached to its unmounted
parent disconnect it like every other unmounted mount and leave a
marker behind.

A lookup on the parent that misses the mount hash and hits a marker
finds knullfs. Either a file or a directory. Nothing leads from a marker
to any other mount.

The marker is owned by the parent and dropped by the parent's final
mntput() or by __detach_mounts() when the mountpoint is deleted from
under it. It is allocated together with the mount.

With that every unmounted mount is a root and holds only its own
reference which namespace_unlock() drops. No unmounted mount owns
another one. A superblock that pins an ancestor can't form a cycle.

It has a visible change. Mounts left connected (rmdir etc.) used to stay
traversable through the parent for as long as something held the parent.
Now it is detached with the umount. It lives as long as something
references it but it isn't reachable through the parent anymore and ".."
inside it leads nowhere which is the same as for every other lazily
unmounted mount.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (3):
      nullfs: add an empty immutable regular file
      namespace: rework connected mounts
      selftests/filesystems: test covered mounts

 Documentation/filesystems/propagate_umount.txt     |   12 +-
 fs/mount.h                                         |   11 +-
 fs/namespace.c                                     |  154 +-
 fs/nullfs.c                                        |   46 +
 fs/pnode.c                                         |    4 +-
 .../selftests/filesystems/mount_cycle/.gitignore   |    3 +
 .../selftests/filesystems/mount_cycle/Makefile     |    7 +-
 .../selftests/filesystems/mount_cycle/config       |   39 +
 .../filesystems/mount_cycle/locked_handle_test.c   |  377 +++++
 .../filesystems/mount_cycle/loop_cycle_test.c      | 1542 ++++++++++++++++++++
 .../filesystems/mount_cycle/mount_cover_test.c     |  565 +++++++
 .../selftests/filesystems/mount_cycle/settings     |    1 +
 12 files changed, 2709 insertions(+), 52 deletions(-)
---
base-commit: e7d906b21f721c8ed884cecabdb182626941beb8
change-id: 20261002-work-mount-cover-b102ce0597aa

