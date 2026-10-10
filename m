Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8036230F55F;
	Sat, 10 Oct 2026 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655830; cv=none; b=VEda1XYB0JV/10HoPdY+61UAAedFNAwBr/An31klmuI4j644pcSeZYm94PWQAnPiW9SdIqZaaFC4cqeAUmNpcUowcMj7cn44c7oyUCejwpf3W/rODRxYAOSzMvOeL2WANQvpRJH1vfEqo7X2adOUCMSTtxXY/B7mAyPgUbyYM2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655830; c=relaxed/simple;
	bh=2MFCa2g9mR833mpA1ZLv3Jrd+zAYbkQUEzEhWw1N9Ro=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=L8BFgbxTdy2SAyw99NNc2OFvGUZydXZjAaSbcrqzLLaiB411yeIB0tEWu2AjcbANrHYzi1/wQiu6lZuF8X0KeoUlJ3wh/4gIwcUb80i13RsYJhnMEySjSFqms/uVMewm9CHxBlvFTw0odGD2P3vBT0FrE4L+7egmnqL1QIAUOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gAvShXXH; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gAvShXXH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1791655822; x=1792260622; i=markus.elfring@web.de;
	bh=DmjZgOLOOOv4Ct+7ez2dPb31Ctn48nINPgNlWtcXtbY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gAvShXXHvoh/HLWGEQQqS1+IlCU7pwO/HfhkIpmN13xvnchPH4LB7NVqkPd2hr+T
	 DFZmBY+TLvzDUCD8M31uiUI9XqQQ5yH+3rfBLZ+AMjoPSz//wrmZ+Suh65oRs5As2
	 ZxW336FCP/LmfJFbTddc6EYtCBX/Flm4oRGib1o0n7H+a4uFOrhIJuu+Jo9ewYgKF
	 Gvc8t4ylVYnYVF2ou3kscusbcx36xbi3X3q4k7nKMOmMyu4rhqGAS9tKz+qPOXMtx
	 1rkUQRf8hxQizNH1XkFl+wpMXnOkjnxmJC/EfRLa1h2XVU0DxonsBt3/Xmt2ppZuq
	 EnWGlfUIKeFs3OdnvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MFs1z-1xRMRN2SWV-007Opn; Sat, 10
 Oct 2026 20:10:22 +0200
Message-ID: <3906d06e-50cf-4230-a29e-939a1ac04e07@web.de>
Date: Sat, 10 Oct 2026 20:10:18 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, de-DE
To: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Mateusz Guzik <mjguzik@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Nikolaos Karaolidis <nick@karaolidis.com>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] fs: Use common code in wait_on_new_inode()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Uz3fnnJuNouJDAtxkIZbR86+e+U3nEcpvAB/UeZrwyOLUsOGiAO
 5M2lY0lUdwGCYksLZDxh2yTaIAgyeff/iRhjkNe1sOF6f73l+6KwP2heDNZ2MbvO/TpvqqP
 WJAJ+Vkoh5fTPsC8jMhtcxSiFjDuk1ODQcpgM+To8X5ZceWkDnPk/ui+72ayQ6AmXqQdlWI
 N8PYQXb4cIBrQhXoOkoNA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0boYX8hPweo=;aNe9cyemGK4uEWD5S22N1m95YQ8
 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
 QXYTeW7ZmAk2M8d+A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Oct 2026 20:00:18 +0200

Use an additional label so that a statement can be better reused
at the end of this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 702f2d5ef459..f4699866a73b 100644
=2D-- a/fs/inode.c
+++ b/fs/inode.c
@@ -529,10 +529,8 @@ void wait_on_new_inode(struct inode *inode)
 	struct wait_queue_head *wq_head;
=20
 	spin_lock(&inode->i_lock);
-	if (!(inode_state_read(inode) & I_NEW)) {
-		spin_unlock(&inode->i_lock);
-		return;
-	}
+	if (!(inode_state_read(inode) & I_NEW))
+		goto unlock;
=20
 	wq_head =3D inode_bit_waitqueue(&wqe, inode, __I_NEW);
 	for (;;) {
@@ -545,6 +543,7 @@ void wait_on_new_inode(struct inode *inode)
 	}
 	finish_wait(wq_head, &wqe.wq_entry);
 	WARN_ON(inode_state_read(inode) & I_NEW);
+unlock:
 	spin_unlock(&inode->i_lock);
 }
 EXPORT_SYMBOL(wait_on_new_inode);
=2D-=20
2.56.0

