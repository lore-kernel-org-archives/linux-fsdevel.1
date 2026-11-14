Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794630943;
	b=yvjnuzQJ3jQxpANNkxmmWIjJGOeRR44wj1dry+c3YJHOUUDwDytOlEWQf9as0uvoz0I7
	 vLD+VqlUeixswGsAnJlCKFC2kmiS09AycQ9jTL1y0TeMZKolVf0bW1qMUXgi8yxwOk4wd
	 54XwroS3aCTBj6yVBruAkuDbsRpV2UphBQe4SteoMBY5yx5zsFzUAIc9QC/QLT0v4LnUp
	 lB0/Q//qlhITbs7+rOWQsobiFtT7FWGKpOfRhvnAGJuWVtZsX1Jz2E/bWPDk1hZhhATVg
	 QfzSpMfKdBHZuaNUdIX3/f6sF5DPNxZA/IUADz9pb6yRFLjuYlST0YuePRkwlLYoLEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794630943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UU1PVy+t0ft+3E+0Qc94jUs2EjiskHrBXbsDGPqWZls=;
	b=V8hEGxeWTHIeqdfhhCC2cQPMg9+wl6ZmEsgo/bgL2qpDqxEFlRqT6n5O4xe64G8VctZo
	 upru+8QozQknO23YvMfuaYHF8mis1l7VWInBHiop1Ei43T3NIOD1FaoUM8zp6KGUDtITb
	 yYqpEd4oHu8w+LdcGZSv912RJxhQrLOm2JEluZEG731/SbXA5qrOHzfoa3fbqCCZVR2w3
	 JGLbxHfXnuIgn3JWiZX9S22wN+bXSqrEyggYVpMYcXHckXifTnlsoda7d5C87kufaBkKv
	 uj8+de/1curdr9nw75XCNr/RsI6rkZHYwTxfmQfiA+PiiFxMOrLllfV6fGFxKzyldhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcUKM2dJ;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD7606A338
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Nov 2026 04:35:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63BD7606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qcUKM2dJ
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-36eb1cb7aabso2123983eec.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Nov 2026 20:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794630942; x=1795235742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UU1PVy+t0ft+3E+0Qc94jUs2EjiskHrBXbsDGPqWZls=;
        b=qcUKM2dJY+hVn7ZYZN8ifpz+9VYU7Z/gJE7VN33MuMkDOFME7v//gFnu/X7cmdXxOL
         m3bsuQnBFNmE+8narU/7oX0ZQY3zT/67SXywHGW7HG/896aSHHarSAz/wTfzkcRvYgE4
         iUhQxMZVbcrJVebkID0ctja/eL2+ZuKhmcLNEpEBI593uCtMkn5d3c/0l+yO3FflPq0X
         FcIaTrg3gk1mkr2EVoQDrkh6yM6tfTQM/4HGtp6Qe162xbf71j053I5gLPG7Wo1iNYOd
         oANEuyhbhbctujjPuaDNMp4bcq/WXuJ8d3RhQ5FC7oFenBegwmmqMOKFBMEXDM9smEIu
         XI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794630942; x=1795235742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UU1PVy+t0ft+3E+0Qc94jUs2EjiskHrBXbsDGPqWZls=;
        b=lmtsL+qoEmGiBJYodXJzfI9L6KaeR2ePtW9ZEkW34kEgLjV8zq4wBQZaWXKdosN1Io
         KpucPn50F7KbjBDX3M0RNEVn4psgMu1zU5jECTZNnJJiMwENCIGdC0K0dZ27QKcDEYoj
         nhZBnD9/gxOBu95dci+Fm3MJ76zgRKibthvkmLwGpb4g0KJ4iVX6k3/EQNO270XSBQ+P
         av7Vet/lUAfihNXr1F3ib0/uEv7GUj7joKIi/f+OxD161DcG7wKniRApfKqtraLTKPeT
         DOQEf/2YSzKU1mO4uQJDD8J3DLFry06NxDYJNuI1+wCb4R9WD/iBZJU/pqbN2RKxiKxs
         xKag==
X-Gm-Message-State: APuU4Z+O0Zruy0vP2HoL7wvONvkGpJaC9O5I3DUXyj3mZxqa4R8Id07D
	Aj4FpD5JP0JPUJMdiiWxU78IVfk4vM9QkyKlFgLtq+uXRYdoj4uZoNxW
X-Gm-Gg: AYBFou2487Tev7zsVQoUqBQIxDHK+H+/6P6T9xpnMNbPLP9j0+F1WGdR9WnSLpTccmZ
	BFJBcsePI9Do/lXIMKiC/v9bPsGQYKGu/2iUxgv0Ps6A1Gd+UdTUpUj8GEIhIbGILmfwo9adjjx
	DJ6GBScEpVxDqqz5ibaYSckyR032vJ7+8SBtIBTzOPOh2knCHkvxgMgE0R6Ugt+6HAfYTVX8VWI
	uUdmBiIKZAt9V4eOO4VGijZkU6PuMHBkWjKZEMnj8up/rmIopF9/rihlTd3e9vkC6qFcv1ERZAE
	UYr2MOEpm/R9j9j2AkJpNZ8h9F3rvb8Lj4kXnBvjDQkEyKl1LYy/hUaoOVbvDinhSA9AcFKxHHQ
	74UakJ/MNeY6N0BkydvDQRHJ5LrcVVLczjmJhX8LVLCziWFr4S5aaPIBha5qc73kk76/dwthqIp
	fJwRoWG6ZcUNpqu4Lf/XPXeNFq2x0ZBsEFsri7i77WI2BBuMRAjDnpsDQz6fjrXmzEs/ND61T12
	8DV3NdufrWD65neHVfnDJzMVi1UjHENlr6z3qoIkP65PglRiDMlwBg+2g4ZfH7MupJ1qMH5Nmsm
	/jxicKicPXyYDd9qkgNjpQh5rNavZ4LtgR3/fLg+y6t1ootKBLeFKktPoYh1kVh1ajYDZbEL0P9
	Ycy8GRZMJBPzUJxvEUByna4dN550=
X-Received: by 2002:a05:7301:4604:b0:36a:532e:4abe with SMTP id 5a478bee46e88-379681c9ee0mr4421901eec.35.1794630942458;
        Fri, 13 Nov 2026 20:35:42 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:796f:2855:533:1bb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm11744106eec.16.2026.11.13.20.35.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Nov 2026 20:35:42 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>,
	Guikun Yang <yangguikun19@qq.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] hfs: bound btree keys by the tree's max_key_len in hfs_bnode_read_key()
Date: Fri, 13 Nov 2026 20:35:22 -0800
Message-ID: <20261114043522.48764-2-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114043522.48764-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
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

The classic HFS variant of the same bug: hfs_bnode_read_key() accepts
an on-disk key length up to sizeof(hfs_btree_key), while the key buffers
from hfs_find_init() hold tree->max_key_len + 2 bytes (18 bytes in total
for the extents tree). Bound the length by the tree's maximum and clear
only the buffer's own size on error.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index fcb5b9c..f678eed 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -83,8 +83,9 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 1;
 
-	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfs_btree_key));
+	/* hfs_find_init() sizes each key buffer as tree->max_key_len + 2 */
+	if (key_len > tree->max_key_len + 1 || key_len < 1) {
+		memset(key, 0, tree->max_key_len + 2);
 		pr_err("hfs: Invalid key length: %u\n", key_len);
 		return;
 	}
--
2.47.0
