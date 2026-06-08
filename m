Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354A2EA481
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780883489; cv=none; b=tfCwWY6N2+g1/geUwFEAr4tbmvkKtc59PLvDMGN/ednPGzOLUPucwOIxHYRm5xYolyAB9pZR72wwDwC8LqmoVp62nBiUYiLqOI2DX3KZ6kEWECgzVX80UU7hsQ2RZsUsm/dcKRRz8hx8S4CJvK8Zw6hxsrMvVslnLYjVYXYEzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780883489; c=relaxed/simple;
	bh=xqe2sx5InC2QpVMjvLwp4eQsfDYk/M8FjB/FTm1xlcs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=eEt8KKkOhCEO/eLV1B/rhDkhS3Jpj6DUOgakhSQn0BJtAMsalGvVF9Zqn5cR5dQZxI+nMrrAoFS4TLhdGITDSy23/mfKdYh2+/mm5aqgdu0XSclV9uFZKlWxs6JL0K1PwZG8umdChVkV622H9AUJgEVJw2oLBEskwH5sSQetofQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RGmlZo6j; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RGmlZo6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780883478; x=1781142678;
	bh=wjF/+LtPyR06hPR8dcHiytPOtb2lSEnKJAITVGpxC2I=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=RGmlZo6j+KNjC0b6SGCACTvwmXYLGGoSMn+DEprTLaGz2lMejRVDgQAg6ipEIp5DM
	 kcDaFvmlAoOzoeZ4rBMKlUWEAWWdxFserwnOUOmf3/yA4cuEwm4LS99XOZR8uwVM7K
	 4KvUHbN051Qo/6GBF+m+/UEK6rZqwO5NjjhkWv3hMMCE8DxQf3u7YDxBD2QUzNgXpy
	 RXy1pMOlVzi1Lqtt9aQnmCEJIePDIyhMo2s4ebDEl5N3EGCfsWkm0i52tV4143JSXY
	 JLfP7ZY8+AE1tzeOr9lEvOMHS1yTxfIhCnK0MOSBteEb9WapDlUcPQAVT1qK5DwNo8
	 gdqIt/4NvMFSA==
Date: Mon, 08 Jun 2026 01:51:12 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] ntfs: validate resident attribute lists and harden the validator
Message-ID: <20260607203000.700100-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 96d6f6e426ce49e941fe7f688e3b3b402669a3fa
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
at all. Every subsequent walk of ni->attr_list --
ntfs_external_attr_find(), ntfs_inode_attach_all_extents() and
ntfs_attrlist_need() -- then trusts the entries are well-formed and reads
attr_list_entry fixed-header fields
(lowest_vcn at offset 8, mft_reference at offset 16, and the name) with
bounds that assume validation already happened. A crafted resident
attribute list therefore reaches those walks unvalidated and can drive
out-of-bounds reads of the attribute-list buffer.

load_attribute_list() itself reads ale->name_offset (offset 7),
ale->mft_reference (offset 16) and the name length under only an
"al < al_start + size" bound, so its own validation loop can over-read the
fixed header of a truncated trailing entry by a few bytes.

Factor the per-entry validation into ntfs_attr_list_entry_is_valid(),
which requires each entry's fixed header (offsetof(struct
attr_list_entry, name)) to be in range before any field is dereferenced,
that ale->length is a multiple of 8 covering the fixed header plus the
name, and that the entry is in use and carries a live MFT reference.
ntfs_attr_list_is_valid() walks the buffer with it and checks the entries
tile it exactly. Use the list validator in load_attribute_list()
(replacing the open-coded loop, closing its own over-read) and on the
resident path in ntfs_read_locked_inode() (which previously skipped
validation entirely); patches 2/3 reuse the per-entry helper at the other
two attribute-list walks.

Fixes: 1e9ea7e04472 ("Revert "fs: Remove NTFS classic"")
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
---
v4: rebased onto the "ntfs: validate attribute values on lookup" series
    (0001-0004) now applied to ntfs-next; this patch is unchanged on top
    of it. Added the Fixes: tag (the fs/ntfs revival commit) requested by
    Hyunchul on 2/3 and 3/3. Compile-tested on ntfs-next (fs/ntfs builds
    clean).
v3 (Hyunchul Lee review): split the per-entry check into
    ntfs_attr_list_entry_is_valid() and call it from the whole series;
    require ale->length to be a multiple of 8.
v2: dropped the redundant Reported-by; reproducer omitted on the public
    list (available to the maintainers on request).

