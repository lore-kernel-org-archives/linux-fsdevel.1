Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A83B14DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 06:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208163; cv=none; b=W16mNa7o/JxtJD4n5HgaqqDZ2GbRBaLbk8ZpyrrzeHwe6GmsBVAZD3zGD5mSeBjk5cOC3Ae8xOuv7cr+q+AyRk5iUt29waZjkEVXwBjCKGa+zRgdq1L+ozgbSYY185sdeVd8I8VusTTR+QOYlymjyWElBzDvnSEasPa4ajKZpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208163; c=relaxed/simple;
	bh=lJm4ebvKVaxifpJh49jYAtxE3Jr658vnjf+dd9yZuEc=;
	h=Message-ID:Date:From:To:Cc:Subject:MIME-Version:Content-Type:
	 Content-Disposition; b=LDQdx5uAW3s2DZriqGYY2LIFUoJlBTM2YteOoEBcSJuWVemaqPpesENYaDyH3kLJyGSOIVDratO1Myx4yphVU9Mo6noOa60HFfl97NJCd82+u7UTeEGLHK5tfaEaDSGNyeV8paKOoy0JEZ8GGbMuR4x6NhDXkzluVUveZPda5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlhKzxCJ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlhKzxCJ"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e88b60121so1503604a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Aug 2026 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787208162; x=1787812962; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ySKcbNvx111V9QjBY3CXX8m1j0vcfzMaXNZH3TRNdiE=;
        b=NlhKzxCJj2EMfmLTY2MGG9DOgtW3QM5zwSTRYDFvC2PuI8U0fFzXoesqEhZ9Mlc1QR
         Jrxzs/BEOyY3nVw+YOcnEwdFuRcLeUAtHxFrFg0VdowIY0VjrmFYaC+ziqRFQ1JqfDRn
         VnUImNH1AQ0yI3EHmf7FUD96ZlFdov+7vewjIw+2Cgw3D4SNpo4Vs3oKS24TKPvm98kO
         ZlQkYNT0iMAdbvzsBA0Z7pnqy9o+ms6bqZBRJG6uhSnQDJGI2n38CSiwIhyAyElG45Z2
         N6LI5gojqYKWnHBgghwci+UrPxG7QEmDTFckeXKiY01LlQ/ze24PPFC6BhZZaBjDq1Xz
         gplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787208162; x=1787812962;
        h=content-disposition:content-type:mime-version:subject:cc:to:from
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ySKcbNvx111V9QjBY3CXX8m1j0vcfzMaXNZH3TRNdiE=;
        b=OYyp7CgnibU7Bmwx7keTi+AL1Y6wY3DdIgutfhYKOU+ed0p3fJNc/WpygHOlDSDmTB
         rK53DFeLhY0an3ANJGj77GwACmSzmOXGtjNm13yLd1qnS8Am/WxErH8slptXmZrbK3hJ
         R7FYWslA1r2DeUdHOBJVpuC3yWAlP1LdeoNaj0LK5cjrT45aOJ2L8hscVBx+N8xphnNF
         0o6LaT25qlooXQftwTnyMRW6HOOzFwkPLG9xurYmYOMEfsmJzUXpJVB6Qj4Mm0qhadOy
         diBLNCQLjCvR2N0iVKatRtFaxhhf1RKSiapkN1ZEHvhhhk/N4UpFpakoFED+XefOJGpW
         LSvg==
X-Gm-Message-State: AFuF++lI5G50EWOt4GvvMMKdVzMX3b8cCxDZjauHZYB23eX09ykrGRoD
	UQG5zk9jPsmJoHNDBMVGqFJUjz7QXPvyakdIWYVbSSdi7joqtriH5YTS
