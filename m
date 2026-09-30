Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802F443C24
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752974; cv=none; b=SPI32Gd2q//wkJd1uoXHwrKSgnM6YQ+ZjIyzGKwDMgechMXxSTqat2R4j0wgsyvbAe4BUtyc2Zf3RobOB5r8adyn7EE/owR+AOTxesDRr/jhRUFPDgSygbTaa9az0xEVi8eSGaoq4b0j72SJoMLFba7H4heGMZyLP6+8HmvvC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752974; c=relaxed/simple;
	bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fW+cff91WP8sPbbBm0EzFaLo1l0dOJKjsgb8k4dqC3NG+rEEW/13abbDM7yJH0hYH3uaBHSw30MBa1g1sfK7+aRCdqRNkWjoRab8R/HfOU0Wt4s94sQoWaDZ8OXfri+yWowrJotKruMpY6Z9k+8S3mtalvsom8AJ2Htz06kvxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEICMtTt; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEICMtTt"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4bb1ed012so633418a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Sep 2026 00:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752972; x=1791357772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=CEICMtTttVfLi9+k2c16ydDJ8mWbdF/GDSH0RsLpUd1HgBCQbLCwsoa/vLZkKhjgr/
         W12EonsHLD5NOkOwWq3t5jVfZqnd4aZzZH2AEyLrfbW8HwliMKBcKl1aihbPHIUG3to/
         M54Ms+nRiSHOq983WBlnqRnOkma3PiUgfc/JDCdVBq4wpTbFpYc/k/eU3wDpfmhJZrbs
         uLYVZ7nbaXX4NoEIVMuIz79aOS/rNoso3ao/Y1LZFZlvJ8gjCLoQxUPNVOwaDxNY//iw
         BVLuwX0Rq4LUgcuvHvYLf5bZrgN/PTCpzRuZpvEJOu4pnifo4EkDnswEpQtVxQD/f/Li
         NUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752972; x=1791357772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Joi2OZuTmjgbDN57dzLD+JcRLScvJC3JC66V30FnFJs=;
        b=T/aLpf5Rx4hHaf1ZQdrBwdaGiqp1JnvFQjEfCDNcNz+Pj1Q7AMs6skreBv2VvOpePi
         28AU+rrfoPctM2uRtivL2l1u6zxcrFuYP+Ol2dwyBdwr86C7mzV0ivAhasv3b8bWQw3d
         nsbpS5reDh9BTq3OX0Iyp0W/p1FaXfDDWuienzw9rNj+ftIuytyVq5V7cnSu7dfI/VD+
         36YZdD7rF+JqxlPYrd0nd+g5+x0TmgkKpnFj9HQtZwGNVeWCFE0NnmZonxllMzqPUrCQ
         xtfJ2yvdm1pUekS/oY8GeapQz1eecScl70aaie7eTL3VMXVgKZa99o61cb7uHYQSP+lO
         QnvQ==
X-Forwarded-Encrypted: i=1; AKwUvBxzT9ETOaG7JHIamnWEF7iwbn7KahqG7evaW+TpREbDEwSctj3x5mPqyPtgZRys2O4PZJaXd0e3V/8YjnJX@vger.kernel.org
X-Gm-Message-State: AFq9FYLWjKyvCZsGt0XIBAQNJV3mSG3YZ7MzazvaNb9rV7i61Gx++BBJ
	QKIf6Y0Bmqq6IDKFcj2AucpE5VvUC3yHhRegRDG+JNeprS/m1y6S2oITICGd/7fc
X-Gm-Gg: AYBFou0GleV0km/vMxjOZ3bk4dRD7hdIZNN4SdWIzmJ+TgQWMJAntDqb3N02oZUO3nX
	FZ46A333XmRe7Rnwa3Uo8s8f745rZTinAPftNkZetWDqWmh566z8mboPsSxxm3Xi8nzoL0TbMhx
	Qc4YiZ/fImuWtskGMHPlacc/UnXClAiQITI1S+T93vDfLEpt8UVpF649e+KcdGKgHzjTvop4Ueb
	wKEO4jW54NhAc0+0xTkolnkgOdxmPr8DpLKiTyAvNJH0U+e8YN5qWEzosTGrGIsWpRucmKvHrNX
	01dRVgReDEwR6fnRsdhsxS4g9/nvIYgXZdK9LSqTm1fdfIa9uJkOnRWAWHG6ULVI4fINbEtyJ9s
	Jsrk1VqlgIhFfX+j3wR7X40u5EjzMQ5vuyMswxtzGRlW8aUGX1E/VjF9LCaa4BpI1MFk6TvS5Yj
	TJ/MOGC83FE0bKRRH08Zo7O3BGrkJen8rzyE7VYppP7HB8frAZWV3sjw2qiAzWkxoKtexBVdaWT
	XJLSUhAGlrNC3bI5BqDbrFSvAhheKoMYH5tn2BpkPb82ZWEJIph/h5U7GitTQ0YslQecc9QQZNP
	YDp4FlEwZaO+jnxTRA2t7xDYTUflhp1X+LXFL6ALIknanXBE7iYQLbc3hFE=
X-Received: by 2002:a17:90b:4ccb:b0:3a0:3a3e:f78d with SMTP id 98e67ed59e1d1-3a4d18cba19mr522044a91.47.1790752972125;
        Wed, 30 Sep 2026 00:22:52 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4c75fcda5sm936078a91.4.2026.09.30.00.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 00:22:51 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: Anders Larsen <al@alarsen.net>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/6] qnx6: validate di_filelevels in qnx6_iget() before accessing level pointers
Date: Wed, 30 Sep 2026 15:22:49 +0800
Message-ID: <20260930072249.1167653-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930031604.70544-2-benquike@gmail.com>
References: <20260930031604.70544-1-benquike@gmail.com> <20260930031604.70544-2-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested as described in my reply to the cover letter.

Tested-by: Matthias Goergens <matthias.goergens@gmail.com>
