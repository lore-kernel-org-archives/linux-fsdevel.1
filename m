Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B62A436BEC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362174; cv=none; b=dGvpMpjzv8sYr68QfTShoIFosnviWTjHLHYCs2yG/3i8vtlAnBHm0Y07WsU20fwmUTHU6DvPBzu9AEQfqNRlNLBp1fpPBD9MsQM/M6KywMUbg5yZmfBVxEZJG25f5J6oRbS76jkKgrAn/JIy500fo1LDJ4hMa+InqqXTCldXr8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362174; c=relaxed/simple;
	bh=f8A8HSnnoJfx2V2FXn4Rkd737vzAC7KNR5OAkSuZgzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sdGx+9iNnsapwOZ88A5Qie/Yg1oO/3CbBU7kOhPZgwSTXKKsgspCAEqUaDpMhfPInUFxWJUv4+fhVISBG2aYw+bdOfuMITbdQdtYskSuNeahSe934mfJkuXsQL+deUT1uloCiXKEbu7IH4Vdf6+Z65ZVnHiPhZgKnIHIPlKdW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oSNRrmEZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oSNRrmEZ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-493c556ada3so12045e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 11:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783362169; x=1783966969; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2n0bB53EEy+f4O05YVB7+hzJUrWYRhdG8q1UZt65t50=;
        b=oSNRrmEZe4qsdYPbqJOJzQHDmwtJBpstiTxC/+z3bKuzik8JiswdbIN/dbkH9FAQtw
         Dh8JsJIT1u2Jg1KXje3wfk12537MuED65Npk9gd7d7PkYmBo6euC/L8soQqahXTU6tB5
         Fz8Qw63Z0sGdYSYGkmZkbKbSh7QnT3ng5D7WM8eiQ4GlDI1WWRGAFiQT1vVEPSjSFa0m
         vVJRw/wmpUB59D3EQos7hsZIjv0P4pCSp1xpk4a3/c33u287kZ2Nm1nSnhi5JHEOrsCU
         4wRQdqYl3es26QeFwMprhCj3iMRO78xeVQpRa47XtxIugCmSuCGGbNIeMP/49CW2FeGs
         1m/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783362169; x=1783966969;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2n0bB53EEy+f4O05YVB7+hzJUrWYRhdG8q1UZt65t50=;
        b=FH0x5LUi+S9aqqovq+PT2cQHospkpYGV7qKfD+KxOR1GE9gza5WeD3+s7S9rmIjcKo
         A69eyYHkP22h6Lwf1Ygm99MAKrF4cjk5Y2996fYPqknmetP+H992gPALCSqplcG0caur
         P7j1OJRY26wFBlf8ROPBwTpjZEA41CKUOjV3aolmDicH6UNdjATOoqjCeJny0+GsxzXv
         vkUHNB7QS1saENbXchaAcxp4cYL7A4HSM7g/fDNzJhJu3nEFgPui62JDZbiv5g3/+/8m
         zG7+vPL/7y5eClTOpJl5ofXHVgn9SsQm8JhJLBNlalC6jnIbnbSjmPUsXFwDWXqBBpA9
         vVow==
X-Forwarded-Encrypted: i=1; AHgh+RpzyuKOh1cFJDZiIKat45UnwR53Uyp5zH9QtGRCsP7TORvp7UzDUUAh8YcAcXxgFvvrCRbUx2BwD27LMKLr@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf3LUAT6U7R7STHZgrwbkY680Zr6TuScCJN0WHj7ATPdoy/dgH
	5sbLZjYnJL6rX0W9iiL5Bb/w04qGmdApLBStbDjgB6xG7IfXVo/mz99T308mKBH/RQ==
