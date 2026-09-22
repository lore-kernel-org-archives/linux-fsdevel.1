Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B1F37E5F1
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 03:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790046756; cv=none; b=uCe3tLW/sqrAHAwEh00XkIWN1LDKgU9LIa8eeuPjjoZ4LqAa4Y/c/hveBj/vVfJtBI0VKZstByqgt3aE0ys1Gf/gpS6iFd0FcMIV1bozKh5MVElFDf25biSVMxCsXZAUtVPpqrJVJL5J8Fqfcgk588urO4iejhuhQO1rP9296cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790046756; c=relaxed/simple;
	bh=9B5L81kvVSXlVKSqFNeGPUoI3a3c4odt73AUe65yXX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2OYP63v9ldZj6lFakGr1cDruiXBXDiq/yHowQN4kMwx44Lxh3rEWgqTYXYoyHD+8pILDhVW/maF0A4jjwEgJO59tYIK232jdviwH1TDmLGvPgKwb2B+NBqtqT4Ueqi6Kd15HiMflxCt1GFvGdrR2epjDpPIyvpeH44sxxMPZaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oI852utW; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oI852utW"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so2843637a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 20:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790046755; x=1790651555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M7jvHxTv14GtRHevnUIJSj/4ENOuym9r9hmNx9q8r8M=;
        b=oI852utWqgN1AoQJn9zVJil6aaWCIi/MYzdESr7UhYzu4f4eqa0pl/Xnu6xB/gnaKN
         /liNrUJCN69ebkEzo4UW3ms/ZUcfmW54VMrporansmc3M2kw+XSoCg4ZN2JffWB8AvQM
         WQAkpiETikh+IGxG40W0EhZlQpF+cTcIskEJJlAp10w2pxKZMPtNAkg/la4u9j+3PsH+
         x2V04HHzvpoTNqE7cpbLfWB1rgJgehb8kPzE0iAJF0CUQlvTQqoNgDfAiDFYWHJmhAGB
         ChG7mQzua8mmr7MBCKAfHVuQHyYNS1lmuDocBI2JeUuu5b9z7lEv5MrE0m2pIjasp7Ot
         EXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790046755; x=1790651555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7jvHxTv14GtRHevnUIJSj/4ENOuym9r9hmNx9q8r8M=;
        b=xxv9UhYj9bldEPIYeMNLAXH4kXUS7JRKnRCvLLlITJOUn+LZy6dAMnmOq7gQJabnnt
         7OMg7Cl0lVTjy/eHK3OceMhI3LGyxe4+vbWOqo07TLl9EiTfvbKtL+0+7OyCqsCHIPbr
         hVsU/gSjELr3NgKtWtPqCG41ocNTadQdVoES7x1FVwxwq0iSnj3YSKenkO18O05sMDaU
         ZW6D+2v1JQBmGFP4aJGdiYJZnG6Vwq5b36bbQctsqkPHWwgWkg3da58mYfooxhQ1BwkY
         E3Icy/XJUpg/AJA6MHboW8BC0Z76b91A1xr7Jm61ASRyV+PuHK4t005qa9PKWozTcVc1
         jvQg==
X-Forwarded-Encrypted: i=1; AKwUvBzHLQoDiVMd5Xo1IeixgXfA6saludyIK4FvRadKW1bhUclnY3Im2Ahf4dXFuv2cumvEQNr4VbR67BFI4Uwl@vger.kernel.org
X-Gm-Message-State: AFuF++lah26zXGxWNHkg9LiRuCTVPk9jjDgKW7kyg6TOgIGURYnqElCU
	h8Lw0iDLSGzeg66PElBB9+ZtRlhLQcOX/11+PFOBUFFtIfyCCBlRK0pnCydbpg==
X-Gm-Gg: AYBFou0jvizrE4CBMpiCmPNtLiiFRf9ZgtGXurMj2Ls0yG0NxjAxWi8CpAX9gHvDpOG
	ZMnD1q/ndrkW317eciiIt9Qdh5c0GVtdjhpfCF0caTEAQIHV+TNyW2W1TQexqWUftXybcyWaHlt
	kFWxqf0SH8zEIP0dcNz/tmA9yNmlUFiqM+GFMxZ0j0se1aIUyI9hB15K5PhKeFhcQqlqnYg7Qed
	TsU2G1DKw1SZ6+NJOp3TVTli3/tHgWVb4rq6+1+yP7EQ3hR2VEo73MdpdYIAwHEICT2ShHwajU1
	aOHc0Y2bLNEFha8YFk5Vdu2eddbnNV7ZD6mTa50JWSUThf8rqtwGJ5eIJsk/0p4Z1nuN6glDM0J
	Qg0lV7sK7opEwtMs17eOAe4PCA+ljNrx/M35/nDOamKgOKOfrjkMkNJZj3ZAxsu7L452R7WMrL/
	DJXKhxadO8ooVtclnzMyjmnGyY7AIQ5+4qyOG99q+8FNOaU0qoShSfbDzxbLGTBTubxnpCPwNkW
	z0/GVRI/8U=
X-Received: by 2002:a17:90b:3ccf:b0:39e:4c7f:7309 with SMTP id 98e67ed59e1d1-39e550784ecmr18060387a91.32.1790046754990;
        Mon, 21 Sep 2026 20:12:34 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a06cbe3714sm294627a91.0.2026.09.21.20.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 20:12:34 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: kees@kernel.org,
	joel.granados@kernel.org
Cc: kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: [PATCH 0/2] sysctl: Two jiffies converter regressions from 2dc164a48e6f
Date: Tue, 22 Sep 2026 11:12:26 +0800
Message-ID: <20260922031229.2300283-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following commit afdf35cfae0d ("sysctl: Fix type truncation in
sysctl_msec_to_jiffies") I went through the rest of the converter family.
Commit 2dc164a48e6f ("sysctl: Create converter functions with two new
macros") dropped two guards when it folded the open-coded conversions into
macros:

  - the read path hands a sign-extended int to the converter, so reading
    back any negative value produces a wrapped number

  - mult_hz() multiplies unbounded, and the caller's INT_MAX check
    inspects the product, so it cannot see a wrap

clock_t_to_jiffies(), used by the userhz variant, kept its own saturation
and is not affected.

Tested on x86_64 at HZ=1000 under QEMU, writing and reading back
tcp_fin_timeout, tcp_keepalive_time, ipfrag_time, icmp_ratelimit and
neigh/default/retrans_time before and after.  I did not test 32-bit or
other HZ values.

One thing I am not sure about: afdf35cfae0d carries Fixes: b96b5c6708ea,
but the "jif > INT_MAX" guard the ms variant used to have also went away
in 2dc164a48e6f.

Zhan Xusheng (2):
  sysctl: Negate before converting in the int read path
  time/jiffies: Saturate in mult_hz() instead of wrapping

 kernel/sysctl.c       | 2 +-
 kernel/time/jiffies.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)


base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

