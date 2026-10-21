Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.11.79.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792558713;
	b=spnF0XfCl2sSqQgpipF0WLDwaxH1nUlTPvyDOuBePAErCMHeO3T68AFk4DtI1aymQL4+
	 Yq//FddyP+ZcZO60xBiPkKtMyprla7cdMvzkCItVOVpH+MI+f0YDl+FPWveV0vDQ9SpE5
	 g/nemvBlpFT4lNH0MYI2hattzZvdtmseJwSsUWoVrtVP+CSG8GTHThtyV8YkOhl16J6Pa
	 V9je1eZzGRlksQsJOZaLcZV5/1A2WBOAHIT7QqvgJVZaAAuCvR21IY58qXD0arbPZRU8K
	 I1u9hvHZ9bX1Iv0BvQLXdqwPvR5uixagoZpbm2OYYZi+2Lyx+agNxOf3/rbFT8tbEBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792558713;
	h=DMARC-Filter:DKIM-Signature:DKIM-Signature:X-Mailer-Info:Subject:
	 From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:
	 Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GK5DYawV3fS7qH49Jxdk4PU9MufYHyEhVsSUc+gLqw4=;
	b=Qwv0muD9Rps3i7C2Ll6S0lC04K1aNdw0Vo8+kit1pRTrMhGKbEr3cDnUZstJUNMbqQJW
	 3Iqd1VdJJb0f3X4joXtxzAGut1oJoZq331dM8vN4EyJ8uPo8iIzUK/Qk8pKxu9URGURSt
	 ymAkJy0iYbdKC22Abv3PNYmd54D9TpKu5EHkMtQ7dAZ82dVex+ni5HNaANu6uzc10VO8u
	 JsKgwtq9ojgCPh1fUHw/rHQ4mQYGWW8NzPmIbqkw8/1MYVQ+igd0EsxdtvSUBdTzS9DFb
	 P94KT+wwo9uOI5lypn5/ACccIbFwtl+SbursIX9YxH0vbVdEiPkT/C9W03oDCC39AcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hatchling.org;
	spf=pass smtp.mailfrom=mta.hatchling.org;
	dkim=pass header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=PcW8eEn8;
	dkim=pass header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=Ek9qqBfc;
	arc=none smtp.remote-ip=212.11.79.131
Received: from mail131.mailersend.net (mail131.mailersend.net [212.11.79.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A4D5606A319
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Oct 2026 04:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A4D5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hatchling.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mta.hatchling.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=hatchling.org header.i=@hatchling.org header.a=rsa-sha256 header.s=mlsend2 header.b=PcW8eEn8;
	dkim=pass (2048-bit key, unprotected) header.d=mailersend.net header.i=@mailersend.net header.a=rsa-sha256 header.s=ms1 header.b=Ek9qqBfc
DKIM-Signature: a=rsa-sha256; bh=GK5DYawV3fS7qH49Jxdk4PU9MufYHyEhVsSUc+gLqw4=;
 c=relaxed/relaxed; d=hatchling.org;
 h=DKIM-Signature:X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=mlsend2; t=1792558699; v=1;
 b=PcW8eEn8V6u5ysvU+DaHcJ6ypjU3jFtGG+2esFQhyAk+h+X7ZdxH+oISeo2cG8+dVlGUDxT0
 eicFQiuYujakNbIWLn/d3U94/Q3EARiNLLzXRxRmOSC5RHDt9LhRvhb9nO5nUngjc9JCpLMT3X5
 IlTyLbyTObKaaYDzvTazMlGM=
DKIM-Signature: a=rsa-sha256; bh=GK5DYawV3fS7qH49Jxdk4PU9MufYHyEhVsSUc+gLqw4=;
 c=relaxed/relaxed; d=mailersend.net;
 h=X-Mailer-Info:Subject:From:To:Cc:Date:Received:Message-ID:X-MailerSend-RecipientID:Feedback-ID:X-MailerSend-MessageID:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
 s=ms1; t=1792558699; v=1;
 b=Ek9qqBfcSJsH9Ny3vinZaaSB3mnoiyBz0F91Vo5nwr5nOVBS82gT7Xqzm0ZgyVfzAV3bKooG
 LuuzMHU6VKBpu0rJQHGOM5KuKzxzrd6FBP4T36Tepk83aa0oyk/lgY3egQrdoavm6WHecOFVrjk
 UiZhrARLavqNhMqDhCUCJ1MR0ZghyRQHa3g/FhSp+ZVLovjTdofSmRyJl4eH2DDtYVwb9pfcEgB
 S0LOWQidgeaFoerHPDVxk14cZVI3iE4eK8IXwmPCA3yIa5uadTdtJz61m0iiNM7u8z0Inh6OZFJ
 mQGLw+mvHgk3oV6zNPvwUjtnGjoPe2mC0Ln6a3DAwBLzw==
X-Mailer-Info: 10.AZlZWY1xGd.AZlZWY1xGd0MTN5UzN.wWauVHetY2ckVmdlxGQ2dWZy5yalJ
 nblxmLvJ3Z.gNhRGO0YjNiNmYmJWNiBTN4QmYhVWM2U2K0MTN5UzN....
Subject: [PATCH 0/2] fs/ntfs3: fix silent corruption reading compressed files
From: Senjin <senjin@hatchling.org>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: Senjin <senjin@hatchling.org>,
 ntfs3@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
Date: 21 Oct 2026 04:58:19 -0000
Received: from 10.8.7.120 by 10.132.0.99 with http; 21 Oct 2026 04:58:19 +0000
Message-ID: <6ad8466b98bc0030487babd5@mailersend.net>
X-MailerSend-RecipientID: 6ad8466b98bc0030487babd5;6ad8466bcbfb5b058dbae16e;r9084zv9678gw63d
Feedback-ID: r9084zv9678gw63d:MailerSend
X-MailerSend-MessageID: 6ad8466b0cd662f40ac3541c
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

Reading WOF (LZX/XPRESS) compressed files on ntfs3 can silently return
wrong data: zeroes or garbage, no error from read(), nothing in dmesg.
The bad pages stay in the page cache until it is dropped.

It needs two bugs together:

1. ntfs_read_write_run() maps page 0 of the block device folio it gets
   from read_mapping_folio(), which is wrong for large folios. Those
   appear when userspace has read the block device (e.g. ntfs-3g tools),=

   so the compressed input comes from the wrong 4 KiB page and the
   decompressor fails. The same helper is used for compressed writes.

2. ni_read_frame() marks the frame's pages uptodate even when it fails,
   so the failure is turned into silently wrong data.

Found while copying a Windows drive whose files had been compacted with
"compact /exe:lzx". The data on disk is intact: decoding the
WofCompressedData streams independently with wimlib gives the right
contents, matching uncompressed copies of the same files.

Tested on 7.3 against 16,716 WOF-compressed files (LZX, 32K frames):
the reproducer in patch 1 fails for 1,051 files without the series and
for none with it. With only patch 2, the reproducer gets an error from
read() instead of wrong data.

The bug was introduced in 6.19, hence the stable tags. Both patches
apply to current master.

Senjin (2):
  fs/ntfs3: map the right page of large folios in ntfs_read_write_run()
  fs/ntfs3: don't mark pages uptodate when ni_read_frame() fails

 fs/ntfs3/frecord.c | 12 ++++++++----
 fs/ntfs3/fsntfs.c  | 11 ++++++++---
 2 files changed, 16 insertions(+), 7 deletions(-)

--=20
2.56.0
