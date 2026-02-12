Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295502E36F3
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 23:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770938079; cv=none; b=l9w7ZieTP100guvbjVYQZXrNulV3P4X+3H1r/y68+umhN6cL5cd8CdbSohXre/GkGQQQ0o+T/8p6j0TDlxLn3Ez5dK04BfCXb8fzhIaZM44qEDh0XgTaqL5awAFrOb/v+5uIuxesnKuKg/sdT8kYfW6Sd8/euzbWKfA7HHA7WXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770938079; c=relaxed/simple;
	bh=ZypCk+czviY6aYLxp6aXph3jLFLaAO295/bCWP5JPnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B6O0Rk7vuXOBlBX6y9uMLdwGMQLssmf9w1HRn0Pxe0mmZQDzd277ykq20W9DmrsPvf8GVtFGQ0mOBUE0yNEVPGbblRBaUaztgZm4cYa8MxLkZTq6bNoX1ZIgYNIanyqmYjyKqqNyP8yEhoPNV2hgaCsy1OmCaACAaTISZP9Zmyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=hHuFoB+6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="hHuFoB+6"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8c6aaf3cd62so43402385a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Feb 2026 15:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1770938076; x=1771542876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oz9zR2L7cZ+7IG60yiimRGGhkjs+nRPAQT3aViBLCZo=;
        b=hHuFoB+6+pU4qDMr0BvLE67IY68CAuPeEqaN9U4S33rtqycwaA1i7hpsaN+HsU3lR6
         HGAWtB1apZqyuHEAkd3hawqoTkQGspHh4hAiMw3ToGzRpMo/T3gtJNBPoN9xFW+cVRRi
         94toRPUbyevq5TJDHBsIlb3N/C5eRLjY3n5tW72ayNk3LinttbE64RRKmacp7RuvaWYe
         Caz50Rjim9OZttLReDCN0BzKvM4MOIDFRJgMBNMY6pP84OF0aZ8jeOWoIw593K9MrwsI
         dN1IMjMY4w8xXFGn2BieHwFrKses5akTGgPqigWvDEnkxEkvUNHmjsuTJTrz0I2YcQ0S
         kGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770938076; x=1771542876;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oz9zR2L7cZ+7IG60yiimRGGhkjs+nRPAQT3aViBLCZo=;
        b=ViJ5vyHDgckKuBSBd7VJgHlSE5yrm/1WGFPifg6m3z1o9LNUdvKR126yjT4XFKpqqV
         mbPJvVH1RTj4Rs8kfTf/DJRFBHCHhlfzTLkyyqT9xpTJJQcNxAJ/o+TJ3qMkttaoXGJh
         YMn3QemRN1WNTpIkEt/qR4qOsJg1563C940p5s60k5iGVB0hovlWJQKFaUWgwwAZklM5
         4De46HnM6hXso/NbvMphzoYbLD9lIFN9sje8MvaLbiBXMlGHDeLr1HEwN8BkRElg19QO
         eRGkhXEdekSoPHZvq8No+KIO2kI+rp0Gi93gX4snCZJPnRm4Y9F+3vgzfZ5VHfCdIvC+
         RX4w==
X-Gm-Message-State: AOJu0Yw3SBPRN6BlggMA2PLvlq5PvHFz9GVpEc+dJSYPQN407J0jQYCX
	VyWW/t0+XxzJ/CzxORV+La4NjUmmRWWlPP7l6AC7jiSaovdLob83D1Ilj5vsYir64JM=
X-Gm-Gg: AZuq6aJQoggRJZDA0lL1xTdpzDVgsZr1Kow5CMGoIFb2pS1xbR5mxsvPW+63miQdcpD
	LKoPdkZVp9BWqeDnfoczXNyJQ8Z7Or8IrnmvMRI+qHIIy2jSeYqKN2SwgOIArElINbY9B3bhgYU
	AtFBxdVNObB7jFeL9Vy+lA5nfal3gM8pmSzfxau8DpHu4FPhQ5yUbG66bD2vimYlrlyy2IQ5/cp
	9oHiPewfKouEQD4J8ndfoN9sBpSsvMKMGlWEXJSonfh/WGWqyBtVdzt4+HyhYin8ZqS0rny6DuI
	Ii7LzCs9P1s6UCEm//8tsDbeXIZ7zxLYzSKAo0lcm2dzSMifk9bUDw1MhpPqKHoIA3QEbgZqciJ
	GRV3DQD6a4N5DaMMRgk8rhzPJtf65tDyP3Drq8dgdZ5g3Nm0Y0ZULGEQLovJuvRwbMzFRtsODsg
	Jypdu22qFXZPs2M/CdgefFHEqobL9WTapgpEIZ9Jr8v+0g8WKu+S+5V5fGzr152kDVtxNliWepM
	Kw=
X-Received: by 2002:a05:620a:4591:b0:8c9:eabf:9453 with SMTP id af79cd13be357-8cb4092d57bmr74146085a.87.1770938075736;
        Thu, 12 Feb 2026 15:14:35 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb2b1c8505sm441165385a.25.2026.02.12.15.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 15:14:35 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/2] befs: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
Date: Thu, 12 Feb 2026 18:13:37 -0500
Message-ID: <20260212231339.644714-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ability to read / write to the befs filesystem label through the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

Ethan Ferguson (2):
  befs: Add FS_IOC_GETFSLABEL ioctl
  befs: Add FS_IOC_SETFSLABEL ioctl

 fs/befs/befs.h     |   1 +
 fs/befs/linuxvfs.c | 110 +++++++++++++++++++++++++++++++++++++++------
 fs/befs/super.c    |   1 +
 3 files changed, 99 insertions(+), 13 deletions(-)

base-commit: 541c43310e85dbf35368b43b720c6724bc8ad8ec
-- 
2.43.0

