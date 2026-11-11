Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=188.121.53.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440713;
	b=MmUYcuyPtDWrVh1QRdtY5xTXQC31hxRv79CB68opAAqPJoCOG+U8j5iozyEvAB04q0RY
	 /pJLsEdFmhXv4eEVMVWje06kPdNpQHnaqboEHwCGk5frb9m+uc8b+9SHQ96v5wBDvTvaw
	 XPnQWGoAYjJMNsGmZ2yKugXTSclEitqkVuMxcShBFMPtFV9pmXhIJUguOMsUhtmmCIIBp
	 pVrlCY9fvu3Nfd5SA4rEtUf/eVhwQtoODYB11LwVPO6zoUt8Wvh/xbxF3ooZHEsP2o6V+
	 92esdvjMEzyRUlzcromKshuIBvRBZ6gg2feqkqJPdUIzWXgeSn53jQ1jTKzpbc1s8eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440713;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:X-CMAE-Analysis:
	 Feedback-ID:X-SECURESERVER-ACCT:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CMAE-Envelope;
	bh=2LU4gd1QwZ6NBKlWkP/KjhmJHqiN9qYm6aI1qrY30QU=;
	b=txPvTULFjw3fQH9I7eJiIZX5kR6QneybdPiobLf6TNYP+QoyWBfBMqtiGjMZSCqWLLI+
	 1gJjCyC3HivpbPbtZnxhwpyPrJjB9MpYZ2rqkypokYQPzW10pX2H3vSIjIcTFDmgI9MJ/
	 ztGgdrg0gQr2Au8pd7IcbdE+c1OGwE98bCWOg71sWc5Gyy/xSN/aI6dRiy1Izg9Ct1hDa
	 KABk9Kx6phvrj8hSuC/K3p3gulpX7a6vPymAFGO8OyGcffcNLl1HNwo+pc22udEj6GwoV
	 LblKv++us3x+T6tnBkQdz84sThMJ15t21svAO4vyfvj3V2sMXOfTcOuw5WYyhGVHVlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=squashfs.org.uk;
	spf=pass smtp.mailfrom=squashfs.org.uk;
	dkim=pass header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=ifLEu7yG;
	dkim=pass header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=kRKx4Dwh;
	arc=none smtp.remote-ip=188.121.53.33
