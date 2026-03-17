Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFC8224B1E
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 21:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773783131; cv=none; b=seBvLatRKT6gx1KFs0o2U2m1oH/2qeT0OyIq7q/tw9syFA2T4jZVn0vSEqgSCO011wXYfbr8YhJ3sxAS/tCJLTDdw2wMzROBaf7wLcmRp3lJlRRM8ih7OL8oZDqxFqUbZTX73XNZLyo+UneUWgt8WyyGisS97OW9xbaApi9Uygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773783131; c=relaxed/simple;
	bh=5hJfdIl1jSXBfJzoHn+vgpDYPdEAfAw3oD1/jC5U+aY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXFcGK42QYIWp/G8Bh6W/+gJ5DeCUZZ0C3mcSG3U2GZmgRudfUc6xrWuFqbWFl2QnVbEhXp/uCqBdRf1BrCdlen3hs7KLTUF91grFWP2Eq4aA8dFa2t+1Vehu9yvglEiCSzznEwqarUcZSKEfQRMsWAWN0KDXa5DqcyfUpu+Gj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JlNrQo8U; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JlNrQo8U"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso55859575e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 14:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773783129; x=1774387929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hJfdIl1jSXBfJzoHn+vgpDYPdEAfAw3oD1/jC5U+aY=;
        b=JlNrQo8UWDd6M628v1ESxEAt+3BhFZ3EZAmZk1Li/tQyTsAKIayrOoYnC6ZtyD/Ygq
         B5HgGTFEvRSdRb3PCzRfe9nlHVcejMeehQPTBhuFdFCxnPmwN++I8lhEugsM+x822qLp
         kxQ0pkA2Z7q9YMrnBRmymMsEfeF+zyVKB/WZIrxmhQakmHmMWtgxTvzvVVms9MWauiA+
         okZKMCj6sLKZXd50+FWO9T7lqvXExzVbbY8GcUAB6L9d2h23m9XMot61wTUzBTM2TTuF
         Phz/jM8nao/Y1gGWSgkD+5Zd6jIEJpVxk2j1pYU+lzdE2fyB6jDq+7r6DvPhBNc0vOO5
         jGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773783129; x=1774387929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5hJfdIl1jSXBfJzoHn+vgpDYPdEAfAw3oD1/jC5U+aY=;
        b=HaWKWZoX3l5uwkakCvzCOl3dpCS8KIArixs1d7cTU7m+1zV3GEdjewAsL4KRuu3Ofo
         Rjn8X/r2kBvvkxyPkMmfPOg1qHs13SV5B2V/9hRMTfyshJZi0qem68aWA+keEXqe+grB
         4J0BOJnbzK9fSJX33AKTvlcaVFq/xgAaS38ySLUnuXSDdnuKSA/7Q1c96EPYCFd9g8RK
         ydFYRSbMfYZHW2yNpwFlXBVOJV+TCCG6f1t5RcCfHN32i81HW0bDAAoxvX0VQYdt1ah3
         Sm1Xc2x+kbGXouaZ56ZIyYrLmksOi4bF27utMfSF/ExgAFe9C1mVH8BaNjBBriJvrSA+
         mUBg==
X-Forwarded-Encrypted: i=1; AJvYcCWGya4KA85196tEQi3HGJ1mjE9oUo3ITkduw+Amf9R/ZYizZx/dfCokjBiuazJa//j3T/x9AdtlcKBwNXKd@vger.kernel.org
X-Gm-Message-State: AOJu0YzC5vR6NoL0swLsRZBsDPay3QfenMcDwm2E0Xc/1eNRU1Qw7lYW
	JI7bISuHqIUTSzG2IJr3EmM8pw9TURGWcUO4qoe0BIoBY1U9WZThJHVk
X-Gm-Gg: ATEYQzxK3du+2IZJT7CAcgTf2ELWAMJ/Hzzlq+ZqLlFJ3ew3lhxHO0Yf11IMQmHily1
	Ll5Qpda23ld4Z9s401Y3RT4EQTaG4Gi2rw+bKrANtBThDvlLQoiMDMAeGuz7LXRMA11F9bn1MBd
	8Gtwm1l7HgS7MUd8ispG5lNsW9tawiMfc/KK67FJP9MGCJtkVgVg5D6O1ojn4rR5NgJ/2lYjrus
	3RlKRm/12/rdCBAR5FRhpGWHU2ldaP5OW0JoGlWw1oFUJFtkAmXXbG3DAHOLL2cJZomwmdKf8Hb
	5VFHSvYF8W9XgrFW8RNfTNF84Y0dHaCdpKs4qbknj1JSo7JCX1iWhsY26g5meohcvCGq3R+Bo61
	ZG7I3Hxpi+xUElXhUMHvJt4rfPSDxGFFM4bW4s3wNRnhO64X/jFFrM3eYY/VCrXJep0XGD++Viw
	JjXFfaBI6I8MarxZrdzcU=
X-Received: by 2002:a7b:cb8a:0:b0:485:35d3:ce59 with SMTP id 5b1f17b1804b1-486f4451174mr11909435e9.10.1773783128440;
        Tue, 17 Mar 2026 14:32:08 -0700 (PDT)
Received: from DESKTOP-I0B9J3E ([2a02:8071:5392:3220::bcad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4434750sm16736535e9.12.2026.03.17.14.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 14:32:07 -0700 (PDT)
From: buermarc <buermarc@googlemail.com>
To: ps.report@gmx.net
Cc: buermarc@googlemail.com,
	elias.rw2@gmail.com,
	joel.granados@kernel.org,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH ] sysctl: fix uninitialized variable in proc_do_large_bitmap
Date: Tue, 17 Mar 2026 22:32:05 +0100
Message-ID: <20260317213205.13681-1-buermarc@googlemail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315152635.4c20c6f0@pc-1>
References: <20260315152635.4c20c6f0@pc-1>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Marc Buerg <buermarc@googlemail.com>

Hello Peter,

c will be overwritten by the previous proc_get_long() calls but that
will not be a problem. We only check c again if we had another trailing
char in either tr_a or tr_b[] = { ',', '\n', 0 }, minus '-'. If we find
a first '-' we will only reach the check again after hitting a trailing
char in tr_b. This ensures c must not be '-' before we might encounter a
new '-'. Meaning c should not contain a problematic value in future
iterations, but only in the first.

I agree: checking for left, as you proposed, should be done. I'll drop
setting c to zero and create a new patch which checks left.

Kind Regards,
Marc
