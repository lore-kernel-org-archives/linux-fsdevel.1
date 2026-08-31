Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04203E7BBF
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168231; cv=none; b=CaouaBNXmOE6IL0bwUCKQWQnufr4x0O8U4/lYU8I86XLv2ixd9paDOEqV9w5EDnkQiK5A50Ch4qRum/OL8zGwZxyzqfH3vA5Epu00k+AkgfZk88rhp56nmx4H8k2sBTCSQhzEviq6zUciQyFxDn3do5NiFZtViXC26Zwmv+XwyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168231; c=relaxed/simple;
	bh=fdI9y3sylK76iM9oY9DbpTJU8s7hpw7GE1UUBVIND9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdETVKttbZeeCtjKnX9bOdT4CrmyrZlWSWl+ij5F682X1s0qOcy14uwco/2OjcaMdt87Gx2XJ2UAGIVYSpzAbpOdm6gTImPFcKH1E8vjoRHOrNC0s4E/ComoFrvk6Sn44UDzOpkgjQFPXSYVTXruNnJ2LRGESnJs24g8JVtSgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/oeyLUJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/oeyLUJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so31851895e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788168227; x=1788773027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zON5T+icRRTPJe/tuLdlxvvWhTEjuOvsxI3luAAgobA=;
        b=H/oeyLUJpdq9rl4eElOKD4dYR+SUsuEaRqbpQGC3OUERqIuAFjsVE3Y9bUN5c6nwvm
         Ne7+F2nJu9bYIODsWN+wf51R7x9rG2lCIw837k4WLnYBuZdWf43IsuW73KTdgZDnnIHq
         dw3I+vcB7jwMAlfFU7thDucKRTFkJMXaHnBbU4ZLQsYHlQnwVfDi3EZELVaFz65VG+aA
         m8mj/DDeuImB8zq2NEMyhWgjS824ddWL96dXuteEKaMIVnENnPuAmMAA1IdzVLGJjsTR
         itS5hQkooW4mTZrPkKDxvrTRRgFeD8xp2WncTuUxELDilzqxwKhnaAv5Z+0joyKz9tGs
         aVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788168227; x=1788773027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zON5T+icRRTPJe/tuLdlxvvWhTEjuOvsxI3luAAgobA=;
        b=jVv9I+3zns7GL1d3FU+XDx52CDLM9KDv/ScJ49LkSpvjQ4gyJLmpEGlrpCIdGmS8vv
         9JsJlu/Jn4k4dbWGStxi1+BEsEmUFg3JXoUCdXgKPIhN0WKu+jdXZMHszFD8l7l7H5lU
         UB8NBK5S7Lxsm5/VmpnxQnU+DmfUwMPxgWROHXptVz1ykDRo2VQQrzExlPICeJc0Y4bz
         gzd09e6P3SEhA87xYODC0xdJZJpdeJdODdMuUNiDB6aDhLH6CjKHo1RGxqkI/r139UQS
         5zh2JbXFmk9AkO7nh3f7xEsDv17HOuiwTbEmh4hgnlhHv/HqXC/vEfmPLbcqbc9QY4Xp
         ILnQ==
X-Forwarded-Encrypted: i=1; AHgh+RqDSkL2a+qPIjd/rvcMyByUxgDPkVdXHRUxzsf5qgzq4bTct3Xcdc7dWipvkIsmTNXnuL1T1xUodLlZHC11@vger.kernel.org
X-Gm-Message-State: AFuF++kjUBM7HpX85jpuQ/sTqMTOpGxbmqNynT71pgiBnyLE7qK8RpJD
	5b2/Z6y+9BRKSyKNDVw76R7kQkVjrP81UjNl3EhGFvSkM0JaCNeoEGBPOKoKZHJH4cQ=
X-Gm-Gg: AR+sD12BCU7ykW5teY6gQRPXnpH7hnVZSUh68uf2sfhokAus7GRZRnOO1Tc1ClWhNZ2
	bfMCjs5UwRaJEFIz0QkIodNLySxJtk9HcZGx7BDzMssPj37viyVsqucUvxI9VS69cVN02lvtxRq
	bkY6WRFF/U77xLadOxUFHOCbbRo0sFg7rEqxFuxo12bhYr+SqHtCMWtDiGw3Ix8WdQqy6YiHjgx
	C2cz0W6YNuFfpV7iF/yvCZYUpRNylhfMKXYoQ5nnMRi0MF7tU0EKUlGfxMzkjdNiCgZwRiwYG9h
	hZkDwE1Q1fMcEG3IpH5ybaK+obozkwDklmHJ7626du+sM6NaNLkVlvYqsasBlAhcKaax8BbvB07
	uPyr8kDLD0en8XbrCUsCVpA51qfDWlRQayQNMXA8L4W9fYpemdsiw5EK4ZB2Oelj8B3h1ZX1+4W
	u7BAl2H6XRNFBWjKO4tLIP8eM5blT8CVszDb6GisB8rE48vWhIcKv2bq7u9fcZCNeMc04DnTpM0
	w==
X-Received: by 2002:a05:600c:b85:b0:49c:c96a:d36b with SMTP id 5b1f17b1804b1-49cc96ad411mr286995945e9.12.1788168227398;
        Mon, 31 Aug 2026 02:23:47 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b9500c80asm318248155e9.9.2026.08.31.02.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 02:23:46 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	song@kernel.org,
	utilityemal77@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v3 3/7] exec: Clear bprm->mm before dropping its reference
Date: Mon, 31 Aug 2026 12:23:01 +0300
Message-ID: <20260831092305.42062-4-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
References: <20260831092305.42062-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once mmput() drops the final reference to bprm->mm, the pointer must no
longer remain accessible through struct linux_binprm.

The successful exec path and the bprm initialization error path already
clear bprm->mm when ownership is transferred or released. Do the same in
free_bprm() before calling mmput().

This is required for eBPF kfuncs where bprm->mm is either NULL or points
to a live mm_struct to ensure safe access.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
---
 fs/exec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a14f28b15607..4b4d8f0627a7 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1453,9 +1453,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
 
 static void free_bprm(struct linux_binprm *bprm)
 {
-	if (bprm->mm) {
+	struct mm_struct *mm = bprm->mm;
+
+	if (mm) {
 		acct_arg_size(bprm, 0);
-		mmput(bprm->mm);
+		bprm->mm = NULL;
+		mmput(mm);
 	}
 	if (bprm->user_ns)
 		put_user_ns(bprm->user_ns);
-- 
2.55.0

