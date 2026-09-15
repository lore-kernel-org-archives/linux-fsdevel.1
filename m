Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF013B6BE4
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459416; cv=none; b=Qadq36VfqYAmB5wWNJ97pUZT3pC2Jb8/6FLfjhl4k+XGmwgljRoIf78wu35bMByqz42sqp4q8mJcIlpn0AtoEgD3jHyOq6+q57aEaXjh/E6a7rTx6xl44SWZu0GUYFyXAGAkU6/oS0QPMgpMmG7bbrzF/Vil3ENGj+OgvjyONy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459416; c=relaxed/simple;
	bh=oxBm833C8T+jxHgAdbU6D4xcv4E4TYoli1xZPpTW0yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joSRe4bbjJBL5hTqZ6+5H2z7OIH+PWwdb4lY/07U8IYedekVz7/N9w+9eao24zA1+vwKXUV3N+LDnhVoFpbddY33iSm+73WYDjhbV2OVDklAItFpHFPsDL/Qgo/g2zYEtx10eltRL5f1B2X577ZuRD8kQ5j0VEcLG2tZC581EHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWvY3Oh2; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWvY3Oh2"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso50108855e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459411; x=1790064211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=IWvY3Oh2hOkMZTpQDhBFLKNByCuBv/M1AtXa7HF///XG3qWAO1LqR35wT2PSYQeoQc
         vEY8/T6TtINWfgTX13h1Cz69IoQTyhrgMs/yWzpTgCg+5F98c0Ap+nX0Jg2PLuaFOrK+
         kyqF8IeofK4zWbLMM1jzkq6kx81NW76Y/3EZ6M7Yg9TLAQgD7/RsU3EG+Wx+gWmXtvX8
         lU5Wus++LBDpryNqS+GZnkpWkbv3u+/z0QryXYrmdiKCbcZ+KDKvoZhfTR4xzukVgJXN
         dBEvqEMDXm1ft4qulXaJDm8KopcfZQoiajqFcsrA8qQtDq2AdDGa6VmIy0rAEdPKYCi2
         3PRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459412; x=1790064212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcITG13Gvl8i0HA4g724jWVmnWns/ceZ5ECxTEaQlok=;
        b=E0f8NWSXz4N4xajMvC3o8cUVXMi9zVwe7H/8/j7oz6BUogMW5tPlmfyhOpJmeDvVRA
         xaIfh3HuYz80V6bhG1EyRX7Sj0hmRyLwZKKNXSuoVb23dbErxVyTOMhfr2qj4MeYAy/y
         bPWiQ4ovJgox4G6mYTsd4zA0XMGp+yJGs6bw9mptr4zBbQx1t43GlqZ2yuGHfFhQXFOn
         X1ktp/IBOWkWNr37MyBs6ODJS7yeDeWUZ+9MQZMRi/pe+Eq0UnIsV/sXu6/PU57qFKYZ
         UemCaStk+AX2m3FmvOtKnp7CwZqXNtDCQjlhYvYqaKt4Lill6ILcPhbisPzHgH/vSo+o
         2yng==
X-Gm-Message-State: AFuF++kbsJoVme4sqtYXxpzMOXyRyB/Mn6mlkDY4x7W/OlsQ/lW+Wn2L
	EZi+QMhNLpia1VUpTkzvWMK6tG1UYj3qiaBAEHNXTTHIhW7N57ZTLlNM
X-Gm-Gg: AYBFou0zhlDJwMlfIVos1RRvoI6gIzLzY8FeHaYgEGsgzx+fVD6ycCtKPKls5/TuY3d
	phpj5G2nPxDvG2CB5SyHkLeafHrjgBOXW+Mdjn6VIruyGyLlL3JNitHjXq/fqgHoLgLbbKaRWBv
	aeyFm/UR3DicaSrYlaMyAkra990wjQnfQKQaZh8y1lBt/vF9N4/t20tkBpYYMknSnU5mOfDmgbv
	YWHyofi3z7ghCJP4PAojscUKr/4rq63417DqQem28pXS8RX+Ig9ow6e0aS4eCiGJVTaMQl88jcy
	r9NYhP24IMJOBRyfgz4pvXnciZ7B7Qgw+yNOmPoXj2s4XGWNVj3HhPLrJ2m1WFemCHE6wG7WxI6
	creQ7FA7QViO9pLRNnmWWPBRTo+2/kqXFmr5rF4MikbocRwrt+Snye2v+jwYdyrZwH5Yd4O+u3S
	L8XbKFGZSkiuhbx8jCxBwInV1lxpnw4nb/ki0jIIRoaKbpQDHRwpF3mvbwW6p/HnTRAIyELSuc8
	//xwjWfqqVci2ZRJifktNBJrgQ=
X-Received: by 2002:adf:e19c:0:b0:487:939:23aa with SMTP id ffacd0b85a97d-487093923e3mr1057036f8f.10.1789459411449;
        Tue, 15 Sep 2026 01:03:31 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b4e:8500:290c:210b:1c76:5710])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb35c071sm33764675f8f.33.2026.09.15.01.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:03:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/5] exec: Clear bprm->mm before dropping its reference
Date: Tue, 15 Sep 2026 11:02:52 +0300
Message-ID: <20260915080255.48929-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
References: <20260915080255.48929-1-tasos.papagiannnis@gmail.com>
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

