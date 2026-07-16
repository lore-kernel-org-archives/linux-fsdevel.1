Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35C41D63A
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203073; cv=none; b=kQHjm7iL/6tfzG9u4IK/PND+g0URqorMhK/KOCUBdKbGZ9JcFsEojuG1qx7qZ02nUWYYAsoflqmZahfR6psOfEu+crL+VsIQnKLXr+1OzN5tjqmTpkbLAuZzgiEFM+EZsJlX+XX6ATIr++X1JmDoasscb8lc6H1/hz2j/dAGWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203073; c=relaxed/simple;
	bh=+GHwzsQ+4i43LI5Xh5tdHnXG/sDaoYxRx5Sy1qBv2Ds=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJ/CbVc4/RSC14A8n//ptFBPdcG0TBtnkG1Vlik7ya9r8fjty8lTJCk9V/t+VZQE4IcJ5MMSG1y62xwb1nTynyRHq2gBWsbEhu111DfouUPXqU2ASMgx+qlLi6V0O4Lwk+mVOefKWWa4m251zg+H+p2/5zJmFYYNu2Q4zvPKLDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQj9JGjL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQj9JGjL"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso7090931b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 04:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784203069; x=1784807869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crvbQPwYA/dMgK99dNCCjn85E0qewMxmyRRTho2IQ6E=;
        b=gQj9JGjLqnzBb6FyIV1q/UgbGAUZfFqMXsYeDi5J+1ibSTCjTg2Pj7Gr5Svv2ulIi0
         OWXu8/MV/IB81Zboqy8vUM06xP9doWZc+nYJGy9ugfLKEwrRSoUp3/iwrbmhLWGqbfB0
         uAOhxmOeQ9hXYhpRUGlVJga+I4jgD7jn53Z6i75/OtO4joG93PK1no7iZ5ZsdUF0Sy4C
         WgGax7JOiZ6dbj3a5OWCXau97ziGD6w+UE3LdsIKv+20hOljX3vwYhkJN6/WkSFRcD0M
         SrLxkm7nVNETeJjzTAnF0wo3SEyBZPJKvZwepivEDOp3X3/77LJ9xiXa3Y1cx0vUf8nc
         DHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203069; x=1784807869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=crvbQPwYA/dMgK99dNCCjn85E0qewMxmyRRTho2IQ6E=;
        b=MYAnwGtjODdOl7kXw6SIaiaxuOSOpIGuV/l/ta++G8cSK2KNwPqNERuuvUsklPRscs
         hihvWnnju7265QK12/DRO7RTxymB3xZDQzkSD9MLcdPe7MWEn5N7LnuTS/6332cYSB3V
         DpBs0z9Qgp5v7SZLbBLOadbUpTLGTNLFMZ0jIzmPhN56NPLbmwJc8PtPry5XmR32QP+W
         y8vnJMAIwUF3Hk8pzU+RMMnG90oIWOpdDwpNjWqpELRZcuW3s04NMlp9ejAyZQGlnRm5
         0mHGGB1iwcQliGEd76grCqrbJLVz/GoGqFQuT5gXzcOfRHIW8W1zUykOZkBslbwanqNr
         gtRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqW4HMLJ84wOVpJxhb724RUrGsmg5HWdOd1X9KeIwlprs7LM+p1zVtqcpp5IlE3yn3bM7lxkZg+d2ToHdt3@vger.kernel.org
X-Gm-Message-State: AOJu0YyCuJz2bqICjipoUvoo1cBV/BmFq5hKMZekntVDRKNcmqa3GwUv
	id1iR6w16CgStsOePUq58vqGJt3ypFglSXiemLa7ZQdpm+m5PaxVCj6ENbfrTVHn
X-Gm-Gg: AfdE7cnaNFn+FI2wj1AM7IQZ8dM4lIBcRFsVZyiDTEYjzDaQwrEBt2W0JOgPlNK0yFV
	ukrKxWrY6bLWD3q+5wp3WG3xmDzJ5ksCfVqC09POveDobuy1iJsNCtS/negvme6PkMY8nZbB15P
	/GXaXEtX7p+0gA3nFXXHII6s+L3A+B4wD++sRkq3LjYr2MrOpOB6gMOrP9Dpw+/3uXAeZfRg0Os
	JBwFbSMAL6sgOFNVGiZHdwcCTpBMER2VSAG3ygvOUstfH5o2JnRRSmQkDzKf+KNjl2aqjamesY2
	VIUwOejMZqQdqeIj4u4N/4qqY9IPPhzpBdUgXVBdgb7I+YC5+7e1doM0mZN4F30k1h9v2TA+yoQ
	xTtLZfBAvFXFVCCD79ZLo0tnRPgjksmpPyMSBxli3E62sUxclvQo6482N78dvN2tsZuLDlez6CU
	sPWr/cRaChtwx4jRNSOnp8sLTwaA45o0XSHRNdv8tm
X-Received: by 2002:a05:6a21:329b:b0:3b4:9171:2573 with SMTP id adf61e73a8af0-3c3571d0bf6mr12359951637.37.1784203068527;
        Thu, 16 Jul 2026 04:57:48 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:9c31:f107:8086:4204])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6ebe98sm10920690eec.26.2026.07.16.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 04:57:47 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakroag <gaikwad.dcg@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/3] test: expand proc smaps coverage and require TMPFS
Date: Thu, 16 Jul 2026 17:27:31 +0530
Message-ID: <20260716115734.80909-3-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260716115734.80909-1-gaikwad.dcg@gmail.com>
References: <20260716115734.80909-1-gaikwad.dcg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CONFIG_TMPFS to the selftest config. Assert Private_Clean,
Private_Dirty, Swap, and SwapPss fields in /proc/$PID/smaps output.

Signed-off-by: deepakroag <gaikwad.dcg@gmail.com>
---
 tools/testing/selftests/proc/config        | 1 +
 tools/testing/selftests/proc/proc-pid-vm.c | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/proc/config b/tools/testing/selftests/proc/config
index 68fbd2b35..7dfc3d381 100644
--- a/tools/testing/selftests/proc/config
+++ b/tools/testing/selftests/proc/config
@@ -1 +1,2 @@
 CONFIG_PROC_FS=y
+CONFIG_TMPFS=y
diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
index 4e6a3e53f..59535bb3a 100644
--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -20,7 +20,6 @@
  * Test /proc/$PID/smaps_rollup
  * Test /proc/$PID/statm
  *
- * FIXME require CONFIG_TMPFS which can be disabled
  * FIXME test other values from "smaps"
  * FIXME support other archs
  */
@@ -409,6 +408,10 @@ int main(void)
 			"AnonHugePages:         0 kB\n",
 			"Shared_Hugetlb:        0 kB\n",
 			"Private_Hugetlb:       0 kB\n",
+			"Private_Clean:         4 kB\n",
+			"Private_Dirty:         0 kB\n",
+			"Swap:                  0 kB\n",
+			"SwapPss:               0 kB\n",
 			"Locked:                0 kB\n",
 		};
 		int i;
-- 
Deepak Rao Gaikwad

