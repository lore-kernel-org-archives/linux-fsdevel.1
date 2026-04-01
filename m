Received: from e234-53.smtp-out.ap-northeast-1.amazonses.com (e234-53.smtp-out.ap-northeast-1.amazonses.com [23.251.234.53])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE953A9DA7
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 09:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775034456; cv=none; b=fRapUxNXDvZzrtuT34iKI3hwsi66R7kDJUnr0GIapAdtHbhrYDx06fYCfHy9DrLC3ExTg4u+B12l933Zit843joX294HR8d0cGE/b2wNnxhAGLZVdwrF+1BIdoyl1tcC4Ba/Z8xUL7A6bsztFQn3pAi8IWRJ/BcndLy8Kt7arSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775034456; c=relaxed/simple;
	bh=S30ZhcZeWM/JIGxglu713LkFplfdTFRfFTrbzE9xMSk=;
	h=From:To:Cc:Subject:Message-ID:Date:MIME-Version:Content-Type; b=eDusGqE/U2MpwXMhgthCqKCdofnp7b0E2RChJG3WMZ5yNxe8VMaefbdq1uCGmk/iT7CKOPk8fI36HtivKEL+9InJ42lD3ojjkISG2F/PSx/gUV3BiZts8caCf1vakm6zIA/CKSqkpIf7olVehXyJpIfO01P/oYhuNxKfLYJXY1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voyagerhq.ai; spf=pass smtp.mailfrom=send.voyagerhq.ai; dkim=temperror (0-bit key) header.d=voyagerhq.ai header.i=@voyagerhq.ai header.b=XUp9W92I; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=INPFofbc; arc=none smtp.client-ip=23.251.234.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voyagerhq.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.voyagerhq.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=voyagerhq.ai header.i=@voyagerhq.ai header.b="XUp9W92I";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="INPFofbc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=voyagerhq.ai; t=1775034453;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=S30ZhcZeWM/JIGxglu713LkFplfdTFRfFTrbzE9xMSk=;
	b=XUp9W92IPq49wKbZH5R4yX/WUt9aAzAVb94kGSpibccNbR0O0azxoWq0hRpAzKj8
	67Nf/1h0ZM9T0yc9sZFJvaj6mToomdDtgt0hSKxlyn40kbpFR9itjfCwPCrIKsqQlf/
	T31efB+6w9UhRysiWu8ujcAGrZaXSmgDqbTmYudQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=suwteswkahkjx5z3rgaujjw4zqymtlt2; d=amazonses.com; t=1775034453;
	h=From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=S30ZhcZeWM/JIGxglu713LkFplfdTFRfFTrbzE9xMSk=;
	b=INPFofbc306cjer06ZNH7vl6gyNzRgwnkAmQwi3xh50GnCSmnYNzkpRl93Ivq/Tb
	nVgNX7v8OTEuAWrF/Tx3PLFpEN718uTMt4gKl389tC5IolZ5n8d3MKTev1SVa2KZZ7c
	Uaf4EYxLt/AvKd5MgDjzRwkUilt1aRqcm5ZEI7ak=
X-Mailer: git-send-email 2.43.0
From: mike.wang@voyagerhq.ai
To: miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, fuse-devel@lists.sourceforge.net
Subject: [RFC] fuse: add FUSE_NOTIFY_INVAL_SUBTREE for subtree dcache
 invalidation
Message-ID: <0106019d484c4dec-01be29ea-1b1a-4223-b830-059ec46b0f89-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: 7bit
Date: Wed, 1 Apr 2026 09:07:33 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.m7Hx1PGlSUJvg2Ybc2UfHh4taoB35iw/KDLPwWKlRruHjMh/4oeK5Crm57CbQh8WczGaP8v7ygbE2zjkX5s9DNeci2RtFNPd8tJ5X2eZHxoJNGwL7z+0pQwteJ8b5YKqq3UYSJuJHlY2Gphh9zSFp3W8QCGkiqktHWQfcziIB1GnfF3ZCpbQQeKQl/dVfC+S:1.ap-northeast-1.tL27A1JIpKR2Y51a8BkHZBekDcSR82jwOhKrSwgRw2U=:AmazonSES
X-SES-Outgoing: 2026.04.01-23.251.234.53

Hi Miklos,

I'd like to propose adding a new notification type to FUSE that
allows the daemon to request the kernel to trim the dentry cache
for a given subtree.

Problem
=======

Distributed FUSE filesystems need to invalidate large portions of
the kernel dentry cache when receiving remote metadata change
notifications. The existing mechanisms are insufficient:

1) notify_inval_entry() requires (parent_ino, name) pairs and must
   be called once per dentry -- extremely inefficient for directories
   with thousands of entries that changed remotely.

2) ceph-fuse works around this by calling
   system("mount -i -o remount <mountpoint>") to trigger
   shrink_dcache_parent(). This hack:
   - Broke with util-linux 2.39+ new mount API (util-linux#2576)
   - Has race conditions (shelling out to mount(8) from daemon)
   - Is semantically wrong (remount != cache trim)
   See: https://tracker.ceph.com/issues/10542
   See: https://github.com/libfuse/libfuse/issues/717

3) JuiceFS and GlusterFS have the same need but lack even the
   remount workaround -- they rely solely on entry_timeout expiry,
   which introduces seconds of stale cache visibility.

Proposed solution
=================

Add FUSE_NOTIFY_INVAL_SUBTREE as a new notification type. The daemon
writes a notification containing a nodeid to /dev/fuse. The kernel
calls shrink_dcache_parent() on the corresponding dentry, recursively
trimming all unused dentries in the subtree.

When nodeid is 0, shrink_dcache_sb() is called instead, trimming the
entire filesystem's dentry cache.

The naming follows the existing INVAL_ convention, completing a
granularity spectrum:

  FUSE_NOTIFY_INVAL_INODE   -- single inode attributes/data
  FUSE_NOTIFY_INVAL_ENTRY   -- single directory entry
  FUSE_NOTIFY_INVAL_SUBTREE -- entire subtree of entries (new)

The wire format:

  struct fuse_notify_inval_subtree_out {
      uint64_t nodeid;
  };

The kernel-side implementation would be straightforward -- the core
of the notification handler is essentially:

  if (nodeid == 0)
      shrink_dcache_sb(sb);
  else
      shrink_dcache_parent(dentry);

Users
=====

- ceph-fuse: would replace remount_cb() hack that has been in use
  since 2014 and broke with util-linux 2.39+.
- JuiceFS: distributed filesystem that currently relies on
  entry_timeout for cache coherence with remote metadata changes.
- GlusterFS: similar dcache invalidation needs, discussed in
  fuse-devel archives.

Questions
=========

Before writing a formal patch, I'd appreciate your guidance on
a few design points:

1) Does this approach seem reasonable? Or would you prefer a
   different mechanism, such as extending FUSE_NOTIFY_INVAL_ENTRY
   with a recursive flag?

2) shrink_dcache_parent() can take a while on very large subtrees.
   Should the notification handler call it synchronously (simpler,
   and runs in process context from the daemon's write() to
   /dev/fuse), or defer to a workqueue?

3) Is a FUSE_KERNEL_MINOR_VERSION bump sufficient for feature
   detection, or should this also require FUSE_INIT capability
   negotiation?

I have a prototype implementation ready. Happy to send a formal
patch once we agree on the direction.

Thanks,
Mike Wang
