Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160B480951
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 11:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906286; cv=none; b=kEW9LoCrkfg0X4tmGfw4J/9+iXT2tQ0ls441RiCMycFoz6JekPwlFJF6GumPcFlkEWZQbqINjfyb4IsYPqcsixZCXDGgH2ypMIEYobrg8XdIq/Dnk7BN8c1fWb0WHoUPZ9ZQmAizYgNekeDfPSfFsidbQXCkW9XdGJsJc5xdqCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906286; c=relaxed/simple;
	bh=Bn7cpK7c9P1Ng+xQTLrX5oRSvaP7UkoJRFYhjK+iQcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GP8fUwHULmg3joGecsQmG3gsGmAwFQo7eUj0fZbkRBfWsfQRCjgcxsBDvG1RHrijnnfztDWObEtVQt87nwgHtUAql4gBEzLJqpEBTOwBbD1HXsSrYQfk/jpeDwjcCV1Z3lasEX/H9uF/eytExq205GixaEUa2WGxeI3DTGX6vHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=C0e0vY33; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="C0e0vY33"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92b21f65b60so143515985a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 04:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782906282; x=1783511082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CWuXB5G6o/EOutDklrz0KDK/EngRzHI91oIWGAEJRck=;
        b=C0e0vY333zeAMCS/zM/pqIYUkT/ypLoAkXN5K7p8Sd3JoEhBloB5jC3LghM1QSXQ53
         9v/SHNallheASGhxKVytCtMb5RzQxCr/z+JoeaW3Cn7xpeBBlNC5ewKyiDfA6KEXV3ng
         8QEc1DuOO0Es0pbUn4FR5DeNdATltUAdi0shnf/eeM57mwBEDjatSQaNcaVQbmWeDDHl
         JER10VKk8fQF8KFQ20MTcP9TK9v02gKqj78yRWZwXHccz6oFQ02plz5WswNqCOqP5rWP
         0LdKX9rZJONPayNPmWQuBmzK4U8ITV8FnwWf97bqDM+rEOCLj92O1wDrGESr6xf0HZwd
         9ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782906282; x=1783511082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWuXB5G6o/EOutDklrz0KDK/EngRzHI91oIWGAEJRck=;
        b=apF8rV4GH5BUQh2vZh3T3IT7HrSvPsakLt2aR89il6zI3liGzEebIdiISYs48iMFpi
         yqGv35YzaFS7Fd4G3NSo4OuL/5/vVQMMiHRPicdCu41Yu7qiq5a8kqChGHE8mCBrMb9h
         9ezZiDfubE9FCf7j8Nff+JL6Hz5GicUUdldwVtg2ZImOvO+2BKpAJ8Vxw3GID/OUBbGa
         BgJp3Napy96vvl9KpWGc1R2f0NkSutVcwakCVKCnqz7+/hyhyxCU0Epd9Uglyt5HPxg2
         EXLbeNbCPYSWUrZu3L3E8Y6q8oDQxawc4BCRL2YJZ6zglSEE1UJ3+tVTd07HF0EnF8qZ
         B7Xw==
X-Forwarded-Encrypted: i=1; AHgh+RqjF6HC7T9NUtoqxu955Ir3ZIhw2tP0CjBN0yXJZCr3l44E2oFevKJKYHteEIh/tjHZJWZapKAk9WZmBMMG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkf729PhMCf6qU2uNOeN8Frd+Us8PaKmcvD/CjdOvsN9xombla
	4wpTdvTS2bgr6X7K3Vn/y90qQ2CPbnH746dkrEeEY2DK1ohbNAhDBqA6LIZHVOSiH34=
X-Gm-Gg: AfdE7cnlFq2MhwhAyVadDQfUyV7AWUtMZmljXzqLZxX3wFVdu5OdnHfKA0o0nTeRAwq
	HnS3n8XecdTShfLDN7HPSe4QmSi/DgKMQ/2feI5BSO23KqsQI030pOBdM4IZlSJ4qFALWzNwPZS
	GWDRrI861+hzUqt6hpNNi/AZBD4kSxdO7CbD6Klle8tZEwZ26iHfTXAoHWBwsdQgrh2bLo66B1s
	VQg+7KuS21OiyqGtd91IqXy8/WMUgJkRGgwR93mRiks2CGUrCcjvfTuIkilqScZIfIXmVJkST6V
	NoNnG9g9WfTmaG89Vn7FH9tmsWwmBjgNcu2Xy18EtdRPXjBqV5mq+46hbp3MuDQ7PTeNroZq2mj
	1k31F2QtjTXuyZ/Ga1rlYAfFoIj3SIfCt3/dHlen8iibtuYP//xXqDeZTzwmr2/g1qprmzxEYAs
	Uuwbys74Zq6/pX7+MmOg==
X-Received: by 2002:a05:6214:4e90:b0:8e5:8d7b:5188 with SMTP id 6a1803df08f44-8f2526fa04emr73202606d6.9.1782906282086;
        Wed, 01 Jul 2026 04:44:42 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-8f3611dec91sm19921376d6.29.2026.07.01.04.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 04:44:41 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: viro@zeniv.linux.org.uk,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: David Lee <david.lee@trailofbits.com>,
	Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jann Horn <jannh@google.com>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fhandle: reject detached mounts in capable_wrt_mount()
Date: Wed,  1 Jul 2026 11:44:28 +0000
Message-ID: <20260701114438.24431-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The recent fhandle RCU fix moved the mount namespace capability check
into capable_wrt_mount(), so a non-NULL mnt_namespace survives the
ns_capable() dereference. The helper still assumes the later
READ_ONCE(mount->mnt_ns) must be non-NULL because may_decode_fh()
checked is_mounted() first.

That assumption is not stable. A detached mount from
open_tree(..., OPEN_TREE_CLONE) can be dissolved on fput while
open_by_handle_at() is between those checks, and umount_tree() can
clear mount->mnt_ns. If the helper observes NULL, it dereferences
mnt_ns->user_ns and panics.

Return false when the RCU read observes a detached mount. This keeps
the relaxed permission path conservative: a mount no longer attached
to a namespace cannot authorize open_by_handle_at() access.

Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Cc: stable@vger.kernel.org
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5
---
Bug found and triaged by David Lee from Trail of Bits.

Trail of Bits has a minimal PoC that triggers this crash on a custom
kernel build, which can be shared further if needed.

 fs/fhandle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 1ca7eb3a6cb5..f8829231e3d7 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -295,7 +295,7 @@ static bool capable_wrt_mount(struct mount *mount)
 	 */
 	guard(rcu)();
 	mnt_ns = READ_ONCE(mount->mnt_ns);
-	return ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
+	return mnt_ns && ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
 }
 
 static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
-- 
2.43.0
