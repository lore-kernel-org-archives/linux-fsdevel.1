Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4A83B3892;
	Thu,  4 Jun 2026 04:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780547386; cv=none; b=IRhN5sinBVTeY1+7OBIegTxBoSULII21RM6Wz9zr85rRAuhUjjrOmGCoHWiFlPO3oWmCEJ6cbJjCCTZ7RQY1gggh9wOIv05T1peAl+bR7jgabWfnRoUCdWNFEvzspRVIl+aJCZyAkx2o7mIQ8cUcOjDG5QEDUZE2pClaKn5blfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780547386; c=relaxed/simple;
	bh=+SEuigZEEGg+0A4teMe4619UwJI4gNXH+AClJtRLwYI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WV+3q9iokEhBxLgcPgGoEaH07SROeyQTiYhocLMnuamEDU/N8MCV+5mIQ09l72rFALE/AdZmX84OtfkrPjCf0fmXQUURwcQxH7PE4V9N9JQM5jw0+4Cd0E/AhnPMUiCFNMQuciZHEkDxd2LYc/TCFpYtdy4Ir7JPtkpNhkqZliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=aq3V1XaC; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="aq3V1XaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780547378; x=1780806578;
	bh=IX12agX81MTAPNr6m553lDZtpKx2DC4s08Gg7fgJfBc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aq3V1XaCvGs3idx9/AyBh25u1vRPunbf+AOQK5SnnYwQxkvDsWkTvPsaoXdtQdGkC
	 bS4ChhcyciUVNqSR5PD5IgeVvLt46KFbE7dZzUWUhQKs0jqQuzDjmULt2dmbrLXvJ4
	 w359HoBWNSxYLumWjOmfA3WmH7M3HpvBnbHFKOHcXG4ITU5+Aw9h43deZ7T/3qRzmB
	 pg9PYsGdE0qkH/QfgykrCrsksQt+07U4CLcLYJAqfDeWUspb2sSbENsksqbTsnSRDS
	 HDzSXdN83GPlEE3fN8mmhrqoP7hjVp26ftv5QCKkRfrx6tbvWUdaaIQWQl/qwYw7zw
	 v/XtHDvLBpQlg==
Date: Thu, 04 Jun 2026 04:29:32 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>
Subject: [PATCH v3 3/3] ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
Message-ID: <20260604042912.89893-3-hexlabsecurity@proton.me>
In-Reply-To: <20260604042912.89893-1-hexlabsecurity@proton.me>
References: <20260603175949.11665-1-hexlabsecurity@proton.me> <20260604042912.89893-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 705a9333aceafee5e543861e2ce01652268dbcb8
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

Validate the entry with ntfs_attr_list_entry_is_valid() (added in patch
1/3) before dereferencing it, matching the bound the other attribute-list
walks now use.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3 (Hyunchul Lee review): validate with the extracted
   ntfs_attr_list_entry_is_valid() helper (added in 1/3) rather than an
   open-coded bound, matching the other attribute-list walks.
v2: dropped the redundant Reported-by; reproducer omitted on the public lis=
t
   (available to the maintainers on request).

Sibling of the ntfs_external_attr_find() look-ahead OOB (2/3): the same
struct attr_list_entry fixed fields (lowest_vcn at 8, mft_reference at 16)
are read here with a weaker bound. Geometry is arch-independent (identical
-m32/-m64). Please add the appropriate Fixes: tag for the commit that
introduced ntfs_read_inode_mount() in the new fs/ntfs driver (v7.1 merge
window).

 fs/ntfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index a5f7400fd19d..77d7ea4a855b 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2002,8 +2002,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 =09=09=09=09goto em_put_err_out;
 =09=09=09if (!al_entry->length)
 =09=09=09=09goto em_put_err_out;
-=09=09=09if ((u8 *)al_entry + 6 > al_end ||
-=09=09=09    (u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end)
+=09=09=09if (!ntfs_attr_list_entry_is_valid(al_entry, al_end))
 =09=09=09=09goto em_put_err_out;
 =09=09=09next_al_entry =3D (struct attr_list_entry *)((u8 *)al_entry +
 =09=09=09=09=09le16_to_cpu(al_entry->length));
--=20
2.43.0


