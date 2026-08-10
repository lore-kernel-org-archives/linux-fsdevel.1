Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CABF357CF1
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Aug 2026 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786343830; cv=none; b=rSu7dReiAinzEW9gbDjWSTfwneUd5x7i8KdKiuAiusrldXc1jjgFit+2paFtFwKHOlp6BwvEHE6pMl88Kol369aUHmXCthR30VvW3xAoqNV2NQPG907Qdo8RvF+bn8Vtr50gymtEjtDkJbLAiyW9VUN1fmeOeklQhrqEw2dJVKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786343830; c=relaxed/simple;
	bh=eCY2+fzzmHBLeBz/ir7niiKbAlRZr888YSvC7sxtA4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YDkdeVuRy1y5Dns1q+baXy/Kpih5FD3CSraXUPoTYM3ZzaoCIQ3PSpM4SYsZXC8arwSV9MTzYk+PpNbtdHerzmmq6RBHNJSmrTcA4tkE+H6kK80htXZ2y0zHMwvn4E2uhOf6KuG8OiCP0eWupEGcSplriaBFR8VDe+c0m6tjelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey7CIMzE; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey7CIMzE"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca8a3a77daaso87317a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Aug 2026 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786343828; x=1786948628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKDxKvtxfKiLVXpIQqZolVU649XYNHS35A+eOiSJKEw=;
        b=Ey7CIMzEqSrWaWyKhSCkuArPdEOOb9kWmOtOT3imt2MRm+DobWYVP+tZ4x2/nnqWiG
         gMZtdB/YVT4s1sfNHiJTnmMhMBos0fbfkkDzdDrElGeF+HSZsA75kLvZLT6obYUPbKfk
         n4cwoZMpL0Ux7mjntW9SwaHREflOxqzTOdaicTrNSzMCV1iBaxqP8N9M5uDjO7C+Ct/X
         85L8GWyRpwmk1GrPKv7KjhHTZC0WKCEsQ5UikFFcpKYxpPQB606eSFq5nI48OoRtgNQD
         EMSMJnr05TfiiU9ptKslRvV7H3HjrT9SR3YkYeo3We70D0kdj9WFCMKZ62GNEZm/uEF/
         6BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786343828; x=1786948628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKDxKvtxfKiLVXpIQqZolVU649XYNHS35A+eOiSJKEw=;
        b=kZsLqjlC2hw3sIqktfVpbC1GPPIqesEoFZhaP6QVnDGkJMxnMfJkF2whkxugD+Li10
         ZtYTU2g01AvKKudjw85CIvAlNuaeJtkk1FewKDlC6llKi2x7/N+SWyFjE5hiOYmEyodM
         gjyE/cDRTisg/h9eKtYzBohn+fYQSe7q1F0yAw1TexcNg74Ni2a1BvTgktLIq9E7Vmq5
         GEHc7bECaW3Ec4dfUbVgMVvYYjGQR1FFaNPv7MRq8BTqtWsVjrfh1963YbdEYr243Pvi
         p+1s1slEfnFFkyrh8DC4f52703YTurAVsxX+UzE0kwRy5OcHfYWFajLqvprHPHtqmTXS
         na1Q==
X-Gm-Message-State: AOJu0Yysv1ysZz+e8RCpn/HEScRhQqUruWEpSg5+T0/EicyDSvaHOINT
	NA0eurnNDToFXgMy0GUMe7xHPv8gHPCNMo5NbxWaDFIZkiaKbPdyNj8b
X-Gm-Gg: AR+sD10tmb2Rv4wS89N+Ll3hEB2ZgqPyR4VRfYKrcv9tDbxViE83ya4RWElpApbwQKX
	abED/fEyTc7M+RCOthJe1QSsPaXxOHY1UlKg5kniYZ3Ncn4goFzuSHA2hnwajbYT5xWTy1fZCGP
	u0vnO2/iS8V3VVq349k81KPYEJD1pN9ogF4NS4LcTvr9P48zsoUmi/DC+Yur3Q89Ey5uTma4Cq2
	Autc479cglGTGGSdExRILebP8oJT76RTNrCbsqlVodT3suSt/37etg/LvaD0UFef1RjoBBICFfc
	JCGVn7YLV2szmv+SiUeOHygg6KmZ8xu7k71yWJMV13BaQBjIr768Me5blaVcOYBWyezc4gEGPFR
	uISKxrRevquM2RIjd1IyhQ9LaeiI4/r693wefs3UZHcLhk/+oTxLjIUnAbrTBV0UkEsmcnCyMy4
	3Xm9oWNIDS9yo6C8Isxt7JqlMvPbv2TQOtb5gDl213OsDKs3reLoyYm0E6xnabgS1TQENIknbag
	dtQ9E3ioX0iKenfHAVS
X-Received: by 2002:a17:90b:4410:b0:38e:6d4c:14df with SMTP id 98e67ed59e1d1-3903c5bff9dmr26198582a91.1.1786343828191;
        Sun, 09 Aug 2026 23:37:08 -0700 (PDT)
Received: from PC.hsd1.ca.comcast.net ([2601:644:4383:32e0::16a2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085dc396dsm13491402a91.3.2026.08.09.23.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 23:37:07 -0700 (PDT)
From: Benjamin Wu <benjamin.wu37@gmail.com>
To: brauner@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	Benjamin Wu <benjamin.wu37@gmail.com>
Subject: [PATCH] docs: fix grammatical error in iomap docs
Date: Sun,  9 Aug 2026 23:36:31 -0700
Message-ID: <20260810063704.355933-1-benjamin.wu37@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change "This origins" -> "The origins"

Signed-off-by: Benjamin Wu <benjamin.wu37@gmail.com>
---
 Documentation/filesystems/iomap/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/iomap/design.rst b/Documentation/filesystems/iomap/design.rst
index 0f7672676c0b..681e0cbb6944 100644
--- a/Documentation/filesystems/iomap/design.rst
+++ b/Documentation/filesystems/iomap/design.rst
@@ -43,7 +43,7 @@ as:
  * lseek ``SEEK_DATA`` and ``SEEK_HOLE``
  * swapfile activation
 
-This origins of this library is the file I/O path that XFS once used; it
+The origins of this library is the file I/O path that XFS once used; it
 has now been extended to cover several other operations.
 
 Who Should Read This?

base-commit: a7c7074b58d28c4206d666a12aa2e33447b3c581
-- 
2.54.0

