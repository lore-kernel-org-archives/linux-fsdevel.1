Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270361;
	b=MGfnTZMNFmLIvdtYYWtxCy+mjvYj+IwqLWDwlpO6jqU04tO9pbmVgMgKiIvQVyUxG1lj
	 EVdrTyIlLfBbgBszSQu8udZrbaon8cXIFnil0INaDjTG3AsUTgNN9Tpz5gRqZOqkeZc2U
	 OylAYGGLWR8xffEGaCrJfHFyKTKXLt5Y45aetNksvaXIgQhEwD9XVQY726/IunlV6f+mw
	 GDUBLwziF1G7ProvEPSNz9Vld/IdTOhn+ioEfnBuNHI2iNc7UmyqFJrJJTyZAF6tyuEnF
	 nfju5ZAwUbWhQ3HuaJxIjBUdprpJzoZZ6banH7PfAvAysyWifPpv2v8Xh4VA7yLTB5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8WMI3X3PoRyAlOMTKdphRDblFY375paDpMOGs5Gmny8=;
	b=ygSkT/oA25It77EjSkk6MuvKoKSv7E8teoI84CeEo7R3eyk/oVrEG8blbYEqC+8fekjT
	 25oKkiRYdbhpCvO5AvyY23C0ye8w8UsEZ/iO91XsMRNgIQo4F5Gf6CJB/g7mdj29ZkHpl
	 wQdM9V8B8vbFnx5iEnuDF1s8YMw7Uf3JZ3bYkfd5KaIw6nfjCSHyq/ybh63sFL4mGR6Rr
	 B3Bc1tANy0jO4WetxjyldfIMzAit+s+N/RCaV1iDi9sHRvKM8AXKzPQKvNI0Ct92jpiSv
	 8WTiku4M1aIysnQ98vscw1WMrTQsd69/LcRFH12KC3g0zK5nA8rwOeOuyR8t5MO92vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9tPpbE8;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59060A2610
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 10:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E59060A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S9tPpbE8
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso2214085a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 03:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793270359; x=1793875159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WMI3X3PoRyAlOMTKdphRDblFY375paDpMOGs5Gmny8=;
        b=S9tPpbE89Lm/k+3k2e9HX7agXeshT4lhkQeYTxyEBUYKwVwTo99E7QdhR3EgUBR8FT
         wj6TzLQgOamvN+A80ZS5eOteN9G+qeSO0dIahTked7qGOen3K+eam4bGFN6TBYk7CyZT
         yIgB+Y6DqQ+xsLZ+VLoKlZWR9RvYMSsAIWIWkZJ8BWeJYskXdsRBrp/OcGSu0EcC4nJP
         MrcS+NCEpVGzUJZjeoiiY/C41ZVXT02mcPacK3X0/vQigo43EgIFaTA9qc4+2tUQ6pcu
         ldcN4Yrxde4bH2VaAi4kehHWDojDJB9MkGDNJNjinA7/jOt1Ahr8fRRWO4jB84ai82ht
         GHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793270359; x=1793875159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WMI3X3PoRyAlOMTKdphRDblFY375paDpMOGs5Gmny8=;
        b=vbNX1RzwW5xf4i0DF9oCxsdjr+0jFisddNc5heu4fcTpxCHwe8DGobTZA/ts8n0HVd
         fnaalNDd8yPQkWeiq7OWg5EqohLpSJzf3szo/gdYTBTbPDIey+n7QQvXbfUvOC1ecRX7
         A2+xBZZU7Be9pDawXluC2QCN0tvYJ9VracI093T1skuvbQa4yvgZBoeHJeqt1in2Ieu5
         mYspIrW15kCOSWEAqpnxiWg4AmGw5s8T4/nCgEG+Mpnx/jvH5FIwADBLzPuOmNNLhZ1Z
         C9hlZQ9ZoPyRcD0Oma6p1vF0xPxFzBZl1RdNlrH8u0SDoYiKDvaN4tq5DTz8Du9N25TG
         cqJw==
X-Gm-Message-State: AFq9FYK7ZVLssniMVCoCE3aPMU53ld5453m6MiYYnZSRTAARu3YaPeV2
	JXk3JsO55+1RzgUPut/dF2jTnpRfInXCj2Uvni9/rJjOK9aLVsMZdNwW
