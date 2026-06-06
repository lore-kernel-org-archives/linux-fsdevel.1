Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CE2A59;
	Sat,  6 Jun 2026 22:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780784962; cv=none; b=ePMQTR68S/I6uGZdKEBl3u+eDtdUxpTWdSFLcVdjceaVweEKY2xvo4Q4FQmePYI3r/jXrslz/xr536V5U1V4G9vMKApnSK94STRrvUxr2DMPhS1NYhwUPWkalQPZHssrwOd3loDWHT1kiPIXM9g8jy7Npu6lYnxr9b4H5ok4wbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780784962; c=relaxed/simple;
	bh=X3tBuU+kvwwROh4Eb2E8T5bqWt7+6jOZuVsltSDfwXE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=awwRx1dCpSmaekMU0AUU/gGNo5eX3w6KlLTNsqliiZSzXVeBGAyIjLD8/MtI0suDmQ5SBYmfUGfNSjh6DRyqFxtvA1j8s703wtak9a/a4K5hJKAJETLEj8cZlk/kSvIsjyAaKlyk8N5ARF4vQCmgI6alYa7IMSx+bnA7jGiWkOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=fqeu+2AR; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="fqeu+2AR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780784950; x=1781044150;
	bh=N+F9WuEBM14Qvw0uAHPQ2dM84FnzkxqWCs/JHyNmvHE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fqeu+2ARYuI5rghQ/wlPeWVRyWcHllOrnZlqQGojjIJOkFb6ywThyW2UYjbLox20Y
	 gYMIn69oENmMvxoK0CyJhITNLkX1dK5BYhIFuG317EfgxcgOCAl7VOOAeiavbZ5Tpo
	 C21BHfztvS8FqQaaYTMMLcjmRqZo02RQ/jyWZT8vwrYsr3oiLrO9RpUkFVdbd7gBHj
	 E9XI03tUR530IZMGEWYmNG3x2sjzf2Z2l8Y4dK1wH/ppilqX+86mVqfULqWpBlUHfE
	 BRAR5wPdnwDJuK6ABCipHkL/uVWnKSueBRNHBKirQdZ2VhGL2KMzq2nfv6h5/Iozxd
	 +luEtKw1ltrFg==
Date: Sat, 06 Jun 2026 22:29:03 +0000
To: Jan Kara <jack@suse.cz>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] isofs: bound Rock Ridge symlink components to the SL record
Message-ID: <20260606222857.193818-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 10046c6cc25801d902f0b92ececed420ec8ae786
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

get_symlink_chunk() and the SL handling in
parse_rock_ridge_inode_internal() walk the variable-length components of
a Rock Ridge "SL" (symbolic link) record.  Each component is a two-byte
header (flags, len) followed by len bytes of text, so it occupies
slp->len + 2 bytes.  Both loops read slp->len and advance to the next
component, and get_symlink_chunk() additionally does
memcpy(rpnt, slp->text, slp->len), but neither checks that the component
lies within the SL record before dereferencing it.

A crafted SL record whose component declares a len that runs past the
record (rr->len) therefore triggers an out-of-bounds read of up to 255
bytes.  When the record sits at the tail of its backing buffer - for
example a small kmalloc()ed continuation block reached through a CE
record - the read crosses the allocation; get_symlink_chunk() then
copies the out-of-bounds bytes into the symlink body returned to user
space by readlink(), disclosing adjacent kernel memory.

ISO 9660 images are routinely mounted from untrusted removable media -
desktop environments auto-mount them (e.g. via udisks2) without
CAP_SYS_ADMIN - so the record contents are attacker-controlled.

Reject any component that does not fit in the remaining record bytes
before using it, in both walk sites.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproducer (crafted ISO-9660 image with Rock Ridge):

  # a symlink whose SL component length byte is enlarged so the
  # component overruns its SL record
  ln -s "$(python3 -c 'print("A"*250)')" /tmp/iso/l
  genisoimage -R -o rr.iso /tmp/iso
  # repoint the symlink's CE record to a tight continuation block
  # (cont_size =3D 7) holding one SL record:
  #   53 4c 07 01 00 00 ff   "SL", len 7, ver 1, comp flags 0, comp len 0xf=
f
  # so rock_continue() does kmalloc(7) and the component text begins at
  # the end of that allocation.
  mount -o loop,ro rr.iso /mnt
  readlink /mnt/l

Without the patch, get_symlink_chunk() memcpy()s slp->len (0xff) bytes
starting one byte into the 7-byte allocation, so readlink() returns the
symlink target followed by adjacent in-kernel bytes (verified: the
returned link contains neighbouring directory-record / slab contents,
not just the target).  On a tight continuation allocation the read
leaves the object and is a slab-out-of-bounds read that KASAN reports in
get_symlink_chunk().  With the patch the over-long component is rejected
(slp->len + 2 > slen) and readlink() returns only the valid prefix; a
well-formed Rock Ridge image is unaffected.

 fs/isofs/rock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/isofs/rock.c b/fs/isofs/rock.c
index 1232fab59a4e..0fe781381e66 100644
--- a/fs/isofs/rock.c
+++ b/fs/isofs/rock.c
@@ -466,6 +466,9 @@ parse_rock_ridge_inode_internal(struct iso_directory_re=
cord *de,
 =09=09=09=09inode->i_size =3D symlink_len;
 =09=09=09=09while (slen > 1) {
 =09=09=09=09=09rootflag =3D 0;
+=09=09=09=09=09/* keep the component within the SL record */
+=09=09=09=09=09if (slp->len + 2 > slen)
+=09=09=09=09=09=09break;
 =09=09=09=09=09switch (slp->flags & ~1) {
 =09=09=09=09=09case 0:
 =09=09=09=09=09=09inode->i_size +=3D
@@ -621,6 +624,14 @@ static char *get_symlink_chunk(char *rpnt, struct rock=
_ridge *rr, char *plimit)
 =09slp =3D &rr->u.SL.link;
 =09while (slen > 1) {
 =09=09rootflag =3D 0;
+=09=09/*
+=09=09 * A component is a two-byte header (flags, len) followed by
+=09=09 * len bytes of text, i.e. slp->len + 2 bytes.  Stop if it does
+=09=09 * not fit in the bytes left in the SL record, otherwise the
+=09=09 * memcpy() of slp->text below reads past the record.
+=09=09 */
+=09=09if (slp->len + 2 > slen)
+=09=09=09break;
 =09=09switch (slp->flags & ~1) {
 =09=09case 0:
 =09=09=09if (slp->len > plimit - rpnt)
--
2.43.0

