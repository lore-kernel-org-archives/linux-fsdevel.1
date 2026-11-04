Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825122;
	b=nczqLMNCYKOjmQ4MQc9z9K58vf2Ni5JodCSow2Mhm9NKk2WKZuf9GpKpuZ6CpmNt/jYV
	 UCF5p4b97biQazG5puTDjBN+dytNjLnr5bGI4DpHd5bm+EqLwe67/ARv6EuBHpaqjaVJp
	 IrN52OuKiuE/i9mxgU5sJdsHyUlXkNSYuYAiCr4bTTPxZsJbp2A/kCle/2f1LO3e2cUQB
	 /AmnbvwucfiMAfnY6hItrbPcwx9FKQrxrGM0RniATXRiMczT+mkRCfWns/WKuziMeXegq
	 2hdO1oO0KNn6v36v81cjupfORHIrxKy0jCEYjzSfIkps1/0WXDaDJel6neNsT/aLomQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825122;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FFyElV0JGp89hQTPXMOgAiCtnc9VkWZMulp2A1EvBCw=;
	b=WdCECpKhqv3R4r3t0xj1lgwkez6/oVFNaZbfRnEvZvGmWxoq9yn++CGw5wMINz6cw/sz
	 ie/98hWPtqY/fLzX7jFftJ35nEGSBq9gtLgsW3Z9MoaXmEq4ECKLNlX15MJbJ0yDKzkXr
	 ERcO/cFGIr2GJhr6m0c3636tdVzgdolBbyA/ac2px1Bo47vV6wlv8z2JZfSYrUvFDKceg
	 6XBFs0aQ33psuHEM4+FUZNGjvlEmvQM1NEv9HudChxssabKQ1JvGv9ibAnWbdhnxSVmzS
	 hTaDFI+skL7flkP8/JVgZvci9eE7BdDMKR2DLpekWevJGqSq9AOx2l9A+CtY64dA6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fQ4rD7Ol;
	arc=none smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE0F6077B53
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Nov 2026 20:45:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAE0F6077B53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=fQ4rD7Ol
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5363316fa0cso12530991cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Nov 2026 12:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825121; x=1794429921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FFyElV0JGp89hQTPXMOgAiCtnc9VkWZMulp2A1EvBCw=;
        b=fQ4rD7OlgZ1AHHMJIiqoY7rklz7cTMHvKZOCzhhFEN+Y4cBrK4y+ymWwQpmMR/v57q
         qzNB3cnm9BTN0I2DWpswNhTw+8lHIgS63B94aURnhDjmVHb3MDYbAc1KdxaoI4y6Ztai
         +ivorZNFvpAgZpDQq0S2xDYk4Pc54ttUwDTzHxsTrxsVNI6qFRAQfBkMP0fewHHDz3Sb
         qjKhrkVX/ioqmYQfn5hLa5niWTuOwalq8Bt/dtctMbNArNrOi9kA+dwwU2EDzpRbwq5/
         WHRnW9Kf3SV9VlIAl1VRtgmYe9be2K9RJf9mN0fyQDT18w2h3K5FDS23qJjXG4z1rfkm
         hugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825121; x=1794429921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FFyElV0JGp89hQTPXMOgAiCtnc9VkWZMulp2A1EvBCw=;
        b=xT1c+UOSjZHrV7roi5ZiAsvaQHPwt2aG/j/Exb52Sbdv+35L/BdXM4322utV7VVqs4
         Nyz+mX+YLGGeznDNPqzB5CA+LWp/5J2l6sYmz6ALjmYcE25zCjjEHSEiyPgy0ge3iJpQ
         gyDnJLIfn6Cu8O03OWUgSCPzpNpnDaEZ3ElRXojSBv5O9TaGofzzNeYXFpKwEJwqcdaq
         ZTH6mpGLcMiXyh+u7tq/PBWulPlYec1xu/9ExYP3pAXlMslXes/PMwnXatux7yqkbDro
         NhprH/hpRbCmTLlKlJV4IV0fPznFrf8SCeYxL4weYN6T47bJAKe/aEgaJID+PxbnteS2
         jGSQ==
