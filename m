Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998110;
	b=uR3JNlvZTev8SIBmBcZYx/VdSIWie0itLpqmJe5Odp05piJGnhUc+DoP14mzAW76gve4
	 +hHB+zwp8iBU/OO/Nw8EYVl8X05kpo1pgBt4f1Q0vZT7KPLzwGNaKjpRcn+Ji7fSseXeB
	 BKVb0JLCIHkZBkfuqoknit8CSo/E0cJvYqQbD8wIskAWgZ9o/zGU/DV/N2p6YiI7IWwSF
	 V+vZhZOrfGSnqMhAaUSGQzc9ioj2G81rv2D++GrB5YGx+F+TDW2sMUF+p7TIxXsBjePKZ
	 Cei9P3DqH3PMJ89oRuzXVER3sfb8+NHwt0A9GN3zXEWt4d57cKh0CaZPcJt/nFOvXwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ul29onCED1G/GzZehDklBOv4YKtGEiuVI0wtuD2b89k=;
	b=vrNCmCgZNXqX87WQpt574vyiO6+PPAeCR0O4GW7vyu1Kl26BCeCKN/sEcXOoz4rlmPSR
	 z2cb0Y12cZFsUKQ1dvcPU2aZIi5IDNRZqWq3lj/TOzsbpv3wuaxYf7UcPIYLrmSNtBMkX
	 0w27ytY5yZLEWhZ1dzGISSVW5jlClNfKN27P5cn03LBf4DqdyDm0BIO74kq+ke/d+xk9T
	 FQ92XkFwb5AJZuuuft+gNV0Qym+smkwuM2xnyNYDo4US7oPp0khZ1sPDXpYBh/aNt5Ndr
	 lqhExz4dRDOpNZujL2RO+tNSLrPO2zBkFNSQWLTJrLznKteNMSdA583+NxjPllSBHrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JvAFOh82;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B448606A320
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 10:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B448606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JvAFOh82
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae1da332bcso271625a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 02:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998109; x=1795602909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ul29onCED1G/GzZehDklBOv4YKtGEiuVI0wtuD2b89k=;
        b=JvAFOh82Q8TfZvVvLezW8C8XFuRyy6oqF1g2WBHSOGy4oAVbiZoUp7n3tgRIO/wLAO
         NRspmhK9hspV+881yrCryQnkWhtxQo13l/Jg6UNMDbzgeqCmXAaUy2Di2yitOlN9nvlq
         suLloRigHHX4QmUzCZ5tqUYl5gMHkicdCouth7UK1s3sW0A26Gyxhfzog0OkCJWssv6r
         VV2XwQ0qwp2CbovniJdno35V6VGPm+6gNa2VDC4Y9ZD5Fv3gzL2lgKgwaBetK0jm0vDK
         JrB0ucV8e7heJnaeMjxH60YI37HGYhA+DydsT/UtueEDCINpTxKY1RzUTD7DLvMNo1uT
         D45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998109; x=1795602909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ul29onCED1G/GzZehDklBOv4YKtGEiuVI0wtuD2b89k=;
        b=KMaxul1Emezo4vAT5mVrc6HgEM+KlQAbrGfvyLGH0SAqttoQkYT4pDlTf3gFilkkhD
         eYdRmKUzXXWUtXwmpefIsuZjCXcOmETY8leRCDVf5XNG6NvbiD90hJpMuP2fTrBKmv2S
         sbX+tQEciL4LjBoeLC/47gk5f7bNCTAMq5oAWw1cnNyn9AXaEoVa+BGqpZ0xtAaUzlm7
         1lCeA4wGEra9wDGf4AEB8UKiFVf7vQ0VyBGG21rRAtHnHQtlkShY6f+P4BPvfqRxc5ln
         +c76sMpfKkINUEzxnwhg31V+qlXmQsuuCW2dwnO5XtqT/BEXrAehJgxlCXsNi4ofFn2R
         pTfg==
X-Forwarded-Encrypted: i=1; AL+hErGY6uHccjJDSJ5171M2+zsPRLMKHhEazciHoU5/RXfWEDL/CdSc8aIE/irDpToqkC7d2voXJobTIWIsRZOw@vger.kernel.org
X-Gm-Message-State: APuU4Z+bUsJBy3Oc1hdhNWkF+qGOgA5/d0jekcRdTnPcPbqPYTTWdiPT
	XGZGLrbnX7qnHOFh7HbFE4UBYsg1HQM8O40loghO9bA59JNa3T2x2qNb
