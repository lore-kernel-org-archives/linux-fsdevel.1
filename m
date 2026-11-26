Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.193
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668756;
	b=HPdrgieTyi34cR7yhZwEGrOPr3yvGsBZB3NiuEIF/LypfVJFRQ3ub6j4DdNbuWsg1NeQ
	 lFU9AoDsGfyGaygw/xIF58t3FqfJSK4CKbR7Mt0wYzwAgaRQiR4TJ9/s7R1qoYWupx636
	 izREXSmi28DCIdvLcoKNlCoRSDZsb7qMqO0AN8LBHWTJZn6OIn8ml+SSIdIllqhY4WaFo
	 q7bwKWgSLjJVibexA+ezzS2oRzM45LWSHpJNQMOJofMP/YCLzA8Ma9tscrd3kTjR4UzRm
	 mB1+7jNRmM4IPqXqcxD7q1/UqceEGZGMoOdyMShntFiX1i2HbUMUF+krplQ6QTmJ0GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lqulBbTwbeeixwOkIu5Oj5QCzLuwttc22xt7NXl3CCQ=;
	b=D+PtPqZt0LA2CuT2YnLYCUpaQj43ownSqUVPanFGqDJel4G14R+N63BV7xMOfXFxWpQR
	 Ly6S2qP4mIL7hdUnO+5YvT38Ojdfwj1/k1tZfM+RGk8p9c1uTGYsH/NhHSYbB/qZdcGx3
	 yiQqQg9JB1qE1fHqiljWTMfGD8O+pewdBnABRf4tXdN1yURcU+8XBMo+Ey8c5XBuU0rLx
	 1lvE/I5/ohrdj/YXZ1iZuYbGatV1xQ97LjunCS8kY4HlmfqTgYzIl6asJmRyePuqaJi3g
	 OpRN4eRwo0KzbdWU5nc6mlPeNf2gXxdPFRZCmt7dLQWF6pNN/bMrK+OrtHQ483iR2MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvZFstsL;
	arc=none smtp.remote-ip=74.125.82.193
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893DD606A31E
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 04:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893DD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvZFstsL
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-3869f03af6aso5776617eec.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2026 20:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795668755; x=1796273555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lqulBbTwbeeixwOkIu5Oj5QCzLuwttc22xt7NXl3CCQ=;
        b=DvZFstsLLK+1xG2KigY2VDKpJPTRqwgiZVAa8LjS9LWMHgwIkWFfzK9gwhucuxJ83h
         u8PcYAek+ZQP7EgnB0jubD3AQayrOoCUq+ot6LSO+dJHlWbIMkvCDWgPsSqydJ8zverF
         PlBiZSYhO3SkLDB4Hj90SZuhvGevAEzWBmYnuREYnm0Vi9mmlvYgKnMcfRxBaF50P96/
         nAGrjcxf3wPQHXHJtj4tQuMP4URAiv+T8ou0Y5tdou+C1+gGde8GtjxGuDUWCZ2CLMSw
         LKhi070BRgNmwzwYeEIR4RqeJnvKe2bYPy2PZN6iJcEqreKL2Ea2Iipr25q3p+Q+1HbX
         VN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795668755; x=1796273555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lqulBbTwbeeixwOkIu5Oj5QCzLuwttc22xt7NXl3CCQ=;
        b=1QwHIbgIg3QB42IzZuQUF1WKIBXBZYqzakhUgtP2kWbkgqc0x5zI8LP0OtMbRjy0QW
         VYO83HGbL0tb/Btd6SkRiaBRt7sGUc7T99wCprxN2fa6bKckrxYAam6r7llWffcf8xtw
         cQUoS8B9iJV6k2sPc++V7wxxmPcJBvK19P1UA/ttbkkNVAvdKupJ9jkJTR7rXfGnylQ9
         2uVUSyuOVPbaWzhacihl8KL47FvwhR+lnbC9SSWg3KsSfSFzl4Go41qFCduSiLlQlJxk
         fn3e68MeGpA6vWjVDrs/9FTuH2RO9iZbkO043LOIiDnCp0VD3++AdJ17ZeONgsrG4q71
         Cong==
X-Forwarded-Encrypted: i=1; AL+hErG18WcrIsMUuJs8VYXhnIrDLDtl9l62L0tI1sSWp+oIc2bUIP4uHgqgkDoLlGrWXhsh+rNiWyB1icAL20Om@vger.kernel.org
X-Gm-Message-State: APuU4Z9y5wem9IN08LJ2DHB5gX7BOQuMJDGe9fitOIr2UQpgb/P0VAjH
	a3yMOm1fL/5xONmZgll53j1fxEUNa2gS8qkbta4vpUab2AnTmGe3HW4H8Zdx9UQxnfG+hQ==
