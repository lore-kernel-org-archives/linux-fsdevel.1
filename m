Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97196387347
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592175; cv=none; b=C6jnPGVAEzDdhyONWqLMOXlg4lsaFv7CqVJKggw5Un/jPdmN2MmG1n6NwH8h6tsWmZGWQj/QJmtPg3rOcuWb8g06xR+UgzG/Frig9SXr1lm/IrRNSACu0kS+4iVuKgYwaJ37WcIrSM5CgJbCx/LTWUDVA7iz23whkLKrFDNX0kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592175; c=relaxed/simple;
	bh=vi5FjNFei0DMVU6UndsLw5X+Sug4/lpzBigVH5ACDgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g0AdJPRj8qulzUGRNAZsBz5WOnNh4T/yvAYnMSAAnbE1mS+P24fbfOEMYOMBSRIEM1C0WNIml7QV32Tr+KLyPqQ9QK3/Yoo8LP+zR7wP8ULKMNYu7grm6kF7jKsQEk+b1ySJLy13SkRTZbv4Q5/6EHZrrSoAeBaasMKGDTuZyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQD5IOG2; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQD5IOG2"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-650789b22e3so1728159d50.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592173; x=1776196973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=67+cKnsUxsC8cUauaFfSWyXKAlrlKdFCay5MrA604yk=;
        b=FQD5IOG2tWX0D59HiO4K9pEDlYxhmVP4MpXfrNIQSwpTgJpi90+YdCCZixnUArZKcU
         L3wnhMNmFMRXeP+eMdZIimpxKcqGN7Za6dzqbYagzhJLsxNkkzN8Sq0qzpXA093l6Rmz
         5H5A6p1AgkNRnUMO0K1NhxEJl8LsFvmbILHHXH3LKTSJEl/jXjM+LS3cep+M+xtsDPzZ
         gfJEMffOVL0QVhSHcChaNnTKEF3SiDtCMugA2zOz6LxGvRRFIaFSE+C0+HMFfWWbX2K0
         e/B5aZeSOFOOREdPWldZSjSrSr5ICMbWE3KKG2qmR++ITiu/mZCA5hKiaYc2dzL3x32l
         QAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592173; x=1776196973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=67+cKnsUxsC8cUauaFfSWyXKAlrlKdFCay5MrA604yk=;
        b=NJZejBN4oe/BrIc89B4zJDNWa2L/dWslYhYm0Kbnc8Br6FLsP28KXrwLUIaCRMS6y6
         c6hwqTDdobfceKEQBT3JCvdXQDHMsKuob38buZ4N98um7nyBNNWEtDFxGBRNIol4YxIE
         SdIwFmYcnOprKGgM9F19fBWBRs6qiPjJtp0qZ+8cQU5qvafb+D72PSQcdWJDeB1FdK9l
         bQXfoCPhrg8lCmnb/z/9hfO2yeh3snOPbJYsH7++QHJBOgSDqQ1VFLafsyw+ixrpoyF5
         3i2qcBtnu4kMdHBlr4LG3pM5yjLM46/nKi3XgS5bpwsiWzjlVgFr7lMilzbHMs743tP0
         ZjjA==
X-Forwarded-Encrypted: i=1; AJvYcCXzTXzmM7J3qCImrPsnrTDi99/HKQuFPwrPCVM0BJe5R7a57tFSeRSEj31jQIjnYsNBgr+RVRXw6RSeYfn2@vger.kernel.org
X-Gm-Message-State: AOJu0YwnK09eiyq6kWyDcaFT+Meovy+NBabG9Gwl9a7AjnglyKK7Ul4T
	Q8D/obPm7bEKnzltvwM/zDMcaxlD2cxhKpWWObpiD/zZu6L5Ctn7UY5Q
X-Gm-Gg: AeBDieunTddcWsZxUPkaUaJ5HQ0l6P/7h0lChwA3Ehw1cJHvOEszmBBQR1b9djrdcNb
	h6Hy68CkozMh4+AsaFJUjc0QUAoGd7Cq3dYCHyVktKgXlZu/JYL7cFb4lQUtYmBtWz2ihsWXY+l
	TGMizCZBE2ZPVQNI1tjjcCbo/NqmEokquWnXBhCZ8qe+emWM8VNhXF0nBghjLtmj27jmRHhZNE8
	92PQ54gIjvc4lBXq2Qlcfr06sMpJ/3+/+h/8/rrLB47RwJWxlE24wQk6jnCAml/tsAoShk2cpN7
	rJk2M+1p5w64HK9cS3LTxOVVm/G+xVlf1iENb9Aajy1unjR5fnH49f866EqMhYby0fXq/+NcW7T
	a5y1zLv/I+tKQr6zp1uFCSzH1tGyQEkiGPSeP3TBUQYY3SqFAgT0EVUx+9t1VAc7HWy7OQSjPU7
	pvbPkGITahPApsmhgKUFs5xT0wyVy5O8dBWfqNcXMGwyq504rNjtf69oDCopUfI7YPYhMknbjd
X-Received: by 2002:a05:690e:11ca:b0:650:891d:e1a6 with SMTP id 956f58d0204a3-650891de307mr938379d50.51.1775592172595;
        Tue, 07 Apr 2026 13:02:52 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:52 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 18/20] landlock: Document LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS
Date: Tue,  7 Apr 2026 16:01:40 -0400
Message-ID: <20260407200157.3874806-19-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS flag, and explain
how its designed primarily for BPF-side use cases for Landlock.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 Documentation/userspace-api/landlock.rst | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index fd8b78c31f2f..82c88d75ef21 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -204,7 +204,8 @@ similar backwards compatibility check is needed for the restrict flags
 
     __u32 restrict_flags =
         LANDLOCK_RESTRICT_SELF_LOG_NEW_EXEC_ON |
-        LANDLOCK_RESTRICT_SELF_TSYNC;
+        LANDLOCK_RESTRICT_SELF_TSYNC |
+        LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     switch (abi) {
     case 1 ... 6:
         /* Removes logging flags for ABI < 7 */
@@ -223,10 +224,18 @@ similar backwards compatibility check is needed for the restrict flags
          * children (and not for all threads, including parents and siblings).
          */
         restrict_flags &= ~LANDLOCK_RESTRICT_SELF_TSYNC;
+        __attribute__((fallthrough));
+    case 8:
+    case 9:
+        /* Removes no_new_privs convenience flag for ABI < 10 */
+        restrict_flags &= ~LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS;
     }
 
 The next step is to restrict the current thread from gaining more privileges
-(e.g. through a SUID binary).  We now have a ruleset with the first rule
+(e.g. through a SUID binary).  When supported, this can be folded into
+``landlock_restrict_self()`` with ``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS``;
+otherwise, user space must still call :manpage:`prctl(2)` explicitly.  We now
+have a ruleset with the first rule
 allowing read and execute access to ``/usr`` while denying all other handled
 accesses for the filesystem, and a second rule allowing HTTPS connections.
 
@@ -716,6 +725,15 @@ Starting with the Landlock ABI version 9, it is possible to restrict
 connections to pathname UNIX domain sockets (:manpage:`unix(7)`) using
 the new ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` right.
 
+No New Privs flag (ABI < 10)
+----------------------------------------
+
+Starting with the Landlock ABI version 10, it is possible to request
+``no_new_privs`` as part of ``landlock_restrict_self()`` by passing the
+``LANDLOCK_RESTRICT_SELF_NO_NEW_PRIVS`` flag.  This lets user space request
+the prerequisite from the Landlock API itself, which is especially useful when
+the restriction is applied from an external context such as BPF.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.53.0

