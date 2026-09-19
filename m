Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873CE47FAFB
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789817123; cv=none; b=mzzvhUvzENKnn0EkolDlHgoIewo0dNFfRXxhMqhnFHW3oyl5k4ys1c/ag2FEzKRRQQgnCuBJuv1v/syEtR3ftehL7TWuudy71Gu0in/MfaQEz0PWteyiTcYu7Tzeph69SwFCWKwUtS+yRN72MtfGmKc/6VelwKmsziVVBkEhCpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789817123; c=relaxed/simple;
	bh=o8qYnC0iodB6i5JYex5NwbUYoqmBX7ZvIJfjLF28bDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CacmvYqvPcuNNhE4gRbdaygiEwwb57uqYyV2ieBfuufTr3XbwSzVAog6T2jdSv6dI0NKdYtxgCqDOwIuqdHmCYqB/NLXUu+Dw/vgG+Nr2NR7aI6jOL0xpQCP92ZXrNwdj7fHUf4d4icSYlr4IWbPcJijPEdYSbvBkm79V7HMPyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUEmySLY; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUEmySLY"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469e25400so1219528b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Sep 2026 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789817121; x=1790421921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fz45Uiv+rMZz4ewexv5U1L2m2XZjVKu0OOwOAru4fI4=;
        b=HUEmySLYuiW6CBntMnADpaurgOpUg381KDxu3JAv3/kChmMRrXr4wX1l2bRpgFmo8E
         B0UWx8WyxttxK0tY6fSNqmsk0vPDF6Rcm1mzcUKvfnQCePMt+fmDiJMHPMn3y2+ppm88
         lrITtaUd7Z/L0Fe4jDbnwy8fjplvMWnwN+nSi3omyMUleYjJX3dHitUbdBqifu2qPoj8
         iycybrLfTa8aqxjldyc4/Nl3W9pSOAifkWpaxRxITm6Tgs0+3QnteJEu0sSoHC6nKs+m
         th3ZawGDDDdiJRtBfU9ZI6KmGLzCUpcRH1/uaJriEuu0USVOHmhkRRUKkPyZ22HUBj35
         JAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789817121; x=1790421921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fz45Uiv+rMZz4ewexv5U1L2m2XZjVKu0OOwOAru4fI4=;
        b=HYimWsslYkea5ldpt73DgNQb3JjEJrTJr6RipjPWymNYIImIKfEYO/PyJzq1TUXOEd
         3qtR9Hrr2Xe93D0cB02AKbNnRsuFayXYbgfFZ+5QddRxkfsadC8Ydif4rqaO6Hx1L+Ul
         Jn1Q1zx77r0a1rPEZyPyuzFI8mGDrfnZbyP+OyrLVGU/+2py6vuxAqPFfiDNZKpn37wY
         pIQHIMj+IubSFPPKQV2PsoBcoNl1t7ejvvn2KJT5ZkQmGyKiH0mZjBDYCFevkZfDlkgu
         q+Vd6h5okIAqSOyAcG+BBTefm5R0f9rAHPIR8MrWqUk4lDlXpEBe1CrF/DrvoqIsWXq/
         ABgw==
X-Forwarded-Encrypted: i=1; AKwUvBxv5MHTjRoCUn8Jq6DC0og46EQGs8WXaAhkbmlS9w3qQmM3JNRRfgEtRA0guJRSGKyPdZVCKnyevJrXn4vK@vger.kernel.org
X-Gm-Message-State: AFuF++lDCAXtAkzdKf4MZUjxuuCo/BbO0FTIhghLnqEvekXoMW4KyXF1
	tpyzFXOTLHR+JKmFFpw1TIPsl5xx2xcQQnz/rsdkKhGCF/mWaQD+pTwM
