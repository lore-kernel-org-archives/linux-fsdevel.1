Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7718C1E1DE5
	for <linux-fsdevel@vger.kernel.org>; Sun,  7 Jun 2026 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780795123; cv=none; b=od3aDvH7wPH7YPzj4FqzbAX31NKEP9/GdDgnTt5RI82g+7Suim+oSxIdCdG/gBe67BYH5MJaBOF3JEm/W6SANUbGvFg1u06KedmBIg5MEq3S7E8NFhXHx2UK5jqeTFCMKfppmRgc5PC/o5J51UBT9N7I8lBMVa0zTHq1WsNYPYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780795123; c=relaxed/simple;
	bh=ASKjjWNz9s4coJoshd3o+jrceXEI0y/+xplNVEcgkqg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=fGkz4uBwQ5sGE4qGMeWTkQ0/vmc6annNO+mGTSHbaeWr1yWeDkymuJgCmd3I85C0m1S12zyBZq7qCXWhDcP7yOPXLV6jSOvt3pikAakIC5s5pkPWQCh/l5RBRUteoK9ftqelzA5MrLSFxyKS218T9a8A+EpnJYib13f0FJAxmio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L/l/Wcve; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L/l/Wcve"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780795112; x=1781054312;
	bh=xrYwmOMniSXjQLPYeg4R977pNd39/OwacxST5UoppdM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=L/l/WcveMlZ/B1jB2oydA9/HQPTssUx4/qfNgXTs5uuDuwTpi8MvD0TEqjlm95Z/7
	 nVT+rxrfkW+NyUCflhwd009+OJO04SasUq8rqYjlGa6jXJqaxIggPKkJbOWrzqvKU2
	 U2EQXx1t5T7YtT6Ob7VSfm4CPBX38rOUjrISo7lcn1vwIavW65SRI9LJCTMoNhG8qR
	 0enKrF86ioMRAi14yI5cXyo4cvWdT+l1pDpXY62MDfx2Nc4oevLoET24+Gwj3EBO6P
	 UTKCzLLgN3UtVeCaumAwuRxNOnZIb31wY4dmbbpoQEfcICrih6WCd3MF0R7sW2mjxD
	 8/BCW/L56+9Gg==
Date: Sun, 07 Jun 2026 01:18:27 +0000
To: Jan Kara <jack@suse.cz>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: Michael Bommarito <michael.bommarito@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] isofs: bound Rock Ridge symlink components to the SL record
Message-ID: <20260607011823.217748-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: d043ea059030478525295b522b17a8908eccfc35
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
before using it.  In get_symlink_chunk() return NULL, like the existing
output-buffer (plimit) checks, so a malformed record makes readlink()
fail with -EIO rather than silently returning a truncated target; in
parse_rock_ridge_inode_internal() stop the inode-size walk.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Suggested-by: Michael Bommarito <michael.bommarito@gmail.com>
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: in get_symlink_chunk() return NULL (-> readlink() -EIO) instead of
    break on an over-long component, per Michael Bommarito's review.
    break would let rock_ridge_symlink_read_folio() treat the truncated
    rpnt as success and hand a silently-truncated symlink to userspace;
    NULL matches the function's existing plimit-overflow handling and
    fails closed.  The size walk in parse_rock_ridge_inode_internal()
    keeps break (it only bounds i_size; the read path now errors).

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
symlink target followed by adjacent in-kernel bytes.  With the patch the
over-long component is rejected (slp->len + 2 > slen) and readlink()
fails with -EIO; a well-formed Rock Ridge image is unaffected.

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
+=09=09 * A component is slp->len + 2 bytes (a two-byte header plus
+=09=09 * len bytes of text).  If it does not fit in the bytes left in
+=09=09 * the SL record the record is malformed: fail like the plimit
+=09=09 * checks below so readlink() returns -EIO, not a truncated path.
+=09=09 */
+=09=09if (slp->len + 2 > slen)
+=09=09=09return NULL;
 =09=09switch (slp->flags & ~1) {
 =09=09case 0:
 =09=09=09if (slp->len > plimit - rpnt)
--
2.43.0

