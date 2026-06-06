Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C07303CAE
	for <linux-fsdevel@vger.kernel.org>; Sat,  6 Jun 2026 08:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780734100; cv=none; b=u4VlEH1XbfINS1jnlKLVSmfhZZbAjTiM+BYsAH/X0IdePd6gC2Rgt/BH/Xoy/y826T5EoresjaXiLKu2wVzWemnZg09RZEfmQTUT0oBEWd3HM6+VLbY2XPRr+NUAMrfyiW4B9KKhATlb8SW1jm5znFMABScTfoy7Gs8M63D4Ido=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780734100; c=relaxed/simple;
	bh=5cajux8LBgFpSl46LONPrBdqnE60cNojVOp+ScXkuF0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FwCYJPlEUe5pxsPOK+CZgfOdhkx5lqmls/Er7/MVtKwkY3OAeoKM2U2OjAXxKWCGZ/FSunk5W0MyQG4k0FfUAU5ZbzIcmf5gw8Z6Rp36yAglTzpJuEzGdO2kJDKzBl4VDAb+xOpnJyDYs4rm/kx8ddAxswlJnxqUr8tX/g8XhOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=O1b22/YI; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="O1b22/YI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1780734088; x=1780993288;
	bh=5cajux8LBgFpSl46LONPrBdqnE60cNojVOp+ScXkuF0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=O1b22/YIVXJamvlbhgYKrWo5U+mmGMOB/h46+nQ1ljK80UVlX85p9f0PsPyo/YEgH
	 1HtwQOaFp2MKn0ArCQeeur35X3BR9KH+bIfFXSr8wsPn4JQWrx8JFt0SrRYxrPXGpM
	 kBh1zZLpTXU5MQIZ0MKTEY8ahElKc79W80dtk2hyJ7SQ3olu/Mdhwd0iSPW3dL9BBR
	 E5rM+E6uQ38juLrByFFr4HJQkB+1EJhTcKQ0ekP5irk4QZVJ6GZ2IMV3a5XNgWi37X
	 h/qpLFCNE65KlX7snv2M9jnIznTG9nGATUWxuUFR3118M+XB+FKsssMVrEPlCfscRx
	 bPxzyDRRQ/NfQ==
Date: Sat, 06 Jun 2026 08:21:26 +0000
To: Anders Larsen <al@alarsen.net>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] fs/qnx4: release the buffer head on an invalid extent-block signature
Message-ID: <6fb5c987e5b777c5027791d4b5f77b5b017162e8.1780733712.git.hexlabsecurity@proton.me>
In-Reply-To: <cover.1780733712.git.hexlabsecurity@proton.me>
References: <cover.1780733712.git.hexlabsecurity@proton.me>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 36fb8506f8af0d2675bb4555471b3dd1223629fb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In qnx4_block_map(), after sb_bread() reads an extent block, the
"IamXblk" signature-mismatch path returns -EIO without releasing the
buffer head, leaking it on every malformed extent block. Release it
before returning.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>
---
 fs/qnx4/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 4deb0eeadbde..3828ba7d4492 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -109,6 +109,7 @@ unsigned long qnx4_block_map( struct inode *inode, long=
 iblock )
 =09=09=09=09xblk =3D (struct qnx4_xblk*)bh->b_data;
 =09=09=09=09if ( memcmp( xblk->xblk_signature, "IamXblk", 7 ) ) {
 =09=09=09=09=09QNX4DEBUG((KERN_ERR "qnx4: block at %ld is not a valid xtnt=
\n", qnx4_inode->i_xblk));
+=09=09=09=09=09brelse(bh);
 =09=09=09=09=09return -EIO;
 =09=09=09=09}
 =09=09=09}
--=20
2.43.0