X-Gm-Gg: AfdE7cl5s8oqOHUh+IuV43dDm0z9uV5qhrA8b/d5bN7tHx9x2NZrU6c3mwMLagndnzb
	ETwlAhF46NnCK560FsS5tnWyQbvINb6ffJqXmxdY9kQUYlBSJxfkPXB5tzjoMbci2Dah+RURPN5
	ydZsrQ85lGBtJc8c3KVhFl5SwLFLik82E1mEFNOnAJcU62JTFWR/2uTIqsBYPDg7OGv4dX8+H0a
	IwSfaEy+ek/6ZtmvH1n3cwX1f3sbHkSOF+AuRssNG8P0+o87tILdApwgKS21jup/3So9Zus4X/U
	nen8hOElQ86c1lD5nYEyU94lCxR2SPl9TWqSHGCD6g2xfj6RyOfDO9tCdD+cCAyPHzR7ma9xomL
	cXFOxHQICadUyN672vreIP4iBR+O87AZxn8ez9T/hnIQ7SkQ6bp1aoUREAmjk7zLzFLCf9oxJpq
	48yMLFjg3Qz4MSCdKMJTrnXUg4KCapDSqSs7z8D8Vnw3F1cP/iTlXSFbA3CYGmlukA2SdabJ0=
X-Received: by 2002:a05:600c:621b:b0:493:b47f:a24 with SMTP id 5b1f17b1804b1-493dfb5d91fmr282775e9.6.1783362168372;
        Mon, 06 Jul 2026 11:22:48 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c536:dee:89b4:9c3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e006b6besm3278025e9.2.2026.07.06.11.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 11:22:47 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 06 Jul 2026 20:22:42 +0200
Subject: [PATCH] proc: Fix broken error paths for namespace links
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-procfs-ns-eacces-fix-v1-1-a69ab14c02e6@google.com>
X-B4-Tracking: v=1; b=H4sIAHHyS2oC/yXMwQqDMBCE4VeRPXchNRC1r1J6iOtY10OUbFsK4
 rs32uM3MP9GhqwwulUbZXzUdEkF10tFMsX0BOtQTLWrg2tc4DUvMhonY0QRGI/6ZR/7oYV3Tec
 DleuaUeYze3/8be9+hryOFu37D/uSikl4AAAA
X-Change-ID: 20260706-procfs-ns-eacces-fix-3abd8e307936
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Magnus Lindholm <linmag7@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 stable@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783362164; l=1618;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=f8A8HSnnoJfx2V2FXn4Rkd737vzAC7KNR5OAkSuZgzE=;
 b=OsAeK+y2dAYcnAgPmrdLreaRNOSG0UawNxTe4j2PcNHlHFHOZFs34fUDS8CdejScfxGGlkuaD
 t8eWdFjIxwSC4ynU0Sq0ag/8RJubwsYxh6DDIVNg2hwFvhlaZGbbeqP
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Don't return the return value of down_read_killable() (0) when a ptrace
access check fails, return -EACCES as intended.

Reported-by: Magnus Lindholm <linmag7@gmail.com>
Closes: https://lore.kernel.org/r/20260706170735.2941493-1-linmag7@gmail.com
Fixes: 6650527444da ("proc: protect ptrace_may_access() with exec_update_lock (part 1)")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/namespaces.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/proc/namespaces.c b/fs/proc/namespaces.c
index 2f46f1396744..ea6ec61a0430 100644
--- a/fs/proc/namespaces.c
+++ b/fs/proc/namespaces.c
@@ -46,7 +46,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	const struct proc_ns_operations *ns_ops = PROC_I(inode)->ns_ops;
 	struct task_struct *task;
 	struct path ns_path;
-	int error = -EACCES;
+	int error;
 
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
@@ -59,6 +59,7 @@ static const char *proc_ns_get_link(struct dentry *dentry,
 	if (error)
 		goto out_put_task;
 
+	error = -EACCES;
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS))
 		goto out;
 
@@ -90,6 +91,7 @@ static int proc_ns_readlink(struct dentry *dentry, char __user *buffer, int bufl
 	if (res)
 		goto out_put_task;
 
+	res = -EACCES;
 	if (ptrace_may_access(task, PTRACE_MODE_READ_FSCREDS)) {
 		res = ns_get_name(name, sizeof(name), task, ns_ops);
 		if (res >= 0)

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260706-procfs-ns-eacces-fix-3abd8e307936

Best regards,
--  
Jann Horn <jannh@google.com>

