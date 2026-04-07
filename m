Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FA438BF94
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592179; cv=none; b=pb5f/mQrZFCiFq18lGbEdNjMNre7waJ55Vc1V1hYBGpMFtkFlr2xB6cBRxZ8Lo05NQn/FqGUzrg8oahyln0/vabacspT/qZ+hBPhvdF43JxsZ6KrKos4tUlVL/sC5PtOe5ZweA89KtGf/3+owSp0m0wFQjrqzu6Qw+RKAfCvKPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592179; c=relaxed/simple;
	bh=CQEDiS2TgsP2GNu6TF8JkrnFYM0eCP/VH66tqdE1J8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Skuk9lII+CMqxXZSgUYWk6xsO+A7//vt+v5+a5yTsHMgF8b5eEe7N3/7CIxZ+wOmcFl0q1DUCYCTYsfcv3k7OH2YTOmVC/CwYe/W1TcJkO5z/ytwyRVr2AnUszOQwzXk0RwhI9+x3+lSXQU5ylUPUKpLrSCKx5GaAfhBgNl9e0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lm/oF6qO; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lm/oF6qO"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64e87a81639so5306865d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Apr 2026 13:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592177; x=1776196977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LyM2suN7bPTp8NTdaz9bJElLdCWwHCAj6iPO64WmYnE=;
        b=lm/oF6qOeSt/15txSjsWr2gkJjUBKhdnHWOqVt/srE2EK/JVMQ27Y9GGzBoQ0qn8Ck
         MlGIgXprHTTUYJlDQf8V/yteTUnOFuXs/Pz9DDBeJYKgw3lyeI0KBkcVqynFUpu+cIj4
         +a4LXik4KkHSC+FrXnR0/Wzm968DEYqXrsZzG0YIO3Mgk7kjpXdxTMkJOW5VThzP5pOX
         ww1ELGearTZAOgR+xP5Of7ZMDHpez/ai66oFTgeTxWE8Ag3akHrp0+Rfq05deA9PyJKf
         nXbPAenQlLFjQQheFYqahD6Eqq9roDFWqzGyob0Nrs0OV9xyb/HcB1aalpOSyMkgeT0e
         ZNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592177; x=1776196977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LyM2suN7bPTp8NTdaz9bJElLdCWwHCAj6iPO64WmYnE=;
        b=pr7LTXsencdDYnwR0WGKPcBGj805W0UGoxc9fp/LoSa0oF7qoN4eA1ztNe+exVCV51
         R3aH1YSx7wEpflitCULrdaUQpbJO1WHbD6swbLoMaPwcjQUFCP7VCoCDe000KJ36cUPs
         rDiFTBdtZvGE2t6mibnBPajUNt85Pw9H8jUa5LrW1TIAwcuU/sTq6IBCoGA1RSs7hZw5
         vrWFTLgLPklgItcytj4FlHtDPfQ/dmkXOCJOTGPK473OzhtfgBWpr8nfcWKWBBc+rfh8
         H5k4FlwUybynfuiIZWPdjzrC4outHkmmwaaq2M0PcfGoIiweO591WwmB0EnQaeB6h3+D
         Z87w==
X-Forwarded-Encrypted: i=1; AJvYcCX2FFtntta+fUBwpn119Rn5MdxaBH6HVTyERnLriD7IpB4SFDEdeQ9W0odiNa+nJMTX+GwfVkzUldQJpm5i@vger.kernel.org
X-Gm-Message-State: AOJu0YzsBAATJWTVDDZWJx1z9+VmsI+maoqDZv8VAw2RBcHrKFtb1wg5
	m3gzGtvxRIJ22YU3XsG70rUT4d6PHtHsuekcu1kBwIGRpra/M4tTEscj
X-Gm-Gg: AeBDiet4FTJoWNmAbzXUfoR8D5boxyeGxJ7Qk+frIyOAXnhp7mIKv0CcAWkoA5fusB6
	ZekbPROfysQKEi0VdKF7VBrDa5Bymw+qAlCIB2ElMShIMQeUGgQ/pYSYB2UW3Iq6fQFm1TGDu6q
	UdNBVJZTeAiFZzV7peaJBhomf+vC1SL/7o/AlsMaBGE4s0FdV5cLe17VPMGcl3San1uZSSMP8HX
	FHOMI6LXcC180KGDc/ADs478cjLJwEsADOVq/dlLONUVwhoZg7NZFre3Rf9BlAmNFGkPNQKz6lu
	dxrFb/ciNjAsgOf22Kvs9OsnmKtmsC7FNMVTa9HO1w4VIrfxeIDqZPsbhzGlUd5M6tj1LvEchtb
	e8YYPA+m5iS3hXzycAZnouVNoN0RXQ12aN2inClZTBjRpGGovmkTy7vl25IejUwEY1zLJfuC/j0
	W51Vv/Ec9lhYYFMwADu4tozd7pJo4gVmamHjpXZR5PVVTAVY10jqBx3W+EfiTqNCMDuf9b3BdQ
X-Received: by 2002:a05:690e:bc9:b0:650:7846:f326 with SMTP id 956f58d0204a3-6507846f3bamr5830968d50.51.1775592177087;
        Tue, 07 Apr 2026 13:02:57 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:56 -0700 (PDT)
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
Subject: [RFC PATCH 20/20] MAINTAINERS: update entry for the Landlock subsystem
Date: Tue,  7 Apr 2026 16:01:42 -0400
Message-ID: <20260407200157.3874806-21-utilityemal77@gmail.com>
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

Update the maintainers file to reflect the new selftest files,
cross-subsystem, documentation, and kernel-internal Landlock headers.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3fe46d7c4bc..e9ad2ed1237a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14386,12 +14386,16 @@ S:	Supported
 W:	https://landlock.io
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git
 F:	Documentation/admin-guide/LSM/landlock.rst
+F:	Documentation/bpf/map_landlock_ruleset.rst
 F:	Documentation/security/landlock.rst
 F:	Documentation/userspace-api/landlock.rst
 F:	fs/ioctl.c
+F:	include/linux/landlock.h
 F:	include/uapi/linux/landlock.h
 F:	samples/landlock/
 F:	security/landlock/
+F:	tools/testing/selftests/bpf/prog_tests/landlock_kfuncs.c
+F:	tools/testing/selftests/bpf/progs/landlock_kfuncs.c
 F:	tools/testing/selftests/landlock/
 K:	landlock
 K:	LANDLOCK
-- 
2.53.0

