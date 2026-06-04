Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFE622D7B5;
	Thu,  4 Jun 2026 05:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780551581; cv=none; b=GUMvQL+4Q1o4184SA/YQEnrididnRqOHJmSo8EQQFCwma3IGvtXpim9PKXVQP3v9ziF0ei0nCyz82Rxx6KFz6snS79CWNs5eOGpXDn2cg8y3T6YCsySsGHwTKN1tthMlFMtA1mJxMPkoRPC+rZ8hjcmYNPYKOCSmXgBmqdeK1xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780551581; c=relaxed/simple;
	bh=HNHqRq01vvZksaFr5VxaAR61jLsUjdcitNyOClDjAjI=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DdqlWqEr25pE0TMU16jDNEub6hqMdnzRilD9smLF+iNoyru6GdIsP3WMMEgBHQJ0BPrEJbCXJhYXtDNVu9a160n8AUiz/s3VgDg+vzQo9raIRq3MDcq8eX+KaxeKvyRHFEcB++MyXC0K0vpIwkqPzaa1iJhopJz84vDmhPO9AYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Rkg/MZUA; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Rkg/MZUA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780551574; x=1780810774;
	bh=R0s8BOqMOt4AG61pMZfP3Xxe3bwVqCULb2cgwU9Y4BQ=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Rkg/MZUA8qUv/CrT/AGbxToZTO/R1A7e8ONNfYQIpDwINCAPpqSrihq56U3YEl7hn
	 1xa5mhUYG7RrUw4Tb5iND5qyPFMua2rMkZpa6tI+hINClBBN/qu+JnPrWBw1LhvGW4
	 Bl+Dte7Pab+66Ri2e8KRf3z3+ewj/lhUDlaVq2aD2BXsqBJO2YWLQldaaAJf9w0YsS
	 1ZZqhrAyegfdpVC5WHwRzxGmMA4j87ZOw6BG6jahbr7dV7QFlSW1PKZgXLQFG4z80D
	 OeqTa+6N2vzyVsiT2NgjzihC7GWAsgxXrXTWfU4czsjWK8QxaWLlnM/awa/WcIPtSG
	 uZTjLC/+34Wmg==
Date: Thu, 04 Jun 2026 05:39:27 +0000
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Bryam Vargas <hexlabsecurity@proton.me>
Subject: [PATCH] ntfs: validate $FILE_NAME length before converting the name
Message-ID: <20260604053921.100409-1-hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: c8614f94192909d9ca0e15fb1b9b1cbc997eff82
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ntfs_is_extended_system_file() walks a base inode's $FILE_NAME attributes
and, for a name whose parent is $Extend, converts the on-disk name to the
local charset via ntfs_attr_name_get() -> ntfs_ucstonls(). It checks that
the resident value [file_name_attr, +value_length) lies within the
attribute, but never checks that file_name_length (an on-disk u8) fits
inside that value.

ntfs_ucstonls() then reads file_name_length __le16 characters starting at
file_name_attr->file_name (offset 66 in the __packed struct), so a crafted
$FILE_NAME whose value_length covers just the fixed header but whose
file_name_length is 255 drives an out-of-bounds read of up to ~508 bytes
past the resident value -- and, when the MFT record buffer is a tight
kmalloc (mft_record_size equal to a power-of-two slab bucket), past the
allocation itself.

Reject the attribute when file_name_length does not fit within
value_length before the name is read.

Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
Reproducer omitted on the public list -- available to the maintainers on
request. This is a crafted-image filesystem bug; posting publicly per the
security@kernel.org guidance on the sibling fs/ntfs attribute-list fixes th=
at
such bugs fall outside the kernel security process's threat model.

The over-read was observed under KASAN by mounting a crafted NTFS image
(fs/ntfs built as a module against v7.1-rc5): a $FILE_NAME on a system file=
 in
$Extend with value_length 68 and file_name_length 255 trips, during inode
read, a slab-out-of-bounds read of size 2 in utf16s_to_utf8s() along the ch=
ain

  ntfs_ucstonls <- ntfs_attr_name_get <- ntfs_is_extended_system_file <-
  ntfs_read_locked_inode <- ntfs_iget <- ntfs_fill_super

off the kmalloc-1k MFT record buffer (mft_record_size 1024, allocated by
map_mft_record_folio). A benign mkntfs image is clean on the same kernel
(control). With this bound in place the crafted $FILE_NAME is rejected with
-EIO ("Corrupt file name attribute") before the conversion, while a benign
name (value_length =3D=3D 66 + file_name_length * 2) still passes. The boun=
d is arch-independent: struct
file_name_attr is __packed, so offsetof(.., file_name) =3D=3D 66 and the ch=
eck
decides every case identically built -m32/-m64.

The only other reader of file_name_length for name conversion is under
#ifdef DEBUG in fs/ntfs/namei.c (not built in production); it can be guarde=
d
the same way if desired.

The flaw is original to the fs/ntfs driver: ntfs_is_extended_system_file()
landed with the driver itself (linkinjeon/ntfs, v7.1 merge window). A Fixes=
:
tag against that introducing commit is appropriate -- I'd appreciate you
pinning the exact SHA from your tree, as it is not unambiguously citable fr=
om
a mainline clone. checkpatch clean.

 fs/ntfs/inode.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 360bebd1ee3f..d1a79c276502 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -581,6 +581,17 @@ static int ntfs_is_extended_system_file(struct ntfs_at=
tr_search_ctx *ctx)
 =09=09p2 =3D (u8 *)file_name_attr + le32_to_cpu(attr->data.resident.value_=
length);
 =09=09if (p2 < (u8 *)attr || p2 > p)
 =09=09=09goto err_corrupt_attr;
+=09=09/*
+=09=09 * The name is converted below; file_name_length is an on-disk
+=09=09 * u8 that is not otherwise cross-checked, so make sure the name
+=09=09 * fits within the resident value before it is read.
+=09=09 */
+=09=09if (le32_to_cpu(attr->data.resident.value_length) <
+=09=09=09=09offsetof(struct file_name_attr, file_name) ||
+=09=09    offsetof(struct file_name_attr, file_name) +
+=09=09=09=09file_name_attr->file_name_length * sizeof(__le16) >
+=09=09=09=09le32_to_cpu(attr->data.resident.value_length))
+=09=09=09goto err_corrupt_attr;
 =09=09/* This attribute is ok, but is it in the $Extend directory? */
 =09=09if (MREF_LE(file_name_attr->parent_directory) =3D=3D FILE_Extend) {
 =09=09=09unsigned char *s;
--
2.43.0

