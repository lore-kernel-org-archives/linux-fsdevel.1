Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205374;
	b=T1VmSNZ3lT1q76b7QDWca4sJ7EfWUkxG/Q2EoDLarnqeqn1UzYVTCDTlbQtYdW18sq6I
	 KdqHs2I4D7RcV8fOXltpFP8WYSRncmarryz6Cc45ArENOr8UwshbsdCU6qQEEXB/LN80V
	 UL4Yndso9Edx8FDAUBfaHWjWmY41Vt88NRoeljlW5S0tG3KGIPwBuYlYOFhPD5XU0Wfwv
	 BSRg42DQyNB/J1yvAWsvwzopoNTT2FGaPmmsiElj6mZkW1fLHRsNqfN7DyzEN2au1qpTK
	 8pcdFUzFUoxkBp0rHVwjF0upDY9cKvB7gNidf7iPl7gXWh3O+j5sFL5BcRcuuHrvwWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205374;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j18R/u9AFwxow4H4xAXgdYr2II53/V49eYYOKd0B+TM=;
	b=hnqepwgsF8KY57amVbVW2aENxsMcbNPX8JPJI9g1G3sw56YdaFKQa2KYXmi0MtOBNoUU
	 MlC9+sDlyBOh0J9iHy0lXrb8jpYs+T6h5vK0gzpIp2kylq4k4Ue3/jHkmyVhaWZd2Nn/D
	 WZ8mU3Z9ahTMGIHKQBQ7iyvrwxDe6sm/PhoZhUcd+F/kHTemuULov+bh7A9C85O540SIl
	 mgjFKz1pV6AaZejlfT6CuV6YydH90Yh3rpPHj0j29Fys+dsmvLMRUFbM1GbAgGi90cdFJ
	 Lt8rOwRQBjNJGJIl8FjdESr4EqWIKvu62qBuB+4zHBcMAhJfHOKYSc2Rw4JBtsGDoYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o7gqYsmt;
	arc=none smtp.remote-ip=91.218.175.18
Received: from mta0.migadu.com (out-18.mta0.migadu.com [91.218.175.18])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726B606A31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 16:36:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2726B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o7gqYsmt
X-Envelope-To: linux-fsdevel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Jkj1eD+MmhP3VhWyT7x0V+pjjQ5A/qULoxmR4y16hyU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793205373; v=1; x=1793810173;
 b=o7gqYsmtdEyGglZ3DvThu8BiWr9fZtcCrBqte9bFtrxhRiU74BpQJb7c8+3FGKLIrlrAXRfw
 uggBvhLMDtifhYHpTDcHFUuT+8qo2r2hLgxb5cqnLiGmjGUMCH/0iBhlU6d+hq+Xu9wQsyb962l
 S08mQQc7dx96T/UnWX1GxIVs=
X-Envelope-To: linux-fsdevel@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 0a69350423016007;
	Wed, 28 Oct 2026 16:36:13 +0000
X-Mizu-Trace-ID: 0a69350423016007
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Joel Granados <joel.granados@kernel.org>
Cc: Wen Yang <wen.yang@linux.dev>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 06/39] sysctl: convert core table bounds to numeric values
Date: Thu, 29 Oct 2026 00:34:45 +0800
Message-Id: <667add68291d43432ff3bc7323d265ee74f3b7ee.1793204511.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1793204511.git.wen.yang@linux.dev>
References: <cover.1793204511.git.wen.yang@linux.dev>
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

From: Wen Yang <wen.yang@linux.dev>

Use numeric bounds for the write-mode table and static-key handler.

Suggested-by: Joel Granados <joel.granados@kernel.org>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 kernel/sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7d0bcd2b24ef..ab25c75cb3ac 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1348,8 +1348,8 @@ int proc_do_static_key(const struct ctl_table *table, int dir,
 		.data   = &val,
 		.maxlen = sizeof(val),
 		.mode   = table->mode,
-		.extra1 = SYSCTL_ZERO,
-		.extra2 = SYSCTL_ONE,
+		.min    = 0,
+		.max    = 1,
 	};
 
 	if (SYSCTL_USER_TO_KERN(dir) && !capable(CAP_SYS_ADMIN))
@@ -1375,8 +1375,8 @@ static const struct ctl_table sysctl_subsys_table[] = {
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_NEG_ONE,
-		.extra2		= SYSCTL_ONE,
+		.min		= -1,
+		.max		= 1,
 	},
 	{
 		.procname	= "ngroups_max",
-- 
2.25.1

