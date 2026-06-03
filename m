Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E43955E8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 18:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509608; cv=none; b=ZxbirzOLM8/ZKa1D+DrM273JVt/1nzOoq43oCT02/kgukPQhJGyGDJeVBSGl+J1Byr5gneHVvAuGlCFR4A+DmhvAPUhMW5EfG0xpp42jJBqaRe1JPeZr5ifHl3P215dkX2Okgls5Z81Yfa1liLiO9fY48JFYjEBUk1CKf2ytc0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509608; c=relaxed/simple;
	bh=uWRvSD5R/A0qr2bWrr1HdlktH7kki+g33CgkhcTHbK4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tUcQOcUaHt7QItS8tXKd4wlrn4i2R4iTAviEOO6Pxc4yrjmvgxRz4o4T4Y4CT8nbHhyMT/QyeHqdADDhPATjNA+y5bI0Y01kdRTP/8w1M5/1Tgb4570GwsKk23JscGTWaIpCWjbJdpaBc8nM0noO6+wF/z+Yl1dfhBCkuS/Sfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=SkADy4rI; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="SkADy4rI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=f5b7xc643fdivmdk2fwwootyze.protonmail; t=1780509602; x=1780768802;
	bh=zBbZijUH9fIEJxd5EG6dnZ9o1p14VBqTrn0gqtpVFh8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=SkADy4rInkTuN8uFCP4nw9gUvJqbicULZ+nluaG3K7j0NH00XPN3eO3f8+k8YWZS4
	 zg7kgSsJVOvnLnnCx7cdcn434UxmV8q/KFrloPZw1K7CWCXYsIesG0jT4qA4ft+Z+N
	 SYUiLEq54NTztl1HUDkn6ufcEAynWXSvnpl7bm5QbvjDM5GBkZaTaBHy2PURfwXpa/
	 gadDsIoxh8Vvz660Ma8h/l7B/flgFb71hgscneqZivHDnNyIZSpgBqR2NDVs+UkTOe
	 +7nH/KFgKnpS5gntxKwS9WFFsJG2nPWZmkQ8+oBBLLcKPfURlmulwhyQpOd4ZZUaxF
	 2F8c320ev/QYw==
Date: Wed, 03 Jun 2026 17:59:54 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ntfs: validate resident attribute lists and harden the validator
Message-ID: <20260603175949.11665-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: eed086e93c94d567f83321ab28f7a7ddf0743fc1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A base inode's $ATTRIBUTE_LIST is sanity-checked by load_attribute_list()
only on the non-resident path; ntfs_read_locked_inode() copies a *resident*
attribute list into ni->attr_list with a plain memcpy() and no validation
at all. Every subsequent walk of ni->attr_list -- ntfs_external_attr_find()=
,
ntfs_inode_attach_all_extents(), ntfs_attrlist_need() -- then trusts the
entries are well-formed and reads attr_list_entry fixed-header fields
(lowest_vcn at offset 8, mft_reference at offset 16, and the name) with
bounds that assume validation already happened. A crafted resident
attribute list therefore reaches those walks unvalidated and can drive
out-of-bounds reads of the attribute-list buffer.

load_attribute_list() itself reads ale->name_offset (offset 7),
ale->mft_reference (offset 16) and the name length under only an
"al < al_start + size" bound, so its own validation loop can over-read the
fixed header of a truncated trailing entry by a few bytes.

Factor the per-entry validation into ntfs_attr_list_is_valid(), which
requires each entry's fixed header (offsetof(struct attr_list_entry, name))
to be in range before any field is dereferenced and that the entries tile
the buffer exactly. Use it both in load_attribute_list() (replacing the
open-coded loop, closing its own over-read) and on the resident path in
ntfs_read_locked_inode() (which previously skipped validation entirely).

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
v2: dropped the redundant Reported-by (it duplicated Signed-off-by); reprod=
ucer
    omitted on the public list -- available to the maintainers on request.
    Posting publicly per security@kernel.org guidance that crafted-image
    filesystem bugs fall outside the kernel security process's threat model=
.

Root cause behind the two out-of-bounds reads in patches 2/3 and 3/3: those
harden the individual read sites; this validates the list centrally so the
other walks (ntfs_inode_attach_all_extents, ntfs_attrlist_need) are covered
too. Verified under KASAN: the crafted attribute list that previously oopse=
d
ntfs_external_attr_find() is now rejected at load with
"ntfs_read_locked_inode(): Corrupt attribute list." and no out-of-bounds
access; a benign mkntfs image still mounts. checkpatch clean.

 fs/ntfs/attrib.c |   56 ++++++++++++++++++++++++++++++++++++++++----------=
----
 fs/ntfs/attrib.h |    2 ++
 fs/ntfs/inode.c  |    6 ++++++
 3 files changed, 49 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 421c6cdcbb53..36c1df25a622 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -843,11 +843,49 @@ char *ntfs_attr_name_get(const struct ntfs_volume *vo=
l, const __le16 *uname,
 =09return NULL;
 }
