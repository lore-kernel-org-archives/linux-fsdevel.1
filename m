Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA631CDFCA
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883496; cv=none; b=fnVyGh9QP6RHlfjoGgr7qMl3h4qJvjQZl9o2vDNqKbqUfrVX8mCvd7/G8hl0oMAxVHvgS+BF8qyrhxjo4OAXxnjlkltdzriF8CMeUkk+AcMSwaekWHf3sM/W7KX9kMMLVrNM9Ju7tyfv+khEbt6/7RYERJykDBaCf2gq39TxZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883496; c=relaxed/simple;
	bh=het//vAYUpNaCa7rU5enQbCi8XEV5Hv1UT/R3NY3jRQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGyiZ9pDei3Yj4DSAU9dD5GFDdoeBKkhdx9hgsPjDbSUGJ/uIRYTqqUhTBejYx7EC2WyHOaI7RY4b0brnV1UOR26bMGOavMRXYgHVyd/AtoD06btlafRqTMkOK2xJzDo0hhHHZmo7+WmFtlj7nPmkAMdyVlebw/IRDsM6kN23rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WJl3VC6L; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WJl3VC6L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780883483; x=1781142683;
	bh=qpwTkzm+nQSx8pTaN7JDN8U95TqD1kCehQQ28Ppb3qw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WJl3VC6LdqOTdH3jjs/pnjis+mswITqlXpAaReWaDvkMGwQle2sZNUf09okwDBrzQ
	 c57lT8B4I36Kqc497VdmtWuAmZV/d2dayMFuLlV2QamRe3vPPbJ3+NYH8xTDDU2wca
	 DyWM6yn4svXVdALle1AksY6TyYepmqjZ4VRXYKqhm17J9YVoNCVHXOC2inNSDsB7Ry
	 qNNbX0EXRdkIx34Q62ilMjybS+2ePAkignWjByhskC1eksqfKwlGAJPVxIzf2Rjxg0
	 +GZZ7eewB52tnwCvx0OiA2q4EGyzj4vLq4Cn6plisQQ9dhA2NLHj2Z3u95nhgpeDa1
	 JmpBzsS0gdRYA==
Date: Mon, 08 Jun 2026 01:51:19 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] ntfs: bound the look-ahead attribute-list entry in ntfs_external_attr_find()
Message-ID: <20260607203000.700100-2-hexlabsecurity@proton.me>
In-Reply-To: <20260607203000.700100-1-hexlabsecurity@proton.me>
References: <20260607203000.700100-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 654e282f66eb1668eb5283ca2a54cfb3816407b5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When resolving an attribute lookup with a non-zero @lowest_vcn,
ntfs_external_attr_find() peeks at the next $ATTRIBUTE_LIST entry to
decide whether to keep searching, but bounds that not-yet-validated
entry only with "(u8 *)next_al_entry + 6 < al_end" (which proves just
bytes 0..6 are in range) and "(u8 *)next_al_entry + length <=3D al_end"
with an attacker-controlled, non-8-aligned length. It then reads
next_al_entry->lowest_vcn (an __le64 at offset 8) and the name at
next_al_entry->name_offset, both of which can lie past al_end -- the
exact end of the kvmalloc'd attribute-list buffer (allocated at the
on-disk attr_list_size, no rounding). A crafted on-disk $ATTRIBUTE_LIST
whose last entry sits a few bytes before al_end therefore yields a slab
out-of-bounds read when the inode is read.

Validate the look-ahead entry with ntfs_attr_list_entry_is_valid() (added
in patch 1/3) before dereferencing lowest_vcn and the name, so the same
fixed-header, length and name bounds the main attribute-list walk uses now
guard this read too.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
---
v4: rebased onto the "ntfs: validate attribute values on lookup" series
    (0001-0004) now applied to ntfs-next. That series reworked
    ntfs_external_attr_find(), but its changes (resident @val matching and
    the attrlist duplicate check) do not touch this look-ahead block, so
    this patch is unchanged on top of it. Added the Fixes: tag requested
    by Hyunchul. Compile-tested on ntfs-next.
v3 (Hyunchul Lee review): use the extracted ntfs_attr_list_entry_is_valid()
    helper instead of an open-coded bound, so the look-ahead gets the same
    fixed-header, 8-byte-aligned-length and name checks as the main walk.
v2: dropped the redundant Reported-by; reproducer/KASAN splat omitted on
    the public list (available to the maintainers on request).

Confirmed under KASAN on the earlier revision: a slab out-of-bounds read of
next_al_entry->lowest_vcn during inode read of a crafted image; a benign
mkntfs image is KASAN-clean (control). Arch-independent (lowest_vcn at
offset 8, fixed header offsetof(.., name) =3D=3D 26; identical geometry bui=
lt
-m32/-m64).

 fs/ntfs/attrib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 2d675bf99ca7..1e0076ef81ef 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1263,9 +1263,8 @@ static int ntfs_external_attr_find(const __le32 type,
 =09=09 * we have reached the right one or the search has failed.
 =09=09 */
 =09=09if (lowest_vcn && (u8 *)next_al_entry >=3D al_start &&
-=09=09=09=09(u8 *)next_al_entry + 6 < al_end &&
-=09=09=09=09(u8 *)next_al_entry + le16_to_cpu(
-=09=09=09=09=09next_al_entry->length) <=3D al_end &&
+=09=09=09=09ntfs_attr_list_entry_is_valid(next_al_entry,
+=09=09=09=09=09=09=09      al_end) &&
 =09=09=09=09le64_to_cpu(next_al_entry->lowest_vcn) <=3D
 =09=09=09=09=09lowest_vcn &&
 =09=09=09=09next_al_entry->type =3D=3D al_entry->type &&
--
2.43.0

