Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792838710;
	b=WLnVmSfgIi/YgnkQrkEdKmg2g4h10/zDJQhCcuCncc5UEaxSN3E8zVtTOk2+dlY+BzaN
	 NTXrMYBqugieTYtp0CK4hZ2FdrwZhDta+xi8yCIWdqV4ondjs9QgCcGsIRar1YEsuNrHd
	 a6xuExxnvepmOYSg86hfIg4KeaPvWtToN5eyAQlaRSXFq0Xpp6w3voN8DRk5jICTBwp5d
	 sBXu/soOwUXlkK/bJ3x3cQxZhdNLxoIcPCppnZJ3CogmsNX5mZvsQhop/ApPaMkt3S8H9
	 vgwFjwg0/VIFLE1MHvkar4PrsceGFxyhfKRW0SvHbQZYufazm9mX2u22MAd2ljffPFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792838710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding;
	bh=oJpKvP6ghRQJBW6KOWHNtJuyCIajPUo3Zb1hp+b2HMc=;
	b=x2iSNbvBv2GxA1uvT7bidQLcVhXRxDtyy7K7v5Vyo+/yfJKuEQe9RcW0Z1Gk1mC0lBaG
	 B0scL5txH2YJkkyjxbKhx4QEC1T6s4FJBgCfLQlT71L06d4+WRleY560NeWExoUApBJ0z
	 0o1wIAmtVKeTocarTu5wEQyyqZjwv5Jp2ezdKq5+SVMfdxf4jIuU3dt+yVpRtusIVxHcz
	 1PUjYW/JzLaidXq7JezvNh/QRD8dJS+1sxIUHBGzVX/e63H55ujrYBg8+tBm0qT+/jJUz
	 f+B0yjTfLfm1JXA6piYTP3teYSaRRU1Zqb5mGty50zzfqhYuKM01v3hwp/MYSOV3okA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6ZagRG0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE36606A31E;
	Sat, 24 Oct 2026 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T6ZagRG0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B4B1F01828;
	Sat, 24 Oct 2026 10:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792838710;
	bh=oJpKvP6ghRQJBW6KOWHNtJuyCIajPUo3Zb1hp+b2HMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T6ZagRG0UX9LA7Y5RMPfwvUP2ap7qRSiVaBqLVfRLms6nB5ztxSk/oKtu3h6QvpAp
	 Zt/b09XQkcVumoF88ah1qKVHxH/iWjQiuXPcquEXpq/xc4Bm65vGRkm0f4SG7iGMKN
	 6dotdoOVMmaAT481Fhz8PLE/UrwqohRe1W2R0+6+g0zcJcV+2aGyEWdHoFzsoVpHrF
	 q/cItUfs0VAnB3HVGVoDMdCVnQY9omtwCPOiBYhZ2GJK1IxT6CvpI//XLyP482Msax
	 cOMiSmpTL0OCMhE6PbAxKTuHoB53arsfPTEHpPdmh0r87d5pX8RfT85JVJHTG4Ieby
	 oSOW8qPOEBMmQ==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL for v7.4] vfs keyring
Date: Sat, 24 Oct 2026 12:44:48 +0200
Message-ID: <20261024-vfs-7.4-rc1.keyring-db88a8f3b5b1@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016-vfs-v74-41eaf6c4712c@brauner>
References: <20261016-vfs-v74-41eaf6c4712c@brauner>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345; i=brauner@kernel.org; h=from:subject:message-id; bh=W9C/RRsg3K50LLKD2tQBv4j+TOvch76wT6isqYzlBGU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTd6VH/aqfDP/H39ymJmb9+3KnsU+18pKB/S3niQ9MFg gI2T2wDO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCXsrIsOhSZW9YX1vG1vsR 7/fwu2pf+5d1LkbFeMmyPQmLzrxoSGT4w9V0345p7a5d57rm+Haram7Zreryaf5NEdN994wMvuz h5gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Hey Linus,

This is a delayed pull request which was waiting for the bpf merge.
This used a shared branch.

/* Summary */
This adds well-known key ids for the .dm-verity and .fs-verity
keyrings.

Neither keyring is linked into any other keyring so request_key() and
KEYCTL_SEARCH can't find them. Userspace has to scrape the serial out
of /proc/keys before it can add a key to either of them. That's not
great as any user can add a key with a newline in its description and
make /proc/keys show a fake .dm-verity keyring line with whatever
serial they like.

/* Testing */

No build failures or warnings were observed.

/* Conflicts */

Merge conflicts with mainline
=============================

No known conflicts.

Merge conflicts with other trees
================================

No known conflicts.

The following changes since commit 1b7415bf70be95b9a1e7e87d544867881065613f:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf 7.3-rc2 (2026-09-06 16:17:40 -0700)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs tags/vfs-7.4-rc1.keyring

for you to fetch changes up to 503b65da9a7e5447d91222f62399522f2f62a0fa:

  Merge patch series "keys: Add well known IDs for fs-verity/dm-verity keys" (2026-10-12 23:37:42 +0200)

----------------------------------------------------------------
vfs-7.4-rc1.keyring

Please consider pulling these changes from the signed vfs-7.4-rc1.keyring tag.

Thanks!
Christian

----------------------------------------------------------------
Andrew Halaney (3):
      keys: add KEY_SPEC_DM_VERITY_KEYRING
      keys: add KEY_SPEC_FS_VERITY_KEYRING
      Documentation: keys: document IDs added since KEY_SPEC_REQKEY_AUTH_KEY

Christian Brauner (2):
      Merge bpf keyring work from of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next
      Merge patch series "keys: Add well known IDs for fs-verity/dm-verity keys"

 Documentation/security/keys/core.rst | 13 ++++++++
 drivers/md/dm-verity-verify-sig.c    |  3 ++
 fs/verity/signature.c                |  2 ++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  2 ++
 security/keys/process_keys.c         | 58 ++++++++++++++++++++++++++++++++++++
 6 files changed, 80 insertions(+)
