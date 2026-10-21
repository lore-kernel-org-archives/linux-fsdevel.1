Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.11.79.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558724;
	b=4fhXcyKalCI0HOY8BocgaQC6MOI8eu7wHzBJfvfPwrtFpsdIdZV+n3sBfIvKP0UuczR0
	 SxI5EgfsN4r8Fs4tdk7SM8Q6p1qzQ1duqEsiuf0o3O5IJ1v7gburnAvtsU8gYdx4iX0LN
	 awBSOac0Z+zfsXQfmnx5Y5cauq8Z01BcCwUGkG8KQYAT+N95OHdtedK2QOAJCpu1hKd9h
	 FMA5fv89P51j8ERzki2tJWDJBzBxqxWK4Kw5s02XOXnK+k6YC1pu9zF6sWm3z9DOnTLHk
	 diPTCagFAO/gTZPka7hogKbBIi8YOuRUnflby29jXM6yofYmqA7WDvDiPyxUu5aQPyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558724;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Mailer-Info:Subject:
	 From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:
	 Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XNIiXMO9bfSyLcpPsK7ibpdKfu6r2xJzZLEZeW2Ur4U=;
	b=gm+GarMjc/tFg6Xp/sXYc6Lp3ulaoDv/rD6ZHMluGILrIeJcr0yAU72GD1ljljzq6PFa
	 L8npEv1LnCoiFiALCN7I6L2P2l87zvsnEb9cPaJoNo7jtSr22Ys0W9B8ciHT0RuFT9qFn
	 yiZV9cTffZiIMkc5cjnifOUc8Ig69uNYxUDJdXeFqZfbZAAgESmPzq4ffqLA9H08zjsd6
	 PNF2Q0sYRS+CsfyXnqpnlzG0eXMU2mihKzasx5l9IRil6bsRWIXa50FLYavk4u2ishhSn
	 fDy89Z07jGpjAEJ/NbMbFv0begnVqxAf0rEb57D6bKLCBRaHU3Q4WhLZsZzDJR+Cx6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hatchling.org;
	spf=pass smtp.mailfrom=mta.hatchling.org;
	dkim=pass header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b="mLjI0vc/";
	dkim=pass header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b="CH/vUHEw";
	arc=none smtp.remote-ip=212.11.79.132
Received: from mail132.mailersend.net (mail132.mailersend.net [212.11.79.132])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655F8606A31B
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 04:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655F8606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hatchling.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mta.hatchling.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=mLjI0vc/;
	dkim=pass (2048-bit key, unprotected) header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=CH/vUHEw
DKIM-Signature: a=rsa-sha256; bh=XNIiXMO9bfSyLcpPsK7ibpdKfu6r2xJzZLEZeW2Ur4U=;
 c=relaxed/relaxed; d=hatchling.org;
 h=DKIM-Signature:X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend2; t=1792558718; v=1;
 b=mLjI0vc/5JjvkRcmn2hzFobOTtarxuFPHB/fW40VukmIVSoFIX7vGevV+xCXDiNOewH4+oGj
 FD8CZbMukearjyXK62qL/wIG8aqrfM5ZtYR6+DGNM/+VlzjIf/gjbHJOIoN4Zav7RS4lf7QoY+X
 +5dpmoT4Ma7+pkul1G+qnMVE=
DKIM-Signature: a=rsa-sha256; bh=XNIiXMO9bfSyLcpPsK7ibpdKfu6r2xJzZLEZeW2Ur4U=;
 c=relaxed/relaxed; d=mailersend.net;
 h=X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=ms1; t=1792558718; v=1;
 b=CH/vUHEwJe3lK5jvDqwFFBbnVeZevRDQm0Mu0q9WRQnmn5cpMNT0YDCbkA1Jz3ifrbJT21HB
 FrzIGc+9P8fC9gnhpoXbe0Ec9Mp76uS0knR8KwJveP5WBu+EfGXfpL5vl5jQFYnaQl9GuqIXrhM
 1sOCwFOnm4wIrfXGpwxehxvdddOzzIBeuNZyyApr7P4Bmd6zDRRriAtEMaIo/8bGoBVIiay8M78
 DNBUJ+AUyTvQFr6ESLbmfV8CW6LyQk6oiHfWFLSrbPDnkcf+yHsfof2K3X3fVV91GTrB2t9iTBP
 7J/8XHuNVjq+LU7HpqSrT3g+urKer3A6DaMGG0eJIcBFw==
