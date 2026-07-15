Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488A936E48D
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 14:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126221; cv=none; b=ML/b+lENC7sACf7H2r+/uINuB/Z/df8VBkLkr+iLj9SwN/tIfK4AjHOarkf85FboAeUwkwhusoEUGRHc4wbQx3fJp8OkNDebAt9cJlQ4zCOhA37xyCeA1Wz3rsYXUXnjLgeVVUfJMcmzYdIX5yIDOQ2QV5XULlrKg0CaVl01lNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126221; c=relaxed/simple;
	bh=sJ1lnAh96oGS6PkaWKwiWo28un4N5cLDvAhC1dHUPHM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HaSlfVHm5gmuAdkFLh88skblCnk7JvR4kqM90GSBZ7WAyPD2g7GjYb/T+zzW5sa78j/NqU9mfYL9cqNTCZhbzjiII1CwQuWJbf00a93/dMgN/pwwtH2n0ofXjSgkCK30Tdl1B4fQUH+h4i6ntGCCnQe8t0cPaf1wgapp+b61wqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qpXY+2OE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qpXY+2OE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2590276a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 07:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784126220; x=1784731020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rY098vF9FzwngbPPwA8WaV8xoRoA5ppO3RBZ4W8bTcQ=;
        b=qpXY+2OESiGdC4fvRezO8G5xcxnyn7a/IwysE9sgQKEgLYA+jFWBRTJ3vktwKTXLWz
         bnxzpjcK93jJhZKM6xsxdLgymq4l40TlHVOVLyEXCvfSNpOncZUP7N8NV7hiVVQx442u
         nLe8K88i29Stwi9w3TcSP6aewEgcPKKwf/db0i3bBqbpwr0+XeuJqo0PpAQYfFcPlozX
         tphDsHxSTitZoeiaU05SeQuG1+vW9uJ4nDkpORQZrZrJTp/src6xQJwhfdiDCtYgauKr
         WEVNBpFeEOVQOWaH/AguCYsjLhFRb3yV19khgd/EhdrczNSc+aY0RN42FY8TZG61mmUe
         CuWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784126220; x=1784731020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:sender:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rY098vF9FzwngbPPwA8WaV8xoRoA5ppO3RBZ4W8bTcQ=;
        b=YYc7HxIMU0wPz8CJMc7DrxYHbR/QMFxea+ZzBDmiL957zHwethMDigjNH5cVld+ovK
         X9QetjeXXLFOctAMZSrW9Ky/g/i6Q6JW9eCnUZFON4MRDd2+WcXaF3ZyhDXJeG9N2nsq
         1QlBNwCbtDPsCbUPzXJIOj8WMTQrpenlRFVSLbqfsy0Yw8/BXZ9tU5zpkHVl8iv0legP
         5nW1L9bHNRHIbCLIFVmyRBGmIEVKbZpbs11zpjQlrUxF/v51eR2HGUtjJ6trlspZ9Fi3
         n8m+VXRnyM/Yo3QAmq92L6YzZbaDqak+yDhh1iQX7P1nXIGo/bpu9nruisZ01Zgmdnok
         X1Dg==
X-Forwarded-Encrypted: i=1; AHgh+Rqcu9oEMiEc2PbL90feYsn1W/8P392DxIn3DZm/UpotBvKwSBbngGawPpGI/O8lB+6+j0dt6e14ajrFEcTy@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjm+elxTgszZSQTHt7IQUkkzrVUIVfKpFRjU5UrVDQesnYGQjv
	XLrkVSSXLPL4EjqiRliOIJKbdU3vdWMlMhnAf6aWbKephbKQ73h5zSLg
X-Gm-Gg: AfdE7clD+ke75Ojg8gHHK9y4ugEVCwANOAQYjoPg6PYTkec+btlMxJWR7Qph3BSobZl
	IM63gba33pd7fx00eqtaCe4cTNAnnuAqqt/GpA92Z5sBioTuvXnsWvx4vhC/WNlAcEhQal8vZvl
	My+w84IkJQJ7Js3EhkHakBWIqqubb5Lm538Zpv6rAbgi4Ot3sITb8uamcpAaeSrfb3y9kLmQBE2
	EiYMQbbk8Gs+XHVs6BC1aW/mFHMYNvy5oP+HDJ/734kQCOET1lISHl4OgSBixmKmyIu+HyrcsH+
	TPvqnjPmAjsZaifpiuCtdK5on1tKTudng2NZogo5vudT/vaIvuoLmKnngHDxj8+ORWY5E6km8/u
	jDUVu8Jy5E86alCG56GxU8OFb3jNbR/xbgNM+EJGQ/ok2CYvIGGA+bHKN/7Iaxd1rMeRhqZlrrj
	yzeiALgQzC2DzJjWAIXk8it54an0MSnpdIaMBC0ybB0cJu6anRXUg=
X-Received: by 2002:a17:90b:5863:b0:36d:b424:4f17 with SMTP id 98e67ed59e1d1-38dc73bcfdfmr16065194a91.1.1784126219729;
        Wed, 15 Jul 2026 07:36:59 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:90:2db1:3066:c473:74d2:497d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fd3e9sm2020161eec.1.2026.07.15.07.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:36:58 -0700 (PDT)
Sender: Deepak Rao Gaikwad <deepaksraog@gmail.com>
From: deepakraog <gaikwad.dcg@gmail.com>
To: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/4] selftests/proc: expand smaps field coverage and require TMPFS
Date: Wed, 15 Jul 2026 20:06:42 +0530
Message-ID: <20260715143646.15828-2-gaikwad.dcg@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715143646.15828-1-gaikwad.dcg@gmail.com>
References: <20260715143646.15828-1-gaikwad.dcg@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gate the test on CONFIG_TMPFS in the selftest config file. Assert
Private_Clean, Private_Dirty, Swap, and SwapPss fields are present in
/proc/$PID/smaps output for the mapped executable page.

Signed-off-by: deepakraog <gaikwad.dcg@gmail.com>
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

