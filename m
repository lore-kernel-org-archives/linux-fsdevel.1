Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D79330DEA5
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883500; cv=none; b=JVAmBWNwBRkpsUz57K63gaSIZa5VyzWInwRXeOYAam3sEFkXWwouvEuaq/ZgS+qjRs2SwY6O0QQMGq3dGNMka0r/ey3bAfyrstGmKfm2lIezFJhA7OfQ44i5Ue8IhK6qqizxmqBXBTMZZxSB0sFtny1tSnjGxzl7Y8mLLxdcpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883500; c=relaxed/simple;
	bh=UUjg4a8GCEj3EBwQNQIM2WMJjLhzuisqKxMZ7kYpn90=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZnhT39iSr/We2IOMkAr4Y74hBaNmExP1x0I6vNI/Rh7BRpuHHIskJOVIrv8gfATNSvMUR+fsHWHSjYyyunkTcRyQY5nYHRWgwRt6supu3F5O8HhrkZ8btYDStoOcXMftUudh0QMsBJvqZS32DTh0EDR2vOCvfT2/r5tDGSxFiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=e9hUNahu; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="e9hUNahu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780883490; x=1781142690;
	bh=1aPauIx5gFdC+yexw77JNmUtyqnfWZhcyFl3kaD2ouM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e9hUNahup4edexGGsc9nj3QmEkDvgQEXem8hqFz31sixWcbkAEfko3qv6KHqemWdL
	 fr2WUB/o3blATdKgyo4j/HSqcJKE/Uj3rnW3f4FO8q5H1jb0BtjL5rhu1EJEycvQiD
	 Idk9xgqztucezsM/EKcyL7eE4ZZ/YKzc0Q067AE9SDpguuVR9yddrjqj2lF6ou5D4Y
	 QxyTpxwZAzW+O3JY1EQeCflaOIJAhGrgz35ziXEhH4HEnWXpWq8X+K/PkfcLCR4bjJ
	 CkPk4rXbBV+vqx/HyZ0s3EiLgvJ1WM0nAbLBpqzp1wLvw8nl80Q3wBLHlP2JkBdE+v
	 T2ROXssBKlUDw==
Date: Mon, 08 Jun 2026 01:51:25 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] ntfs: bound the attribute-list entry in ntfs_read_inode_mount()
Message-ID: <20260607203000.700100-3-hexlabsecurity@proton.me>
In-Reply-To: <20260607203000.700100-1-hexlabsecurity@proton.me>
References: <20260607203000.700100-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 419a0339d29603a6604275a5be4d46d4932c9de5
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
walks now use. The validator already requires the length to cover the fixed
header, which makes the separate "!al_entry->length" check redundant, so
drop it too.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v4: also drop the now-redundant "if (!al_entry->length)" check, per
    Hyunchul's review -- ntfs_attr_list_entry_is_valid() forces
    name_offset =3D=3D sizeof(struct attr_list_entry) and requires
    name_offset + name_length * sizeof(__le16) <=3D length, so length =3D=
=3D 0 is
    already rejected there (and length is a multiple of 8, so a valid entry
    is at least 32 bytes and next_al_entry still advances -- no
    zero-length loop). Rebased onto the "ntfs: validate attribute values on
    lookup" series (0001-0004) now applied to ntfs-next; added the Fixes:
    tag. Compile-tested on ntfs-next.
v3 (Hyunchul Lee review): validate with the extracted
    ntfs_attr_list_entry_is_valid() helper rather than an open-coded bound,
    matching the other attribute-list walks.
v2: dropped the redundant Reported-by; reproducer omitted on the public
    list (available to the maintainers on request).

Sibling of the ntfs_external_attr_find() look-ahead OOB (2/3): the same
struct attr_list_entry fixed fields (lowest_vcn at 8, mft_reference at 16)
are read here with a weaker bound. Geometry is arch-independent (identical
-m32/-m64).

 fs/ntfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 8a7798d7f5fc..2f2634baa285 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -1997,10 +1997,7 @@ int ntfs_read_inode_mount(struct inode *vi)
 =09=09=09/* Catch the end of the attribute list. */
 =09=09=09if ((u8 *)al_entry =3D=3D al_end)
 =09=09=09=09goto em_put_err_out;
-=09=09=09if (!al_entry->length)
-=09=09=09=09goto em_put_err_out;
-=09=09=09if ((u8 *)al_entry + 6 > al_end ||
-=09=09=09    (u8 *)al_entry + le16_to_cpu(al_entry->length) > al_end)
+=09=09=09if (!ntfs_attr_list_entry_is_valid(al_entry, al_end))
 =09=09=09=09goto em_put_err_out;
 =09=09=09next_al_entry =3D (struct attr_list_entry *)((u8 *)al_entry +
 =09=09=09=09=09le16_to_cpu(al_entry->length));
--
2.43.0

