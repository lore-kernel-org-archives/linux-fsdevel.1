Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B8C32E12E
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Sep 2026 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585539; cv=none; b=sTs/9Q6VK7ApvTFlLLy5Uu9i6/P6zD7x86/4CcLFaSRR92I7PK96lg15WYufaplSAXG5WQP0/pNZHKZCU2McMo/i6hiYTMyTgzhLDlFU01XhBNC70LbBu9Cm8RgzrHK8c8bAj1MYrIGqc76zFnqX4WXj4W7p+j5X7dQzAhrEhaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585539; c=relaxed/simple;
	bh=UwfSi01JrjgFFoyq4nGcZMTUyyfTi0iyb+hO2kMTbno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HebeynNmZ3pplMCBO9FzgxLJXU5OZTbNq/m+S11+AeiSFl9t2B/lBA1b2r4ciq71QOeUsilImsmcliE/02Vb1dhhwl2/X4LrjlTUrXZ35oz/SkKje/ceG5eHf1OWgRDG6ehU1Yd8JPjUv81iSfUzLh1uNxpPQMSMuxJFb/jcOM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLZciGuH; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLZciGuH"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-485850cf499so995551f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 22:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788585536; x=1789190336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YP1AYjVYNbHbr+XqRGPctt4NDejyNq5oyC8iI1I37GM=;
        b=TLZciGuHHnOYhOuEYQb2XvyDRtQVPsyCZnqdSkr76mT0hlDjZu21VR2JjZ9vitHeF2
         NMwIl10j8rGePWGZL2arj+MoXVMZqOtxanCPGnDBvl/hRnyp/vzXxyvz0BPxUqhqLuKX
         n666lIis+Syi1Q/WsaaZjZwP/waaj+gBZZ76/kup1CtDnOf+r5h+klIQj7z1Ed+L8t1X
         /llwc04FZESw9woNx47E3dkgT2UIHOd0Pw+NbWHRaxzRNZNDWRDb9SoMqyC+t0vlkLGp
         MgaqTsyAglFiDvfGP6fTTK68t4YMWkMxfNjJGWbFZWQlaG8f9UHCAOLl940bl0P8YWUX
         1Gmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585536; x=1789190336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YP1AYjVYNbHbr+XqRGPctt4NDejyNq5oyC8iI1I37GM=;
        b=ZuIEk7tDCQTfCxh6DRi4NrfOFh4cPIKDKfSTfeYx1Mie1tX0gQ1dYhgYgpL0SCcrax
         KBgc0Lorexdt/W9sSH+3ydw0ycvy2YOGwMUt8urrDkpL0QJD85UfpxZ/oEHgZaYISxve
         lYyPXvA1ir7PMDfecq2wjDG7LOikOyW7OGDa+ReWb3kQwaYGHsISNlNQlnoNGKlUE4sz
         tdlDB5MiOeeNZWbvbfbW62N4x2m829N1Zav+8kuvpkK2Ep9l1e0HEYilt1bjiRYcVjvj
         PIgLJNFAtmarvZMnV0e3jIEFlDXhxhEc0WFk8lL6azNCqABC4BX1DOPSFqa8/bLaNXo4
         b2BA==
X-Forwarded-Encrypted: i=1; AKwUvByWKEjmsXP57kpDzQJpaRObYkT+kqiTliP+wDYT3xvf25qK469d+3xndo5DKzAr/MtFIkUG8KEAYmz5Jyxf@vger.kernel.org
X-Gm-Message-State: AFuF++mMeDcdtwQUIvzq5nbKrFNwzFCfFzgpbkY3PRZwjQeQq3swlnIv
	PxlGHDqyCNuVhJ8PSFm2oCMBdX9i1xT4iTA2w0fxIOzTIDpH0HwHd4if
X-Gm-Gg: AYBFou2Y8KalCVm/V85CbsSLI7mZ4luPCLnl6+M14uiaswXCP2p5rNj7tU3spi2GkqX
	LgMEYvxETW/Bh1m/n4/uG1m9/RMcfmHz3Uy6dYTE1xsNj95jukSKoGqO2iWY5/cHPrWST9pc4tL
	zHnZd7D+OJM6KI6yTaEbVC4a0OtsATyL2om579f3/yol/eI71g6NNlryeo+Sh/dXKDCYSBOfC9F
	Chq52BsQQDxZFXjSR1MIgxlxxDJ7QDHS+FF2TexWuzcqwrTdc8BJpBH7I6bG3x5zqD+N9hqCVlp
	rJ2DRSp+gWXGpCQhlYEP2oEcTDsHHzjcYOb/T5sM1O227HaMwzp/f4Ia04nozzhPXKYyzLobNBn
	uswImvnelc7BRTrglz2/6kusuFpwME7QQbkvuepXQg4w6uq1lK7cPTopN0ckFOjMbL24W83Q7Ri
	RB/Jc833A5MZhD5tQUNxIQ3OVgBBEX8ASMUF8dCkYoHUi49EWimx+tkdWEnW3Y/2tZPzKFrfupu
	OnbTcmw5Dt2UmtLuukEjmhypXmo2I8Q65VGT+7qlNnkZGhM3PTXPUuI65nszrUi51NVTbSyU+Bp
	fll1r7oEcYGK8nVjGgbxVutVkZxkr/UW/3kh7vL7QKoLzukzGX4CwcTn5PoU/S2ny8s=
X-Received: by 2002:a05:6000:701:b0:485:8c17:9766 with SMTP id ffacd0b85a97d-4858c1799b3mr6894505f8f.40.1788585536473;
        Fri, 04 Sep 2026 22:18:56 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858ab73c2bsm9581135f8f.22.2026.09.04.22.18.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 22:18:56 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] netfs: Fix the debug module parameter description
Date: Sat,  5 Sep 2026 07:18:51 +0200
Message-Id: <20260905051851.11516-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The debugging mask is registered as the "debug" parameter, but
MODULE_PARM_DESC() attaches its description to "netfs_debug", the
backing variable, so modinfo lists the description under a parameter
that does not exist.

Use the parameter name.

Fixes: b900f4b89b4d ("netfs: Split some core bits out into their own file")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 fs/netfs/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 927badf3989d..ec402837aab8 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -22,7 +22,7 @@ EXPORT_TRACEPOINT_SYMBOL(netfs_sreq);
 
 unsigned netfs_debug;
 module_param_named(debug, netfs_debug, uint, S_IWUSR | S_IRUGO);
-MODULE_PARM_DESC(netfs_debug, "Netfs support debugging mask");
+MODULE_PARM_DESC(debug, "Netfs support debugging mask");
 
 static struct kmem_cache *netfs_request_slab;
 static struct kmem_cache *netfs_subrequest_slab;
-- 
2.39.5 (Apple Git-154)

