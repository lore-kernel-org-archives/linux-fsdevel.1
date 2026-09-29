Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5D2D1911
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Sep 2026 01:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790643652; cv=none; b=VIsZsee7f2+cT3sE3g+Hlq00NDGR6nJEQN6qTIgWtfqhm+204ZEkLZVcFPbTCcG6sBb5f0Eji2nefBFfyTWgt/y0wwdPcB5D/3SqJbYQFVNfk8YCmBs2TOxstAudLTC6E7xe87Cp9x8I6lKEe2+9O+JqeX10DxisNNv5xSYf8b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790643652; c=relaxed/simple;
	bh=tTvzke3DfKKWtYV8+SwzyB0UUAV5X0AJTYUDzhIU7pI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S+ZipzTk/FpcM1PA66aTURUhWboNS3qIyjfOxhL5HrJDwIvqU2y3zKkwGk1jbwjQjsViUZ1MWEl1jJ5xwCgL4HS+waF+W/zNfqYPeiZUEXF6ZiQPKWj8N3w7dk0TgUY7lBnmTy5nZivOxeaQC7CBA14bQHliUfjDYOgcgNqEs8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AoDDDKpK; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoDDDKpK"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6d817a94755so527553eaf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2026 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790643648; x=1791248448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6it+SmeVeHMYo8qun+39zeU0I/4M6Z51mplDGX3Lxkg=;
        b=AoDDDKpKwmXEmG4TjHmmL/aw293eFXnAK2hSnhnZPH72muSYcqOQQTj37QaccBGs93
         uw19NqPGroF8JVWNDhdHfldDqDgshPT19+OX/bzHXKBYGdiTTDTplPetWaNrd0BnJWks
         bSJd8Ts2U2ln5CJ9KYM/UJl7RFN8/gq+LDeJCN+9xXswFhq3fBSerWdEnHrT11vTwUjy
         QnHfiCocnAV67fFyl4lliq970mT9C80BO8FiWajGhj8kTvj1smNoDhnNmmF7LhtGWbAA
         cP4mwqzAMUq0WTobVnVczCpvJ+zkkf/XGwHXESg5EYBSZyUYwWcvf9tpPjt8ewLwub5C
         qwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790643648; x=1791248448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6it+SmeVeHMYo8qun+39zeU0I/4M6Z51mplDGX3Lxkg=;
        b=XKW915sdT66fIH0Z//gC+Bqkf0e5IYw1SlazuN3sSKiMPBbY9fhHRFdGZLF3mqJDiH
         IJhIl5FjgrHka2XTr0ZTbaMzlvEhewfqw9InIRP1Cou3DAvd6/bTdDKf6/fOwujiaofM
         xUDtkcyRKzYB0uihqCjHT5bSkUZOqho9wPyzf82fXyXPqqvS6eY5Xm1W5uFn+ypURi9B
         7ID4/SoATFe2FbmlVGhOSlFetoZyTgJiD8ZW/pjo6dSPQq2KF4ceBDHtXmeHKK/VUIb/
         xVlO9xe3XPhA6sS9Sbp589eaBMPxNomkAfRxSCO5l4m3k+mL9DKsOxpXUfJnii45M5hX
         6Z3A==
X-Forwarded-Encrypted: i=1; AKwUvBwT7BoT6gC2p5lxjk99LG0lIwRXRsQjdb9VZ1DYiOY3tuBl3QwbhR8USROmtZUiOeZYNC1JHS9ihl4oiKFZ@vger.kernel.org
X-Gm-Message-State: AFuF++mJaAdzsY6QZ2/lD7dK8FyN9Rxtd6e7fIshBaVI3Laq+CVPFKaa
	0e/4snUv/NvZhrjGy2P9Ubz2OBjwnYCQQAFjmcht1R5wHs/cSpXfS4t3
X-Gm-Gg: AYBFou0Kh8vsJbCyTegSYPmkkkIfY0NJ8StNM2OAkWCxVEfSVin65dFglS8z3SaSYO9
	O/e1jk6kwb8jG0oEUpkCwN9veMPpodLRpxQEXKX0DMjPzhHlbHbOFRuRsOOIONxhGR/BEe2hFea
	8P4joMhtR5vxVAH04moAodQKwhXgiPqjUG6GvUFaliDYI6FqK+cZLATJuyg1awMVNN1RYUtRocu
	mFzZqmrJNMSblrEKGe57m/DGy4OnMTtVQN+SnK7h3umU+Fz2QGByuLX9PUJJOg1dFQtDotEHxKE
	hnGPUvrA/0FZF/b5xUULXv6B5IGPet+KbLMlfmziEjuO1+qsMpGYT2SlJppwLEXoFG6pUhrAclu
	Xa7RNqflOeXbJ57zuGn1w2D9lw4VKUNJ9exd5NtEVFZw/Y0CFvN9+5soGaGoUjolKcThRfbB0vk
	/TkvioIdrLhmfQcOX1THIwF1ln0N7OEdU5Ywen00G6vKgox4mirBwA6dy3P/b/m9wt0XEHZOrWK
	mAz5D3l+Ea6zcXldjp3ibjXk7Opq4SQrKA2QyvLy3WMH58qKBU=
X-Received: by 2002:a05:6820:827:b0:6da:9dae:a22 with SMTP id 006d021491bc7-6da9dae1613mr1713830eaf.62.1790643647899;
        Mon, 28 Sep 2026 18:00:47 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d88358bb8dsm6410092eaf.14.2026.09.28.18.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:00:46 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] selftests/filesystems: expect EINVAL from overlayfs in fscontext_ns_test
Date: Mon, 28 Sep 2026 20:00:44 -0500
Message-ID: <20260929010044.5297-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a518e63c3775 ("ovl: return EINVAL instead of EIO in case of
mismatched user_ns"), overlayfs refuses a context created in another
user namespace with EINVAL, like binfmt_misc does. The test still
expects EIO, so it fails:

  # fscontext_ns_test.c:208:create_from_descendant_userns:Expected variant->expected_errno (5) == errno (22)
  #          FAIL  fscontext_ns.overlay.create_from_descendant_userns

Expect EINVAL.

Fixes: a518e63c3775 ("ovl: return EINVAL instead of EIO in case of mismatched user_ns")
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---

Notes:
    Tested on next-20260925 in QEMU: fails as above without this patch, and
    all 3 tests pass with it.

 .../selftests/filesystems/fscontext_ns/fscontext_ns_test.c      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c b/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
index 0f30a3e6e197..535bf1f4e1a3 100644
--- a/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
+++ b/tools/testing/selftests/filesystems/fscontext_ns/fscontext_ns_test.c
@@ -193,7 +193,7 @@ FIXTURE_VARIANT_ADD(fscontext_ns, binfmt_misc) {
 
 FIXTURE_VARIANT_ADD(fscontext_ns, overlay) {
 	.fsname = "overlay",
-	.expected_errno = EIO,
+	.expected_errno = EINVAL,
 };
 
 TEST_F(fscontext_ns, create_from_descendant_userns)

base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
-- 
2.55.0

