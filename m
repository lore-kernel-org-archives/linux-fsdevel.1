Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9985519A9
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873627; cv=none; b=ZaPyKnI07zmEFLOE8oBMz50OQGJ++ZejDYrIdJ4Q7uvdqSNQebqjGsk8k3XOU4Cz4kYs878PFsR3vWO7esn9Nmwe3vgTaeA9nCr5P8+wgw+pIaLbjlOm8qjg/es2grB3Eq2BB+n+cjsoQbEn/DOJdGJn1so90xsx6Ky3PzJFC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873627; c=relaxed/simple;
	bh=ZI1g/vHb9cji6vCcQ+uARVz1H8o1gKWXi33ujmqGvdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4Lv70jxIlIne3BF1M/cO2VZI0ey+EyqCnFKUsgB/U32w4IjDAYaO8ZDKeKeoF8DOxyqmNXVmxpKPtukh65+Aja8DavMA05En4ld+pn/H3ZRisq9OAckLpYDAdUg4B/WmdTSCscw4jn0ttP7lXXVseRJG5hYbUDGG+JNPwFd0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Spq2afWz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Spq2afWz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4858595f997so2829504f8f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788873623; x=1789478423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZI1g/vHb9cji6vCcQ+uARVz1H8o1gKWXi33ujmqGvdo=;
        b=Spq2afWzIISzYRMZnn40BGUyGHtdXGNPegfTWPPWbrkmKwNuwxo5ltj6HvKD7u+4Zg
         jbBbOHamijpL4207qANtaF4LkOCeaVIk26cT+HiRXTdVVEBtyFKjrlTcLv/2KSgbHJpE
         F2zkzepWY0IS4oI5mhWg8Xpc6DibwXvNtGgWuKyoOZbpgW1BwAYMXlvQsiMWUnX9gSBg
         IeZGfs+7X6B9oOdciB29NeBl27geUi+UCz7jSZsmDeVFGKgRwLqGceAfpYE8uJe9kcY2
         BQ44WCGpOgwh3PdswEs1kaZTW7+CeQb5T5yBAOlc2893FjnCRa1KNXWMs/+A9ATe9em+
         SlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788873623; x=1789478423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZI1g/vHb9cji6vCcQ+uARVz1H8o1gKWXi33ujmqGvdo=;
        b=c8y5/Fj0GsBXpui7T4UCjo8ha+dchVN8QZVJm9fUsARDBqC6OP5jKBuJ6nr7qqFqRL
         0E4E3Go8pMIJtia5fuc04w82D6/RUVvet80Xzq1K68D8hF9rnIGZeP6rc8RhaktuV9R8
         N9LUUbcxRyv3FROEw/k7SJpfzeXVzitpyxS5q7+tiEehCmsSPpDojW7E4QFVbdeGs+1g
         nqGOUXJcdQCmO6J1SRAHxS3/Nic0jTgZ/4ub0gMJK1iinjQtcScsrZzDlEUT7U7zJ1FB
         1Re1zIRu5laX7iPqW1BtWlVOqz4hOFd1pPGKGK9swOKj/ppzrrNfwSYgDyvguHLdWrXj
         Sb+A==
X-Forwarded-Encrypted: i=1; AKwUvBzgizMBlRtcQR4/5eRCVvu3ceNBiAfYf6Ts48ewmNuOy9VD9MI1DdqHupMmBNcqCo4TGDz5v3j055K1G6d8@vger.kernel.org
X-Gm-Message-State: AFuF++m55eO7M8rbcMRE/rNq3gWuBb2dEPAU+TSS6yFXpK2YIb3UUtaM
	wRKB2uKPPZirGm3qkGgVcLlNNnmXZel+ipccBUxkRZoUiEOwzsZFct3Z
X-Gm-Gg: AYBFou3mETGbtXIFUtNI94XVu8XqdsYNYiakY4TPA/amIfAzJTCd2hn7FKmZtweKre+
	BmWSPqyaokJ1XDitBgoGY1bQEd4EOTyV6mm8dbXoh6FzzWBDwYmLSZJkggWighBX0X4DmlUmGkI
	n2tNGoI4Y0XooxARO2+RXeqYoBYcE6yJ2Ee8pmU3q22KENTnLyhodRsS/iNPz7YTqzTvgK6416Y
	AxKGRX51nrFXuoFh1DGU+KdaRFdVgzt0lmlhhxk4fLddP2HxZ2xOjyRpuYhJxgPv572Zu6EhHTY
	rnIIdIbgsK5IgDkewPjjfeUdUMBWH1SYP2Z8RIhpcnbUexk8b0h0N3p+XhNmujw0Pch884Pmflq
	pDFGu5DSda2i9LEg4Urh/9cs2vf7GNiis4WnFSw4YUaoBOmDruYum15vVbYU3gTO2dzqp6Pswmt
	ngp//D/aIGkNX5j4UbSg81oWocaeHuego7bNHphTywUxhlNWnaur6Sz0ZpA0JQslF7uaISj7le5
	Q==
X-Received: by 2002:a5d:59c9:0:b0:485:8420:26d with SMTP id ffacd0b85a97d-48587057223mr56490158f8f.8.1788873623214;
        Tue, 08 Sep 2026 06:20:23 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b5f:900:ef25:2f4:1792:4e6f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm35214027f8f.23.2026.09.08.06.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 06:20:22 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: tasos.papagiannnis@gmail.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	brauner@kernel.org,
	daniel@iogearbox.net,
	david@kernel.org,
	eddyz87@gmail.com,
	kpsingh@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matt@bobrowski.net,
	memxor@gmail.com,
	song@kernel.org,
	sun.jian.kdev@gmail.com,
	utilityemal77@gmail.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH bpf-next v5 4/7] bpf: Allow reads through trusted-or-null BTF pointers
Date: Tue,  8 Sep 2026 16:19:39 +0300
Message-ID: <20260908131939.73400-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908114736.5342-1-tasos.papagiannnis@gmail.com>
References: <20260908114736.5342-1-tasos.papagiannnis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Out of curiosity, what were the main issues caused by that change?

Found the discussions in [1] and [2].

[1] https://lore.kernel.org/bpf/20241213221929.3495062-2-memxor@gmail.com/
[2] https://lore.kernel.org/bpf/20241206161053.809580-1-memxor@gmail.com/
