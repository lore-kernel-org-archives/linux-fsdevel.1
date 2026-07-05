Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89713C918
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783236387; cv=none; b=pESKVYkB/l/shlMJfSRnnPpVKzeKsIwODDXuQLsaeSrBgM8YK5IbkzAKkiyeKYlwgNB9zJuiNDbO1vNp24W2GmkNqqrLeeYWmxVLTV/9gRdrax4ubcCxPA30WzTSJorI59L27dDr+ZOCRXfsEMLdjnQtGW7jN3hYdPPbOgX/7cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783236387; c=relaxed/simple;
	bh=cgPO41zzNjU6O93UEwyAVluafD2uWIUQA0Cpobu+O/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J06WStzug/xmK17CMT1Ly/e+CdUNp56wooQG4M14yd1a0a0omXABeMRGFk95lIiUL71zjWntf3Do4RrIyUpVm+NHo/DnJqIUPjiUH/Ddt4lgVFx3L94qcCo9RIpuVx9l5Ic3dC/WL641Mg+ff1o+WaoiWM6BA1EEHwkRSdxfBug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mN0ofP31; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mN0ofP31"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab973140bso23028515ad.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 00:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783236385; x=1783841185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FBdctp38/9wGuY0f0rzSmIXPq8MzNuRFKf2gmiFzvrY=;
        b=mN0ofP31v7zgdXd+raxmbds9SWjevxNkHn8pZIe0Wc/YMfF11kb8NZI4hIvKOlacnn
         uglQeW+9+WaSkKMlzya7XPgm6LtsXTyXzCj1wsVjz2f42DWjlTpea2SrJATBaA9PcQZV
         VkVaS84lTtDkcgowXPj2OZmF0bnm6dCNUeefvf25nSPSdBsSoWhY2zbq1tERqQ1CniB7
         RIyG4eoPHq9xIoYkNrrNX4bnusMdnPBfHRcHI+4YvBX1LHk91BTPgYoqOk/ngAZuLAXw
         PtfF0PuDa2tFDU/rsrSRDoJcU62bcT0qiMFj80emNSQzWIYUsaUzsSytd5AjPH83nNJe
         Ek7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783236385; x=1783841185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FBdctp38/9wGuY0f0rzSmIXPq8MzNuRFKf2gmiFzvrY=;
        b=J/YYwbteLctOv+Dyz4djWOYqsvcWX6w2aW4MAnaz8NGvgATx8Avl2emmfJyMPm6FzK
         C7tkfuV0J7rktcq9cmxD/fd0Z5zYg/2HQxJ69Pu8dS4Ov2jJ3VgxT12Pg+JnTh5xA15k
         XgS91d4yh1+uYl06lwVp6niksRJp60vcys6x8wH+yAYhAlqoYqKEzKc930T9SUFNld0n
         x/cWTbn/axX1iAQ8gysDjdTzQzuq11nkKqQjtCgqTWnwUkCADMW9+Xni6T1WmMHn+v5S
         fEZC+Klxy9qYAml9r41ZXPHB25buJ8CBSSiPntM+oEBa2E/+akLhz7aEMA90Hz4N/7dg
         Fo2Q==
X-Gm-Message-State: AOJu0YyDXtzGP3ScYtrHo0dav9FpV+DGsLC7MiUX9yEdozoHF+j3aqt/
	DiOI1vlYTmzHvOfHZaUDGrzzUWqQQLp8aTbk88qEK2POLCTxKUH/EiVpGdmQ6QS6mMVl+g==
X-Gm-Gg: AfdE7cn+69TfNBNACJ+fYvXzGJDKXSI7SKSkYw4qZY/DG12BiEQE/M6NE9NMywf3yKq
	az6Vpf+9l1GUY5g42dQJo+jgzLXsAThT/IVfa+Z8lj7cfY+HPISK5gwC50Y1kKWwl7lHneb6UzS
	uxRUz56jHA1t1N+Cq6p8RH/dKaalrE9BCgrMmhvPQ+JroPvlsSjjiW7Q/L2ziNWzcMozwTEpYK8
	FnuG6CXXOMT710U4R2oDKLt2hwuTMWAwbBdTCNqAlVTLyftDfCXV3AMLHLW6OKek5rMpriSoeHJ
	kmYNgIIhiZQiXkCu9zVsdEyrbI1kwgHWJ486sspeYLEDWLRDDYDAeGvonxAdoTnDBhFJgmQoNkZ
	HSxhpyeWpUp4uKi8PE4vd1+3WsYh7evDrVCe+2UlG81gAyi7dH3PAgK4q+u4pqQZ3Lib6l0AWAU
	MdXVHS1ScBedJ0xfNkwFj0
X-Received: by 2002:a17:902:f68a:b0:2cb:2b50:d9e5 with SMTP id d9443c01a7336-2cbb9f06719mr61270415ad.45.1783236385283;
        Sun, 05 Jul 2026 00:26:25 -0700 (PDT)
Received: from localhost.localdomain ([138.199.21.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad7765810sm31224625ad.53.2026.07.05.00.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 00:26:25 -0700 (PDT)
From: Yuhong Cheng <ceohunk@gmail.com>
To: corbet@lwn.net
Cc: linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Yuhong Cheng <ceohunk@gmail.com>
Subject: [PATCH] docs: filesystems: porting: fix spelling of returned and instead
Date: Sun,  5 Jul 2026 15:26:09 +0800
Message-ID: <20260705072609.1692-1-ceohunk@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the spelling of 'rreturned' and 'instread' in the LOOKUP_EXCL section.

Signed-off-by: Yuhong Cheng <ceohunk@gmail.com>
---
 Documentation/filesystems/porting.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index d13f0a23c..e040b0ff4 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1173,7 +1173,7 @@ these conditions don't require explicit checks:
  - if LOOKUP_CREATE is NOT given, then the dentry won't be negative,
    ERR_PTR(-ENOENT) is returned instead
  - if LOOKUP_EXCL IS given, then the dentry won't be positive,
-   ERR_PTR(-EEXIST) is rreturned instread
+   ERR_PTR(-EEXIST) is returned instead
 
 LOOKUP_EXCL now means "target must not exist".  It can be combined with
 LOOK_CREATE or LOOKUP_RENAME_TARGET.
-- 
2.46.0.windows.1

