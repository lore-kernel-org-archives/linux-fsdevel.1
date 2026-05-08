Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7703EF0C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247960; cv=none; b=TEjdLcgPSseoCVcHghp9iEv4CX5invGF8aUcvoHk4u3bRHh2vJSxZb/F7OrpfmjOT4OySfRPV9TwUaTp3YiH0LbTNVL37t5KJhcuByqXY0BMugJzl4D29BPn3dQmKVwyMVRktgHxpPCphhjmmlvErJua2jTT8UGS7bTPtAmTOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247960; c=relaxed/simple;
	bh=x54ah22Wc1H/lycjg8gZlMfozlhFoOnMK4xmTmDdqDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENIQiVzFlzgM/fMxdcMMAMKRo3EimwZG8Tk54Vx2972jE28mZdkIZkDjWfMkxhlHEdPROCmzR6BXdaa6oD3OxsnAyRmjbMhCFdbaCtzsjYVesilKrjNw88sgt9Leyj3o9D/4rlJxJUS2jihD/q01QIXhS/PvpSr0wupMyijzXXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d2fWYkwU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d2fWYkwU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48a7fe4f40bso21985055e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 06:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778247957; x=1778852757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWWi4rREBYVdB+LWWZZk5r5JC16Ku02dMieXneoROGo=;
        b=d2fWYkwU//B/Q44tI4kEdfqCsRp/nrP+7ameDsExujy8s4vaosF3LB7PJH/uFqHpKW
         anEpglG5p11wQBc+cPSlmEpcaZ4Dd4NAM13wBuzq/1H0b4n+iVTVMuNZbPfvCdbjJ3iv
         BntPg+qAiOyJz4bif2Jrk6fh3ZEzJrUVMCRFNAQa6M6BVC/r9u8o/iBSob577flwpcWj
         cNb/69EObVHYmudYtaSmj1j0sg+GfsaCf8IQPIqGW+yV7BPROgV/oLVS+1UGAnUqafDQ
         skqahw/wCBpYXxSH4fwoJ2CpB2sWPCTyEarEYizgfstzvWFjztiF9U+O2OdjmpL+w4Cl
         fHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247957; x=1778852757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jWWi4rREBYVdB+LWWZZk5r5JC16Ku02dMieXneoROGo=;
        b=NUgIeF82kIbQdwymBen2uzdzBsM1gkflWbzmdpZWA1YpKEg1i2UUFI1DQjeMXx9Iyl
         gF5ymrQjzWudKWVT4APgGBnY1q7sloS2QeqTX4ce2/6fsB4kHh3tyREVkh1gyyMsm6kV
         3F75hNorDkQoYqqMeyBh7my7If02iWX8kgCX6aMb3tTJznbgMsCdcI5UzzCug5FrfrbG
         z+cVhMgnhZo8mdz+UIJ2rELDIqkWalqctUb4tOA2UHWt1i9n03LOl/fL2BnxKNxO9MD+
         TFWfRQ62GcgIkv1fL1XIRoTKvmptFUXfkN0dTZz8ZXOH8Fz5N40GfFfka9ydPS07iKY0
         jtmg==
X-Forwarded-Encrypted: i=1; AFNElJ/nsdjO7tIJb0M0n8caqWoEFlGlGiBUHHpLa6tf6Rb65mYk8Kxn+Pq7+h7dcAHqhkcQOnSR8u6EVDc6Pd7A@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/PJMZzFyEHVYxiV2uocSd/nn6jLKvq/PFTr1HnW1jYOfEdA/L
	NPiaE23A+Z/HBs5eOijgHb9VcXamFLdFyNYEFUTjlJvb3pOdsILg61SePfYHMklXtAw=
X-Gm-Gg: AeBDievbIz8L3DpbkEAkAYi+wGnuHDm8X/Wea84iWnCM6fodYflmyw2gaVXIZP1pOl+
	5uAo2QKVwb2Ze/AH8uq2lfp6Xwox9QALl1LUzr4CrCFNHBzrRTr6GuDhHJiBkodNCJVrjGMaL49
	GcVfa+0+nZ7XzuXtRWj8gYj+IycWDbI+ekQB3L6aIuDVP03fTuYHdaVI5/X6DaJp0IDdFggvzSC
	/c/EVtawOOHvIg3zV5UnpnWr4HlIJ3JMYlMmUHoIbeCVVJMXJ7sCbASvMrj+3do/Nq54zuisBOj
	tI9vOCaor9o1cEIEqgnVg7c7usU6jEeS1jpLu52kBnfDkLGE5eaTKBLVvrA/JaHd9OrnzZbH7U0
	37AvD/y/M7TiAV3u5Tgqz1fZ+/UyQymQPRciqusUWa1x5p4a70hfVZUp7tlsSgaLrfx4a874CQu
	QxId1V/0K5QlnsF9oH+hcxihxazltVKqXkTpoFMhnMvDn+aZg=
X-Received: by 2002:a05:600c:a110:b0:488:ae6c:42c6 with SMTP id 5b1f17b1804b1-48e51f2e8a3mr156808975e9.14.1778247957078;
        Fri, 08 May 2026 06:45:57 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db1413csm178475e9.29.2026.05.08.06.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:45:56 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 6/6] affs: Move long delayed work on system_dfl_long_wq
Date: Fri,  8 May 2026 15:45:34 +0200
Message-ID: <20260508134541.282073-7-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508134541.282073-1-marco.crivellari@suse.com>
References: <20260508134541.282073-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using {queue|mod}_delayed_work(),
using system_long_wq. This workqueue should be used when long works are
expected and it is a per-cpu workqueue.

The function(s) end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption. Long work shouldn't stick to a single
CPU.

Recently, a new unbound workqueue specific for long running work has
been added:

    c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change
system_long_wq with system_dfl_long_wq so that the work may benefit from
scheduler task placement.

Cc: David Sterba <dsterba@suse.com>
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 fs/affs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/super.c b/fs/affs/super.c
index 079f36e1ddec..061da7b795bd 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -88,7 +88,7 @@ void affs_mark_sb_dirty(struct super_block *sb)
 	spin_lock(&sbi->work_lock);
 	if (!sbi->work_queued) {
 	       delay = msecs_to_jiffies(dirty_writeback_interval * 10);
-	       queue_delayed_work(system_long_wq, &sbi->sb_work, delay);
+	       queue_delayed_work(system_dfl_long_wq, &sbi->sb_work, delay);
 	       sbi->work_queued = 1;
 	}
 	spin_unlock(&sbi->work_lock);
-- 
2.53.0