=20
+/*
+ * ntfs_attr_list_is_valid - sanity check an in-memory $ATTRIBUTE_LIST
+ * @al_start:=09start of the attribute list buffer
+ * @size:=09length of the attribute list in bytes
+ *
+ * Verify that [@al_start, @al_start + @size) is a well-formed sequence of
+ * attr_list_entry records.  Each record's fixed header must lie within th=
e
+ * buffer before any of its fields are dereferenced, its length must cover
+ * the fixed header plus the name, and the records must tile the buffer
+ * exactly.  Return true if valid, false otherwise.
+ */
+bool ntfs_attr_list_is_valid(const u8 *al_start, s64 size)
+{
+=09const u8 *al =3D al_start;
+=09const u8 *al_end =3D al_start + size;
+
+=09while (al < al_end) {
+=09=09const struct attr_list_entry *ale =3D
+=09=09=09=09(const struct attr_list_entry *)al;
+=09=09u16 ale_len;
+
+=09=09/* The fixed header must be in bounds before it is parsed. */
+=09=09if (al + offsetof(struct attr_list_entry, name) > al_end)
+=09=09=09return false;
+=09=09ale_len =3D le16_to_cpu(ale->length);
+=09=09if (ale->name_offset !=3D sizeof(struct attr_list_entry))
+=09=09=09return false;
+=09=09if ((u32)ale->name_offset +
+=09=09    (u32)ale->name_length * sizeof(__le16) > ale_len ||
+=09=09    al + ale_len > al_end)
+=09=09=09return false;
+=09=09if (ale->type =3D=3D AT_UNUSED)
+=09=09=09return false;
+=09=09if (MSEQNO_LE(ale->mft_reference) =3D=3D 0)
+=09=09=09return false;
+=09=09al +=3D ale_len;
+=09}
+=09return al =3D=3D al_end;
+}
+
 int load_attribute_list(struct ntfs_inode *base_ni, u8 *al_start, const s6=
4 size)
 {
 =09struct inode *attr_vi =3D NULL;
-=09u8 *al;
-=09struct attr_list_entry *ale;
=20
 =09if (!al_start || size <=3D 0)
 =09=09return -EINVAL;
@@ -869,19 +907,7 @@ int load_attribute_list(struct ntfs_inode *base_ni, u8=
 *al_start, const s64 size
 =09}
 =09iput(attr_vi);
=20
-=09for (al =3D al_start; al < al_start + size; al +=3D le16_to_cpu(ale->le=
ngth)) {
-=09=09ale =3D (struct attr_list_entry *)al;
-=09=09if (ale->name_offset !=3D sizeof(struct attr_list_entry))
-=09=09=09break;
-=09=09if (le16_to_cpu(ale->length) <=3D ale->name_offset + ale->name_lengt=
h ||
-=09=09    al + le16_to_cpu(ale->length) > al_start + size)
-=09=09=09break;
-=09=09if (ale->type =3D=3D AT_UNUSED)
-=09=09=09break;
-=09=09if (MSEQNO_LE(ale->mft_reference) =3D=3D 0)
-=09=09=09break;
-=09}
-=09if (al !=3D al_start + size) {
+=09if (!ntfs_attr_list_is_valid(al_start, size)) {
 =09=09ntfs_error(base_ni->vol->sb, "Corrupt attribute list, mft =3D %llu",
 =09=09=09   base_ni->mft_no);
 =09=09return -EIO;
diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
index f7acc7986b09..4b11d4b0be14 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -71,6 +71,8 @@ int ntfs_attr_lookup(const __le32 type, const __le16 *nam=
e,
 =09=09const u32 name_len, const u32 ic,
 =09=09const s64 lowest_vcn, const u8 *val, const u32 val_len,
 =09=09struct ntfs_attr_search_ctx *ctx);
+bool ntfs_attr_list_is_valid(const u8 *al_start, s64 size);
+
 int load_attribute_list(struct ntfs_inode *base_ni,
 =09=09=09       u8 *al_start, const s64 size);
=20
diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 360bebd1ee3f..a5f7400fd19d 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -848,6 +848,12 @@ static int ntfs_read_locked_inode(struct inode *vi)
 =09=09=09=09=09a->data.resident.value_offset),
 =09=09=09=09=09le32_to_cpu(
 =09=09=09=09=09a->data.resident.value_length));
+=09=09=09/* A resident list is not validated on load; check it now. */
+=09=09=09if (!ntfs_attr_list_is_valid(ni->attr_list,
+=09=09=09=09=09=09     ni->attr_list_size)) {
+=09=09=09=09ntfs_error(vi->i_sb, "Corrupt attribute list.");
+=09=09=09=09goto unm_err_out;
+=09=09=09}
 =09=09}
 =09}
 skip_attr_list_load:
--=20
2.43.0

