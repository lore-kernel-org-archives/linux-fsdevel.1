Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492094;
	b=KGi/f4fLaou6kXrBkedHsXUvD4ZZ/jqjGj9bXcvYrLasbwy3ZOtcV127y9EqzGFfL1Y5
	 3ikmc7PqjEIyb6d2XFBKLjZAO4VWaE6XU1g/eFPg2AWQG++C9x8P2PKwLPV8iRiCzNp5g
	 Wg6RUWzknTVAvlGyoijD2mMAj7nEEG2pEZHFZRKVBurXOSGT1SD+tfvjxJWmDG5d63Fuj
	 vrRyTksyJxQO2ynu8oB7/6vVq3xT+xml0KI0HcZjF+HDGOXQ0qkS5B0jLq97huaCOkksX
	 OHWF3OylJqFd50z4COXaw1w2mRI3X3cUOBHJX72BhRu29S/6gdXQoVLAsHEjVsgPQVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492094;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+d+2w/kP1HSpx1Wuo82bePoixwqF95UhUQrN/Uv14yk=;
	b=LYNDOmKQ/ieb8EkOsOAsqOrpuTCl4owcGrUdrrP1Dinh5G/hnj92swlr23adV8wdbMkg
	 WlwB+EDbxRUdwh4q/9Auf8v9wHVSSVtcA8iamrK9kGQd/9asOVfAEhJsbHYf7E9RJdOl9
	 HCM7R0LywHileNClYOQyk4uzNBXjOCW8t/HuE/aePc8/n4YAdAUAJcIX4xZTjnygbTGwL
	 qXIi6Z4qqfQVxa7+PrSFjphGA9Z1M02cogP51SkHCK6LhyqVLO1MJqPBPkgT7o98wwAGE
	 2j99EDYsffV3e8PAWFeC3yO7X7SS2YWUvww5G9V0ycchO7iDhQ8959hQGXEtUJlygYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Fltq/LZE";
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DED60A6F66
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 14:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24DED60A6F66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Fltq/LZE
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3ada81853so4000145c88.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 06:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794492093; x=1795096893; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+d+2w/kP1HSpx1Wuo82bePoixwqF95UhUQrN/Uv14yk=;
        b=Fltq/LZEr/fWUfnOsLQk6D3tBL6ZwkW63axHxR4iInnMNMChKAn34xiYZVdxZKTlRh
         VDpd/AZSpMzwb1jhHKccGpEfSHEYqrZZahTrdQ2xfqwsoS551lXHebGu20EnskGqvvFU
         7lgRPrHpapf6MuewHtr1saEbGU48WaQ/xl8Zd6hI///4zoXaNi27V8Tkj1gCn0Nt2pyH
         iVDiH19P9naDiw9ofnR2Biro8pMSkqT4Hum/CsALabzVDRvBOAqK9PcodQyx+iGl0v6w
         lLbhTn4edlCLPyikLmFaBtVMsATzVfS9zBmBKH0IeYMhGg1qcDQt+m5RsffLX/Gc15FZ
         GRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492093; x=1795096893;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+d+2w/kP1HSpx1Wuo82bePoixwqF95UhUQrN/Uv14yk=;
        b=pXFNK19m0SSm7tujGTPIvjymwqGkBTSeElpdveaNaA87bLfK/IKSAootybFqp89HEM
         VrW8gNV++Sndny9eCTZGm1CBuHfN8RlqzgX24XBi4JjMzx6rAeCifm/Gb6dNjKhSvYSn
         mi/V6EQ8wzl720J2rKjDmfq2/q1DW9n0dXK8bnlSo8PaCnCfQUYfB4wDqu7m+jl/BSDO
         4kqWQ8SQE+BLyN58FKu6zjYeKc6IManp3LXJeJq56g0MlHLTNVIVmHf6sUkkT0WMfwnr
         449KJCB6L057B94OHn4vLoyx88SUTiWhQBD1itcyyFXvMUyqGQfk9gd0s3kqlCPLvS2A
         OWzg==
