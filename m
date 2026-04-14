Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CFE3D6CD0
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168719; cv=none; b=AYfc5j+w967+/BJyEqqH1G1M1JyXoQEgzSp46KfrreGruxfo2goVoZyne56jK8OKY8a4hURLh5GzQOqz+boRJjeli1CtvnwUXP2uBK57S5VborRGBst5VHq36XYCgR8l5N6cW6MLCzeYlgFkYCADsy4TZusuiGT4raXAaiLOlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168719; c=relaxed/simple;
	bh=b79a/FeRzU7DAYcvsukbMcvTIdQXuX/Qu+vm+CTVtoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M4VjGlAWmCsHIEhh20AUMdBu+HI0z4OoaHRjVfq+vcbYP5z1r9xY8aI8sBqkkxUJUw+LMmcOAczqMX8T8TQ6QNMaqZNZXeUbpunyh1RBt5bxqjuWXWHrSWOd39G2R3wgnMrqGAhUC6cJwri3H9SUxJsB+GpukhyvJrlCw0p1R24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48880947b7dso7465145e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 05:11:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776168716; x=1776773516;
        h=message-id:date:references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b79a/FeRzU7DAYcvsukbMcvTIdQXuX/Qu+vm+CTVtoI=;
        b=K27pnHkqYYA/0zsjVN47b6Lj/2KWcbwN2V+z+BxujHD/Mc3wx3ktKBULcL+16Dzi3H
         P4uzHn+6UF9LMfoVTw773NGVzjI2Qe47XTtbYeBcESbzaDsOhz2KVxhypR1iKoWCtMQz
         QpnAdtFWOpQkf4CCsRSL2OkYDrCP/g61A7LcDGu5BJ8mAsw/mBc+7Fb9fEzFdByIhBKM
         IupDWNwf+f5v6nrsHifv27TZgwczCHGQTWEZX7F/fSVbsPAvoIcGrWpL+JgEjjAWTtKb
         EAP1QANfk62SewxBCHekhegBopjBFFmmsqhnq9qqQ/h2EhIqRFsvVaaMb+tJTiDdjNSJ
         N3Wg==
X-Gm-Message-State: AOJu0Yzg0a+CZBcmLmxFKqmrCUytUwpACXEmmyicjAuh3b/2F79S7c0a
	ecYx2ECj0ejFLEdXdpwHjjyvMblD3PJMWFR+tIbGZdyY+/3rGxNddz0LKKEo9JEE
X-Gm-Gg: AeBDievCSPTxufogFhrh1jRWuGaYIAz47PO7E427HnxO/2OfBgtjg28a0Xv2WGloCHs
	syaxuRZQV6j2sPTDTM3rNJQ57/sysTP2/4l4OW0SYUanJfioo+gIfNasR27rKOI/TRmo2wYVpXv
	Y9sQEI669qWjbtEE47ft5jM8RkFEqZ60hrxK7IGa+s0vShNeNsJ0zADdeJV8mcR7OqX57nUESKi
	x1UFtiJ40ypAtAXBOBLO3fARcr8v4kxduE/Kv2TTnQ68/Db3+8hSuem+FRZRioFYs7gRI2xXjmt
	n8tZuKGIsG6/QVTv8A5Ch2V74vQYQSxBOJd8EvJEmbWXtHjz4yJ4NDQrZZnLFCUf+kLNN8YX2bT
	sZB+Nh1/wZHMZuAHFMtUeqTBaO7pcgT+VHFp9jZj0TtLxggICAwQdT2sVJUTVootcN+UcphThsU
	PgN5ThveTgdobRpPw+jRiYVoCC7nqlDoUgE7/wmEWpYbIf3MflZ1S4U+61uaruXBianleTk90=
X-Received: by 2002:a05:600c:524a:b0:488:926e:3ccd with SMTP id 5b1f17b1804b1-488d7f24014mr123925205e9.4.1776168715997;
        Tue, 14 Apr 2026 05:11:55 -0700 (PDT)
Received: from hackers.camp ([2a01:cb1c:784:2f00:708:2805:7128:7a75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede156a1sm49028485e9.2.2026.04.14.05.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:11:55 -0700 (PDT)
Received: (nullmailer pid 12724 invoked by uid 1000);
	Tue, 14 Apr 2026 14:11:31 -0000
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: Darrick J. Wong <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org
Subject: Re: [RFC PATCH 06/10] ftrfs: add block and inode allocator
In-Reply-To: <20260413152101.GX6202@frogsfrogsfrogs>
References: <20260413142357.515792-1-aurelien@hackers.camp>
 <20260413142357.515792-7-aurelien@hackers.camp>
 <20260413152101.GX6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 14 Apr 2026 16:11:31 +0200
Message-Id: <1776175891.838384.12723.nullmailer@hackers.camp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

On Mon, Apr 13, 2026 at 08:21:01AM -0700, Darrick J. Wong wrote:
> No journalling? Or even COW metadata? How is this fault tolerant??

Fair question. The answer is that FTRFS fault tolerance is at the
block data layer via Reed-Solomon FEC, not at the metadata consistency
layer via journalling or COW.

The threat model is radiation-induced single-event upsets (SEU) causing
silent bit flips in data at rest on MRAM or NOR flash. Journalling
protects against crash consistency (power loss mid-write). COW protects
against torn writes. Neither corrects a bit flip that occurred while
the device was idle and powered.

RS FEC corrects up to 8 symbol errors per 255-byte subblock in place,
without requiring a redundant copy. That is the specific gap that
FTRFS addresses. The Radiation Event Journal (added in v3) provides a
persistent log of every correction event in the superblock, giving
operators a map of physical degradation over time.

Journalling for crash consistency is a valid concern for v4. The
current design assumes the target environment (space, avionics) has
well-defined power cycles and controlled shutdown procedures, which
reduces the crash consistency risk relative to general-purpose use.
This will be documented explicitly in v4.

Aurelien DESBRIERES <aurelien@hackers.camp>
