Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB39E426690
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379228; cv=none; b=d3SacmhwbsSV2de4FFz3zecOMH6gzl5NJ6elYqJbHrVhN/Hf9p+uU/Pvo72KFE0KnKi30cCJe8iF6c67FeYM4pfshG1f01XCMNrhuLX6YxzRbcv9G1YdMQAwU9mFvANIf0U/1b/CQnwbmyEHDNzfS4GH5twnK29n5n6ZwpTjjmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379228; c=relaxed/simple;
	bh=xcPscxFmFlvLehZTEo8r9Z26NBYGBJGvjku0jtR/Kcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pMxdoI8tmVRTeEuqN00SIJbdUPQxEFK13DGQvGj1EpaYrlndYzUudsm0+/U2o28t2yPbD9vbBvFVxzuLd8/QuenH+eu+8InuHNcqHJ3UG2cQww4DDrJKTBIGSDp1TLopfUaBsdFHx3lHs3eXHHTizATUQB8Is73Q+5Jx9kAv1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiR7tBRo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiR7tBRo"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso98253775e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777379220; x=1777984020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HSohUozqi8NkIG0nhDL5W8Zp3PsmTrbCjFJ+jEUQYvk=;
        b=eiR7tBRo9aH4qM1li/S8vF+3N+yv+zm/OMWP+lgwFILeHTqIDAcGohde2VYEREU1lG
         Ui8Qe+V85G+/a0bP3YnFEwgSXTG/yQa/4ev6cYzGS4fZXoavMlnsqeJadyVuEcJi6zMC
         b8hjZaBJvLy5gHe58jmYZuw4TACIBRvaqKsBNbt0ch22TQ39t42BB63mHW0sb5s/Y6l7
         /xN+FyTSx4SEIroN2QvD5seJEMiKUbGU42Yok3b163BvHE4nJU82hk8WjZuEivNmrnCd
         ehnn+1MU66H8s6cEB8R8UbjMl7v0VTB4QpQzkzLQ/eNkPv6zdn6dgj4rBedZjwat9gjh
         3Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777379220; x=1777984020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HSohUozqi8NkIG0nhDL5W8Zp3PsmTrbCjFJ+jEUQYvk=;
        b=lN8mxprJjg0pBwtxx2abINHvOVhOd0LpuyRYrlxE1YDu1l6YIIcoJnD/qhFo8Rh5b1
         +2YqwdevZUd5K5Se30HU0rWp44HtJE65EmX+g6U+r8/+0zeKIUF4v1byEcbQvSs5n7yD
         w9o4SygV1kLV5up4Gg531mU8LEAs8PNnD3mH6y1Jpbz71VqrKcbmL6G7esXfZc+7jJjY
         EURuyR+P9VqQFEFSerwCm9d4dHlHAJxmH26G+nR4mFF7aCbP2bx5HRcUPNfR1VYRw9Pg
         EXJIMEbAC3JbQhGsaAVlxg2ZgPsP+tgtZ4h1akOJdUGZaNVgVZX6BFXJR0AoFJdGkNFT
         KxHQ==
X-Forwarded-Encrypted: i=1; AFNElJ8DE12JAQEx187uh7KiE3HhmjvOe9LGj3FNJQIr6c3Y6cIohtls4VJEBQOmaCIG3yJhNNuaAMYFMN99oOgH@vger.kernel.org
X-Gm-Message-State: AOJu0YzOZXKV0ncaimkxvkZFqKC8umrxLT3eCHD2LHQxOn8e9wDnmXPG
	ce2DkctNJsTMeIl4zXotTLSqBMd8rwBvGgvp0YF5kELEBHqfJNBGV7u5
X-Gm-Gg: AeBDietZKSS+dkMb//RA4idcSU6NFSEyPDNbXedKtXMIeS5Er9mBYmuPH7HMWUT3XQY
	yXzXhfUQ9Yc1FzNH/VwWXuNvtxRb3bZqWpQCuRdpc3p4D7/qGqct4CUDiUmOumtiYQJwRFXgrKp
	nM6Yji760gi9hgwALGylaX17IINMmTXXZdjqcLo7nZTf8l+47Dkj4R0zYZuCozsErN8MQzZYeCE
	NxpcAElI9m7zMe7TRZ78nng7jPptwOOr3RW2Wjfnv5bCFBesK+pMuUn8rmIirWCWvshh5mObxBc
	HybmrHe1Jq7m/WE9zXqdQRDiUOUOf3d72Zf8EFaxgMW/CzCWUNI45VXRX7V5Z35KN6s7PFXFkOZ
	KCdKSz5npT2O54cRPc7DTnO6dWJCyS026LWLfceBiTvlkvWSOJxL5VOeGb0TScvWp94f5VkHk6J
	+DRRNp21xyhs2t1HxRTQch5XmfKBGSrQ+6/BI4kO6iAOUX4NBs65giMb+G/EcGsRXwUup1NhIjI
	hfZ/hKMgXkxcPEiexVif4mBZYydJ9I=
X-Received: by 2002:a05:600c:c177:b0:48a:5301:bb5c with SMTP id 5b1f17b1804b1-48a77b12a49mr40423285e9.16.1777379220201;
        Tue, 28 Apr 2026 05:27:00 -0700 (PDT)
Received: from x250.speedport.ip (p200300c65f496d3577a54ef28bd39e7f.dip0.t-ipconnect.de. [2003:c6:5f49:6d35:77a5:4ef2:8bd3:9e7f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d4fa52bsm6387263f8f.15.2026.04.28.05.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:26:57 -0700 (PDT)
From: Myro <mirademche@gmail.com>
X-Google-Original-From: Myro <myro@myromyro.com>
To: corbet@lwn.net
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Myro <myro@myromyro.com>
Subject: [PATCH] docs: proc: fix minor grammar and formatting issues
Date: Tue, 28 Apr 2026 14:26:53 +0200
Message-ID: <20260428122653.3550-1-myro@myromyro.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix missing "from" in "prevent <pid> being reused" and
add spacing in vm_area_struct range notation for readability.

No functional changes.

Signed-off-by: Myro <myro@myromyro.com>
---
 Documentation/filesystems/proc.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 873761087f8d..d828006bd91c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -118,7 +118,7 @@ PTRACE_MODE_ATTACH permissions; CAP_PERFMON capability does not grant access
 to /proc/PID/mem for other processes.
 
 Note that an open file descriptor to /proc/<pid> or to any of its
-contained files or subdirectories does not prevent <pid> being reused
+contained files or subdirectories does not prevent <pid> from being reused
 for some other process in the event that <pid> exits. Operations on
 open /proc/<pid> file descriptors corresponding to dead processes
 never act on any new process that the kernel may, through chance, have
@@ -2199,7 +2199,7 @@ the process is maintaining.  Example output::
      | lr-------- 1 root root 64 Jan 27 11:24 400000-41a000 -> /usr/bin/ls
 
 The name of a link represents the virtual memory bounds of a mapping, i.e.
-vm_area_struct::vm_start-vm_area_struct::vm_end.
+vm_area_struct::vm_start - vm_area_struct::vm_end.
 
 The main purpose of the map_files is to retrieve a set of memory mapped
 files in a fast way instead of parsing /proc/<pid>/maps or
-- 
2.54.0

