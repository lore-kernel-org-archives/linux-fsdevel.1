Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18CF2F12B3
	for <linux-fsdevel@vger.kernel.org>; Sun,  3 May 2026 16:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777824288; cv=none; b=R6VuaaqA2mOcFhHzQgdUz4WZkg7GXldFJvoSF/VrAQRtalQyZqaAYu+hL8vi576ohA6ZLEI6E81Lmg4rh4oa1NhWH34HQEocdhHJa/HjbS3CfTebUL6idD/OTiP7Ynre+I59W7wihuaoLTFOSDDL1rc4rmuBuwi5JiCAByomAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777824288; c=relaxed/simple;
	bh=bZ713PlyI66Y8baNCt5bU/d4ETaGu0rYRrgUFeTdUFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ss9qNIOtWaHNGbQpbloFH3CSzCtyAglz6+6DN8yG6jVgn7lkEs5Y+jk5It6v/+WM/H9Pp9OlHFldfb+QMQcczEi7rhRmdYJsVaS+DjTN0JKFd4xi3FKGJ2pvEjrkwIJii8wPAiSwyNNMEfXdxBte7iPd+CGouDGtMnc7lj4Fk2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fv8gmclu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QXxr2Ykx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fv8gmclu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QXxr2Ykx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777824285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X+mJ3ULyyTKCXVslNnzkq+GlbrFoX1sf8l7wRqCeWDg=;
	b=Fv8gmcluCsjNakPc5ZWrOM0ZvgcZyIVX28xWcX5gBkxypO6Z7OFdv+4Jmleztqy2IX4IYa
	VcmH0QDMkrb2gH9FtM+cvC4pTTwmBDgkZBx8B/fzq5n38kSPk6rXmFXpFj1O9gNrBnxSbf
	Ay+0Y4AEntuxR2XW6mELCyh+h7la/9E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-FsCESS5HOW63wFnHkXiuhQ-1; Sun, 03 May 2026 12:04:43 -0400
X-MC-Unique: FsCESS5HOW63wFnHkXiuhQ-1
X-Mimecast-MFC-AGG-ID: FsCESS5HOW63wFnHkXiuhQ_1777824282
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-43d721a4858so1790366f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 May 2026 09:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777824282; x=1778429082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+mJ3ULyyTKCXVslNnzkq+GlbrFoX1sf8l7wRqCeWDg=;
        b=QXxr2YkxaNoD341tdRmTqSnHShQF+MxBiNDFOCtWefQvK1eUSj9UyW2grGSB4xXkZH
         3dppFtVVyFVgMEKwkLegIpZc6k8Kk/rd4b4aNcVwritvofwKIXbpI78d3UsUXeBTeqg/
         PdtMQw4pj+7/+HfhaV2XrYQAmTawcEtYTrh0T5g9jnVQ0xcF2tuvRVVa44GExv/yOWae
         KcopnmstMLt0nuc6PTRcYyCCx02sPj9YVVRwZQ5me9LSOg0gQc2STVx1maXICc1s0KLt
         HZeexNB9hlA7yAQ+MKckHi4Ytc2ZqtwjCQUbKix/X3r/QTXf5ruCb6Tu7d5h72ygA4W5
         /Tpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777824282; x=1778429082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+mJ3ULyyTKCXVslNnzkq+GlbrFoX1sf8l7wRqCeWDg=;
        b=UhIcbg0k3hctciALnAX/6zs2K4ileh1ru0ZsWTg30+yvLQiqtP/JtG6YEYv/oUoxml
         3G0Cu7gWylA5hcsSEZRTiZtmLRvnjt43Ss0/2S2elxMqu9nhm/23yTuZuOU49GV4sgpK
         8BXSO+wM9Kncr0mntgcKse0k3Obc8J5jtGE5zkCLbkOIHUFNfMGeNiVhraG+IaIu1SZb
         OIhmnADUAr8R8Ebug5F7xcv7oOLiEyfzl/0UKaCkuFW6/XW3Ay4+u327RM5kvcZrAVZN
         AqC0fy33RwVp+s3T04cME9aCYMkZYWcNlnp4zJaS5sXVNNaLEnw/HR47XVBFd41yiXmg
         llAg==
X-Forwarded-Encrypted: i=1; AFNElJ9QKUdBbcew8Yk++8Lxa+IB3e4tYSHVQ1w4/KpaZZD8vougdS0LwXgml69mANo+CNghVV0w7XqIChF6bIgE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg1x+fSQ2xAG+andXJ2FgMw3IK2NF6HmOzsCBo4mEJP8W9ek9o
	zQi6tiK/6vnkDppYE9fYA91f6Z8zxmbihoyf/2IeJl0dpHDMValWIZgszATG3vl43ue/s2RpYql
	D6wH2HanhfbUEuhp7rp/PJC0UxLSoN4XZu2SN9ASvF06diLVbfZidkeaXx5RpGVoW00w=
X-Gm-Gg: AeBDietcU6+2TwRhCBIX5GrPNYhoakf18ci0R8yWaSZbeHntUMI7FPiclO35bGYYK+l
	8StfNJqWkqOeX9PQcHAzqRCButsUU6fvtIWsErpTNa9DGi0FH9HxQPganablUW5ILYMn94N2rMM
	TLTW55cTVBhO81NG9BT9tlNXJuuRTZe+KGo3LrZmQH3i0mSFsimH1EvmLjYbRBtJnpjTBFHogI5
	/o00q/xLh6ymkRb8ElwkuRa/L9Fm8+D8NlkDtDfpA1KKSbfrPqZsVtR7iHLLy8ifAzkA+k226Eq
	1L903yv11Seuqtv+3Ik86c2XwDZOgkkRcB+fq1XS7Iq2nPYKH+C43Tp0+oC1DL0yJ8SMQTXNXfX
	k9aSR7+bb7xEHC/FXpGW6IJIpggjPp7wWe07OE5R2aeSmp3m2
X-Received: by 2002:a05:6000:613:b0:445:ed7f:ce84 with SMTP id ffacd0b85a97d-44bb34e71e3mr11488048f8f.10.1777824282480;
        Sun, 03 May 2026 09:04:42 -0700 (PDT)
X-Received: by 2002:a05:6000:613:b0:445:ed7f:ce84 with SMTP id ffacd0b85a97d-44bb34e71e3mr11488010f8f.10.1777824282049;
        Sun, 03 May 2026 09:04:42 -0700 (PDT)
Received: from costa-tp.redhat.com ([2a00:a041:e223:1b00:fe51:8bb:7986:c897])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a981ded99sm19800555f8f.18.2026.05.03.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 09:04:41 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Costa Shulyupin <costa.shul@redhat.com>
Subject: [PATCH v1] docs: locking: Fix stale dquot.c path
Date: Sun,  3 May 2026 19:02:22 +0300
Message-ID: <20260503160221.1594319-2-costa.shul@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The quota code was moved from fs/dquot.c to fs/quota/dquot.c
in commit 884d179dff3a ("quota: Move quota files into separate
directory"). Update the reference.

Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 Documentation/filesystems/locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 8421ea21bd35..277e49314d32 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -584,7 +584,7 @@ write_info:	yes		dqonoff_sem
 FS recursion means calling ->quota_read() and ->quota_write() from superblock
 operations.
 
-More details about quota locking can be found in fs/dquot.c.
+More details about quota locking can be found in fs/quota/dquot.c.
 
 vm_operations_struct
 ====================
-- 
2.53.0

