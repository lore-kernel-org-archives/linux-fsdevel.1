Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24973F7A9E
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766859; cv=none; b=srWOAW0qaqBVH62rlBTx4CQ7kubU2sp6UR1/SfbVwEEql3xS8DXkfvFQUSZaIwNaaAC4HjPFMwcYtG/tbV6ID25kyMk4RPvRlXsS40Cg7Z2y6xie+eDUbwHdKjnbaP/CW/dSUPsNv0Ts8pYYCzHVz8x7OTVvOAatG1GqH5ToIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766859; c=relaxed/simple;
	bh=qYARlwiD1g9KlG1Yrc52hSCGCDck2KV2pHVVGnmPbHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q4bGgj3tNN4itT1ng7ctnMwJ20wPphFr43ZCz+EjlyMD7fy2/Iu3rmOFmQWERMXRuinDcmrcGzNloDuJbp9LZzI0Uzf/fWL4ozc5UdFuOFZmbMMzc4raHyMdTwcOvCCp1tX/GrQZWvxPyFqcqf2WO9damwDOT+msNVWnyKOeTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z1YT9TwW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z1YT9TwW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48d102471a4so79411915e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 06:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778766856; x=1779371656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQMhOfU2sGITxZKT7MrmZ/tUUqpzfrOYg5nLcwr41Pc=;
        b=Z1YT9TwWe8wIo3btQW/bZt+gjXbvK3n1iEvNURXqGf0VVr8MNVw4Z/ApOmvlWFlJdJ
         eu1ml7xjd1qtNXVMKEoviYNdmko8nVgkiH21dfqc0ymKNbybLJkbVMCN2gPo/zfUPMXS
         rSJe3Zk5g74dPOyRUps8LT5LQOEq3YXbfj5fJcOdrCXgQNU/dSvAOIjpVWy0ac6aN+TD
         sArVPF+Mw17YmK249VmnqK/9106HOwzLq5w+j4Tc3einLsS/nDOgdN7vQ8EHrrqM0xwj
         AwThIR6zOKTuodsaQdv0N026ANvHxu2Qg5Ko9bupholaWt43frsalHn8SV+eGHGCYCB+
         aBiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766856; x=1779371656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQMhOfU2sGITxZKT7MrmZ/tUUqpzfrOYg5nLcwr41Pc=;
        b=Hv6gQaLneu4K4Y+A559u+WnMS82Q+UhbquWCCVAu2md1gxVOvG8lKypbEuRMtT9wHU
         319+cAS4syeRMNvRdMXRhwObarIcvuk2VcXeq2xIwHNgjUFR4qT1UGsybMbrLqc95AbB
         RsJR8zyAC82ZPrR25wJfjfHudYlpHV2FntMsN0ggT85NpRUiSCeQ80sEiXSRkkAyjKRU
         U6vHx1ggMDl7/WdKS2MFpuI78RV0Bgj9TB8UruQsjr6iQtNK23mW5YmqZ3ziDeBGEOgt
         Lxroi9A1VOW8ZRCxorVkENf9kMcSdcLkclWFi0ez2V4KXALKecVoVK9TLOp7VyAdaYsq
         vvNg==
X-Forwarded-Encrypted: i=1; AFNElJ+gfXQ+XeN7QyOvbTxFwEE7MPJ7Ra1T6zMnAl/1iNQD/U36VIlC0WyhEcBOIZgAejRz8MHGaLrsa/wkSRNd@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5iPJfe2Me1PXo93DDO7sSN39s+8niKjVMaNIBTQj2d4nt+CX
	o+YAHx604FGfa//3EMFE5GwwWNZGileQJeDKWU4x2lRyii5mvvFHePXc5Ml0oJKFXO8=
X-Gm-Gg: Acq92OEIgCy4RCxss7F//i4zANwo++QtMEYYmaFI3wgWOK77HuBQs+0UhgfLqbAgMSt
	vADUGCOy6YiKGOmlE3I+5bFLI7goVmXdrpfl8Dn7Ae2L3wvASDq/ISEoVarR7jqIygPqQlIC8Se
	eydbSnO0gcrtBMon28Bczppj2ko671/5vOQlwBTpJdJMSHJoFzBq+TX1VgMDDhbPuPW55xA1xUW
	JRXO+pC9hkRITQrUB13QmOPYWMohXs5rGaKKBBUJBkEk7pXk0n/foj74WYVFlu65kxgQZL2US/F
	N5EWJws75WI5QqRhJtTHlagm5sHYNYRRfHbtObKIybqYWLgXnFjpLmVuy9P7yjFQdOsvPJFfKFz
	i7NKMuFRP6JlYO0BCCBjUc8e2l7Q3ylRjwQj17mJ0D/KfqRelB5TSbgwYLjUEu2cgnPMx++ANVE
	UOO1+lRMOxZ9xiht/mYuc5J93zILrSnWqFfdEBUVk2u2dyftM=
X-Received: by 2002:a05:600c:4e02:b0:483:8062:b2f with SMTP id 5b1f17b1804b1-48fc9a06f56mr110517305e9.6.1778766856512;
        Thu, 14 May 2026 06:54:16 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da15a5653sm7363584f8f.35.2026.05.14.06.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 06:54:16 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH] ntfs: Add WQ_PERCPU to alloc_workqueue users
Date: Thu, 14 May 2026 15:54:08 +0200
Message-ID: <20260514135408.297659-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The refactoring is going to alter the default behavior of
alloc_workqueue() to be unbound by default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU. For more details see the Link tag below.

In order to keep alloc_workqueue() behavior identical, explicitly request
WQ_PERCPU.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/ntfs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
index 22dc7865eca7..3a25e4dcfba4 100644
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -2628,7 +2628,7 @@ MODULE_ALIAS_FS("ntfs");
 
 static int ntfs_workqueue_init(void)
 {
-	ntfs_wq = alloc_workqueue("ntfs-bg-io", 0, 0);
+	ntfs_wq = alloc_workqueue("ntfs-bg-io", WQ_PERCPU, 0);
 	if (!ntfs_wq)
 		return -ENOMEM;
 	return 0;
-- 
2.54.0