X-Gm-Gg: AYBFou2LwBCXaPG2Htt09dYVYqQP4alxO93A9qesbGm7WBDKgqh9ya+N8qbtG/LwMPC
	zJmDBMEdIbHhUr3tilflWDCWEx+7jwWYq/ZEhXXjX5OyJWK5+npJiRLE0VA7JoMv+rfR0Adyz6M
	lPEdyA4PL19dBbKxTBhv8y/u4Ylvnrw4/2RWPCSrUx6cUqUK/PoFv9Ebc8EcNRj4wn1VNHuXSO/
	IDg0VDP3AqqaPq6RfknOKeOmnN9wWtWR8KLvNdM248hci5guQ0lnBJwOjTtcc9N31QmVlg8si6A
	Tf9a9Ziguhwr+k9sO7RXWOl0xAA4KcFWkY/EMw5Lt7Hro3BNx6ukQ5OSJie0WIbDjWDMKNlUS9L
	J8cqpBa8b4ErLsaXKG3iIX6LIc6Ujx5SF35Zg9r/CQVM+ip6ac5NwlR/lDq0gnKTIaPfauW3Lbu
	vzby9NmvuemmPZU3AYAQhzMmgd2ZGC1pAXuGaODgSilkDyhkZuXXtbxBLwOUyTsuUv0lRmEj1jR
	f679R21/6y8jRkCNQwWodoQ27JCCqut3k+zE8MZvneVlGLy50q7jhzFTBDNpCd3Zv4siGRxlXEQ
	5Qj92jtZuA==
X-Received: by 2002:a05:6a00:9291:b0:874:705d:f649 with SMTP id d2e1a72fcca58-874deced9c5mr7653377b3a.43.1789817120928;
        Sat, 19 Sep 2026 04:25:20 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm949957b3a.42.2026.09.19.04.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:25:20 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: brauner@kernel.org,
	viro@zeniv.linux.org.uk
Cc: jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] nsfs: fix namespace reference leak on unsupported ns_type in nsfs_fh_to_dentry()
Date: Sat, 19 Sep 2026 11:25:19 +0000
Message-ID: <20260919112519.3872163-2-benquike@gmail.com>
In-Reply-To: <20260919112519.3872163-1-benquike@gmail.com>
References: <20260919080850.3005810-1-benquike@gmail.com>
 <20260919112519.3872163-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nsfs_fh_to_dentry(), ns_get_unless_inactive(ns) acquires an active
reference to ns before switching on ns->ns_type. Unlike the CLONE_NEWPID
error path and the owning_ns permission error path, the default: branch
returns ERR_PTR(-EOPNOTSUPP) without calling ns->ops->put(ns), leaking
the namespace reference.

Call ns->ops->put(ns) before returning ERR_PTR(-EOPNOTSUPP) in the
default: branch.

Fixes: 5222470b2fbb ("nsfs: support file handles")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
v2: Add a Fixes: tag. I blamed the default: label and its return
separately from patch 1/2 to be sure: both come from 5222470b2fbb
("nsfs: support file handles"), and the asymmetry is present in the
original version - the sibling CLONE_NEWPID and ns_capable() error paths
both call ns->ops->put(ns), only default: does not. The two later
commits touching this switch, 4055526d3574 ("ns: move ns type into
struct ns_common") and 3a18f809184b ("ns: add active reference count"),
only change the switch expression and how the reference is taken; they
do not add or remove a put.

Please note I have no reproducer for this one and I am not claiming it
is currently reachable: ns comes from ns_tree_lookup_rcu(), which only
returns namespaces present in the ns tree, and every namespace type that
can exist in a given config has a matching case, gated by the same
CONFIG_* symbols. So default: looks dead today and this is really an
error-path-symmetry / future-proofing fix rather than a live leak.
Treat it accordingly for stable - I would not object to dropping the
Fixes: tag to keep AUTOSEL away from it, or to folding the three error
paths into a common goto out_put; if you prefer that shape.

 fs/nsfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index a1842e12f..e9cc09583 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -624,6 +624,7 @@
 		break;
 #endif
 	default:
+		ns->ops->put(ns);
 		return ERR_PTR(-EOPNOTSUPP);
 	}
 
-- 
2.43.0
