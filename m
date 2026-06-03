Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EE37E2FB
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509626; cv=none; b=o+/OqLhZeM4VGO0LJMC3Lgqn5Cz2TJB9KOM553Wrx/xOWDwpuJflcdp/+u/O2BYIXChabWjRBo/CydH5c+wuJQrgHfEGnjivqoBLCCipnq5wi2IgKj8eKoyG5P6wxRryJOrL43eTw1VFwVbURvOmzv+Cq3KmHceYMTMWxmlKxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509626; c=relaxed/simple;
	bh=pxwtQog6z7zjX5by+yNu90RpDhJdAQunX34F87guwSE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jk4+MaXWeMfQFSIkqH1LyQob73ByjpLNX2enY8ZPByulmi65l0Ff/gF2XNiHfx/Dobvoc7DrImqkBMHrcZt97uCNB5o7GXR3zVYBbnD+2SQ1XPpAbjR3cHNFgkCjKHu6qwW9x+5aHuZjayBJ7MRNUbFR63WGGRtG388moiqblCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ZxH6ZXXi; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ZxH6ZXXi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780509618; x=1780768818;
	bh=hkdLl6Qwwni8UfZiJxUA9MopOTMV2Oo55My9l61wsjU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ZxH6ZXXifGCprxZPbDZMCtRd3ac250mLxPzjET9iifZe6eNE2reZAUC9Tq2WkjNjE
	 SZ+1MUa/mMeIXGpObFnwi8jhJaRE+ruIV9Dp9q9iG3J1ddZcmfm4wE9w/3HWP7if6l
	 i9NuWoCiiLK6vHApwOkZTqVcxnPqsmBzyvtQfERrFUUlevvC9uSBUDsG4c0nQSOWRo
	 Dt2z+qIjqfeVZGskd73DHo6fYBy/Bb6qSXGNsEaFTCHz6BKbsfAiBb4OpG44SVMrUc
	 SLPaXN7TEj5td94WY4nTcdS/JK4GAa4CNfQ60/GNvvSVrEWqwc5NKSRsrgoNw4uGgC
	 cMDPEYm9PHK7g==
Date: Wed, 03 Jun 2026 18:00:11 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
Message-ID: <20260603175949.11665-3-hexlabsecurity@proton.me>
In-Reply-To: <20260603175949.11665-1-hexlabsecurity@proton.me>
References: <20260603175949.11665-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: a9981f591cf9e0c9589bb2e31bab40b82e9740f2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The $MFT attribute-list walk in ntfs_read_inode_mount() validates each
entry only with "(u8 *)al_entry + 6 > al_end" and
"(u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end", but then reads
al_entry->lowest_vcn (an __le64 at offset 8) and al_entry->mft_reference
(offset 16) -- fields beyond the 6 bytes proven in range. al_entry->length
is attacker-controlled and only required non-zero, so a short entry (e.g.
length 8) placed at the tail passes both checks while the lowest_vcn /
mft_reference reads fall past al_end.

al_end is ni->attr_list + attr_list_size (the on-disk size); the buffer is
kvzalloc(round_up(attr_list_size, SECTOR_SIZE)), so the sector rounding
usually absorbs the over-read -- but when attr_list_size is a multiple of
SECTOR_SIZE there is no slack and a crafted $MFT attribute list produces an
out-of-bounds read at mount time.

Require the fixed attribute-list-entry header to be in range before
dereferencing it, matching the bound ntfs_external_attr_find() already
applies to the entries in its own attribute-list walk.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: dropped the redundant Reported-by; reproducer omitted on the public lis=
t
    (available to the maintainers on request). Posting per security@kernel.=
org
    guidance that crafted-image filesystem bugs are out of the security thr=
eat
    model.

Sibling of the ntfs_external_attr_find() look-ahead OOB (patch 2/3): the sa=
me
struct attr_list_entry fixed fields (lowest_vcn at 8, mft_reference at 16) =
are
read here with a weaker bound. The expression is carried from the legacy
fs/ntfs driver (removed v6.9; present since v2.6.12), where ntfs_malloc_nof=
s()
rounded every allocation up to kmalloc(PAGE_SIZE) and masked it. Please add=
 the
appropriate Fixes: tag for the commit that introduced ntfs_read_inode_mount=
()
in the new driver.

 fs/ntfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 360bebd1ee3f..70fb216a1bd0 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1996,7 +1996,8 @@ int ntfs_read_inode_mount(struct inode *vi)
 =09=09=09=09goto em_put_err_out;
 =09=09=09if (!al_entry->length)
 =09=09=09=09goto em_put_err_out;
-=09=09=09if ((u8 *)al_entry + 6 > al_end ||
+=09=09=09if ((u8 *)al_entry + offsetof(struct attr_list_entry, name) >
+=09=09=09    al_end ||
 =09=09=09    (u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end)
 =09=09=09=09goto em_put_err_out;
 =09=09=09next_al_entry =3D (struct attr_list_entry *)((u8 *)al_entry +
--=20
2.43.0