X-Gm-Gg: AR+sD11I1G5UeAS3p9dFRrXeZCSazvOid625B/TilfFtvGhlOniiXjK1VvFL9QY4yKk
	VIzA/f2PsJN0E51D11C5jq2+M6deIcD+9NX58QIpVDrEpKhD2xj+Ll7KmTSIxB9/J0urAKAvW9c
	T4Bzn7uTIgioXapVAJWns+p725aQ2Dw/BCfZL/GLs3dM7QiQY4cdKReUh2BbcgfcIk/nNBOxrJN
	ifRLsJJdJ5r3KrMtvwwcpOCHFnzHzivKC/6EBjyQ8+D/p8KDHsPMMJxagPK9MnffpmPZmlnGExY
	AnXXxuAC5BMnfn7vWu/cIg1Nqlxd9ZVQPR6Q9bdhcAWpxYp7ay+QFle65/R8gQ17Ti9PuVsQUyI
	Ww9BI97OV5Mj/PWEqs4LpgnBCWYSBJiaQB6Lme3jVaw1uu4PvtYGPXmRWOC8LbZoZRglHI8ZbJj
	z6O55z/prGsYWyr81rDqkS2E39CirpzgZ7ly5ezxMTiRa9z2IMobm5cid0z/H5UnelQzb1imTSi
	OifTFIp0/PPjQYIo2sJmZOSO5rw2XNdEDu7jlEjM2ZSGQ==
X-Received: by 2002:a17:90b:5250:b0:38d:b36e:9813 with SMTP id 98e67ed59e1d1-395810b57d1mr19603977a91.11.1787208161795;
        Wed, 19 Aug 2026 23:42:41 -0700 (PDT)
Received: from localhost (75-172-9-230.tukw.qwest.net. [75.172.9.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad69638sm12205170c88.7.2026.08.19.23.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 23:42:41 -0700 (PDT)
Message-ID: <6a86a1e1.ee10049a.267d65.9802@mx.google.com>
X-Google-Original-Message-ID: <aoah3OHfJAJ6OuJ9@DESKTOP-HH660AU.>
Date: Wed, 19 Aug 2026 23:42:36 -0700
From: Dennis Tighe <dennis.tighe@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ntfs: validate usa_ofs before preserving the update
 sequence number
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When ntfs_mft_record_alloc() reuses a free mft record it reads the old
update sequence number straight from the on-disk record:

    usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));

Here m points into the raw $MFT page-cache folio, which still holds
unvalidated, MST-protected bytes: the folio is read by a plain
iomap_read_folio() and neither post_read_mst_fixup() nor
ntfs_mft_record_check() has run on it (both work on private copies).
m->usa_ofs is therefore an untrusted u16, and a corrupted record can put
it past the end of the record so the two-byte read lands outside the
folio.  Reading such a record while creating a file gives, under KASAN:

  BUG: KASAN: use-after-free in ntfs_mft_record_alloc+...
  Read of size 2 at addr ...
   ntfs_mft_record_alloc -> __ntfs_create -> ntfs_create -> path_openat

Only preserve the old update sequence number when usa_ofs is even and in
range, mirroring the check ntfs_mft_record_check() already applies;
otherwise leave usn zero, which the existing restore below skips. 

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dennis Tighe <dennis.tighe@gmail.com>
---
For v2: 
- drop the explanatory comment above the check (per review).
- fix blankspace issues

 fs/ntfs/mft.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
index fd20d7a..82d2190 100644
--- a/fs/ntfs/mft.c
+++ b/fs/ntfs/mft.c
@@ -2333,7 +2333,11 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, const int mode,
 		 * wrong with the previous mft record.
 		 */
 		seq_no = m->sequence_number;
-		usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
+		if (!(le16_to_cpu(m->usa_ofs) & 1) &&
+		    le16_to_cpu(m->usa_ofs) + sizeof(usn) <= vol->mft_record_size)
+			usn = *(__le16 *)((u8 *)m + le16_to_cpu(m->usa_ofs));
+		else
+			usn = 0;
 		err = ntfs_mft_record_layout(vol, bit, m);
 		if (unlikely(err)) {
 			ntfs_error(vol->sb, "Failed to layout allocated mft record 0x%llx.",
-- 
2.47.3

