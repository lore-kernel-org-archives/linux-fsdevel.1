Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.11.79.128
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558732;
	b=f7ZKtKPzd0UDLRetgEsuiQlf1LwqmnzcZtjuD76/SU3PYRPzZ1/iqGb5guvwaR/PjwqG
	 GhFk26DPYFqkTuQ+6U3DjYSCYe2VrEI1IxX8tQ2oc4frvlBLu+QszDI9X+WrKYcoczo75
	 eBm4QEwz4NDUcYKIdKsBv+vklnE/esW+dqW8N+BvDFJ7wepoR51s/b1SN8JOK0jDDHKmk
	 osPNZNVrMTctrTYSTJXn+gtGeiLSQLs34jSD08KOkgJxdJDtkLsN8dBSaveoacjDPhLWT
	 0c6blzD3UeOtu1WhURvsIcdxpR/DStibG06JhcuJJ7ePpF/4d0uX+VlHX85Qs153iZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558732;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Mailer-Info:Subject:
	 From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:
	 Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Abp8x3DSJqqn2+3iXSrmmhIrpq3pCoX57uw/qGsuvA8=;
	b=bnlcYK40jzuiOfJgHjLnE1/UZbHZV3kMF5k0nr7kxLxi/qjPMtfnfvFUqBg6H0OUSz0y
	 erIkuK9yp97Iqo1DypnH7h/KBkg8QlIuYYiNXlecVdzgeBaLFHjN5ZX6VNoFpz3D71vvx
	 yU+m9U8D5/jpRg9qQyEzlud6TQVwXX+VybXcRmQiLjTAN/ezMH12KR0US/rjQpIpWj2Mi
	 Gi8hYUSOomtq1PikyAP5MX7oMR/GNFkz/99tTZGas5usGVFdW++4S9U0CYZU6kV/pFAzW
	 UFNDcVUzuxhXF5h1pdfWSF/MWdJYQmatJKK1UVUoJDGpfOwa/tMaJyd7Xk/kx2mKzIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hatchling.org;
	spf=pass smtp.mailfrom=mta.hatchling.org;
	dkim=pass header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=h9phJWxN;
	dkim=pass header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=hP7YgUtR;
	arc=none smtp.remote-ip=212.11.79.128
Received: from mail128.mailersend.net (mail128.mailersend.net [212.11.79.128])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59960606A322
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 04:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59960606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hatchling.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mta.hatchling.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=h9phJWxN;
	dkim=pass (2048-bit key, unprotected) header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=hP7YgUtR
DKIM-Signature: a=rsa-sha256; bh=Abp8x3DSJqqn2+3iXSrmmhIrpq3pCoX57uw/qGsuvA8=;
 c=relaxed/relaxed; d=hatchling.org;
 h=DKIM-Signature:X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend2; t=1792558719; v=1;
 b=h9phJWxNlvbXgrQTD7xceh/olGhFOscepk46XHjYK6/uQGYFpWMls9ukESzcr7u3FmNI1ax4
 8NlubkbxlOXpY2AzZNFUB0UAY+5wXYSdVrUE0hWydUZnmIUSQMMEteR76JlwmOOLrDgJ9lDqHRf
 XZLBdB27/f4uMbM6Ykk12sOA=
DKIM-Signature: a=rsa-sha256; bh=Abp8x3DSJqqn2+3iXSrmmhIrpq3pCoX57uw/qGsuvA8=;
 c=relaxed/relaxed; d=mailersend.net;
 h=X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:In-Reply-To:References:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=ms1; t=1792558719; v=1;
 b=hP7YgUtRz7WA4vi+xt4lf1PaeuD+3GbbUkL4gDnEstiPymsMUm3i6rHNoU5TsrY9IOwLqQhP
 N8tYQa/xebkKSMtc7r8alaB88vnn242F/tLMzPFlt8cRmseczbW97+NT7h/NqRywUFkzDsADeZi
 DM8RSvR43EvTqNZhFyxQYjnvzWU1vlGAkjCO4LZGZgnfg12v3DdgkvKh12kfambV7tdFJit037m
 piix53tkt6Kb508WjRnbvfbxoeaB3CMFQgjNsEveFA5V1M3eSRsY+YjRdCehjB/Ha9W4QG7p6Ow
 Cde2YURqYjgmXzKX2VbmSBjSXLB8tdoHH/+/tQitleXoA==
X-Mailer-Info: 10.AZlZWY1xGd.AZlZWY1xGd0MTN5UzN.wWauVHetY2ckVmdlxGQ2dWZy5yalJ
 nblxmLvJ3Z.gNhRGO0YjNiNmYmJWNiBTN4QmYhVWM2U2K0MTN5UzN....
Subject: [PATCH 2/2] fs/ntfs3: don't mark pages uptodate when ni_read_frame() fails
From: Senjin <senjin@hatchling.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Senjin <senjin@hatchling.org>,
 ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
Date: 21 Oct 2026 04:58:39 -0000
Received: from 10.8.15.26 by 10.132.0.99 with http; 21 Oct 2026 04:58:39 +0000
Message-ID: <6ad8467f30bcfe9e100d3b06@mailersend.net>
X-MailerSend-RecipientID: 6ad8467f30bcfe9e100d3b06;6ad8466bcbfb5b058dbae16e;r9084zv9678gw63d
Feedback-ID: r9084zv9678gw63d:MailerSend
X-MailerSend-MessageID: 6ad8467f6da68140f232e816
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

ni_read_frame() calls SetPageUptodate() on every page of the frame on
exit, including when reading or decompressing the frame failed. The
pages then hold zeroes or partially decompressed data, and that is
served as valid file data until the page cache is dropped.

The error is also lost for the folio that was actually requested:
ni_read_folio_cmpr() returns it from ->read_folio, but
filemap_read_folio() only checks folio_test_uptodate() afterwards and
treats the read as successful. Userspace gets wrong data, read() returns=

no error, and nothing is logged.

Only mark the pages uptodate when the frame was read successfully. On
failure the requested folio is left !uptodate and the read returns an
error; the other pages of the frame are retried on their next access.

With the bug fixed by the previous patch still present, a read of an
affected file now fails with an error after the last good frame, instead=

of silently returning zeroes.

Fixes: f35590ee26f5 ("fs/ntfs3: remove ntfs_bio_pages and use page cache=
 for compressed I/O")
Cc: stable@vger.kernel.org # 6.19+
Signed-off-by: Senjin <senjin@hatchling.org>
---
 fs/ntfs3/frecord.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index bead01a..a8b696d 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2287,7 +2287,6 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame=
_vbo, struct page **pages,
 	u64 vbo_disk;
 	size_t unc_size =3D 0;
 	u32 frame_size, i, ondisk_size;
-	struct page *pg;
 	struct ATTRIB *attr;
 	CLST frame, clst_data;
=20
@@ -2519,9 +2518,14 @@ out1:
 #endif
 	vunmap(frame_mem);
 out:
-	for (i =3D 0; i < pages_per_frame; i++) {
-		pg =3D pages[i];
-		SetPageUptodate(pg);
+	/*
+	 * Only mark the pages uptodate if the frame was read successfully,
+	 * otherwise zeroed or partially decompressed pages would be served
+	 * from the page cache as valid data.
+	 */
+	if (!err) {
+		for (i =3D 0; i < pages_per_frame; i++)
+			SetPageUptodate(pages[i]);
 	}
=20
 	return err;
--=20
2.56.0
