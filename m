Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362634FB9B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789565660; cv=none; b=KcjufoTKc+gRudNUSKtI2dGwgDafISxU/MVRiV9KDSa+VH7MMg06qPwqp2IXem7l9bFv/TCwklwlipbXifRSonYxQ8z+n9sah67ZtO3MdOlde7W9yv6jm9EaiZwykXX7uZ+QVU5Z/xEkeZ/E0Xnrg8HoB/LYReO3PQgjCnGukdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789565660; c=relaxed/simple;
	bh=TWTYiq5qy4yczgvLZWe5852fv9kP7nXzwOzboAO4VhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVwfWXBxz1w+vEsHbK1UugcJeZjel1rZM/EMc8/wtUpI6qHgoHCXHMsvJ3YZEZjTXjUTk77cT3UeyeooUTkXfPS1zC2n+5mTeOJV/terGdhqApVf0MflazB6HHWyWw4fOwNbpoLOlaOnOrbI05Ws6NeRoJB1ovvGspAiNfVQe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YORpnS6k; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YORpnS6k"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cfbdac7a1so703155e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 06:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789565645; x=1790170445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKxhsj7x2KGNTWtDWeg+zi9RZVEL4pyqe1TauKiMIHM=;
        b=YORpnS6koHvO4MR9LQ7/GuDjQpiqBz9rxLRHUE9v4tcHIq2J3qmC2/yGE3Nw3nfI2N
         YsHw5/jrLTFkPHHpBr/OXt7oCU8rUlHMqWaYwbFMMlWFgMRVJR8yQ5KPb0d1q3HwS30B
         GF4GGeo1ALUzFaeGSuD5frMjS208Tlc9x1pnl581GA4VKEKbJarc1wq5hoSzeQWxtOTg
         twYliD3nz3ZpXUgEKTML8K7uWPuc/aN3zWZqGQo9F+soRvBKEsTfkzPxcyOmVxGwiN0G
         /QTV/3L2e4r5maVYjPVXskHgHk15IhTn29OA0jMxFC0MXXlHV9zr6N0NlfWKcv5FW3sM
         9wxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789565645; x=1790170445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKxhsj7x2KGNTWtDWeg+zi9RZVEL4pyqe1TauKiMIHM=;
        b=XHL2x9Jk6e2Qk155z4uFvWbyPLWEBsLfRBHAqhJUdIZq0uygdlBrkXkHDWSLTQS4lo
         wE2YpVaVlA8ZRjVpPNlUPUnUOhNfZOWWNeSlzUQD8YXhwrSxNGNmrJnFakS9B+dG7xKr
         wVoB5tO9hfAlejeR8xsV+uH1Yi99HhhX8681NbTOeyCN5ryWgvt6KbbrGGHAAl92/2cq
         DIxkdBH3VZObR6pDRBR4cdIfPBj6MQ5PPtfan/1mRyMR+AaNcjb++br8ZuKMBY6wFOH6
         EDUVKOgWirAK7BnKV3+TSfCbOThv7fUQ0hsilDSStpcA7Kh9u29mJM//zCJR4x5ieyOj
         YR3g==
X-Forwarded-Encrypted: i=1; AKwUvBwq/dWet+I2+sSUqTM/BHSvzAvjVvlEdcD8nvXY0HpSaxLRDshwjJgzkF83DBO9yiYc9IKC7t3XSM2NGQ+Y@vger.kernel.org
X-Gm-Message-State: AFuF++lgM7RM0qkGPzsXaxuSveEWwAOYvbfMGbCqKqm638V4xVrd3Rf3
	kuucnK9ebNwO/wgUjlJApE4xxvlkLaYDFBXvv9p+dbcWfHr9Nb1BZ7kj
X-Gm-Gg: AYBFou1zWEflkejj+cjA1/7U0Ly0wSBoADvaeacWfMGHPJ+DfsoMs3rw73YXdZ7keUH
	RGSApdG/5o7V1JPFTU8X24664PR/KUuwvgoDdKODWX/D589kCxB3Q8gTA5c/rGplsQj3k27OCZz
	4Dbi9AWhHQoKmg5/et6zDSw/c4Gcp4QvRTPUf0gTYF6nrVBycG9+L1pbDa9Qs3lbp5tVa0syxCv
	nNaOWX2tJ06+SgSwacS36kMM3XFxIfFc0oRpE/DJ1aQE1zAXS0GSt2KKuShPCKChJ8JEeI/FMHb
	Kayg0CWzPIEo3nWiL0KGBA9xQbw4JQt6tvPAbShOVYp01f19XMZ+aaCt2Wvx0oTmwrOB4ZrgF7V
	EZQaPZz8BObXnsx/3bf4xCEYeRl3aI0WpXCgNQAF57Em2OyZqv5guqC695F+ODbbPw/wolYvDot
	QJgV0Etuz4335DrOaXi/dHQq0m5nC540EYiGaBEzOUSf/Czkpw1h9kgyeZbe5xrqaYdyNHaJ8q5
	sFNeDAo/0rSO2UuXmInfSARqlG2jtxaqA==
X-Received: by 2002:a05:600c:1f84:b0:49e:6806:5712 with SMTP id 5b1f17b1804b1-49eb733596bmr27842625e9.2.1789565644472;
        Wed, 16 Sep 2026 06:34:04 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1fa70sm6931392f8f.9.2026.09.16.06.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:34:04 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: peterz@infradead.org,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>
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
	zhanxusheng1024@gmail.com,
	zhanxusheng@xiaomi.com,
	ziqianlu@bytedance.com
Subject: Re: [PATCH 1/4] sched/cache: Keep nr_pref_llc_running in the runnable domain
Date: Wed, 16 Sep 2026 16:33:28 +0300
Message-ID: <20260916133328.3422-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916123046.GE776954@noisy.programming.kicks-ass.net>
References: <20260916123046.GE776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Needs a fixes tag.

Hi Peter and Tim,

The Fixes tag should be something like: 

Fixes: 714059f79ff0 ("sched/cache: Handle moving single tasks to/from their preferred LLC")

This is the commit that adds this:
env->src_rq->nr_pref_llc_running == env->src_rq->cfs.h_nr_runnable
thing. It causes the issue so, you can use this, Tim.

Hope this wasn't a unnecessary message. I wanted to
say this since I already found the commit and didn't want 
you guys to search for it again.

Thanks,
Kayra :>


