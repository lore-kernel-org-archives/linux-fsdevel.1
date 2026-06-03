Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B237F74B;
	Wed,  3 Jun 2026 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509614; cv=none; b=PpxKV5J3M9cXyn7VMX/jaSTwq0Q4yNSrNwLbaCCj3RETJhwJ7f+0zF6z8FuwdSZaGG746z8BCogllx0EeUlOXLhG9sPgAEsUDgpANu3HJZAAr/kSPN+sTL/Ju+aeZViRDvu/JT+r6uCtlEmLhfXJkxNFEDOoUoye4ehTJ8C/4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509614; c=relaxed/simple;
	bh=8HttBhrzDebS1fdrNx5Im3oOwaB9v/hX+rNrtZH8n6k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcr1UPOgBzoZJqeERah9zyHm50ZCE6ElCrdapxWj657GAc3OFDUB7EKggv5SFw9yLGZnc6k3lR4Jaq6dz+8nSyei52UT8H2kBAIfzL/jxhvIQ6ntheJ1ajVoOyJ7SxR3MqQRCS4fxDJidkY3eqorsrpRKnsSTLbBA2hVul/WFec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=IDRqrO2u; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="IDRqrO2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=k6tpzgjqnrd67fkrqcy4qpplbu.protonmail; t=1780509608; x=1780768808;
	bh=iBXELzdrDdc2CjxRxVjDSJ5xuzl+6LB2bx8iIu3vz4U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=IDRqrO2unDP3Eh+wZK6nchWeFM+dLfS3zvPu209/sX6FiPibjifys1Pfdu15d9/2L
	 j4CDrqHYsKsdqMxi5m2Nfg0SQvBE+8UzOSPgeSztRle1XVPLDRngn8GUlaW4nqcISy
	 dzn9i9OqTIAAGAW12Cj0uNNAQLHXoCvBt1uNunZJx/8UYhnWb9LATrPscYZcX7o9Ju
	 /RNqyoOk2Xlsidq+N/WfeiL4aX4lJ7yuLRGJYAhsEuVUwxFEYV55YBkFidXw6gIV2u
	 e+FB1b30TY+3c9RSQ5wbmJUeqEHO/QgnNfOSVNNOAWK4tH+DumAztbCKJV50eoFzC8
	 WBcyn6oR2+fqQ==
Date: Wed, 03 Jun 2026 18:00:01 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] ntfs: bound the look-ahead attribute-list entry in ntfs_external_attr_find()
Message-ID: <20260603175949.11665-2-hexlabsecurity@proton.me>
In-Reply-To: <20260603175949.11665-1-hexlabsecurity@proton.me>
References: <20260603175949.11665-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: cef88df27b2eec9baf0cd22b6026e314a84fc051
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

Apply to the look-ahead entry the same bounds the main loop already
applies to the current entry: require the fixed header up to
offsetof(struct attr_list_entry, name) to be in range, and the name to
lie within the buffer, before dereferencing lowest_vcn and the name.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: dropped the redundant Reported-by; reproducer and KASAN splat omitted o=
n
    the public list -- available to the maintainers on request. Posting per
    security@kernel.org guidance that crafted-image filesystem bugs are out=
 of
    the kernel security process's threat model.

Verified by mounting a crafted NTFS image under KASAN (fs/ntfs built as a
module against v7.1-rc5): a slab out-of-bounds read of next_al_entry->lowes=
t_vcn
during inode read; a benign mkntfs image is KASAN-clean on the same kernel
(control). Arch-independent: the on-disk struct is __packed (lowest_vcn at
offset 8, fixed header up to offsetof(struct attr_list_entry, name) =3D=3D =
26) and
the over-read is an le64; identical geometry built -m32/-m64, so 32- and 64=
-bit
kernels are both affected.

Fixes note: this is in the fs/ntfs driver added during the v7.1 merge windo=
w.
The look-ahead expression is carried verbatim from the legacy fs/ntfs drive=
r
(removed in v6.9; present unchanged since v2.6.12), where __ntfs_malloc()
rounded the list allocation up to a full kmalloc(PAGE_SIZE) and masked it; =
the
new driver's exact-size kvmalloc(attr_list_size) exposes it. Please add the
appropriate Fixes: tag for the commit that introduced ntfs_external_attr_fi=
nd()
in the new driver.

 fs/ntfs/attrib.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 421c6cdcbb53..aed68b8e69ea 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1137,9 +1137,14 @@ static int ntfs_external_attr_find(const __le32 type=
,
 =09=09 * we have reached the right one or the search has failed.
 =09=09 */
 =09=09if (lowest_vcn && (u8 *)next_al_entry >=3D al_start &&
-=09=09=09=09(u8 *)next_al_entry + 6 < al_end &&
+=09=09=09=09(u8 *)next_al_entry +
+=09=09=09=09=09=09offsetof(struct attr_list_entry, name) <=3D al_end &&
 =09=09=09=09(u8 *)next_al_entry + le16_to_cpu(
 =09=09=09=09=09next_al_entry->length) <=3D al_end &&
+=09=09=09=09(!next_al_entry->name_length ||
+=09=09=09=09 (u8 *)next_al_entry + next_al_entry->name_offset +
+=09=09=09=09 next_al_entry->name_length * sizeof(__le16) <=3D
+=09=09=09=09=09=09al_end) &&
 =09=09=09=09le64_to_cpu(next_al_entry->lowest_vcn) <=3D
 =09=09=09=09=09lowest_vcn &&
 =09=09=09=09next_al_entry->type =3D=3D al_entry->type &&
--=20
2.43.0

