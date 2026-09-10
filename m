Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361583FCC
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788998716; cv=none; b=iuKvFHNVth3I+JX90yVWNlROalnQxmMh9KGuWwOEy5OfSRRRQlmxniW32R2uj6i9yQLq+A5FjQMF4dl8wKN+Elj0JKyFPTiXX50Oc/IQa2rGrUFLneee0nJltgv9uzKalC/MNdABIZwkfkYCozIIQk/GPKFFl3hQQKNEnfDop94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788998716; c=relaxed/simple;
	bh=vPGGigZtbn609VllmdxIrfgs2wVQVwK4tTE8Lofg/mA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQXxnFycHjoBTCUHRSQQXSBvs2p756h9VZRiJGIuaQ5uMgjn62KizPVkdbv1wCZLYUdVzvYJVrrQwVvcUFJex+gsmIGOElPMBm2iAHHvAt9gxWSdlzqr5jX4XuZ9rCOaE/s7LIwKk5j1/Jj0bIF4S+AcMPOC0Hc7FWxdkzeBoXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=n/unJEpP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="n/unJEpP"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-857ff9fef54so64068217b3.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 17:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1788998712; x=1789603512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SBS5mNZmCsiLBp7HvXFMoNdv6DnLngpLQ6EQEUK1Hco=;
        b=n/unJEpP0izSh1Guwp4X1e84gw4dp4dz85xPeBi/uLDts4snOuJtwQDOeeqUw2yCFJ
         3CuuMg0OUb3mrL84n+JH3z/aHbOizez/8KSKUmtC6RllS7u9xNJ/lBJTPr571R2P6Sub
         XDZfNQsAYQUlQRMFOjNFsX+ThucsM/laHB7onnNMiBACKnBErZl+PDqldWSDBmn9MhRS
         ExQLIPGzuJHa0YcRH0yIRO3xfoDLOmAatrWku/WXP2dJNtyHP7FViQxA+hELPA1oQfnr
         RWAiLZs5ljOt2QcwFdG3h79R1TBlDCOFNFo3KSnuO4uW+cx1Yxa9iWHyvL1J1wETLKHM
         36Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788998712; x=1789603512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SBS5mNZmCsiLBp7HvXFMoNdv6DnLngpLQ6EQEUK1Hco=;
        b=V2SglZ/6+oFmWRtKEiTe5DJYtoNWpl9LJFjRvwCYsSQDNYQ68TikbbDWXEPgFu8BeR
         x+ebIZIAAd2ly2C+PvMqCSrT54y2/nw0CtRJhAtG5rlqveioNyqAEyu8zeSSqhCycXsk
         mfmI4tJdDCijv+v1T9PqpObs4lE41QvO9pfa/9fol/LN/152NE9MdATLA2+1r7AUW/iN
         Og3jSmbLvvoQgscw88HPDv2z8ar95xzX+aC4MwZzVdSlnZN4w+ybD0Gbq3+OREPZg9v1
         bymBcNd0nqrZ+XYrWT/+48savmrscEg/lst0pnhcEyMq2fbu+iWFJUD/GVdxrPuo9S1y
         DCIQ==
X-Forwarded-Encrypted: i=1; AKwUvByqXDSJ+dMN6641hFOTBwTf/3HKubgjtOzrS1J3Y5LnwouL0u/kRKrG9oQzN1JPjE9+bkdRWJVgul21mxC4@vger.kernel.org
X-Gm-Message-State: AFuF++lyCgdlKtMgKN2nZA0uL/5dysyOFStd0Q9cllEmolRuSlwvhcfR
	XWa12B3PDV1A1BPMBD7JjtYy/mBqdobQjilCfQCv+gcuRtyyqcOz1z2jADMw50yTulo=
X-Gm-Gg: AYBFou08NhD6hDDHWPPey2XIp+2UBysVSMeM8SGbLXHw4jEAvmN4PKXm/AixLz1rBfP
	+INOSxTQpiprqTa5krVshWwXOfJF8gEwMT/hbQ4Nti5NLc7xgVQWfI53lVW3fMOr7CrBk5cMTtZ
	yzGkSPJ2leWvGtCuBliecMR49Fd3wA3sjCX8GhWWPt4pDos2gsMxMKqW17zZBY2ESWQEC9pE33q
	BogHrZWJOTWWWY4NTf1D2m4jeKZAGIHdhCw8VebvfE5NntVhQoffIZV+Gz8rMIqWIRsKjiu3yf1
	o7c3MpO0ITyIVGiIkrXqHwf93tm0QUl35PhNLOjc8KPQGARKJkzNKJWRxWrXhi5ZZXc6muNrwhk
	BH9rVWmlfP80c8nsO69NEFxkM1DkmArF1GLcKEJHTTogZ9Kj6H98L+opPe6Px9jan4I3OvDiyep
	clMQdsGtTQz+BjanfAnZX8irQvUEZJerT434VnEvp7NrC9hso5jAWD7eB0XjPhAXQi5X0OQ6RW+
	ghnfK8WyfRszNos1F/IQKAGPm1k13j4I1aOIZ5B3AIHf2yjCZMgKZ5hw2ym46/wHwPecPimySNH
	G6tN7/QdcGCym7BR4auwDIzyVznRyZrnbNKcxb8=
X-Received: by 2002:a05:690c:dc2:b0:870:47a0:6fce with SMTP id 00721157ae682-871225989c2mr154470257b3.4.1788998711977;
        Wed, 09 Sep 2026 17:05:11 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:bfe2:d67c:7903:eb5e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8714b62503dsm118699177b3.38.2026.09.09.17.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 17:05:10 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: zlang@redhat.com,
	fstests@vger.kernel.org
Cc: glaubitz@physik.fu-berlin.de,
	vdubeyko@coreweave.com,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH] xfstests: exclude hfs/hfsplus from generic/339 run
Date: Wed,  9 Sep 2026 17:04:50 -0700
Message-ID: <20260910000449.747189-2-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dirhash_collide generates filenames from arbitrary random
bytes (only '.' and '/' are filtered out), which are not valid
UTF-8 in general. Catalog names on both classic HFS and HFS+ are
Unicode. Feeding random bytes causes fsck to report "Illegal name"
or catalog corruption that has nothing to do with directory
hash-collision handling, which is what this test is actually meant
to exercise.

This patch excludes HFS/HFS+ file systems from generic/339 run.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 tests/generic/339 | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/generic/339 b/tests/generic/339
index bf8f7729..5cc1086f 100755
--- a/tests/generic/339
+++ b/tests/generic/339
@@ -17,6 +17,15 @@ _begin_fstest auto dir
 _require_scratch
 _require_test_program "dirhash_collide"
 
+# dirhash_collide generates filenames from arbitrary random bytes (only
+# '.' and '/' are filtered out), which are not valid UTF-8 in general.
+# Catalog names on both classic HFS and HFS+ are Unicode. Feeding random
+# bytes causes fsck to report "Illegal name" / catalog corruption that has
+# nothing to do with directory hash-collision handling, which is what this
+# test is actually meant to exercise.
+_exclude_fs hfs
+_exclude_fs hfsplus
+
 _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount
 
-- 
2.43.0

