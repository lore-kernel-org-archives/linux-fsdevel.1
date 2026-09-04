Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E44CC277
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Sep 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788533663; cv=none; b=QGF+Hr7HwUfkBd0nJC53/ZmIhIdRraKrC4Dcv+XVsQoF4QvLGZMoP+slVWN9F3XzeCgdA1JVFO4Apos1z0dlE509NX4oKlZCswgUu/5tjwWtUudZF8t7ryAgLGW2u/jfgjN/fhprlHz5NjOOUHdOIfW3/5rztZvClkeIOc2iq+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788533663; c=relaxed/simple;
	bh=H0PjCPTa3w7wilyel1zRSrNHGZqgVebyP6uA3RW6oM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HcSlJOpLxdr28GQx561JKzHd/yOL/d/hJiWXNn/DPkL1NZ2f5iNrk2y+nOsIo0L9o+szNO7jaNNuGb/Enb31n7FjAYfdadRyOLk38KDRFxCQpvEyFkHs8yvO+Huj6fRae/5RMpNUDxnLPe0GnApPLZLZ72Kp2Ux4pByMVNlsBwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G14j6431; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G14j6431"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49cca4ffdcfso8919845e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Sep 2026 07:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788533658; x=1789138458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YZ+Ou2H8lPx1TAAGkvNkr9pKRWk8vksitXFvIwQOCbY=;
        b=G14j6431mqz4DH/V6fLP/ifE9EnEVFaEfHlZ/TYMxgQAanNEZh3NoGFfgvHP7ELxN1
         0RKebuZ//BgOBb05xpqX+5IwL+yl7enc+EkkivO+XKXd/t/NUm+cxzD6OLO5MKQpBwjw
         m/x7sE0yQ/k3TZSkHTD2d5j5o6Z5WSXR1Mg0alFmHomBmkNVBs78REEK9soOXubiWJhd
         IwYH58/KQEjnQNHbU5ff3dWpIFijQR+jjpL2C+kb5bPMlma0Atygl/8Xc3VVbcvZCLb6
         nmcryAivqFz1/T3th74mCr7rCnrXPpADzjrkYzIXwFqP0F2iSAOKnFH4+EQemUyGGkhB
         ggAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788533658; x=1789138458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YZ+Ou2H8lPx1TAAGkvNkr9pKRWk8vksitXFvIwQOCbY=;
        b=C/kh4B1F6lm+AV07kUiRkT7FNLIvd6PKPh4k1RAzNthtp5u+hyBv76uA1VccfMfwgp
         B5QrFgNxJmTsu4SXx2gDI6GiWYFoT0vW/vfv/cxrE3rroV03JNWMUMjAOE8U4cuHn8nT
         lMC8jp+AAaOVpu9H95n+RCBlpXHU/Ue7Et3UInBvRROhFg0XTV8dCu7jhq5EMbPSltyi
         7ljmFftZQMDMnGsl47qfc7+ONI8h1x1vJW5FcLfyiaSYoWeLZE52ISAKqUqvZACciYou
         ZeBUhx0hbT9aJ25qBPwiFEOoILJfI/nAmui82X5TNAWUHDHV1mXLtR51+HLJWJwqPZWE
         LJyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwljZ7HwJqbhz6cg5v1/ra4jPENLm3S22KU6Jx1DYniqY3BR2n9J0aZCkSRbJm8KxL/fSWYFmetD5DBkSDc@vger.kernel.org
X-Gm-Message-State: AFuF++m2lo1EbVLDCtU/qGJpwzWIWSn8+jjp5Fiw/zky/ETrhuJMcvAt
	adRXmmtjRurwnfMGKI2+sj5us5bo6qApD+2NYRLZmzSXXeb+BGNBJmnU
X-Gm-Gg: AYBFou0/hxneITg8uRY2RqKOmC/dLSGk+tB56DGL9GMGuDys5DMXMcPDCTxPK+GGR1a
	vOlbbDby04tcTes1u/EZEjPkw8Kv03D9gNdi18AEfrUk75cUN/gM52MgVXLKkCcqpzh56DZR6Ib
	zxQn/iDQHq8LZtvhlYQUSANc3R8Hccrft/w8Ef8tVvTRkQN46xdQn9xR7gKzt5he0VDC3m7iemw
	stjh2NgEpxJ828tMWtaYg+fOASU4EapvyUzIOulr2YToJkdJgO99v6QreU4SbbxdeKCCHkZMNE2
	AjVjxbY5oHxzMuYFYaOKVpXah+Wjtvx2xH4fJ/yJDwDvXmkbl/NqJ8anFOZAO0yYwIm9L7O12VF
	IYFfEPDyRQFRc1G7zS3a3NSRhuKvwtTBhyaAep1+lkX4L5aZQouZmClfxD0abIU6HMlGu8UQT7p
	ZBLXn1xZmfd3Sj48OxAOwRho91sVgao/JIhtDijtF01MX2Jcy3NUVKi6/W6yiflIugRDtssot6B
	A==
X-Received: by 2002:a05:600c:310d:b0:49c:dc14:d681 with SMTP id 5b1f17b1804b1-49cf81e5449mr69837005e9.3.1788533658417;
        Fri, 04 Sep 2026 07:54:18 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485885cb03asm6802799f8f.37.2026.09.04.07.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 07:54:17 -0700 (PDT)
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
	sun.jian.kdev@gmail.com,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next v4 2/7] exec: Clear bprm->mm before dropping its reference
Date: Fri,  4 Sep 2026 17:53:35 +0300
Message-ID: <20260904145340.40212-3-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
References: <20260904145340.40212-1-tasos.papagiannnis@gmail.com>
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

