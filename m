Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.11.79.129
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792841224;
	b=YTzU+ohVi/KNlW9/AQ7PBPH73+fbXDOwguOaJFfw9gWf4rDTxVbnKulgivQ3c5g41Dy3
	 ft4iT9xeIHVG6OhsBqcu7iUKuxEh/8qXeJidW0+OowYxkqoLJp+vbFUs6/LaZxxHAue6Y
	 ZgiMTpW2V6X4yDHAD1s7j3dbmNbRPZouluatBXvk2Ay24QJJ2sxNYSxZ2xZSoLoQEYQiw
	 vBCB+YzCiDNwW7SqGdS0Ssa7nAUyitLYs9PpL7kKw9BhfngmqegtwYs3fJNcFkLFYk6Dn
	 CL5ll4OzENVecLA9ypJ9strZdcdUcRYwgFyyKdV4DkhGdhLVnPhxolXNf4gxBHPlRTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792841224;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Mailer-Info:Subject:
	 From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:
	 Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=J1ePy/7DtRjSH/7YiNDxqRZYlYA7Rkm9Xz1sKnQwiPM=;
	b=yzdQNsFm8n4dTvOw5F0C37m1W8opw7ZqS3MI6h1t9pmaHx1D/hDSxV2PbEsWFuSnuTZs
	 T0+LMXJAURueodqxrNomRYxcUYO17RcoU7fUzmViFOXj2OT9T3TEgjtx1CoMspDQtiVT7
	 z7vBhKXVrR/oiSBx0eaqVef0FFj2Rqjo+gXnHsl+nPSK/zSp693nbYacousX7E7sg6lif
	 GstY4j5/XApC/uBmYs/N4TWSFvnToHg7IYshgsNX5lh+S4zJUflJSEoFemK5EGw5K54pG
	 OXPZyQbY0Rqi4WW3FgfSiO+pDaUwRA06Gs6gCKQpbaYZovqyfJWV4uunoUp5GETAoeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hatchling.org;
	spf=pass smtp.mailfrom=mta.hatchling.org;
	dkim=pass header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=oGmiOAeJ;
	dkim=pass header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=mII2FMP9;
	arc=none smtp.remote-ip=212.11.79.129
Received: from mail129.mailersend.net (mail129.mailersend.net [212.11.79.129])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A939606A31D
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 11:27:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A939606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hatchling.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mta.hatchling.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=oGmiOAeJ;
	dkim=pass (2048-bit key, unprotected) header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=mII2FMP9
DKIM-Signature: a=rsa-sha256; bh=J1ePy/7DtRjSH/7YiNDxqRZYlYA7Rkm9Xz1sKnQwiPM=;
 c=relaxed/relaxed; d=hatchling.org;
 h=DKIM-Signature:X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend2; t=1792841212; v=1;
 b=oGmiOAeJh6gF5leYC14nY0zNRPXZHzkncXX0XtIuhWrtJSZU4YYY2ZJw8VX7CJ5Q5LR1I07i
 1kz9ijXV+Ic6WScV/H8VjsfuktgwZ0hVzrhTOT65659k9NTb3LG67/ft9MuILW9dLMsjf0s2mGm
 lKIJROW/fTwEBuyZfqgKczNU=
DKIM-Signature: a=rsa-sha256; bh=J1ePy/7DtRjSH/7YiNDxqRZYlYA7Rkm9Xz1sKnQwiPM=;
 c=relaxed/relaxed; d=mailersend.net;
 h=X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=ms1; t=1792841212; v=1;
 b=mII2FMP9aTq1t3yq4YMkjnJHJ6g8keqWWcI0MDYVfdf4i1Xm14lQtkr2C7b2iuuCzaR6gXBi
 tSz6RMAC3sWLzDZIayVqDyExD3V29vPebExOvjqWAGKmtT7OxRr3EpTcQlUZE4Q2Mah7NeYF+xb
 1c/+HWgn17TsNO8Cs1FS3xEQZzjg02yY4UdE8Se9XHH2OhRDf+Q3FBf7XPGXD6xT07d5QEIu2G0
 K6i0fjfTrY8qzbxkflUrISnZaK9ZthcbeCoQYn91eejdk8yaN8aJi6mZD4KVXlsQhkX2ZzGGrIU
 pJPg+2MCZ5+B2/Ye55Zl3pX+tbabF8OfUkH0oR/l8CrpQ==
X-Mailer-Info: 10.AZlZWY1xGd.AZlZWY1xGd0MTN5UzN.wWauVHetY2ckVmdlxGQ2dWZy5yalJ
 nblxmLvJ3Z.gNhRGO0YjNiNmYmJWNiBTN4QmYhVWM2U2K0MTN5UzN....
Subject: [PATCH] fs/ntfs3: fix SEEK_DATA/SEEK_HOLE on externally compressed (WOF) files
From: Senjin <senjin@hatchling.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Senjin <senjin@hatchling.org>,
 ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Date: 24 Oct 2026 11:26:52 -0000
Received: from 10.8.11.244 by 10.132.0.99 with http; 24 Oct 2026 11:26:52 +0000
Message-ID: <6adc95fced5aa4bf9555fe31@mailersend.net>
X-MailerSend-RecipientID: 6adc95fced5aa4bf9555fe31;6ad8466bcbfb5b058dbae16e;r9084zv9678gw63d
Feedback-ID: r9084zv9678gw63d:MailerSend
X-MailerSend-MessageID: 6adc95fb646700d215d33fb3
Reply-To: senjin@hatchling.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