X-Gm-Gg: AZFdTZffr+SrjWajpmCg2h8bah1VPFU32vR4Ab8GyQQ4LzE4FigxyxBRX1ElzAoYi34
	XIhGKKrutk6x3mQ+sJzer5ycfTj7Kxo2T/afRPydfXqdOjHxWwKTRXphma3ju+irEilnEmcZyay
	t9jifFw5DoQ4ywPuyi6rwlx4nuunV+XLZ5Fbo8J9dwbGoZxmzlSjut4+ZP+CDvL8qLJfIjPrjEo
	2/sDKWbq/4NY6YIetZqE80prP6EvgYeooDu3le/B69tc4zVBMKaUS0AN65kinWHSM4vSp6POZJ3
	T8n2yShfQeoZVJjXy2HZFaP84Rj7Ysb1dUZXY9g58tTTiQC2en2huwzlqXcKp/pzWsqtl2Iuh1H
	2k94YrALaPTCUX/XJ0UNY6t62ZpY1uDWbhbuYSv8jNb8f9XVnN0FjzlEYy6C42KIkEwt5m5Y6TO
	TsLQ3b1Y/7/fMIBIDyIyPvN1nXAWdvIxtyH0r4oucldoKbEpOgSwuSorJ3anbW071x1ngOFSzD7
	SnLKkeRSA3DXFtb85XTkjKCF40YhQ7i0R4ZvKfnFyNphThvrXswFrK6Rh2e/qa6TWUwSvJ2EhCT
	qetot/9dQnBVM0j82oOM0cy1UMfgbI7NM+GporMsVrHbosx0/Z2QFeE5aokYexQHd//lcdzVrCO
	j9mKhsqHqX5shCIVVgGHHQkrQNmYj984Fa/44XwpAnzn1HI+pnoOAqE/Wkadt/A==
X-Received: by 2002:a05:7301:a0b:b0:386:a416:6c91 with SMTP id 5a478bee46e88-386a4166fdemr14329337eec.20.1795668755200;
        Wed, 25 Nov 2026 20:52:35 -0800 (PST)
Received: from localhost.localdomain ([76.33.234.50])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm31450572eec.18.2026.11.25.20.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 20:52:34 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org
Cc: adobriyan@gmail.com,
	jannh@google.com,
	oleg@redhat.com,
	jack@suse.cz,
	sforshee@kernel.org,
	me@black-desk.cn,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dennylin0707@gmail.com
Subject: [PATCH] proc: also check the opener's capability for oom_score_adj and oom_adj
Date: Thu, 26 Nov 2026 04:52:22 +0000
Message-ID: <20261126045222.20770-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
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

__set_oom_adj() checks CAP_SYS_RESOURCE against the task that calls
write(). A task without the capability can open its own
/proc/<pid>/oom_score_adj or /proc/<pid>/oom_adj and have a privileged
process write to that file descriptor, for example a set-user-ID
program that inherits it as standard output. The write then lowers the
value below oom_score_adj_min, down to OOM_SCORE_ADJ_MIN, which the
opener is not allowed to do.

Require the capability from the opener of the file as well as from the
writer: check file_ns_capable() in addition to capable().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/proc/base.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index e6d54193b9f5..42e4645899fe 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1099,7 +1099,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 	mutex_lock(&oom_adj_mutex);
 	if (legacy) {
 		if (oom_adj < task->signal->oom_score_adj &&
-				!capable(CAP_SYS_RESOURCE)) {
+				(!file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE) ||
+				 !capable(CAP_SYS_RESOURCE))) {
 			err = -EACCES;
 			goto err_unlock;
 		}
@@ -1112,7 +1113,8 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 			  task_pid_nr(task));
 	} else {
 		if ((short)oom_adj < task->signal->oom_score_adj_min &&
-				!capable(CAP_SYS_RESOURCE)) {
+				(!file_ns_capable(file, &init_user_ns, CAP_SYS_RESOURCE) ||
+				 !capable(CAP_SYS_RESOURCE))) {
 			err = -EACCES;
 			goto err_unlock;
 		}

base-commit: 9437046953b2fb3bf55b36582450ea0267df82a7
-- 
2.43.0

