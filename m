Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8AC44A725
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779902973; cv=none; b=t3Cfau0ACFUjVdMAdqhlPw5M2jWV6UBE1VuAmDvx+K638o5JtE2LRuJvI+7tRNUUuLX49Rhrza8GNVqrXolcYM6U1LYhWikwd77oZvveTdF4FtPAD2vV+n4Pymz2sTHVZ/T4Tg73X9YVAaUESOKvVeuus7BeT44qBY8RtDy2qZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779902973; c=relaxed/simple;
	bh=MPKa3p6JGBfWnfrHkk5iB5cfsCOMtRKq9GIw9Rc1SHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5TXTooz1h6Dy3RHlqrij6322gPKOh0PpMFyrVnEl3AQ4WXTH7ZkmBN3CBkA4/SBXyx3CQ5joorhd2SvLro1hqilZHdAFBnC83z1MvSrtXaVpTD0J6cJC+64ebuPXf47L5RG225y2a3OBDzK/xon9Xc/UQ8hr+q8qLu95doj1R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0zNyOTF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0zNyOTF"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43fe608cb92so7353154f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779902970; x=1780507770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dCM5CHX9NA6rr2wvefcWqOIL2P8WReBoNA8gBiSZl+o=;
        b=H0zNyOTFuQB3A4pme9RIe9lmVJb2hZhIpkzAO4GZDyKmqjTK/i+g9Xi4FzWDK8+09l
         Fuere4HjYzelXtXG9yQfVOFVM1oSefstZNq/NRuRFJyF2cUjOM7tIYxTPoqyuK8OrS/o
         Gz93GpGsddPf1N7QiY5S0mIS28AMxjKcvFobpkES33icwv48g4cyZj5MEwEZesPoLCFn
         UfX4/K9OoBSXHI9GkEcTDKJAnvi1mQ2Gi7EYCHUcMYYYH7V3NVBe6UC9gZQZp1qHEhdO
         9pNcMPnOV/s8IvcybEarg4p1oyzq74KrE1kB/UIwJcfFJ3IC4zs5gVY4tDfBBSEqfBue
         OvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779902970; x=1780507770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dCM5CHX9NA6rr2wvefcWqOIL2P8WReBoNA8gBiSZl+o=;
        b=d/9aAvIGDmdZ2UJad5ZF0g4UIBQQVtcU5Ytc+BrVp8v17mOqsFlthNe9+PIrDNbyws
         RjN3wbuuw280py6fmhwowp/SM43m0sM5++6a4kgufi/CJqBb9658jz9lRImn0ydG+jl+
         tQ8ZpKrelD4410mFT3fnDm1SONsfpO/aOtO5xDHoquh9J96UDC3sDPs4NasIzuAqyQAH
         09H0RCqpO5jwMAa4b5QPnr4sOJ5SZLmIqm0BbfjQYrP0hY5HVYscRd/q1Gpt5twwdwox
         O7QMLPgjmtEaiBQDVcCbKxUdRTNlcLJWYZNLuS56Mh3+CdGG1cAiblLEYTwJdC4P077F
         gL4A==
X-Forwarded-Encrypted: i=1; AFNElJ/NSsZnL4+4D5ufPhyA+Lsy3cjKN45ofDFLb4sqsHz4jeY8PTroPOEF4DyeGdrNHC0+D56JNBTak9WsxGUn@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9bus+6jj6HUjjHIp8rWkhuv9zJLJNO93VUx8rZZEajPm3kyCx
	r2V+orC1SXUNBA6O5oRIKPgxBAXsxeVsBZ9yKrS09AJ3gRJk1tIU5zM/
X-Gm-Gg: Acq92OHTFY/3Xbh9R0ttG9bbjImngIyn+5U2ChvLTkbXUNoYy3OyYzF3F6ThFOQtF/J
	sZAV1cbqXwSGl1WVA9xhY9KTEEF2r71s5LObBLwRMnvV2dpP4kr1Wmt8l2oIekFVm5bEIkBFnyp
	4gzEQSxfmcHyD8yQte+0Ys2AtmV4RTOLMQAuczawQ3l5rxXTgX0/JAEOMOagEWGLi/M280+RalO
	y77WY8uRexaAQOTW8YCSVK28iFwCglcNSOUk4CyA3UcjC8yhq6eCz6Q1NXJDfAdQxGsODeRhJcX
	OhU8Fd7OvbsK/6Mn/cA5y5Jj3dwOcYjJ9DryUE81qVuOeo04u2hrXNEU3zwAfOAQ0l8mWTjzGKG
	Lh2IxhP/LB4zWRiRSox49S41ijpDpk3uWS2uqtt2hKUXAgRAA1pR8ECOkhGEUe6iVDm82wqwI8E
	JXROsGHkKyeP5fgvKpZHU=
X-Received: by 2002:a05:600c:a402:b0:48f:d1c0:721e with SMTP id 5b1f17b1804b1-490426b294amr279279305e9.12.1779902970278;
        Wed, 27 May 2026 10:29:30 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45edb549e79sm8131065f8f.7.2026.05.27.10.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 10:29:29 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: jkoolstra@xs4all.nl
Cc: brauner@kernel.org,
	cmirabil@redhat.com,
	cyphar@cyphar.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH v5 0/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Wed, 27 May 2026 20:29:22 +0300
Message-ID: <20260527172922.2193170-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260525202937.466497-1-jkoolstra@xs4all.nl>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jori Koolstra <jkoolstra@xs4all.nl>:
> This series implements new semantics for the O_CREAT|O_DIRECTORY flag
> combination for open*(2): perform a mkdir and open the resulting
> directory; return a pinning fd (which mkdir does not).

Al Viro strongly opposed this idea back in 2020:
> For fuck sake, *NO*!
> We don't need any more multiplexors from hell.

https://lore.kernel.org/all/20200313182844.GO23230@ZenIV.linux.org.uk/

So, at my opinion, at very least, Ack-By from Al Viro is mandatory.

-- 
Askar Safin