X-Forwarded-Encrypted: i=1; AKwUvByDuKfeN5L0HJBucCoxn2Suk43f6H0B7ker5JVwASN2BXTRAGiHrhnQ/ZS9BJOcZHltl3UpAhK0UpwxBVM1@vger.kernel.org
X-Gm-Message-State: APuU4Z+IBHj28ZuZAQGCbEn41Ro/nE0vMT0EQUvgIg0jM243qQByzea7
	mW5Yhr7j9UBZCXtPf+H0nQigEZnWKm/xlt9z4aHNRYyCn+k4OqW/OvQFkrsAibACuUY=
X-Gm-Gg: AYBFou2pw7hvZS1ymi+p1spTGtOcV38q6Lt7PPKRGWJUURZ4CQo8roK0iR3OxG8NxDc
	WN2tfDmYhkIJyX8wAZ6okiUv+BWR2RvTN7JAgUBGv0iWx2G7JzoltxNb7bGgkX7eFZH3FNYaPJF
	PHO0EvIi9tp/vtcCvdddTMULxPKQr4LNNAcojiZUFnWJyTESVcEZed5j/9vB79wQmvNfkAp1L52
	kdQgTIbMoRXwN4T0nwnQmDa4xtyvInmKfAndR1MQcj0pn7nTbkt+vRDLYUykYElRIPn+zBUPksO
	ahR3LIFUYZitEQlDoThloqsXI90V+8sUr35VnN1ftH11ACc/XLSWOM8o/+DHPeNPf7JeCNCsnmz
	kjjwLGDGRoWvtBoOwnViZ3tZJB8TvlvEZnaqgLD30UTe+X/NlEyG+Ese1KC1wKJ+XdHaOIvGSRk
	lSLHcjVRNKvPs8oH39p87yWwUkEUKjZZyvq++emEnKeDi7KUBY252JDEcCLA+7waHD+VIbSntT4
	dKPe0MYlcuR1oQdHtW3Dl8H4fJgqsqGs9M6vRUcXCDjw7yTuCQletjDz/NLGtZqXLt3MXsGWCyh
	o9XLrfy3opjJeRh/vrTu0cLCAfbficP8Zih4aYpAPRPikA==
X-Received: by 2002:a05:622a:38e:b0:536:3760:e6cb with SMTP id d75a77b69052e-542b6781aa8mr290505121cf.14.1793825120793;
        Wed, 04 Nov 2026 12:45:20 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b100ab8e4sm33768751cf.7.2026.11.04.12.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:45:19 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:45:00 +0000
Subject: [PATCH v3 3/8] ovl: make the root inode appear hashed
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-ovl-containerized-sync-v3-3-8daa20144f53@toxicpanda.com>
References: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
In-Reply-To: <20261104-b4-ovl-containerized-sync-v3-0-8daa20144f53@toxicpanda.com>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Christoph Hellwig <hch@infradead.org>, Chris Mason <mason@kernel.org>, 
 Chengguang Xu <cgxu519@mykernel.net>, linux-unionfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825112; l=1088;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ezVCiVHlXduEGN/JKqN233jz7I4B7cGFx2BULYbRDoA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QORkF2pQNIHUPSjD2pa1aC3HFV9lTWplFwhF2J5CN4s3vwCfVwe1XEffjfEYONUnvhSeIGOq7Kb
 LRgXuWs/4SgI=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__mark_inode_dirty() does not put an unhashed inode on a dirty list, and
the root inode of an overlay is never hashed.  Use inode_fake_hash() on it,
so that the following patches can track it like any other overlay inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/overlayfs/super.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index efa4d862039c..55635648b3de 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1372,6 +1372,11 @@ static struct dentry *ovl_get_root(struct super_block *sb,
 	ovl_set_flag(OVL_WHITEOUTS, d_inode(root));
 	ovl_dentry_set_flag(OVL_E_CONNECTED, root);
 	ovl_set_upperdata(d_inode(root));
+	/*
+	 * Nobody looks the root up by its hash, but __mark_inode_dirty() only
+	 * puts hashed inodes on a dirty list.
+	 */
+	inode_fake_hash(d_inode(root));
 	ovl_inode_init(d_inode(root), &oip, ino, fsid);
 	WARN_ON(!!IS_CASEFOLDED(d_inode(root)) != ofs->casefold);
 	ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVALIDATE);

-- 
2.55.0

