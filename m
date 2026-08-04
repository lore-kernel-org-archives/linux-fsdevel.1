Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDEE3290B9
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 07:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785826834; cv=none; b=g9KT0jp4tqYEJo7YuT032RvwFx4iHAQUrr+qAkSXUGuu88o9a9P38Z6NSR6FZqDaetEipC57a31AfMWZEBht+AZfVmSOXA8m/dlX4M6hMOt+vvaCEGm4Ok80ssiJJ1jiuM3SEHEGCZy3ttAfS4OexN2d26HOHjqkyEQfw3G8xJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785826834; c=relaxed/simple;
	bh=ZTJIGvbRJzAFEfe9lGsFwo490/TE8Ds9sbtsjVe8Mr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzqtjbWKg/G429y+faV0hNjChtwvPw9XyuYIZPA+Ax/Gzqx+Meua8VBZgdiEnWzuN7KclDAHCGcMF/gcJcN2tA1rfg1hngpm+xq7E1K5vP8Y0xpacUZ6eDxL6VrPwYdtizEJHaUhZAEw6dUm1QFtwa1cPipOiCvWoVoYMtdXhZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=E+WGd9l6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="E+WGd9l6"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2caea3f742bso44379625ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Aug 2026 00:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785826827; x=1786431627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/S+1PBjrGBEUu7nxCeFZRReMl5493FNSk6+JZoIwyAE=;
        b=E+WGd9l6lmvsU2Fbn1XPZ6bkeedqRODtJ9KwtVqxHgv+oIDRiSFJmZH17LwCYyn8tT
         i4Zrws07XJ2HbQiugJ/g6NKAsCxSiFiD/O/UVoHofBNvRDC49lYrfEWKtrFcEpUyDoNa
         n5EoKluxJBeTiEME3Oc7qXdaB6v7gp6vTIa5FcnIeQhbC2hAOTED4Vu+vovHFtu8xVKl
         x5G5FVM68T+rrErIs4qWVTiE5ikH24El/N7EXURi/WJdVucmpSU8xh3hC7dR5tQvjN3v
         2WuvcGYuJdXkQnbKIM8tP79eiV50nu4dBkI6BpLsWiKRBWenIfWENrg0SCI8T0wfnuWY
         zxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785826827; x=1786431627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/S+1PBjrGBEUu7nxCeFZRReMl5493FNSk6+JZoIwyAE=;
        b=XNR3JjMbp45Lwqt6zEq+L2Nm2U+t6YOTab8YbZ+p5odErfuVnpxnyekvm9vae7RKRt
         CiJQzb6nTqIsa58t1/2HLm7NEG22DOlAXdHijrQir7RRLhy9E87Jq4k2gnJd6WGpQ56G
         gEcdsmZci0c5LxxDecmOCAlLSH7Tei9SzP6fH4br0Q9f6J7jDVPZVkmJ/EAypZJv4i63
         k8P+DB9XLFZvgvUiup5Pg7YiBUeugskD2BK2Wsw4RvV9KV/kqtann08PDW0HjyfSApcL
         HQpMzl6exGfb6nz0dMXmm0TSKAfJgav9diXsRL8gdDVM8Ro/3qF2AcUW4Vzb7+3t4its
         CPCA==
X-Gm-Message-State: AOJu0YyfaPChTY/93SKazpcPtk3neJ0XftXw1v7r+dbLa60B5F4QN2Ct
	OQvWAH5vQckTHx5+K2OoX8jZsbiowG8pId18n2QZryG0IzR9gr97EdzOce/QPXCJc2XJ6GOG3oR
	VUUuUKSU=
X-Gm-Gg: AR+sD12NRqEDKtuTw4Ui4dJMbtaEpzZtbmTjaPtJW2p2auc2LDtG3JRGK4ZNxQuua5l
	HyAeGpD4QUG5+kfw5skJjTeBMU0O8Amd5IhZzvu9aaqvLc9u1JJVFgH8ujVHowPgYBIcWTzQ7kJ
	WEGGa3ORtJo4dHhlaYcb6dcg+sLu8pKNcXZszhiFh1J+30Pws0UhdAGhgmLIs2CxTyc3lXQLZBi
	jmXUBwLUWRCuPTfPp3XcQzYPzHzsUPzgLVUQZRKz9SEKzapb1CrQm2e+QsMJO1i0DPgaOt7fyCo
	DDTK8dcPDVtRDsW8bGQ21w+9ZaMhpOZzzA26Uu6/cqveMyFalkegbn6uj/8a98YXwJ5NuldXeez
	uXRwBpKJv+cQEBw5eSu5Es9UeWyo8L8cS3k+Ss/hB0BQceQIG9T8XgTrYOTnrkFygtqwYS8ipZo
	MKuu/o0sRlHy7NkJ8TH11yH/b3jAQM9J7Z6jVbBbaM2P9XQEKY5u8dN1BLsNUTTf4/dSKzynQEq
	NKWmlSIZufMk0M1o6ZyqIFBEOlnHrGi8ddD4J4S
