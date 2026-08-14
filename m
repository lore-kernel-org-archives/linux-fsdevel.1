Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825D043E097;
	Fri, 14 Aug 2026 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786713283; cv=none; b=VKKRl6pf563Cq3jhutGM0npa95L5eBPd7UJWbQekXFUDvlt7sZR2m4iZuWnsD9mmd1Shmi6n/V6krV8JwTEkIIGl1/hLP6E7P1e9nFUKYRm3aMoIN/3/qLWwgFQV7dwejOa86xtfkbGZ82ujp0gPD0SdVpxQlkvJi5ILW4UpCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786713283; c=relaxed/simple;
	bh=g22sN8Tw3ItJQFhSogjkqK7nQvgpwAAzQp+daPH/GeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N8rxGEJwYhmtLvkxB4T7E3OdwhCnnBEApcBhlspgXeqsq9wOxoathH0VCSKTKDrg8bi065XKzMy9OVRawsO/hA4ktwUxlWC57TjJ1GueAiKtZdVTvsATcmMtvCtBpR03QStWp5JyOO7zj8XIbjSBbngitbTWj0zUSKwWu1ZEjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NI5MEwye; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NI5MEwye"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401DD1F000E9;
	Fri, 14 Aug 2026 13:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786713282;
	bh=K+2dTJPBb31ETFwBkcbDGSFqLN3t67G1VpYbi2ZhG70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NI5MEwye/gOaeuM5iOKuycDhHkIB7+EHMcn6DQOUJSKNX4748DMjEtUoIwyDB2SBN
	 2XELwPtRXm/LW7GZWn4nZG8dku0SXZj5EkJAGdHQyoGDVZNxpGZ1GFuh7o9MxbtWjd
	 BCrixXGREGWBdiWf8E+pmXKeiVZ0PFddJWBsqXp6RpTYVjUtytz2WdW5qQVw+bDxOV
	 Gg4dXQQcyfBO6OV6f73c9KvD2fgQy2rpbzdugCSJgEf8Fv8Krcipm6C2GnZeetRRK4
	 vF38DLdiCNMJ0xS4ngrx5X+NhvGazSemPft95yN58WPSdYVhh0BDif2lNCZ1dYrKSK
	 uRJatNxjZNApw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL 16/18 for v7.3] vfs ovl
Date: Fri, 14 Aug 2026 15:14:32 +0200
Message-ID: <20260814-vfs-7.3-rc1.ovl-5cd586fb6045@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814-vfs-v73-6e884cb31ac9@brauner>
References: <20260814-vfs-v73-6e884cb31ac9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3760; i=brauner@kernel.org; h=from:subject:message-id; bh=g22sN8Tw3ItJQFhSogjkqK7nQvgpwAAzQp+daPH/GeY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTVi+yR8ZyemBl/8ISEEzf/NwUd2TL2alE3lf2NKgnpv /5bc//qKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmIgMLyPDy2vvfuXLmngujvTa d0Vpm53uXFOT8xE9VWe3MW5sXb5sJsP/gDVPhZPs7lc1s/zmWeDxRpFl8aX96WZvN0je1Ozjn5b EBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

/* Summary */

This lets the merged overlayfs mount itself be idmapped through
mount_setattr(MOUNT_ATTR_IDMAP). In addition to the already supported
idmapped lower and upper layers. The same overlay tree can then be
exposed under a different ownership view.

Overlayfs already normalizes every underlying id through the relevant
layer idmap when ovl_copyattr() copies attributes into the overlay
inode. So the overlay inode's i_uid and i_gid are overlay-final ids.

The overlay mount idmap composes on top of that and is applied at the
overlay-inode boundary only while the underlying layers keep being
accessed with the mounter's credentials through their own (possibly
idmapped) mounts.

So this only changes how the caller sees the overlay inode and never
widens the mounter's access to the layers. The second,
mounter-credential check in ovl_permission() against the real inode
stays on the layer idmap.

Most paths need no change because the VFS applies the mount idmap to
the overlay inode before overlayfs runs or after it returns at the
syscall boundary. Overlayfs only has to change where it bypasses the
generic path.

This also included is a fix for a double end_creating() on the overlayfs
casefold-mismatch path.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.3-rc1.ovl

for you to fetch changes up to 077ab8985ee278c3d8618182d335b0f0cd919e16:

  ovl: fix double end_creating() on the casefold-mismatch path (2026-08-12 11:40:35 +0200)

----------------------------------------------------------------
vfs-7.3-rc1.ovl

Please consider pulling these changes from the signed vfs-7.3-rc1.ovl tag.

Thanks!
Christian

----------------------------------------------------------------
Christian Brauner (11):
      ovl: handle idmapped mounts in ovl_create_object() and ovl_tmpfile()
      ovl: handle idmapped mounts in ovl_permission()
      ovl: handle idmapped mounts in ovl_setattr()
      ovl: handle idmapped mounts in ovl_getattr()
      ovl: handle idmapped mounts in ovl_set_acl()
      ovl: allow idmapping overlay mounts
      docs: document idmapped overlay mounts
      selftests/filesystems/overlayfs: fix set_layers_via_fds link error
      selftests/filesystems/overlayfs: test idmapped overlay mounts
      ovl: document security.capability idmapping on the xattr forward paths
      Merge patch series "ovl: support idmapped overlay mounts"

Vivek Parikh (1):
      ovl: fix double end_creating() on the casefold-mismatch path

 Documentation/filesystems/overlayfs.rst            |  16 +
 fs/overlayfs/dir.c                                 |  17 +-
 fs/overlayfs/inode.c                               |  26 +-
 fs/overlayfs/overlayfs.h                           |   1 +
 fs/overlayfs/super.c                               |   2 +-
 fs/overlayfs/xattrs.c                              |   1 +
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   2 +
 .../filesystems/overlayfs/idmapped_mounts.c        | 501 +++++++++++++++++++++
 .../filesystems/overlayfs/set_layers_via_fds.c     |  16 +-
 10 files changed, 560 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/filesystems/overlayfs/idmapped_mounts.c
