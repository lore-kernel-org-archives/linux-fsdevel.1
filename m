Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD9A1714AA
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544232; cv=none; b=bfkCvhQ3qTvzP1iOPslSbswvu0YFLT4x2TV7feIqOZ97NKSzrAenytQBw1xv6vEF8+RlmD1Jg1w+eyGD7+90Ss8d0f1DGc6nnNGMMJ9XnrL6w1m0rD7B6eiLVtXVqo1atXoitxqwvwvocZEFUJ0MSQTKpWVaaiWpR1YfnFtaEyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544232; c=relaxed/simple;
	bh=aFb1INi/NUNadwFavlaxDB5+UNJh/ScJxVg4b+I3juQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7AN+V6MFkoicFl7Ob71CZMHqDOIPontMdOv/0cv73nML0RRjIV/fXTBPQY1pa/vKd+dEFmqDlHcpcZm/f+wytUfr2MB7FVh1O4C0UNCML2dK+BErGaDBGLJ7xWXA4tIyr2C41u/+lBgbfbBqAblqnunufwAFGKT7qUeQ6sNlkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4aHZLc5; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4aHZLc5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso13321105e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2026 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775544230; x=1776149030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ZGa67ZFGELe5bUP+eZlyvbCuIknlSmdEyMWxXen444=;
        b=T4aHZLc5Gh1yzq1Hm4a3SF7o1PTKXtDWEvb8vJYIlGQXPH4BOyGTuJug873oM+t7Fk
         3ICFGg0Mk/B3gcmQNL1w/S7tTn6qLOKKboahDXsdqPJi04DZCFxXom0Gx3t9+VXpqJbw
         8/AOlfaJWK2IZgOfUanrhEqcKDRZTIPftq8zOpYeOsvquoxEJxKA/lAu2B8gvv0NADzu
         axa7Szxee4ymfYS52X+ldWW/4nLgP8AGXNsJtK4ummqVXYIc84rN7ZuVhyGfgIrIcf2l
         wCR6Q0pBPdplK8sDx5juu3x3Xh29ngL8xfsm5WkxE1oh1Ms2VzIe7362RSA8zKv6aDpH
         n/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775544230; x=1776149030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ZGa67ZFGELe5bUP+eZlyvbCuIknlSmdEyMWxXen444=;
        b=qFFnatlX6IkeThOsuN5QImqIque/CTn9DsSu/3JM1LKmKS9S61V6zz6chWKYBbrFtL
         hYwINX/Uk8Eagp1gknoyO4/AjSseSvaSxRwgvNkagDlMqvR5Ey7oO9a7XXm/4pDQ8zXM
         BLSYBGS0OUCQph1eOk4+BbmIweR7RT2qjCyavDmlywYkG7aquBgu8q+vuLIq7iMw5qSF
         eTgp3FLsEpVz/wfG+pmIAFeJ1qzG0Qntn1tTc2hNuX+riih1yBv0V8Jx3M5OV6VSp8SQ
         25pJu8b+01PIx+LMGxkEQs7OdRa9LqHr8zDIXSR6XlKBSL4o2xp8G9OK/CfM8GpVmxm0
         NzxA==
X-Forwarded-Encrypted: i=1; AJvYcCWg3TIpk3skYqQ2uDeJBtRzessLq28ndMq1Urg6bMCM/MKJXd1xcvQIiO+diwSucj3JBb/4i0Ea9PiNBciC@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHCOH7c0K4lBdLtZjqEYwWRJMTFen/Ckbgvlhh75VX/m0xm9s
	IKm9PuVEockr5c2ze0VSsoY6qctBKGWzj7kh2g/VVXvWvAb+ex3zDPsj
X-Gm-Gg: AeBDieuN5r0hIyafMy1fz6tljHuXlHUqM5qoZKJEAVYOemo2VGOuegxPmz7eN9ndzXZ
	L9jDhKFeghqhAcLCu/tzI7C6ezpiQVYQQAUG64kXO20eBAPt0UO7TapTvuBMbGjWRZwOZvATd1m
	Kq9PpRMzBCtaBYzvMF9aQutALMk3ICiCpB+GT2aIlNB81EZNv9wh1U+qmESOt+LphKtjzYKvv+W
	MQZ5nBGkrQqOQsAHXoHuEKBFNslmceGjPA+0SApNKubjdCGKD3cGwrYJEn9PS5+sfSwl14G0loq
	TgtpsYmzVbJtEnUo5S33IeVt3wPsW+C345EcUgDQPlsUojy0WfLL3IaSFJqf+YkfNg7OBOBxAdr
	0Mc7GDkbES58+hnJDp6EngY7ElywznFxmlHno5bgBOTNJ8MngEhhE24X6PjzC25+NRitxVjzx6D
	kLfWuR3RZodtKWugqsGzY=
X-Received: by 2002:a05:600c:4512:b0:488:9324:3ab8 with SMTP id 5b1f17b1804b1-4889977604emr216797945e9.18.1775544229793;
        Mon, 06 Apr 2026 23:43:49 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-488be58c982sm10502235e9.31.2026.04.06.23.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 23:43:49 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: brauner@kernel.org,
	ddiss@suse.de,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	kernel-janitors@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	rdunlap@infradead.org,
	safinaskar@gmail.com
Subject: Re: [PATCH] vfs: init/main.c: change comment: opening /dev/console may fail
Date: Tue,  7 Apr 2026 09:43:09 +0300
Message-ID: <20260407064309.3223598-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406095452.GY3836593@ZenIV>
References: <20260406095452.GY3836593@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Al Viro <viro@zeniv.linux.org.uk>:
> ITYM "so if you supply your own internal initramfs, make sure /dev/console is there"

I want to write browser extension for expanding your acronyms like "ITYM".

Okay, I will fix in the next version.

-- 
Askar Safin
