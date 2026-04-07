Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4815537F8D5
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592160; cv=none; b=ZMZPk0aR8y/bAUgId9uBOsEuh76F/Qe0OcWTLoeljY8tL4GlF0n6it5YfTCTIQ6kCLMDjA3JMURm9QH0FVakvC/aWVAM59AkoNLQWUR04gJqIdgmg9PkQrHQRNDR8n3Ok8J85JNG3bmnfh9G1A8NWrWaXmKlvrncTGI8TZwq2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592160; c=relaxed/simple;
	bh=DSsKfaRQj+ShpEKq89cF9lIvHEqhwKCyBQzodRo3jho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHncmvaXv1Zdck4wOyiqmpbcJTT99IEXRX+6x4Q7Po4XEOyTaM0dwl6bcNOBXIHBZ+Fuecc+p2dCb5BVdhLxFltR6cZ8jPQGODj74iQw9y4L+9M+zI9xTmcm53LubErHhADF+4HyTHZQvvZyV2E4Eb15fbHvevayTMYQo0H4kXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCpQj2Xi; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCpQj2Xi"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79ea87af213so4903517b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592158; x=1776196958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3XHVr6+kc4SXGPEMnRFsQFJ4AUqQQgTn3Nba0UO5oM=;
        b=oCpQj2Xi3v4alHXJsI1HQrrty0UzVqEmuZ0wIqm93xb1W4aPpT2LWn3eUtNgEzzGet
         rhu2QM5O2F6UF+OKdlNxbELnnJrhkvIp+X9Zzp9aUDGcvSiJcoa4urp18MWf3N6w0Of/
         2r5pfkEsNpAi3VywbmcqBh+2XL/HdxtYgYoELjQIOMqcE2oZGeji1qfp4k2hmXYVhWIQ
         B/6AbN0U8DwrJFDzmkYcH8KKc8/lZQnKrK6sy0pE1M0vRsJ3PLwaldeTySlFuH1NxzX8
         JjfyhZSkYDRAF6sbcVf2n24KOkQTEjqapxYfDRV9VlZVzZJa9XOXkXdQ7ovKGKjloPam
         aX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592158; x=1776196958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c3XHVr6+kc4SXGPEMnRFsQFJ4AUqQQgTn3Nba0UO5oM=;
        b=Ivu33+IVQGcQ5PfZBDC6YsIueCtX88DGwExpIhhfAfcDJi6wyM7AN6ZsXEpLP50t3g
         lWJl+Y90/SWzPRmhDk7+zwkep8HxmaWU+G92t5JbazbXJXhfolH7k0ihpkG8I1BiHcIE
         idb1fZltVf8CidbbH/XtfzA0+6tWNCoVbyaIY8Rc50umxzTXC0pOEEjyeSfbpYQvGamr
         YrVmIpApprwPI492DjczEinVB4A57L25/SInBMNn1AmM+2yTjdmftFOUVmF9sJbJMmD/
         tfznGGdITGEpmY+R0iB0/PJtwEB5eapITjllmE0H5XMwUaOVVUEbkNkVmc5BGgS0yjQg
         6LWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgLewJGmSWHhE4QJKa7aECJAt4GssxzjuCZPVgblNc3EMDyt/Y69WAWRZaNv7NxtWiHi62na4m84jAuLbA@vger.kernel.org
X-Gm-Message-State: AOJu0YzeAOeRrsCXLRkhJcZIG7k1y+GXetzWOr0jhfiR4NDQA3CHpdm0
	13mmKU1hbpQ0wcnxID9a8FDGrNQM7wciZZdEp5jtgrHuin2BM2v4JpkC
X-Gm-Gg: AeBDieuaVvuoG1W9tTWPbRr9cAUPolboN4yjDC4Kl5nxsI3PY4g6PzEcJ408FsoQLJ8
	Uqc+HNlCEMSGIarXDZQML1tdBHXf3g8EYK3XStsdWkpjSr85OcsQmgUc6NWzHuEzUwVjniGy8lq
	vR3+GAVyhH90e+OkrckVcEqBkTyrxmkIVaP7FD8ipN+JfekzHHL80q2GutCA/oQn0D2Fkcitvo0
	vBXThKhDAqJS2GubxsP0pTxaLGi6qGYhWRxudTcX28TLB4rwrqztdA7DDSfWb2XAa5PkNb4AgBy
	YM6xWIW1E8UsWsAp7qDLW1KdUDozQyHh6sY7LMDOxs6op1ykTonZjeIO7bVc2j480WHfvbHEACl
	Sf6Zq9kQdAaqFNXlXgCjzPBVtsCTWcMPZrDi0HP7iLMSdLLhHiuiP+oPFcCJ1A/FJbfWEqWfT5U
	6Xe6Rv6FzVJq4I7OWcYJsziazDAI0OQpwTnEC8Z149DUMr32+/y+964qZ2cYo+Y4CmOsxJHPdc
X-Received: by 2002:a05:690e:bc6:b0:64f:48ad:891 with SMTP id 956f58d0204a3-6503d735b3dmr17314508d50.10.1775592158131;
        Tue, 07 Apr 2026 13:02:38 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:37 -0700 (PDT)
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
Subject: [RFC PATCH 12/20] selftests/landlock: Rename gettid wrapper for BPF reuse
Date: Tue,  7 Apr 2026 16:01:34 -0400
Message-ID: <20260407200157.3874806-13-utilityemal77@gmail.com>
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

Prevent a name conflict when importing the Landlock wrappers header from
the Landlock selftests into the bpf selftests by renaming the gettid
syscall wrapper.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 tools/testing/selftests/landlock/common.h   | 4 ++--
 tools/testing/selftests/landlock/wrappers.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index f6d6a6a99c52..5fe0158885e5 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -262,8 +262,8 @@ static void __maybe_unused set_unix_address(struct service_fixture *const srv,
 {
 	srv->unix_addr.sun_family = AF_UNIX;
 	sprintf(srv->unix_addr.sun_path,
-		"_selftests-landlock-abstract-unix-tid%d-index%d", sys_gettid(),
-		index);
+		"_selftests-landlock-abstract-unix-tid%d-index%d",
+		landlock_gettid(), index);
 	srv->unix_addr_len = SUN_LEN(&srv->unix_addr);
 	srv->unix_addr.sun_path[0] = '\0';
 }
diff --git a/tools/testing/selftests/landlock/wrappers.h b/tools/testing/selftests/landlock/wrappers.h
index 65548323e45d..114b8c60630d 100644
--- a/tools/testing/selftests/landlock/wrappers.h
+++ b/tools/testing/selftests/landlock/wrappers.h
@@ -41,7 +41,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 }
 #endif
 
-static inline pid_t sys_gettid(void)
+static inline pid_t landlock_gettid(void)
 {
 	return syscall(__NR_gettid);
 }
-- 
2.53.0

