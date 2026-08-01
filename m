Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097E361971;
	Sat,  1 Aug 2026 07:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785568426; cv=pass; b=DSZp2HIhZCn3TTIAoC0PjTNdrKFD/CtGvlD7+ng4vxceq3pNcKSliYbmUPnWQ23pgJiKdq3WsxCFuboAbkEMG/20Ojybz5goQuVsjD/pCbbYSxeEN3uaMT7e4PmlVxspavoGShHZaPgPv7uUNi68rl0fK41JQniP0xKxXfHwSKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785568426; c=relaxed/simple;
	bh=kv5wGjBGXldKVvlnGBgmUrLaYg/B1m2Ih/0xdJLbUK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LruJi91Sh4f+7Nt9pMMtGCbLaLyp6/5SIaX2NWaoXcUP2vm6PTx0LB2OTGklLLV8a5+1yT5qEdNo6ijeUGdUZrWRInx+6gGwEQmtnX07KBaOS9f1VQ3rp6A5ZXZZNfPR+UhZhehwlHorx/WoFCnAh+3LOu0eMQsye0LH0jOMXyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com; spf=pass smtp.mailfrom=iusegentoo.com; dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b=GCfgI77u; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iusegentoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iusegentoo.com header.i=ali@iusegentoo.com header.b="GCfgI77u"
ARC-Seal: i=1; a=rsa-sha256; t=1785568399; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HQNA/p5qurPC12kQh3ioeq9gV1TYouWhDzRdSUFL49X/wNRWsMUP40RyaECQtI3GyNsAjTw8MEq+k5q51gEDzhS+qGU7hewoX8pHu9pmJRPXk0H9t7y7hm1FsD2RcaCd2UIJzg0LOPz2uTlFxISjNAvRtc7ewfynY7WIwXtPdy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1785568399; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2XA8eJ8/bBWXgGImqcpf9rF0z8c5xqbbGzHIpwLE9ho=; 
	b=JYL8Fj3R4t9RH9dtll8KDGOpc23sIjvg0OZCvOya/HxpW6CxQv6cLInrpbbaeVfioSS32+qhmaV2B2KiwFfSCxYVsv6y8yrSvGonXJ5C5a6v6qm9LtpBqXa5f/94k6LjUEoNaTDwcK0JwC8LgXAgH1Il9ooOslz/bhja6gDyw4A=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=iusegentoo.com;
	spf=pass  smtp.mailfrom=ali@iusegentoo.com;
	dmarc=pass header.from=<ali@iusegentoo.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785568399;
	s=zmail; d=iusegentoo.com; i=ali@iusegentoo.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2XA8eJ8/bBWXgGImqcpf9rF0z8c5xqbbGzHIpwLE9ho=;
	b=GCfgI77uhlMbwpNnQ3FM0cz/wMreEAV03tFJpFkCOquTVBAId/r2qcjsk5d70gXu
	OW2w8ZqgTODZl6TkKXYE+VukrlZt/6jurVDY7eTIfT7XAHEOqR8gmvvuKF7d4zaTeHT
	Wslpj/85jYCiKtbl0iE/nfuA+bAveRldJZ5pcYmc=
Received: by mx.zoho.eu with SMTPS id 178556839678562.87758756545054;
	Sat, 1 Aug 2026 09:13:16 +0200 (CEST)
From: Ali Ahmet Memis <ali@iusegentoo.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ufs: harden the mount path against malformed images
Date: Sat,  1 Aug 2026 10:12:56 +0300
Message-ID: <20260801071306.59484-1-ali@iusegentoo.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Two robustness fixes for the ufs mount path, both reachable by mounting
a crafted UFS image.

Patch 1 reorders ufs_fill_super() so the root dentry is created after the
cylinder group metadata is loaded. Today a failure while reading the
cylinder groups drops UFS_SB(sb) but leaves s_root installed, so the
generic teardown oopses on a NULL pointer in ufs_sync_fs() and the
put_super operation.

Patch 2 validates the cylinder group index and the rotor positions in
ufs_read_cylinder() before they are cached. Unchecked, c_cgx indexes the
cylinder summary array (a 32 bit write outside s_csp), and the rotors
become bitmap scan offsets that can wrap an unsigned length and walk past
the cylinder group buffers during an ordinary allocation.

Mounting a ufs image needs CAP_SYS_ADMIN and ufs is not
unprivileged-mountable, so this is image-parsing hardening rather than a
privilege boundary, handled in the open like the recent sibling work:

  ufs: reject malformed cylinder summary geometry
    https://lore.kernel.org/all/20260701215700.822003-1-kudo3228@gmail.com/
  ufs: reject oversized cylinder group metadata
    https://lore.kernel.org/all/20260717104033.38574-1-david.lee@trailofbits.com/

Those validate fs_cssize and fs_cgsize in ufs_fill_super(); the checks
here live in ufs_read_cylinder() and do not overlap with them.

Both were reproduced under KASAN on an unpatched kernel by mounting a
crafted UFS2 image.

Patch 1, an image whose first cylinder group fails the magic check, so
ufs_read_cylinder_structures() fails after the root dentry is installed:

  BUG: KASAN: null-ptr-deref in mutex_lock+0x76/0xe0
   ufs_sync_fs+0x5b/0x6d0
  BUG: kernel NULL pointer dereference, address: 0000000000000100

Patch 2, an image whose on-disk cg_cgx is out of range, followed by a
write that allocates a block:

  BUG: KASAN: slab-out-of-bounds in adjust_free_blocks+0x1bf0/0x2510
   adjust_free_blocks

With the patches applied, patch 1 loads the cylinder groups before
publishing the root dentry and patch 2 rejects the mismatched cg_cgx in
ufs_read_cylinder(), so neither faulting access is reached.

Ali Ahmet Memis (2):
  ufs: create the root dentry after loading cylinder metadata
  ufs: validate cylinder group metadata before caching it

 fs/ufs/cylinder.c | 10 ++++++++++
 fs/ufs/super.c    | 17 +++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

-- 
2.54.0