X-Gm-Gg: AYBFou03Um9iGHNfwqxruDmr059QpG5rDTEZ8uuebFeZH4kjqpJxjCDk7mwjthOiHDR
	/b2QslORINuSiIEjHeOPQn37Omsle9528GpgsG0GY6NysTlkTQ5IFvOkHvpC9FmNyIU0WFibKBK
	sANbV52OQJBQ1XYgH2vCP/16+VSLtsIyxxTtsPeAxjLWxkKrg/zN0OmByIicMvriMf/Co1iFSbQ
	DgHcroWPNV8YIFX4TzdynHN3nRLhJo5agQ6N1EpIol6bwAzbHLfp18cCSNmJl5r3nAD3+w521S2
	2tsyKYfFHhBSVK4Q4dDAQQmQeAUTLZyn97nWxHkuew7ZXcDZ5I6T2T4pAthiXOAKYaKLNWeP4yf
	ppNiPnB6GyboenbxJED2XJ8P9Ve52HFhmKME08ZjmhL9Ekikn+J3Vg1cQE6b3SlXmwQsrIbjR5Y
	lTIfLNKTnisTyicf2sLtpvsHcZPbUB5pK4xjdwm0glvhhCEKsmR6xGtreaz+QseFfEFbhemT0n1
	25BGbwEnrQ36PFaGsvHNqUYTUh+K3dVZnBWub3cQViLJamyscNerLEOa+Ba7m1Ou9TkJGnzcjJC
	RWar8GLllLqQSQvs98Ay0U7lzXaCBKOQAF8yRx4uj1RA4Kavzy6qRs4nZwypiz1uxVSi5iOkzaf
	tkjHNJSciCEp/7B2SUVPLz564fGXdz9Ycgg==
X-Received: by 2002:aa7:d0c5:0:b0:6b1:b611:a2af with SMTP id 4fb4d7f45d1cf-6b49cbe2658mr2513298a12.20.1793270359169;
        Thu, 29 Oct 2026 03:39:19 -0700 (PDT)
Received: from localhost (178-84-201-199.dynamic.upc.nl. [178.84.201.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b496435babsm2437817a12.28.2026.10.29.03.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:39:18 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	Chris Mason <mason@kernel.org>,
	stable@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 03/16] ovl: set OVL_WHITEOUTS before publishing the upper dir
Date: Thu, 29 Oct 2026 11:39:07 +0100
Message-ID: <20261029103913.2785828-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261029103913.2785828-1-amir73il@gmail.com>
References: <20261029103913.2785828-1-amir73il@gmail.com>
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

From: Chris Mason <mason@kernel.org>

Listing a directory while it is copied up causes a use-after-free of
the readdir cache.

A merge directory must never be iterated as a real upper directory:
that mode frees the cache in OVL_I(inode)->cache without looking at
its refcount, while files opened in merged mode still use it.
ovl_copy_up_workdir() publishes the upper dentry before it sets
OVL_WHITEOUTS, and ovl_dir_open() samples both without a lock, so an
open between the two stores finds the upper directory and takes it
for a real one.

With a delay between the two stores, an unprivileged process that
listed a directory during its copy-up saw only "." and "..", and its
next getdents freed the readdir cache of another descriptor.

Fix this by setting OVL_WHITEOUTS before ovl_inode_update(), so that
ovl_dir_reset() agrees with ovl_dir_open(), and by testing
OVL_TYPE_MERGE() of the path type in ovl_dir_open(), so that an open
that observes the upper dentry never iterates a merge dir as a real
dir, regardless of the order in which it observes the flag.

Fixes: b79e05aaa166 ("ovl: no direct iteration for dir with origin xattr")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[amir: test OVL_TYPE_MERGE() instead of smp_rmb() in ovl_dir_open()]
Link: https://lore.kernel.org/linux-unionfs/CAOQ4uxh-1J2OBjnDVbrrrjy1puSOW0kABvghN85ih6dtKUBTyA@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/copy_up.c | 2 +-
 fs/overlayfs/readdir.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index eee22581b14f1..92b3d08a02349 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -819,9 +819,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 
 	if (!c->metacopy)
 		ovl_set_upperdata(inode);
-	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+	ovl_inode_update(inode, temp);
 out:
 	ovl_end_write(c->dentry);
 
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 7d6f7f6022ebe..ba542a1920127 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -1055,7 +1055,8 @@ static int ovl_dir_open(struct inode *inode, struct file *file)
 		return PTR_ERR(realfile);
 	}
 	od->realfile = realfile;
-	od->is_real = ovl_dir_is_real(inode);
+	od->is_real = !OVL_TYPE_MERGE(type) &&
+		      !ovl_test_flag(OVL_WHITEOUTS, inode);
 	od->is_upper = OVL_TYPE_UPPER(type);
 	file->private_data = od;
 
-- 
2.55.0

