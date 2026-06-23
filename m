Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB235AC24;
	Tue, 23 Jun 2026 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782206163; cv=none; b=LwLTW5NRvFPv2mmKpm/Tt7p6Gzjgjdt/eyBX1G48oKEAwLrLMbjuUu3/RATBg+4v/VotybMwD0S5+el4G0TCIwl3i4jPFjDO5MeT3XtCg0RFGXLGtijSo81pjKCci3RtR/HvWwtqmbg5MoPAGLhtWm8BocecpQ9JuhIYneqJIY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782206163; c=relaxed/simple;
	bh=2fGGWS0P4+GqP7BDsbXG+4M0kJfHb/Qy81cW24j0Es8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WStoYP+HVIL5DgkQxjF3CBd0feURgNAUS/j82POpTmFQCm1hZ4f7V0THLbBOPFB4vLWduc0sW+gEpvih2XyBV9t5J91a1yZz7AtnzVmkfEBnaAeH1RJUltpJk5Sq354CqDQ2kyc/44hg1S77AP6WVayuQF0c3xzVrD93pV3WasI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNaKgmFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNaKgmFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17431F000E9;
	Tue, 23 Jun 2026 09:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782206161;
	bh=dwJksdIzMwz2uxNEIudYReLSHRnKiNyII3cysFwTREY=;
	h=From:Subject:Date:To:Cc;
	b=VNaKgmFmznQyoeBulK2m9ac4kiPLoAR5JPsaxOdisC7FWIf3vYYbj6lRKounZbT6U
	 /+6LumlFCNSd5GgF4g2EZ1H02pFT2iHEqAIlv40GpnhseIE11drxjSvcc3DZoNdxNW
	 SQOXGkj8Ws376UM43KATbYphopYWFowsCK/safTm8l0SSMVI3O81QxJnwmzRqa0It1
	 B/CXZ5GgxmthzDbx3NcFYPIqwz5JY86m0eDgG3B5mnqmMolIyftsuL1aBv79O/PUYy
	 m2t5nvXsjDW3sLav1I+bO1iDLSsHk+fqHto9IomYNlKWfsFRfzTyrN4EwdiwPnEURL
	 YN/xyKjcTrMvg==
From: Hannes Reinecke <hare@kernel.org>
Subject: [PATCH RFC v3 00/12] namespace-aware configfs
Date: Tue, 23 Jun 2026 11:15:45 +0200
Message-Id: <20260623-configfs-ns-v3-0-841c100fd5dd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMFOOmoC/22NQQrCMBREr1L+2khMa5q6EgQP4Fa6MMlP+qkkk
 khRSu9uyFqYzZthZlbImAgznJoVEi6UKYYC7a4BMz2CR0a2MAguJJeHgZkYHHmXWchMH/tO6Vb
 KIiiNV0JHn7p2h9v1AmMxJ8rvmL71YRE1+ju2CMaZEs72fOi0suY8Ywr43MfkYdy27QcOPuYBr
 AAAAA==
X-Change-ID: 20260619-configfs-ns-b5748b366366
To: Andreas Hindborg <a.hindborg@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782206158; l=3779;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=2fGGWS0P4+GqP7BDsbXG+4M0kJfHb/Qy81cW24j0Es8=;
 b=7NedXzaZugWH2oJPuKLHBA6vecxoG9Jg3H+7rVkhZp6LR3ZBzVif3pMuzDOsvpBbVamfRC7Xa
 hcCBwWaKnaPCaxTGLqZV94tb4GYUJxtlIOVPabw481xAhY3Qrt7BaFJ
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Hey all,

during discussions at LSF/MM I thought it would be quite helpful
to make configfs namespace aware, such that one could do:

unshare --mnt
mount -t configfs none /sys/kernel/config

and get a new instance of configfs. This will allow to have distinct
configurations for each namespace.
This is particularly helpful if you want to run eg nvmet in a container;
with this patchset each container can have its own configuration, and
one can simulate a multi-node nvmet cluster using containers.

How it works:
The configfs 'root' entries are stored in 'configfs_super_info', which
can be looked up from an xarray using the (network) namespace ID as the index.
A configfs subsystem can be converted to be namespace aware by implementing
the new subsyste callbacks 'fill_subsystem()' and 'clear_subsystem', which
are responsible for populating the subsystem structure.
Upon registration via 'register_subsystem()' the subsystem is put in a
linked list within 'configfs_super_info'. So when mount() is called from
a different namespace this list is traversed, and new subsystems are created
in the new namespace using the callbacks.

Open Issues:
- I've added a new function 'mnt_clone_direct()' to clone the vfsmount
  entry (the original code just did a simple_pin_fs()). Not sure if
  that's correct. Christian?
- Ideally I would love to make the whole thing work without having
  to mount a new configfs instance from within the container.
  Again, not sure if that's possible.
- I've decided to base it off the net namespace (and not any namespace).
  That makes implementation easier, but requires the various subsystems
  to actually _use_ the network namespace.
  The current use-case (nvmet) does that, so it works for me :-)

Otherwise, as usual, commands and reviews are welcome.

Changes to the original submission:
- Changed to use 'net' namespace instead of 'mnt' namespace
- Smaller fixes as suggested by sashiko.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
Changes in v3:
- Split off nvmet patches
- kbuild robot fixes
- Simplify namespace selection
- Link to v2: https://lore.kernel.org/r/20260619-configfs-ns-v2-0-82fd7094b8dc@kernel.org

---
Hannes Reinecke (12):
      fs/configfs: rework configfs_is_root()
      fs/configfs: dynamically allocate super_info
      fs/configfs: separate out configfs_{link,unlink}_root()
      fs/configfs: add superblock as attribute to configfs_pin_fs()
      fs/configfs: add 'fill_subsystem' and 'clear_subsystem' callbacks
      fs/namespace: implement mnt_clone_direct()
      fs/configfs: switch to get_tree_keyed()
      fs/configfs: open-code simple_pin_fs()
      nvmet: make discovery subsystem dynamic
      nvmet: per net-namespace port list
      nvmet: make configfs setup namespace aware
      nvmet: enable transports for net namespaces

 drivers/nvme/target/configfs.c  | 206 +++++++++++++++++++++++++++------
 drivers/nvme/target/core.c      |  36 +++---
 drivers/nvme/target/discovery.c |  91 +++++++++++----
 drivers/nvme/target/loop.c      |   4 +
 drivers/nvme/target/nvmet.h     |  15 ++-
 drivers/nvme/target/rdma.c      |   6 +-
 drivers/nvme/target/tcp.c       |   6 +-
 fs/configfs/configfs_internal.h |  23 +++-
 fs/configfs/dir.c               | 188 +++++++++++++++++++++++++-----
 fs/configfs/mount.c             | 248 +++++++++++++++++++++++++++++++++-------
 fs/namespace.c                  |  11 ++
 include/linux/configfs.h        |   8 ++
 include/linux/mount.h           |   1 +
 13 files changed, 682 insertions(+), 161 deletions(-)
---
base-commit: 66affa37cfac0aec061cc4bcf4a065b0c52f7e19
change-id: 20260619-configfs-ns-b5748b366366

Best regards,
-- 
Hannes Reinecke <hare@kernel.org>