Received: from sxplsmtpa04-03.prod.sxb1.secureserver.net (sxplsmtpa04-03.prod.sxb1.secureserver.net [188.121.53.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E21606D93A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Nov 2026 23:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E21606D93A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squashfs.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secureserver.net header.i=@secureserver.net header.a=rsa-sha256 header.s=secureserver2 header.b=ifLEu7yG;
	dkim=pass (2048-bit key, unprotected) header.d=squashfs.org.uk header.i=@squashfs.org.uk header.a=rsa-sha256 header.s=secureserver1 header.b=kRKx4Dwh
Received: from avalon.fritz.box ([82.69.79.175])
	by :SMTPAUTH: with ESMTPA
	id RHz6xtxIpLwCURHzzxAFa1; Wed, 11 Nov 2026 23:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secureserver.net;
	s=secureserver2; t=1794440704;
	bh=2LU4gd1QwZ6NBKlWkP/KjhmJHqiN9qYm6aI1qrY30QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ifLEu7yGpm/qRU5VjP84NP+B5KmUyIkqR28KENPpMNvkMVnWoOjy+dVnGYVXwkvAd
	 7MvNNYOaHbD2IHzodx+m2HiA3H2fCit04JaZqFZxncqIubC9/FoFwdzFLnof687UBD
	 0ZgI3/43dA5LtMCX61iSKVOa6Mp4m6noGm/YbTavqeluZo5/HtEPSL1kfAebrRnbL4
	 d7nagFDqeQU7OKI2ZDaMSdpp7nM3bhJRp5puWd0Ros/kqlPZWZtCAOo3ajGJT7zU3D
	 G38S+tQnIvD8l74b2Kv5yQhouYmv2QKq5XyTxW+afn5jvNiWjWv1KuavEJEEr3VwCa
	 L50UHVXQeGQ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squashfs.org.uk;
	s=secureserver1; t=1794440704;
	bh=2LU4gd1QwZ6NBKlWkP/KjhmJHqiN9qYm6aI1qrY30QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kRKx4Dwhciuslt1yi+Rx4IthMYAzgmcE0nbd/m0ODl5cs2YNUXAY3KLJ7Ybuz8Mlv
	 2kFhsnzKXtY0URQxY3ztezY0QP4Cx9eew9zFSbkw0bC0d061U/CftTEb3R8SvLPb3l
	 fenODCjVOXNJnXFPHKaZpoKeXzFaYaxLaHvfDDkLPhDmR/wWoW0kA+N5fEvToBQDMG
	 M8LaU2btqprp8PeW2k+yjaRgA+OI2LXdG3nQw4YPn5C4GNM4C9M2JlyPaEXrpl2kxz
	 la3VKLq0gTcZQSxqhvVQFw9pxuyVHyKueIkMZk2mS8iP1eJIqW2zXMLU2wW1vmFqFn
	 Pd7h5FOYjKdwA==
X-CMAE-Analysis: v=2.4 cv=XZYcX455 c=1 sm=1 tr=0 ts=6af4fe00
 a=84ok6UeoqCVsigPHarzEiQ==:117 a=84ok6UeoqCVsigPHarzEiQ==:17 a=FXvPX3liAAAA:8
 a=novXQP1oP690d8Wgf2EA:9 a=UObqyxdv-6Yh2QiB9mM_:22
Feedback-ID: a1509d30a4f02f4f934d5ee235d1e447:squashfs.org.uk:ssnet
X-SECURESERVER-ACCT: phillip@squashfs.org.uk
From: Phillip Lougher <phillip@squashfs.org.uk>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	akpm@linux-foundation.org
Cc: Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH v2 22/22] Squashfs: check index isn't greater than S64_MAX in squashfs_read_data()
Date: Wed, 11 Nov 2026 23:44:02 +0000
Message-ID: <20261111234402.252354-23-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111234402.252354-1-phillip@squashfs.org.uk>
References: <20261111234402.252354-1-phillip@squashfs.org.uk>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfBklT8orcEnOAp8x8rFqgVM0zzHBhU51OUKnssEvt7DE84GgDUnkVnmIxUpjY4yyoggc+PqK9SpIdWaS6fRJDasDjLEqtTbETiE+4REMVl6jAVjlWhd/
 b3x1c1bqVqzjWDE/zART/Mgn2jjjG7ACHdCTr4Y34meCq5t9j7SVUphEJQkNnoXIZ8s3sv/25T++bBltMAyzsfy3XjPQb4f5ksZ7BODZ74IAmRRg7B5kBcH3
 VzU70WC9dfbY+2/tjmvhTJIUn7DgC6d2LdonFtW6Tg+uRGk3BvwEN0Hufaj8bAA7mK9JHEXhmhcpQqDF9ISdvBBmb1HsS891kKnkaWxR6I0=

The previous commits in this patch-set now sanity check index before
squashfs_read_data() is called.  However, it is always wise to take
a belts and braces approach and sanity check at the lowest level to
trap any values that could slip through.

Fixes: e2780ab159ac6 ("Squashfs: block operations")
Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/block.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 20c3030b4f96..f2f03d815167 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -297,6 +297,15 @@ int squashfs_read_data(struct super_block *sb, u64 index, int length,
 	int res;
 	int offset;
 
+	/*
+	 * Reject index values greater than possible filesystem size (S64_MAX).
+	 * This also ensures the index variable doesn't overflow in the function.
+	 */
+	if (index > S64_MAX) {
+		res = -EIO;
+		goto out;
+	}
+
 	if (length) {
 		/*
 		 * Datablock.
-- 
2.47.3

