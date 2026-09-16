Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49788191F94
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Sep 2026 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789529012; cv=none; b=mbodcwrtEYIkXZGRYDIzZgAg3e0ewP2aHYsRrIYr+OBrj4nhoj1R8H07DVl+T/L2DPddsjtkKhImldUAZHS9wZHF4T/h8sCnJtgT/cM8VPggrTcaSuFT23UCO2QvM/+wdGoOelEZyfGGF34rKq1EkSdK6UQuL30H1/FUbkGDIu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789529012; c=relaxed/simple;
	bh=TrzLPfR+KAgzlMAwafjI+5hk4I1lUOvqDQs4cIQ4O/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4yriITEivG+5TEh1q8j+FUoNb24e5uMlKFnGj3bUFCEVk8xPD3ZaWs72ad26GsIos3kt/+TiYiHqsvrL7Mu51VN1wIjQsL7X4hBd6Lw2vRFHFnNvDXRbw8RK1kGpyY+laYfjtCJmnE/WeMbqlCIslL6V4QYEAJ8vclzqNvLHXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThIEkb2h; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThIEkb2h"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4c79fso233731a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 20:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789529010; x=1790133810; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AwHmHA1FRE10MmPE4/Q1QozBv7QcaHa7GxmmDxgqyMM=;
        b=ThIEkb2hkyirCfCMec6AJVj2A7N/Ty6qFZ70qmvWjYLkhWWIFTUjMeYpjPNGWgBRH3
         QNpFKOtgfKvDE7aN4bBe6L3uD0mpRmD4JcPhssBt1UhmntkjeYAW7SddAKukvcpIYaz0
         MWlyQo+gYEGjRakdCku8VooV1/UvHN46xI8aajOArfrY+5AM/DbSt7qMTm9H704QTk3b
         VdFGUn8/f7aFrUPE3MZ9mQj9k7Ir7H+/vzzA/HhVxDD05UlBRxaqW44SLEcDd4GRKIxt
         EtaWqfhtqFZr07olj/fpiETgSGsyrUgLBDQX18j9J2NKewmIMWfHevY+BVEyO3Rb/0r2
         xfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789529010; x=1790133810;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwHmHA1FRE10MmPE4/Q1QozBv7QcaHa7GxmmDxgqyMM=;
        b=KxzkZy/fVtXsHBI7bkKYb7u3Kv0tDVuU56ZsrQ/nXs79RJiMIY2vaj/RbPi7qmWoMl
         SwsmziS4xiQ+mx+8/hWWQQlfi9a+dN7drOu7CUB6kCf5R/kdSWZNWn7urJoBRXu0nh3C
         XCHiUhl6A1I+RN84UXD9x9AHJHLS40SmCjIqGHK809qvd/A/mzBnIcowwUYmn9x4E/gB
         16US2xValIc8QLsnVAsXWZI5xIDQNWDzK39kUWcp91D71TQdSuQdoScKovUOc32lIFwg
         wYHBZn19Sk2FSVTshLJjr4YyMQPV2oMSQYLmkb/gdzXBLtI2x3BATT4lnbtsoLHh/3Tb
         mZqw==
X-Forwarded-Encrypted: i=1; AKwUvBya2+YfVyDtiSyDIMc0pOrjQbfKpDzeqpfp2cJ2Bo9X51SMEoXP1cKn9PxXsXpDlOcjUFewiXdCWnF/AO1T@vger.kernel.org
X-Gm-Message-State: AFuF++lk2UReYjicxcA3qf/5SR/cI+Bn25u2dYTL870/C0salofvTEJM
	Hlz4tLMyoDtTFgif4gAuvZSOYBDxIEeanE4uHqVAEa+He+xASJROy6xw
X-Gm-Gg: AYBFou3C5oWkgbflELgqo/Pmn8c7YNKv0Q6Hge258yGgdkUZQfuV7Yx7Nnh0Tda9Wqq
	M6kVeo/vsjEx9AMfrfT5fEmkbK9lSxSYz+KivlSBoyJDRAIy8kPwGLDoq6DMpC5ZolDDGnjzmqq
	H9sYzZpNmHS/EjVN+8VbmM6YHkKYDzOZrcACzAFoaWtF7cWCeoj8RGM9WhW2PKePrSpc88anCZa
	xnXw8dQcCJ0FZrvsl/j+PjPHa7PulDmYQbyMp20omAgYc+lIWBt0j2o4GPUdghOJtRgwVVYrNyu
	hGJLMXC8XLC3SrfRtcrwhSO7OpZC6gR2B67MucBmJ2nGKb/7FWs2gM9hLRzjFUE8JpGnUbJH0ji
	ATVN3Ud5wYX1Pll+TBlbltqF145H19yroLUdxV1Uu2ixfy7jD+K+KA91fq/iWAIbmRUZ927Mg+/
	qvTnreLfNQRW6s1+ZX9RnHhJiN/jXj4+13WXwq9ls6kD0EhQBN5TKRUZc0c7FIuJa9OwtpdZdnc
	LaCksDlRBNzAwht4s8MQUTY
X-Received: by 2002:a17:90b:2645:b0:398:9be9:ab92 with SMTP id 98e67ed59e1d1-39e1e5777famr2430778a91.23.1789529010534;
        Tue, 15 Sep 2026 20:23:30 -0700 (PDT)
Received: from nixos.tail966018.ts.net ([2405:9800:b530:f677:abf3:8f37:82db:ab0b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395d4cbc9sm2491538c88.11.2026.09.15.20.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:23:30 -0700 (PDT)
From: Tanawat Jukmongkol <tanawat.jukmon@gmail.com>
To: axboe@kernel.dk,
	akpm@linux-foundation.org
Cc: tz2294@columbia.edu,
	hch@lst.de,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/buffer: fix NULL deref on folio-less bh in __bh_submit
Date: Wed, 16 Sep 2026 10:22:57 +0700
Message-ID: <20260916032311.476258-1-tanawat.jukmon@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20260915202534.468958-1-tanawat.jukmon@gmail.com>
References: <20260915202534.468958-1-tanawat.jukmon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Please disregard this patch — it duplicates a fix already posted and
under review:

  https://lore.kernel.org/lkml/20260902013357.2815214-1-joseph.qi@linux.alibaba.com/

Sorry for the noise.

Tanawat Jukmongkol