ni_seek_data_or_hole() only treats a sparse cluster run as still
containing data when the file uses classic NTFS compression
(FILE_ATTRIBUTE_COMPRESSED, LZNT1) and the run isn't aligned to a
NTFS_LZNT_CLUSTERS (16 cluster) boundary. It never checks whether the
file is externally compressed (WOF, reparse point, Xpress/LZX,
NI_FLAG_COMPRESSED_MASK).

For an externally compressed file, the main $DATA attribute's run list
is not frame-compressed in place like LZNT1: it is one continuous
sparse run end to end. The actual compressed bytes live in a separate
named attribute ("WofCompressedData", see ni_read_frame() and
ni_decompress_file()), and ni_read_folio_cmpr()/ni_read_frame()
reconstruct every logical byte of the file on a normal read. There is
no real hole anywhere in such a file.

Because ni_seek_data_or_hole() never recognised this, SEEK_DATA on an
externally compressed file walks its one sparse run straight to
EOF_LCN and returns -ENXIO for the entire file, as if it were empty.

This silently corrupts anything that trusts SEEK_DATA/SEEK_HOLE to
decide what to copy. cp(1) on a modern coreutils probes the source
file with lseek(SEEK_DATA) before falling back to a plain read loop;
when that probe comes back -ENXIO at offset 0, cp treats the whole
file as a hole, punches a hole of the same size in the destination
with fallocate(FALLOC_FL_PUNCH_HOLE), and never calls read() at all.
The result is a destination file of the right size that is entirely
zeroed, copied without any error being reported anywhere.

Confirmed with strace: cp of a WOF-compressed file does exactly this,
producing an all-zero copy every time, unconditionally (no large-folio
readahead trigger needed, unlike the page-mapping bug fixed earlier in
this series). A plain read() of the same file, e.g. via Python's
open().read(), decompresses correctly throughout.

This is not a new class of problem for this driver: ntfs_fiemap()
already special-cases is_compressed() and refuses fiemap outright for
any compressed file, with a comment noting that "cp -r incorrectly
treats compressed clusters". bmap()/FIBMAP is also unreachable for
compressed files, since they use a separate address_space_operations
table (ntfs_aops_cmpr) that has no .bmap. SEEK_DATA/SEEK_HOLE was the
one remaining place that exposes the main attribute's raw run-list
layout to userspace without either accounting for external compression
or refusing outright, which is how this went unnoticed until a plain
cp hit it.

Treat an externally compressed file as having no holes: SEEK_DATA
returns the requested offset whenever it is inside i_size, and
SEEK_HOLE returns i_size (the implicit hole at EOF, same as for any
other file). This mirrors how the already-existing LZNT1 case is
handled, just without pretending the WOF run list carries any
frame-aligned structure it doesn't have.

Fixes: c61326967728 ("fs/ntfs3: implement llseek SEEK_DATA/SEEK_HOLE by =
scanning data runs")
Cc: stable@vger.kernel.org # 7.0+
Signed-off-by: Senjin <senjin@hatchling.org>
---
 fs/ntfs3/frecord.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index a8b696d..d77465d 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2910,9 +2910,32 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni=
, loff_t offset, bool data)
 {
 	int err;
 	u8 cluster_bits =3D ni->mi.sbi->cluster_bits;
-	CLST vcn, lcn, clen;
+	CLST vcn, lcn, clen, frame_clusters =3D 0;
 	loff_t vbo;
=20
+	if (ni->ni_flags & NI_FLAG_COMPRESSED_MASK) {
+		/*
+		 * Xpress or LZX (WOF). The main data attribute's run list is
+		 * entirely sparse: the real, compressed bytes live in a
+		 * separate named attribute (see ni_read_frame()) and every
+		 * logical byte in [0, i_size) is reconstructed on read. There
+		 * is no hole to find here.
+		 */
+		loff_t i_size =3D i_size_read(&ni->vfs_inode);
+
+		if (data)
+			return offset < i_size ? offset : -ENXIO;
+
+		return i_size;
+	}
+
+	if (ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) {
+		/* LZNT compression: compressed frames are embedded directly
+		 * in the main data attribute's own run list.
+		 */
+		frame_clusters =3D NTFS_LZNT_CLUSTERS;
+	}
+
 	/* Enumerate all fragments. */
 	for (vcn =3D offset >> cluster_bits;; vcn +=3D clen) {
 		err =3D attr_data_get_block(ni, vcn, 1, &lcn, &clen, NULL, false,
@@ -2960,8 +2983,8 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni,=
 loff_t offset, bool data)
 				break;
 			}
=20
-			if ((ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) &&
-			    (vcn & (NTFS_LZNT_CLUSTERS - 1))) {
+			if (frame_clusters &&
+			    (vcn & (frame_clusters - 1))) {
 				/* Compressed cluster in compressed frame. */
 				break;
 			}
@@ -2975,8 +2998,8 @@ loff_t ni_seek_data_or_hole(struct ntfs_inode *ni,=
 loff_t offset, bool data)
 			 */
 			if (lcn =3D=3D SPARSE_LCN &&
 			    /* native compression hole begins at aligned vcn. */
-			    (!(ni->std_fa & FILE_ATTRIBUTE_COMPRESSED) ||
-			     !(vcn & (NTFS_LZNT_CLUSTERS - 1)))) {
+			    (!frame_clusters ||
+			     !(vcn & (frame_clusters - 1)))) {
 				/* Hole in sparsed or compressed file frame. */
 				break;
 			}
--=20
2.56.0