X-Received: by 2002:a17:903:1105:b0:2d0:87ee:560 with SMTP id d9443c01a7336-2d087ee0569mr27933385ad.41.1785826827320;
        Tue, 04 Aug 2026 00:00:27 -0700 (PDT)
Received: from Mac.lan ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa492c7fsm961835ad.43.2026.08.04.00.00.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 00:00:26 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: hch@infradead.org,
	federico.kirschbaum@xbow.com,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH v2] freevxfs: fix off-page reads in the directory walkers
Date: Tue,  4 Aug 2026 16:00:23 +0900
Message-ID: <20260804070023.29682-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726062514.43756-1-baul.lee@xbow.com>
References: <20260726062514.43756-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vxfs_readdir() and vxfs_find_entry() walk a directory page with an
intra-page offset, pg_ofs, and dereference kaddr + pg_ofs without bounding
it.  Nothing validates the page first: vxfs_check_page() was never
implemented, only a commented out call survives in vxfs_get_page().  Three
on-disk values steer the walk unchecked.

VXFS_DIRBLKOV(), 2 * d_nhash + 4, is added at a dirblock boundary and the
entry is dereferenced right after; the enclosing while (pg_ofs < PAGE_SIZE
&& pos < limit) only gates the next iteration.  d_nhash can move the
dereference 32 pages from the start of the page.

d_reclen is added at the end of each iteration.  There the loop condition
does run, but it only proves that pg_ofs is inside the page, not that an
entry header is: pg_ofs of PAGE_SIZE - 2 passes it, and d_reclen at offset
4 of the next entry is off the page.

d_namelen is never compared to its record.  vxfs_readdir() passes it to
dir_emit() as the length of d_name, which starts at offset 10 of the entry.
filldir64() rejects PATH_MAX and above, but only after verify_dirent_name()
has run memchr() over the name, and shorter names are copied out - up to
4095 bytes past the page.  vxfs_find_entry() memcmp()s up to 256.

A crafted image reaches all three, vxfs_readdir() from getdents64(2) and
vxfs_find_entry() from a path walk.  KASAN reports a 2-byte read past the
page in vxfs_readdir(), a read in memchr() below filldir64(), and a read in
memcmp() below vxfs_lookup().

Bound them: leave the page if the overhead moved pg_ofs out of it, require
the entry header and then the whole record to fit in the page, and skip an
entry whose name does not fit in its record.  A record shorter than its own
header is refused too, so a free entry cannot slide the next one by less
than an entry.  Where the page is abandoned, advance pos to its end so the
outer loop keeps making progress.

vxfs_readdir() also ended the walk on a page that emitted nothing, its
per-page rc conflating a full buffer with an empty page, and the new checks
add another way to reach that; track the full buffer directly.

Valid images are unaffected: a record holds its own name and does not cross
its dirblock, dirblocks do not cross a block, and sb_set_blocksize() has
already refused a block size larger than a page.

Found by XBOW.

Fixes: 12495ea3ac47 ("freevxfs: refactor readdir and lookup code")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2, in reply to the Sashiko review Christian pointed at.  Its three points
are right.

v1 checked pg_ofs only after the dirblock overhead, which does not cover
the dereference: pg_ofs of PAGE_SIZE - 2 passes that check too, and
d_reclen alone reaches it.  A kernel carrying v1 still reports both reads.
The d_namelen one is the worse of the two and predates the 2016 refactor,
hence the second Fixes tag.  The premature end of the walk is real but is
not memory safety; it is in here because the new checks add a way to reach
it, and I can split it out if you prefer.

Not taken: 4 byte alignment for d_reclen.  It cannot be established from
d_reclen alone - VXFS_DIRBLKOV() is 2 * d_nhash + 4, so an odd d_nhash
already starts a dirblock's entries two bytes off, and such an image mounts
and lists fine before and after this patch.  A short record is refused,
which is the half that needs no guess.  The rest belongs with an
implementation of vxfs_check_page().

Verified on 7.2.0-rc5 with KASAN, on crafted images built from the driver's
own headers: before the patch getdents64() and stat() produce the three
reports above, after it none, and well-formed images list unchanged.

