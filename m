Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2942D1F44
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311001; cv=none; b=iRwHItYlGv24xDI/I3+N6venMeLSjlmAU2RaSjZ0CYhlAqX6LgtuUtSCFNpP8IQbwh8c7G+DVfXdvQzRR/YGjtHaph4pxQQElNA/InOkhotvOxDXyfd/xGfgKPXlUARimOC3xS3gDSQ6UdpwPotx7Biqo1jv3plbV0QRelwn3lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311001; c=relaxed/simple;
	bh=LubrbMnxIKnN7lBVtvVGlZxjV+CpntlE18ShoqLWK+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aq21kaWAcMCzVNb4HF0ld7TcWpMxm3CwzSJjAUJqEUso+uCAHZt8waEumpCnu0FFcJsQKtUE45IgfVFSVMV00pzjM160nbRnAYlfzif6rfr33T+4A4uLoOo42ljtI3xuLWGeNS/ESH0l3+IBo5kOwwa13CtAvNMQr3cjHXSIV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rS0/MFLW; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS0/MFLW"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccf3ca94bso4820125e9.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789310998; x=1789915798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afPZZL7err8emUCp6Hyuu5QUo4GAQSFPzGqL5FJ8ZIg=;
        b=rS0/MFLWDopHFHUzo5HE+aWhwaVj+vUa8JayLN+PCNMBXHJyZxUz1Z9b43v/Z9Eze1
         uf//V08WJyfEhVQZ+sgHmHtGH+OG4OweFteYhpH44nRfYeZORJHOs5foa1fwAgrEszYU
         OEHcpHM6cdoDlIg+nHI/DDN7FkHmtv2PtStVoroLsygH/ay1I9q4krLbpJGvzJYsiPaj
         7jDF5zvk/QTE5on+eSQX3R1tW483mB+JVYFF3nNve2pfq60FLwXZdU2DJlve3xACqCwT
         +UqcH10a7M93Zbege5UcH/ypVq/OmX3CMBAfEjtwFZJLwHymjeQpJkBUwDwzK8WIW6qd
         yASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789310998; x=1789915798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=afPZZL7err8emUCp6Hyuu5QUo4GAQSFPzGqL5FJ8ZIg=;
        b=gngyw/win1dcIcjuqYObmicMt/vl/WUTCMYQ++dG9rMzDVaB2KR4vXxnMTgQ6klDrA
         STpqYVf57emDnWjjOWF4KwLs0zR1FLbtrb8bxBcI4+J4zzklSousmD2611N3Lq9pIbtd
         kGk5NUV++iyanWeNbTol23rZVVzNT7DQZn+4DWz0o0L+ojH9Zt6C+qHBQJXtgk0ectei
         r84lHCehAbrTdh9tPdCsvXtwaH+5pzxcT5KkOJ9CoSKOBigsil/JR4hhBmgL920JUOIY
         QAluCcmQ/bgxMllfm58qAr2eFVtS7+vnWiVAip8Ra17c2WH+XEnq6bnFuz1OM1paUJNS
         eZNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzpJlX+Qedp5vZL2w1d9lPnp86dASqIZO+/cObMePUseSCTUwpOEcqd1wi0hT3tcFdelJKTL38dlJ48ngKS@vger.kernel.org
X-Gm-Message-State: AFuF++lg8/vXsSxuXPtKqsgo5j0FcdU40OL5ng40dzX/cT1ifO8V8wlV
	x6Gn9eTkEqmYEKGUaUaPjpU1HtZyMkcl3+g9vNND0oEgj7owOxootog+
X-Gm-Gg: AYBFou3Hw7dvY0dPL/z7nx46UP+oh8Q0UmbEt5woK6SxODfKq48obIRX5BOJrLMF2Me
	mMMp0fNc+AKgRZHUAECtcFrnxr9MxcbmLgwitAl1HSP7oYxMmDSR7KLLPW7OsqieXrM8gdMluW2
	RQOtu20wsE32+4JbzxP/m7ZVzOB2dOrjKVl01cwTWIlC4e2Wqp4eKZ4Sd7X3CDBJSlCJSj4KhSs
	Ud1tYY8i6rAut4bIW/+b9/LnG18laTiR/NKU9opxEXgzhV3KHgI+P38+z2epdvvCQLwU5WZ0Bnu
	BC/XMAjhii9dRX282hbf/h1SwuBTmAhBpoN34DAYfL0Y7+mlaZw37kkRYA/j1maCE2uzFH8tWQB
	7arl7TeIstYogCOJrMYtAwxxyvjoaOGPWmQS74SXp67qS4qnwFfhviFSxrnpS07pQYbf9qB+8M0
	XxactvgOvtFZIZJUoW4CS/7HSu4gWhbWZEa9SjAdmdz+TXU+vwgaPQ/vlQeafYW+rV9pGObqciR
	0s0sdao0FYNv0CrLIcOUmirvwpPy49fvM+G7x60H5g=
X-Received: by 2002:a05:600c:3ba5:b0:49b:8f18:714a with SMTP id 5b1f17b1804b1-49e6caad1a5mr80018295e9.12.1789310997702;
        Sun, 13 Sep 2026 07:49:57 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:49:56 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 05/10] fs: use path_clone() in backing_file_set_user_path()
Date: Sun, 13 Sep 2026 16:49:12 +0200
Message-ID: <20260913144918.1606123-6-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/file_table.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index f9d1b5edd6ae..0dca0c6c991f 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -70,8 +70,7 @@ EXPORT_SYMBOL_GPL(backing_file_user_path);
 
 void backing_file_set_user_path(struct file *f, const struct path *path)
 {
-	backing_file(f)->user_path = *path;
-	path_get(path);
+	path_clone(path, &backing_file(f)->user_path);
 }
 
 #ifdef CONFIG_SECURITY
-- 
2.53.0

