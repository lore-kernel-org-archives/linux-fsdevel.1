Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F423B14D6
	for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 17:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344731; cv=none; b=K1cIHGIDO12OXu7VvmI+SpQxFKyxNg8ODmwBf1MMKFSgXWAF0ipKWzZszZDDVzIo7oT5BFtxakvQWmosPSERSxNarUuk9fGhmlkqCK0wLuUz7+IL93GG+cIvCXtv4a6SjDTa1vkCclOZNUuGgaABLnVJvCpdx2NM7m6yYbduemI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344731; c=relaxed/simple;
	bh=8Y4pdoO8o6DG3dxU9nQ9kNWZgM1e4m0YatPzcl98+Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kHlRVecRgr+/RsiAn1/0LxbZSya6VFskiEThgnDgvNNWw5NFHjiPYgs3tFirtwa8T4NTsh03VplyX64sk/vnCt/12NU5gxt2vNy9lSZekMU49omS1ZdxfS4TETmZO7scllAVjTnn9+4H2biqS2mGJf6ebMI3g3Y6ttvEbiB0dA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=CdyGEHLf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="CdyGEHLf"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f3c616c84so32836785a.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Oct 2026 10:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344729; x=1792949529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=heYAltlYf2s0SUcvKUJj27EViC0/q0e21YMnkOQZEqI=;
        b=CdyGEHLfUt96NQyLg8/tLKLafwMDl0BRAKhfJOtI+mKRuxsI6qFRgw0jCpKh1D/Ofp
         IGhp7ZnjZGZ6mqxi84CPMPYe2Ju4/7mij+aD+pgTL5aT/HUIfc8qyw7YBYwwPnN1EocB
         SdTAYS2y5nko74nw6YwlZjWw0Vk2gzoLOQjAWLpqVdfJIws0J94SOaLDB3byBkJWiMER
         rHGOZW2/qmacgnTSHdoWwY7OJ22kCK0QEpvymGmAPf3pmfmpNWWfe9Zet2oDpYHayb4Y
         34O1QSWZhEBd3M3jFmKjkJXkER0iUBb+o+Ut/eAjjCpLQvfJUpGeD4MJbL2XzAc8ZH40
         WkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344729; x=1792949529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heYAltlYf2s0SUcvKUJj27EViC0/q0e21YMnkOQZEqI=;
        b=MZkhAtqjSC66ofB0jYuwkhKRd2S3NdNzV5tK6A0y714rqd2ylmDTvtbYXugyhpc7D9
         9pReryXJ5kIHQRyuWti2IA7yMGTX9khMfpoccUswVm2EHOZYRayLZoGRU3JLLdE3ZbTL
         gd3hYtFM9pX6jVyJIax9UErRYqMhHDrJ8w0B2zzSEGn9Sl/EcNBCvATckjXDKeAX0ASG
         WxRYlVtLWnFpvkFNQl7kqD3F/ZZxUjUCl0jwCnlgBu/r6E9Le5Mlit/BEf3On8dTU+mQ
         vd5nh9BM+OzVOL3ZKPwKNQHPb8uZk4/xBQtp3mKLAGIpDCwb6/WGd20k1HgQylxkZ1Ab
         dl3Q==
X-Forwarded-Encrypted: i=1; AKwUvByTXPioNc1K5vUtXeEn1nR63x1trvFLEbHmzEYfIWC3D0aAcXM+tt0pnzRWqAf7VvTVa6c80oL3D2WCN9vc@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/KADyf8Ny9lcEvn4sRGAp9TMTqGaHrEAEXX5mw+z0Qtuqa6A0
	KRaNoH5GYriU4+TNhKbTEwkaM1KWY/85sAjbVTzuhz99Db+Xn+1TsVLvx493NNh3+u0=
X-Gm-Gg: AYBFou3LGID+lyxgFnjAVhiTEg9BhDIxZHGPVkaWCxr/7iCT0V9l15jskwY09iCKpRK
	z3G30q5BRIXCJOqSb+LoHkKSKbZTZKj17O2bryG4j7qiNapOZE8tfeHiRbSn4yI95dvs1rD1HhZ
	9QI7w04cMslV9cFUrYpnIn4mYH+ztWDMa41o3xVdpCNj06ooxFH+QU3zw2E7HF0Bgf7YDfF5xEp
	W15r+uFDSpezxC1QJMDQnCFPhVj0CUC1xsDlMcPSww4AW7crb3U1M+p6BKKI/yWL9I/m2NtxT86
	j9KOMiR6N01Wzp8jROZXRIK4ocW/fPsDpnDuHZH+nylqko7+NCGyKMZdNHG6N1Gey1ZWjlF1yRc
	ZiIKHIUD/jqRL3VpDO26J7JLeyrVWOqGZZqBPC4+EIRE0Clcfx2WKKmkaU1QjupZ5qHLzBjSbF0
	fC8w2Mkj3jonS7OVi/Wid9esL5nNEmH2BB2EoX2zlJI1QXWnSzIEEzNhWmGQ8/J+U2UEG8gDmY1
	DF/Q0ChkNBPybk=
X-Received: by 2002:a05:620a:3715:b0:93e:c12c:9dd3 with SMTP id af79cd13be357-93f29e0afd2mr914791385a.83.1792344728950;
        Sun, 18 Oct 2026 10:32:08 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a16950dsm746673585a.15.2026.10.18.10.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:08 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:48 +0000
Subject: [PATCH 06/13] MIPS: use cred_ids_allow_sched()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-6-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=837;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=8Y4pdoO8o6DG3dxU9nQ9kNWZgM1e4m0YatPzcl98+Nc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHZf0IHNIwf7wrO6Y1j4UwsKUNBcMOqzphoWpEgtgup+ODegOLhRBlu/opGGICZhaQf6f0L2pAT
 YdUYU2k+HeQQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The FPU affinity code has a copy of check_same_owner() from the scheduler.
Use the library there as well.

No functional change. Compile tested only.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/mips/kernel/mips-mt-fpaff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/mips/kernel/mips-mt-fpaff.c b/arch/mips/kernel/mips-mt-fpaff.c
index 4fead87d2f43..1ac86a897956 100644
--- a/arch/mips/kernel/mips-mt-fpaff.c
+++ b/arch/mips/kernel/mips-mt-fpaff.c
@@ -54,8 +54,7 @@ static bool check_same_owner(struct task_struct *p)
 
 	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (uid_eq(cred->euid, pcred->euid) ||
-		 uid_eq(cred->euid, pcred->uid));
+	match = cred_ids_allow_sched(cred, pcred);
 	rcu_read_unlock();
 	return match;
 }

-- 
2.55.0