Review: https://sashiko.dev/#/patchset/20260726062514.43756-1-baul.lee%40xbow.com
v1: https://lore.kernel.org/linux-fsdevel/20260726062514.43756-1-baul.lee@xbow.com/

 fs/freevxfs/vxfs_lookup.c | 69 +++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 13 deletions(-)

diff --git a/fs/freevxfs/vxfs_lookup.c b/fs/freevxfs/vxfs_lookup.c
index 138e08de976e..50c428c63126 100644
--- a/fs/freevxfs/vxfs_lookup.c
+++ b/fs/freevxfs/vxfs_lookup.c
@@ -78,6 +78,7 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 
 		while (pg_ofs < PAGE_SIZE && pos < limit) {
 			struct vxfs_direct *de;
+			int reclen, nlen;
 
 			if ((pos & (bsize - 1)) < 4) {
 				struct vxfs_dirblk *dbp =
@@ -87,6 +88,14 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
+			}
+
+			/* the entry header must fit in the page */
+			if (pg_ofs + VXFS_NAMEMIN > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
@@ -96,12 +105,25 @@ vxfs_find_entry(struct inode *ip, struct dentry *dp, struct page **ppp)
 				break;
 			}
 
-			pg_ofs += fs16_to_cpu(sbi, de->d_reclen);
-			pos += fs16_to_cpu(sbi, de->d_reclen);
+			/* and so must the whole record, header included */
+			reclen = fs16_to_cpu(sbi, de->d_reclen);
+			if (reclen < VXFS_NAMEMIN ||
+			    pg_ofs + reclen > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
+			}
+
+			pg_ofs += reclen;
+			pos += reclen;
 			if (!de->d_ino)
 				continue;
 
-			if (namelen != fs16_to_cpu(sbi, de->d_namelen))
+			/* the name must fit in the record */
+			nlen = fs16_to_cpu(sbi, de->d_namelen);
+			if (VXFS_NAMEMIN + nlen > reclen)
+				continue;
+
+			if (namelen != nlen)
 				continue;
 			if (!memcmp(name, de->d_name, namelen)) {
 				*ppp = pp;
@@ -218,7 +240,7 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 		struct page *pp;
 		char *kaddr;
 		int pg_ofs = pos & ~PAGE_MASK;
-		int rc = 0;
+		bool full = false;
 
 		pp = vxfs_get_page(ip->i_mapping, pos >> PAGE_SHIFT);
 		if (IS_ERR(pp))
@@ -228,6 +250,7 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 
 		while (pg_ofs < PAGE_SIZE && pos < limit) {
 			struct vxfs_direct *de;
+			int reclen, nlen;
 
 			if ((pos & (bsize - 1)) < 4) {
 				struct vxfs_dirblk *dbp =
@@ -237,6 +260,14 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 
 				pos += overhead;
 				pg_ofs += overhead;
+				if (pg_ofs >= PAGE_SIZE)
+					break;
+			}
+
+			/* the entry header must fit in the page */
+			if (pg_ofs + VXFS_NAMEMIN > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
 			}
 			de = (struct vxfs_direct *)(kaddr + pg_ofs);
 
@@ -246,23 +277,35 @@ vxfs_readdir(struct file *fp, struct dir_context *ctx)
 				break;
 			}
 
-			pg_ofs += fs16_to_cpu(sbi, de->d_reclen);
-			pos += fs16_to_cpu(sbi, de->d_reclen);
+			/* and so must the whole record, header included */
+			reclen = fs16_to_cpu(sbi, de->d_reclen);
+			if (reclen < VXFS_NAMEMIN ||
+			    pg_ofs + reclen > PAGE_SIZE) {
+				pos += PAGE_SIZE - pg_ofs;
+				break;
+			}
+
+			pg_ofs += reclen;
+			pos += reclen;
 			if (!de->d_ino)
 				continue;
 
-			rc = dir_emit(ctx, de->d_name,
-					fs16_to_cpu(sbi, de->d_namelen),
-					fs32_to_cpu(sbi, de->d_ino),
-					DT_UNKNOWN);
-			if (!rc) {
+			/* the name must fit in the record */
+			nlen = fs16_to_cpu(sbi, de->d_namelen);
+			if (VXFS_NAMEMIN + nlen > reclen)
+				continue;
+
+			if (!dir_emit(ctx, de->d_name, nlen,
+				      fs32_to_cpu(sbi, de->d_ino),
+				      DT_UNKNOWN)) {
 				/* the dir entry was not read, fix pos. */
-				pos -= fs16_to_cpu(sbi, de->d_reclen);
+				pos -= reclen;
+				full = true;
 				break;
 			}
 		}
 		vxfs_put_page(pp);
-		if (!rc)
+		if (full)
 			break;
 	}
 
-- 
2.53.0

