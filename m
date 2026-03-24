Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB5140DFA7
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 00:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313708; cv=none; b=fXhS0BU1+bQ6kv3bq2tpx8+2sBQ8pxTy6hIND3giNRMZggD/ZjjoI0mhgbaVjZuPzsGh8YDA/Az2MfDg+nQ2Cg+NmyDmrzhLasGFsAsYZr4leRVw8rlrJOQ9sZRk64Sj1pPTWaXu4674SFsIQT4WKIOgoWc1LvayFwR9jZqKJwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313708; c=relaxed/simple;
	bh=8BN7Udpg9VR3CUDNjlMRxDjAJ+r5T9a0yvoZOQ5kunQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=moEudOgRPaOAgEmFeAqiNK8ILofrp/wR861itZ8SWLSoc+pOixTqomoLnusHIqF95+xt/t0kdnRdG9nfUyPDAOE+LunZGeR8IItUkBKQvN+hz6RLEqn74Qlf+h/7Nh3PSm9sEHU3RpSMM3HTXZVecFMNion/v6MTlWS5ie6H3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=iry84VX1; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="iry84VX1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1774313700; bh=8BN7Udpg9VR3CUDNjlMRxDjAJ+r5T9a0yvoZOQ5kunQ=;
	h=From:To:Cc:Subject:Date:From;
	b=iry84VX1bhAIh5gonLNIxKgO2AVu8u2lAYkg12suFgR70igvDFjIEdZ6OZNGvwTEe
	 iQrZwCPzAZlnJYA29TTWf+tNUinAXvrzsXwY0cx8Q9lvP3kvHXC9yUySlwUUXLS5Av
	 GWTb+amv2GGZOwN+ddZMmCdmQ2oKJCF537iOpr0j4Apm0cOTSzbxpbcfNTXoEJgSJg
	 M9aPiUZQvEf0huBU9nJtPzi4cy7QcghBio6q6xPWntt7CLpnuBpV602iRKrY45ZPm5
	 /dyyGKWxSxbawxFFytSVDBusUpCAOBjjvHgu2oXSJJA24zn2C7NsE/NxdqKNJdkq27
	 LpsrV2CwrQQNg==
Received: from nebulosa.vulpes.eutheria.net (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id 0F0CEA041;
	Mon, 23 Mar 2026 17:55:00 -0700 (PDT)
From: Vicki Pfau <vi@endrift.com>
To: Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Cc: Vicki Pfau <vi@endrift.com>
Subject: [PATCH] ufs: Update Kconfig docs
Date: Mon, 23 Mar 2026 17:54:49 -0700
Message-ID: <20260324005451.2153690-1-vi@endrift.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documentation had referred to FreeBSD 5.x as "recently released"
despite coming out before kernel 2.6.

Signed-off-by: Vicki Pfau <vi@endrift.com>
---
 fs/ufs/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ufs/Kconfig b/fs/ufs/Kconfig
index 9301e7ecd0921..6603b8bd71c8d 100644
--- a/fs/ufs/Kconfig
+++ b/fs/ufs/Kconfig
@@ -12,8 +12,7 @@ config UFS_FS
 	  experimental "UFS file system write support", below. Please read the
 	  file <file:Documentation/admin-guide/ufs.rst> for more information.
 
-          The recently released UFS2 variant (used in FreeBSD 5.x) is
-          READ-ONLY supported.
+          The UFS2 variant used in FreeBSD 5.x and newer is READ-ONLY supported.
 
 	  Note that this option is generally not needed for floppies, since a
 	  good portable way to transport files and directories between unixes
-- 
2.53.0