The out-of-bounds reads were confirmed under KASAN on the earlier revision
(crafted NTFS image, fs/ntfs built as a module): the crafted attribute list
that oopsed ntfs_external_attr_find() is now rejected at load with
"ntfs_read_locked_inode(): Corrupt attribute list." and a benign mkntfs
image still mounts. The validator is arch-independent -- struct
attr_list_entry is __packed, so sizeof() =3D=3D offsetof(.., name) =3D=3D 2=
6 and
every field offset (length 4, lowest_vcn 8, mft_reference 16) is identical
built -m32 and -m64.

 fs/ntfs/attrib.c | 78 ++++++++++++++++++++++++++++++++++++++----------
 fs/ntfs/attrib.h |  4 +++
 fs/ntfs/inode.c  |  6 ++++
 3 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 5e1ad1cd0118..2d675bf99ca7 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -921,11 +921,71 @@ char *ntfs_attr_name_get(const struct ntfs_volume *vo=
l, const __le16 *uname,
 =09return NULL;
 }

+/*
+ * ntfs_attr_list_entry_is_valid - sanity check one $ATTRIBUTE_LIST entry
+ * @ale:=09the attribute-list entry to check
+ * @al_end:=09end of the attribute-list buffer @ale lives in
+ *
+ * Verify that @ale is a well-formed attr_list_entry wholly contained in
+ * [.., @al_end): its fixed header must lie in range before any field is
+ * dereferenced, its length must be a multiple of 8 that covers the fixed
+ * header plus the name, the name must lie within the buffer, the entry mu=
st
+ * be in use and carry a live MFT reference.  Return true if valid.
+ */
+bool ntfs_attr_list_entry_is_valid(const struct attr_list_entry *ale,
+=09=09=09=09   const u8 *al_end)
+{
+=09const u8 *al =3D (const u8 *)ale;
+=09u16 ale_len;
+
+=09/* The fixed header must be in bounds before it is parsed. */
+=09if (al + offsetof(struct attr_list_entry, name) > al_end)
+=09=09return false;
+=09ale_len =3D le16_to_cpu(ale->length);
+=09/* On-disk entries are 8-byte aligned (see struct attr_list_entry). */
+=09if (ale_len & 7)
+=09=09return false;
+=09if (ale->name_offset !=3D sizeof(struct attr_list_entry))
+=09=09return false;
+=09if ((u32)ale->name_offset +
+=09    (u32)ale->name_length * sizeof(__le16) > ale_len ||
+=09    al + ale_len > al_end)
+=09=09return false;
+=09if (ale->type =3D=3D AT_UNUSED)
+=09=09return false;
+=09if (MSEQNO_LE(ale->mft_reference) =3D=3D 0)
+=09=09return false;
+=09return true;
+}
+
+/*
+ * ntfs_attr_list_is_valid - sanity check an in-memory $ATTRIBUTE_LIST
+ * @al_start:=09start of the attribute list buffer
+ * @size:=09length of the attribute list in bytes
+ *
+ * Verify that [@al_start, @al_start + @size) is a sequence of valid
+ * attr_list_entry records (see ntfs_attr_list_entry_is_valid()) that tile=
 the
+ * buffer exactly.  Return true if valid, false otherwise.
+ */
+bool ntfs_attr_list_is_valid(const u8 *al_start, s64 size)
+{
+=09const u8 *al =3D al_start;
+=09const u8 *al_end =3D al_start + size;
+
+=09while (al < al_end) {
+=09=09const struct attr_list_entry *ale =3D
+=09=09=09=09(const struct attr_list_entry *)al;
+
+=09=09if (!ntfs_attr_list_entry_is_valid(ale, al_end))
+=09=09=09return false;
+=09=09al +=3D le16_to_cpu(ale->length);
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

 =09if (!al_start || size <=3D 0)
 =09=09return -EINVAL;
@@ -947,19 +1007,7 @@ int load_attribute_list(struct ntfs_inode *base_ni, u=
8 *al_start, const s64 size
 =09}
 =09iput(attr_vi);

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
index f7acc7986b09..e2224fbfaabe 100644
--- a/fs/ntfs/attrib.h
+++ b/fs/ntfs/attrib.h
@@ -71,6 +71,10 @@ int ntfs_attr_lookup(const __le32 type, const __le16 *na=
me,
 =09=09const u32 name_len, const u32 ic,
 =09=09const s64 lowest_vcn, const u8 *val, const u32 val_len,
 =09=09struct ntfs_attr_search_ctx *ctx);
+bool ntfs_attr_list_entry_is_valid(const struct attr_list_entry *ale,
+=09=09=09=09   const u8 *al_end);
+bool ntfs_attr_list_is_valid(const u8 *al_start, s64 size);
+
 int load_attribute_list(struct ntfs_inode *base_ni,
 =09=09=09       u8 *al_start, const s64 size);

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 9717fb5b4709..8a7798d7f5fc 100644
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
--
2.43.0

