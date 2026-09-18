Received: from mail-wr2-f42.google.com (mail-wr2-f42.google.com [74.125.225.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D434F4D10
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789737509; cv=none; b=RZZu0Lt0CUnfi/Yi0GBOFnPQgEN0xD/POr9jI80N/X544rjdyCmWVVdwh2FtsBaA3ZOmeG9doLQD2AqsoYbDZti6Bqz8kIf3Yhr8Uk4Hfj/s6DAFoyaykXON0cU0asWnmvvwzrCu2vOqqO+N03aLG/P91S7JQHbGYSDgjgZf1Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789737509; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mel5p5NnRm93J7OBVJ9mi3Jhwqqlxbxw6yQ+gSp2bDc1F5AOFtkg6wzvj7CVlR/2GD+CpZJhvlR5VcUpFxUYKeeCM7IVwQPcjnceLcj9xsWXjdN5iX0szLN5mffaVNJOs7PlNWCxeEq6Z30eTIFOkFM+9AYd5JBKZUy9Tm6ik7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTaCcuRB; arc=none smtp.client-ip=74.125.225.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTaCcuRB"
Received: by mail-wr2-f42.google.com with SMTP id ffacd0b85a97d-482f6351832so391136f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 06:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789737505; x=1790342305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=DTaCcuRBPvPuYFBbtD+F2d6f25YKCbNgO+WTHSknWaLBGXmG2OpAVMuYbRsYynbO4p
         hU1O+Ft6/couaczpum1O1Irmi6BiCrWLwe3JmmzyTSmTnWbX3OSF5cdAhQk+Zq6w8bhV
         xU8QUQHZdn7FkIZ2bq2vht8ZC+ZWBDppbH4mZIQqgdyhfcOPRcLsCxY09HIs6SLsLX0A
         SxOyRv9mpuBNhWkhejOxIHV31BjEzumxFZWoq9FL1AYU8q3Bxk7bQFzGkzVuhnk+Mb3H
         MGnlvhPWbb7Fu1CV051czmm0c9C6u4OZdr1w/NJm3TYVpqVwjv1H4C++LhhdUon0Ra+7
         AL2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789737505; x=1790342305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=eSncvknfM3jm+aTDQNM1KtLm8Pc2BHTwMD08Ehu5uaqy+OYISeWEoW4vTIOMr4KAyu
         z9MISVpro5oj/Dyx4S3x0qMaSrMLpZqUUWOl5UyC9VGqy7rUAcyUfAMdyzAT/NqNZYYN
         x1KjI8S6trqm+BSoUvOV3XTiFSe4SHnfpKY451Rp0NFwu3qjsX/0J9Ego0fLXMTksnQq
         m3pbPbXIzzwJwTOWpyOFxIWb6ZJBxOvV2qzo7QEDvmZ+1fqjViJxa8azAQ2eRiVwdgTE
         nXKjI6isO+Ghd/hkKYfHrEVmVW5gPApMYU2xjkYMVxBsQmMlsZyZ0sSMDBLtrmgj+d+n
         x7Qw==
X-Gm-Message-State: AFuF++n7IE9icCCL9JAZeJM+pvUAOTb2SNan3Kk+6VPWL3dxq6Qlq69A
	kDRHlix6k5SRF+/5RW4LK3pB8Ogvtc8f1iIgWYENo5qBTVFlk59AoSoP
X-Gm-Gg: AYBFou2KhmbpkGYuCv13k+LhKQafUZtSzqPcfazK9/K8AGO+vavdiY9lDMcuT3XUoF6
	lfhMVJA7WqnLpwUuytcWhOG64m0QIefzaG0eUsuwMWiX7WzWPPlXfElfk6SsvQxnOHZDLJTsYjd
	8ok5oDNgO+w9h1c0+BI35+pMS4JHkV5fcZB9z9oPgYwmapj4yO2n1yxRWQSWOnSnPpkofGEKlve
	NhgGrKCBnmLb6Qc5rPpVXv/GIcDYU3e/ajzUawNfsRBYe8SW/f4OyVYX4/8ljJvsekeQlbo6gUC
	52tFo1Q1ifpr9N3coJ5M/+q/3DOTAwjTL+XHs+R+nhm0h2mlFj7wh1dXbA1OmeHi8/AcjtIxEIc
	k91hJFb+yjRLvhcLhBMkHeKeh2vTvbBqmBUM/+6RW7o2Hi295UUx2y73sLteUZ1zNa/tV8yP9fF
	HPtN2G+4OwSxGukZp4lX2bNXkOjU704/LhImlcvN52+D5T62appv2kmsFcuDqbm9K/BMZEb9A9j
	t97HVSaQpMvHOl3gJRN82rm9Q==
X-Received: by 2002:a05:6000:490d:b0:485:8a47:5b91 with SMTP id ffacd0b85a97d-4871e36cb87mr3143383f8f.46.1789737504555;
        Fri, 18 Sep 2026 06:18:24 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4871feb5de3sm4424549f8f.1.2026.09.18.06.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 06:18:23 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 2/5] exec: Clear bprm->mm before dropping its reference
Date: Fri, 18 Sep 2026 16:17:54 +0300
Message-ID: <20260918131757.42802-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
References: <20260918131757.42802-1-tasos.papagiannnis@gmail.com>
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