X-Gm-Gg: AZFdTZfws2CXC4jToBHfZkkxAYH4Yq8G5kro6uu72s0XHTzYglPzg1L1HKqp/eh1K0b
	52rCx41PUqmaRbgDfJmUrep2vmZOAQwI5l2hGzy/1tJ+5RmnZYPZOpIjkEh4Jn+Md+gKfxMag9R
	2JdZIeOQgIPohOyClV8fHn86cqgBGmI5+uH1scq95n5/2Ize2/LTLK7Yi7blIpgjT7THkbcN/wJ
	hNHMt7DER743ZIb12jZXKdOCG7oukd0FVVpdLttvrqh8rItDG+jOwIf/yzfF/tWtYZIkI2f1YpR
	5oXrd1K3Fq1HkgFx9aGYGNT5CYpOvcvsAGx6lN6g9WvR6M3L3vinSx8LN3vzYQUtOxb7Y4kA6H+
	CsYi2YI3xuylbaZkizimHqbmk8S88VGzx6V/TDmMVlyImh0CbCkvzF1eG/lczap3Zc4lmzTMLv6
	w5IHzJpSAhHdKaQklIPN+7woUk8StqFBPFRoq08EjNE2f90o/Cmf5f5RUFziICDsA2vnoJdA3QD
	AshOqMcZWaKrwFp92e8KAJOOnLuZJHbfIAMhqHnNCOU3PS/gluWNNOM48sN+jyCGQ0v3pWqFZWR
	kCQWC9heiFod8s8yT7EoEBPWXuBg4tTxlv8l3nCzGg8IQ10QFV+3rzOsDU59105hvLsxQTYGLxT
	6OJWQiBxGP4KPM2YdleSYeTdXq+QeKe/Irnl2gIYK4+3m
X-Received: by 2002:a17:90b:39a8:b0:3b3:b0f4:1beb with SMTP id 98e67ed59e1d1-3b3d074d68emr2305361a91.16.1794998109533;
        Wed, 18 Nov 2026 02:35:09 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (static-ip-4-78-56-61.rev.dyxnet.com. [61.56.78.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3d1acd118sm3757904a91.12.2026.11.18.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:35:09 -0800 (PST)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: Suren Baghdasaryan <surenb@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH mm-unstable v2 1/1] fs/proc/task_mmu: avoid spurious seq_file warning on interrupted VMA lookup
Date: Wed, 18 Nov 2026 18:34:21 +0800
Message-Id: <20261118103421.776-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
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

Commit 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under
per-vma lock") introduced the possibility of returning -EINTR from
proc_get_vma() when a fatal signal interrupts mmap_read_lock_killable().

The issue can be reproduced using stress-ng's VMA stressor, which reads
/proc/self/maps while concurrently modifying VMAs and periodically
terminates child processes with SIGKILL. The reproduced command is:

  # stress-ng --vma 0 -t 60

When the VMA lookup is interrupted, proc_get_vma() returns an error
pointer without advancing the position index. Consequently,
seq_read_iter() emits the following rate-limited informational message:

  seq_file: buggy .next function m_next did not update position index

Save the current position in priv->last_pos before checking the VMA
lookup result, allowing it to be reused by both successful and error
paths. Advance the position index when returning an error to avoid
the spurious warning, while preserving the original error handling.

Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
Changes since v1:
  - Simplify the error handling and comments as suggested by Lorenzo.
  - Clarify the fatal-signal trigger and the cosmetic nature of the warning.

 fs/proc/task_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22361607020d..564e52f7ddc6 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -216,16 +216,17 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 
 retry:
 	vma = get_next_vma(priv, *ppos);
-	/* EINTR of EAGAIN is possible */
+	/* Store previous position to be able to restart if needed */
+	priv->last_pos = *ppos;
 	if (IS_ERR(vma)) {
 		if (PTR_ERR(vma) == -EAGAIN && fallback_to_mmap_lock(priv, *ppos))
 			goto retry;
 
+		/* Advance to avoid spurious buggy seq warning in dmesg */
+		(*ppos)++;
 		return vma;
 	}
 
-	/* Store previous position to be able to restart if needed */
-	priv->last_pos = *ppos;
 	if (vma) {
 		/*
 		 * Track the end of the reported vma to ensure position changes
-- 
2.43.0

