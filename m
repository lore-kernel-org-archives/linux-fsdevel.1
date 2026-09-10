Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA9355F47
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080524; cv=none; b=kbboQ9J50JqI3n55B8uM1tZieM9ux47BQuihkElaa+keT4NlqjXIK8Twfmc/xVlGz7PTfT0bghyPQ/Lz2z/f+vHwVuihb3ouNb/FqQ5zTOtLxQgmBCVuAV2hhPatCcYLqGeQoaTBs2od6BLX7zMA6kcI/QcAar0iLbPyFUwihh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080524; c=relaxed/simple;
	bh=UppgDEdeN24Z6bDVGx8PjgeRPS7f4gtYKDr5pla1Dik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o44d1XVvTKCuYi50+15h1/LdRlSyM64tPyTHzjgYVhR/WHrJ6Hi9bGHyJrjXbpLIi5cNi/kIz72PST2s1W9fpjB21uwtSQnfVaj1cvd0evMOnnvlvQt10ewL2I/4Hr2xL4CTVxWdz8DW2Jm46GYOFFBmr8Bic04StGTxO+aTHtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7WDqS4t; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7WDqS4t"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482e1b55da9so27831f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2026 15:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789080519; x=1789685319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LgrTte8+Zm3JUi96agAI4ZS5dvZUFrbR10h0R21xs6c=;
        b=E7WDqS4tvtHZ8OVqNFj6tHq8EuiDGRv9bWiY6inJS5/JpqCU81odyKddLdmJpf1eVO
         Hjok5l3ZdqNErMISpNwLZB5AgJB/TzqOU/ilwyq1WvzVfrQvpqI4jlluCLpyOjGEzFap
         q5L/qJaZrhbUlh3hVT17ZH6N+ruZuQ+fngX6ElzXsXXpLIgDvjcJy1+Gd+jZm0yPC6F9
         3VkmI5OLJzKcgro3wgWRjm00lTj5Poo7wtBcKcTR7F9sL6GleM90bNr7WTcnl4oNd/pL
         HQbtfOAXaAt/6PmkhI/GCqU/apr6Ydwl0ZjGKIVJmDyF8ZJ0qCukzrEbnPdxUr6HC25g
         U6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080519; x=1789685319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LgrTte8+Zm3JUi96agAI4ZS5dvZUFrbR10h0R21xs6c=;
        b=Dn4QOSvsT1wSP6eWFilZ2ZD4HrsbuClHvZTaNLNdUZTM1Q0+/wjl1CvUUGQHnE+RmX
         VzqPK/Vx9Wq6oUZUjd/4JoB30UUIICsrG1Pcim8+qAAOLLuswYStPK4kMcEcONLd9b7Z
         SNfTpMUtfAPK97ZB3spAFi6EthQQKVRbA2qxDm4BaS2dK7NEvU+85wjfgMgJuj/roHHh
         O4L4bJK1JvOOP5bUlpjaorQwqz1ceDwhO0wLmM12alY/hSltU4UHxpHaSaOCDUKiHuuf
         zlok5ZRwpNKmBh3lh/y/LX7dA5wHTKGeGZYpSC+7dBW/Fp99Zzvr6pRmkeCNj0XF0Q3m
         PMKQ==
X-Forwarded-Encrypted: i=1; AKwUvBzvOgwhRHfXmDXTY0Hw/gTssaKne2W51q+Fzrsp3OpKE7Rbr2lX5Ha0RemWEqzKfBFew9yYV9QkckftcqWI@vger.kernel.org
X-Gm-Message-State: AFuF++k+NzcoJXNuNuwGug6tLrpfJGHsTTdujBImtCjDb2Lq6rts3hYO
	bOveYuPp49zXB2KgwU2v1EQ/XY7qBKYxF018vClaZKEramygkKeBMrbR
X-Gm-Gg: AYBFou02aZutI8HeMqfGWwhwhQBdF67/iFwjkcaxfF1o0w4PM4MpdOoga9Vdu6+i2Ff
	aRFUMt8MppwwjReSuWiGHl14ndD86GBfnbe1Q8JXdU9GB7odenixKv9tnkxivviuBbuVfw4mEJE
	j13V3k2M10+yHcgHpjkvGLpx1/5cp3ffYxq/yy5oIZPhvjW+/RLDrwgms/gwitACe4ohqDPfTx7
	eDKdyskomyHyvQA1nQ1Lcu/IsXtWEsPufhOdBOAEIsIZo4TkL8QSFz2DXFuVzLPbZ7tjVz8OMjI
	izeMeon3e9yqPjnxogycGIlggfZYpB11LhunHGvmARTjKV2ii4fHRv0St5yTMgbi/+ESspUU0u1
	SRVm+tzMq0rKzXkddLoHogdwAwFLS+ypAHCUJ6B1TJ/nA0ToVu6PhIvCDdJb77KmsSQdiVIwClV
	UzmncY31aWavWrex8k0JXr6Yz3gjaJbxMVmwu+8soRvaGRsTUeqohtLDzXPngyseYmCQN5Z5Hny
	hofYHolPgXd3yiHZ7Ex2KSEABdJZSlz
X-Received: by 2002:a05:600c:b99:b0:49d:1da4:511b with SMTP id 5b1f17b1804b1-49e619a8962mr11821315e9.1.1789080518610;
        Thu, 10 Sep 2026 15:48:38 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eaccaa1asm2021565f8f.0.2026.09.10.15.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 15:48:38 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: tim.c.chen@linux.intel.com
Cc: brauner@kernel.org,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	imv4bel@gmail.com,
	jack@suse.cz,
	juri.lelli@redhat.com,
	kees@kernel.org,
	kprateek.nayak@amd.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	qyousef@layalina.io,
	ricardo.neri-calderon@linux.intel.com,
	rostedt@goodmis.org,
	srikar@linux.ibm.com,
	sshegde@linux.ibm.com,
	vincent.guittot@linaro.org,
	vineethr@linux.ibm.com,
	viro@zeniv.linux.org.uk,
	vschneid@redhat.com,
	wanglu.priv@gmail.com,
	yi1.lai@intel.com,
	yu.c.chen@intel.com,
	zhanxusheng1024@gmail.com,
	zhanxusheng@xiaomi.com,
	ziqianlu@bytedance.com,
	Kayra Cizmeci <kayracizmeci@gmail.com>
Subject: Re: [PATCH 1/4] sched/cache: Keep nr_pref_llc_running in the runnable domain
Date: Fri, 11 Sep 2026 01:48:23 +0300
Message-ID: <20260910224824.1209785-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>
References: <82736e1329bf8ed195bbbc4990486c87094e6789.1789061845.git.tim.c.chen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Tim,

I thought about the older messages and I think it's really not worth it.
I mean, even if I'm right on 1 call site, the others won't behave the same.

And I think this version is cleaner anyways.

Only thing I could see was that on 1/4. 

Feel free to add:

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>

Now I'm going to sleep. Ah..