X-Forwarded-Encrypted: i=1; AL+hErEAp5+OX4cx/UGO3N/JB8RcSZ1vFBuMrw45Bw2KXYrC8jYiWEgSVMtYwORLtVAGwDHiBVrRAOrcmwsiVbi4@vger.kernel.org
X-Gm-Message-State: APuU4Z+99+DntqIFxUGpktIKlwjqILR7bCfHMe4WzkrcNAwRJw9YL7i4
	OymeZ7A1vfyts7ZXENaNFS4J63dLsOYxZTkEKmV83cCnk47gcUsgRZX8
X-Gm-Gg: AYBFou04ev3CnFdW/6ffLaGl52/604pBk+h5IYyRUF7S9jILOnjjBQ++1QKLl+tPme3
	58qYfWmeGbLmIfeAgdkDfenj76Ls/Mcdhhznb5WXQAs+vXJZ+e5K3ifoSwWlT+d1ESvBr3Wmml5
	rE4nmts0eolMjWa/8bc5sdurX36hKf1ZTdkqUh6Dfw+ginWh981m/3vDzrPiLm/pXY91t7INKAe
	ClMp736oNyKSmFiCiQP0efWKvVpQK3+JSIKGWh89QkEokAdW1XGBVivu91K27liAocV9KlXy5YM
	q6Cd9oi/L0T1A2W/1cw+71Pc7DnV/xxhcS8CDfpmIfPUgRGn/mTYzZd8N6EsXgAeZ4rylPEiBVv
	dk3x09YKhiV5B/Z/0QgxFSuK5CcOxN/TjaP5KF8ibpeNbXGVz3lje0zeaI8rUoQwmgIAppKVLPI
	GOYMOiSYlbTJoN8K4r4wq+rhcBeeCTFcayZPyQLylqYnUC2laGdTWFUG7XsZ0KFzW81xxtkMsLk
	dyO+Yfws+gOo8f24BxVpONuhv1/KcoPuqn9zQZbZG8mx0qQcxNU1uk+ktCk9rJlCPO+kR3CqxA8
	mOOtch/v4i0c6qs55lYWD+pDZ/vbHMbUy4hto/FQzjGy2x1jRNtPld4PePJ7czIpHRIHZL0kWbY
	vRn5TjldDSuO5EBRJnC5QA05o6zg5Hg==
X-Received: by 2002:a05:7022:c93:b0:176:a225:e364 with SMTP id a92af1059eb24-1b3c0342f80mr4576641c88.35.1794492092808;
        Thu, 12 Nov 2026 06:01:32 -0800 (PST)
Received: from AHUANG12-3ZHH9X.lenovo.com (static-ip-5-78-56-61.rev.dyxnet.com. [61.56.78.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm31478659eec.19.2026.11.12.06.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 06:01:32 -0800 (PST)
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
Subject: [PATCH mm-unstable 1/1] fs/proc/task_mmu: advance seq_file position on interrupted VMA lookup
Date: Thu, 12 Nov 2026 22:01:01 +0800
Message-Id: <20261112140101.647-1-adrianhuang0701@gmail.com>
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
per-vma lock") introduced the possibility of returning -EINTR
from proc_get_vma() when the VMA lookup is interrupted.

When this happens in m_next(), proc_get_vma() returns an error
pointer without updating the position index. Consequently,
seq_read_iter() reports:

  seq_file: buggy .next function m_next did not update position index

The above buggy message is reproduced by the following command:

  # stress-ng --vma 0 -t 60

Update the position index when VMA lookup fails, as required by
the seq_file interface. Also save the original position in
priv->last_pos so that subsequent iteration can restart from
the correct address without skipping or repeating a VMA.

Fixes: 5631da56c9a8 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 fs/proc/task_mmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 22361607020d..164b4efc5e09 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -221,6 +221,16 @@ static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
 		if (PTR_ERR(vma) == -EAGAIN && fallback_to_mmap_lock(priv, *ppos))
 			goto retry;
 
+		/*
+		 * seq_file checks that the position advanced before it looks at
+		 * the returned pointer, so an error return that leaves *ppos
+		 * alone is reported as a buggy ->next. Advance it, and keep
+		 * last_pos at the pending position so m_start() would resume
+		 * the lookup from there.
+		 */
+		priv->last_pos = *ppos;
+		(*ppos)++;
+
 		return vma;
 	}
 
-- 
2.43.0