X-Mailer-Info: 10.AZlZWY1xGd.AZlZWY1xGd0MTN5UzN.wWauVHetY2ckVmdlxGQ2dWZy5yalJ
 nblxmLvJ3Z.gNhRGO0YjNiNmYmJWNiBTN4QmYhVWM2U2K0MTN5UzN....
Subject: [PATCH 1/2] fs/ntfs3: map the right page of large folios in
 ntfs_read_write_run()
From: Senjin <senjin@hatchling.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Senjin <senjin@hatchling.org>,
 ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Date: 21 Oct 2026 04:58:38 -0000
Received: from 10.8.12.114 by 10.132.0.99 with http; 21 Oct 2026 04:58:38 +0000
Message-ID: <6ad8467ee2cb35e73a596bc5@mailersend.net>
X-MailerSend-RecipientID: 6ad8467ee2cb35e73a596bc5;6ad8466bcbfb5b058dbae16e;r9084zv9678gw63d
Feedback-ID: r9084zv9678gw63d:MailerSend
X-MailerSend-MessageID: 6ad8467e4b4189a79bb7fc2b
In-Reply-To: <20261021045734.573753-1-senjin@hatchling.org>
References: <20261021045734.573753-1-senjin@hatchling.org>
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

ntfs_read_write_run() reads and writes through the block device page
cache. It looks up the folio that contains lbo with read_mapping_folio()=
,
but then maps offset 0 of that folio and only adds offset_in_page(lbo):

	folio =3D read_mapping_folio(mapping, lbo >> PAGE_SHIFT, NULL);
	off =3D offset_in_page(lbo);
	kaddr =3D kmap_local_folio(folio, 0);
	memcpy(buf, kaddr + off, op);

This is only correct for order-0 folios. If the folio is a large folio
that starts before lbo, the data is copied from (or written to) the wron=
g
page, (index - folio->index) * PAGE_SIZE bytes before the intended
position.

ntfs3 itself populates the block device mapping with order-0 folios, so
this goes unnoticed on a cold cache. But a userspace read of the block
device (ntfs-3g tools such as ntfscat/ntfsinfo, probing tools, ...) fill=
s
the same mapping through readahead with large folios. After that,
reading a WOF (LZX/XPRESS) compressed file passes garbage to the
decompressor: on a test volume, lzx_decompress() failed for 33 of 35
frames of a 1.1 MB file, and the compressed input it was given matched
the real WofCompressedData stream shifted back by 4 KiB to 52 KiB.

Reproducer (WOF-compressed file, e.g. made with "compact /c /exe:lzx"):

	echo 3 > /proc/sys/vm/drop_caches
	ntfscat -f -a 0x80 -n WofCompressedData $DEV /path/file >/dev/null
	md5sum /mnt/path/file    # wrong; correct without the ntfscat step

On a corpus of 16,716 WOF-compressed files, reading each file right
after ntfscat had read its stream gave wrong contents for 1,051 of them,=

nearly all files spanning more than a few 32 KiB frames. With this patch=

all 16,716 read correctly, and plain reads with a cold cache were
correct both before and after.

The same helper is used for writes (ni_write_frame(), and
ni_decompress_file() via ni_read_frame()), so on a read-write mount the
data could be written to the wrong place on disk as well.

Map the page that contains lbo. op is already limited to the end of that=

page, so a single kmap_local_folio() mapping is enough.

Fixes: f35590ee26f5 ("fs/ntfs3: remove ntfs_bio_pages and use page cache=
 for compressed I/O")
Cc: stable@vger.kernel.org # 6.19+
Signed-off-by: Senjin <senjin@hatchling.org>
---
 fs/ntfs3/fsntfs.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 97c04ab..3340e72 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1557,12 +1557,17 @@ int ntfs_read_write_run(struct ntfs_sb_info *sbi=
, const struct runs_tree *run,
 		if (op > bytes)
 			op =3D bytes;
=20
-		kaddr =3D kmap_local_folio(folio, 0);
+		/*
+		 * The folio may be a large folio that starts before
+		 * lbo (e.g. created by readahead on the block device),
+		 * so map the page that actually contains lbo.
+		 */
+		kaddr =3D kmap_local_folio(folio, offset_in_folio(folio, lbo));
 		if (wr) {
-			memcpy(kaddr + off, buf, op);
+			memcpy(kaddr, buf, op);
 			folio_mark_dirty(folio);
 		} else {
-			memcpy(buf, kaddr + off, op);
+			memcpy(buf, kaddr, op);
 			flush_dcache_folio(folio);
 		}
 		kunmap_local(kaddr);
--=20
2.56.0
