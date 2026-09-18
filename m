Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24024415F08
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722687; cv=none; b=b53Y/a2zTkcTHgRO0CCi2Ys6XIPLPdk1t0HD0H6g9ViVMm199X4p0rEbXz7dgLri2OZ1TaV+d9SeGGD8tx614ocxlJaoomENNZJrxBA4RwbJM0EoNjo4JQErdJ9SuT6CnNm0lFdj8bmIQIYWFKMudQuqORpXVBBKZmJUsKwM8U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722687; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByN994CayLnOlfmJrPqZ0Ji8biID2EKeDzRww8FAPj9kb2pbPPWTKTuWWlwnmTQDCqU0QL/5qKlsOaj6TK1JkgR3cQ0gc0bbJ0GlFxCJsB2/jUmzGntZzW9JtItr7OBSPhbHpRKpE0pWfYxNxc1h6CjkhPu4RpAudj8VT0thdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIb6S5VI; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIb6S5VI"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912df756so3789585e9.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 02:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789722684; x=1790327484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=FIb6S5VIl9HErXLXf5Fe7PjNK0bfdAWcityzeJbbPZkdgXU2pDq7mjpHJZyLUJjW8q
         SdyZvJddNcR4feZ8rlSEthkn69Qr5BFKlt5pT9FFuIimXOFkeopLSjz8jgeRFt3X2Uvr
         pdNb9HmpLKM1SGHE7kI7qbnQduD8fRQv0MpBaM5NBFAYo9pfoiUSIUkWW0Y86ciVptfW
         jV/OIr9u8w5Ocp8KoYH4Jum21j/3k9Vw1xCDDUIZHXSsjUeWUDwCarbOweFu57yGUsoZ
         d2e+hRuQ/QdfE1yE61YzY0RPRCSunnV+/K8BXUz7e/QdDIUU/zH8G3bpKp4z/KK8yXr+
         ghgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722684; x=1790327484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=TXPxJc7uYuGfhQnKai7J3fGYp7GfJCcmR8sDlj1VP80SlazjeRkft0yfeL0+fu7eN0
         MoCHP722CNDQGNKDuDNLGRmJ5AE2pSJAtqeWEqjFmxAhbPVUh/saXIMW2a+MIIQWAPbL
         GnGhX6JVN1lZmGppYzljYgHd+Wu0T5movh5DGnqphz77JY0w2PhXMG8i+HM+l/YMKDgX
         INRWPXnwVhbgPVvUsUlZMX4mGEYCggo7C/Al5xEHb3wE11Y+TSrkmjCEFtJfMB3GUdcQ
         r0QlPLWjqBj73WFD7yw5QtB/QxZr0nZkOP+r6pUJcXxlnP/+x8SR9gcinTAG+7UvVkQO
         bHVg==
X-Gm-Message-State: AFuF++ld5qDVrY+mpw7VLPfVc8RAlsMLiNUqdXCLob8cwTNoheUT/GMs
	Nx/aJQLDYypt1WI7x6Llbs0iaUX0LMPcL01NxAAdCFOMzjQviJ8kMR/V6pQaS6ol
X-Gm-Gg: AYBFou14lt/9Pj52HLBhhRYtKTpIvypQSLMsRZpjj0N6hz2MmldjooitSZwckEkqPX6
	Lx2bWBxDry5Tk1bf2+VBAZZN4pDFLEl0o3kPwAfOg9RT7ijN9QwaDM3BHyWCfIvj35MLQjscS1U
	xbuAcPpsA67J6BRiwYP1OXMcgfnVrR5j3AMMkzmMhstlBFIHkRrNVlEMP04sfazsmcJpVsZ/NYE
	4KV+0wU+jtlx7/ysV/phqwixTEzMU4LSFvYL0bI/5l1SQJZ6xJmm9u64zPUChwUvXaIq9uNmxLk
	zY1vGIh3OBNui89ghRNBaG2iS1nIQ0mO3ijJKezJu5TYqzMojmrGgb1ueFElcGcq/6HZD7uzY4n
	vMcKUfSWQciL1FTNiczHIH6qZ2UxcPeTZ+UYvnfqnRGg5h5xBPrcjWTyBoojIDL9qo1NWOarXUh
	YfrDDVLc4YAu0IE3v9izy6Dt41CoC4qninUdEtuqThP1vLbddNXBPyhUpnAhL5sUs+WoJ80KeZ6
	LXuCzOZHNhpdsI=
X-Received: by 2002:a05:600c:468c:b0:49d:16df:8521 with SMTP id 5b1f17b1804b1-49fc56811dcmr23639585e9.4.1789722683646;
        Fri, 18 Sep 2026 02:11:23 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd1d0978sm138774275e9.2.2026.09.18.02.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:11:23 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	david@kernel.org,
	akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v8 2/5] exec: Clear bprm->mm before dropping its reference
Date: Fri, 18 Sep 2026 12:10:55 +0300
Message-ID: <20260918091058.297740-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-1-tasos.papagiannnis@gmail.com>
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

This is required for BPF kfuncs where bprm->mm is either NULL or points
to a live mm_struct to ensure safe access.

Signed-off-by: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 fs/exec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 745f6eb5279e..4ddd403fd91c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1456,9 +1456,12 @@ void bprm_drop_loader(struct linux_binprm *bprm)
 
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

