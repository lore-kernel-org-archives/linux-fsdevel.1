Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F753B2D1A
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 04:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780547374; cv=none; b=h8bVQfkySXUhG7ofNLgCk2OTQ2eJdEJVvtwLyYAfBohz3YSmkN/VRs9LqpLDrC2ZZtGaVFfvq4eTQ8PEfweWiCoccVxI3SURoc8BiEQzLRb0jJb8o775xexJ3HD1DoL4MPvETFFHkD609Wal2f+3BCkOJF++8AQespjGuOvZYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780547374; c=relaxed/simple;
	bh=8nJ5VWLGGa62t0Ko0cIeoQpTFgamopuIDRXZ+9veA+Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ppq0uN12y2na99/wTVqfj3V2QyekgtoRh4VDNKs/OlM4at3WgL4mDFNaXXSR/kkgQ5pmSulyNQdRKHZzdq1YDl72v62finuhxEiOkSrGg3eEQtFNqsPoXruKqqADy2X+gj1+Zkd7cPJfWUyqpy9Pkp9WloanCXbWpBnZRjANEzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=c/A1tZ0R; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="c/A1tZ0R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780547370; x=1780806570;
	bh=KtIrxunl1wbl0DcHjRn3+SpU5WyDnPJ7b+pIP5aKCdI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=c/A1tZ0RYHDJhjxMVmunWackZl5n4rlDXTFRByX300dEvT44r7p9hRlMgiPa17HCR
	 uG1tLCaTm3HjZjjMAH3+sc3+G2AepKRF6R7GlJavcJZDz3rrwNzAxxid7AJwrSIUGm
	 yzNNx/etbgMnFiCTth2u/lviWIUuHVGsLgGjCGNe6IKCAvRxaTTus5DTQ3pWLp2Bzl
	 EUNjzB9idqcNm6fJce7GJ9J80OBf3BTMLiUKFEXXvjyzjW+gFfyQgZgLQxA4rrTHPx
	 GY8T6IcVkaAMXu0WV1C8XJqOK5Zq2IZThWo4huyNaU/dewnQz0RaRNqOV9zZ8ZKMGG
	 6vAEbPEnvN82w==
Date: Thu, 04 Jun 2026 04:29:26 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>
Subject: [PATCH v3 2/3] ntfs: bound the look-ahead attribute-list entry in ntfs_external_attr_find()
Message-ID: <20260604042912.89893-2-hexlabsecurity@proton.me>
In-Reply-To: <20260604042912.89893-1-hexlabsecurity@proton.me>
References: <20260603175949.11665-1-hexlabsecurity@proton.me> <20260604042912.89893-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 813ec7c945622cb951d500041075d4c5b4eafc1b
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

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v3 (Hyunchul Lee review): use the extracted ntfs_attr_list_entry_is_valid()
   helper (added in 1/3) instead of an open-coded bound, so the look-ahead
   gets the same fixed-header, 8-byte-aligned-length and name checks as the
   main walk.
v2: dropped the redundant Reported-by; reproducer/KASAN splat omitted on th=
e
   public list (available to the maintainers on request).

Confirmed under KASAN on the earlier revision: a slab out-of-bounds read of
next_al_entry->lowest_vcn during inode read of a crafted image; a benign
mkntfs image is KASAN-clean (control). Arch-independent (lowest_vcn at
offset 8, fixed header offsetof(.., name) =3D=3D 26; identical geometry bui=
lt
-m32/-m64). Please add the appropriate Fixes: tag for the commit that
introduced ntfs_external_attr_find() in the new fs/ntfs driver (v7.1 merge
window).

 fs/ntfs/attrib.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index abc0add6f0c4..e425c8d074c5 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1185,9 +1185,8 @@ static int ntfs_external_attr_find(const __le32 type,
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
--=20
2.43.0


