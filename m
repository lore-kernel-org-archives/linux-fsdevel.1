Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27823D47C2
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780938786; cv=none; b=hkcB6TT3u0CLJgwU2BARF9Rk18DEwJqsRZuZ52SeZznrAYCXJ5Ft0/0RcES+2CNCXPglRs0OUoSkDwQFRsgwFVUTqSY/xykHeciQ27qdpLi5lLKkKFVtNVBpBxd2dD3A5gfW1xyknTQkxTC7FZDQ4/tCuXuHoPTaXLbRI4e66CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780938786; c=relaxed/simple;
	bh=G2yTdmM+jxM6q4Rp8QMqnUV346H3bZaSNYYTm8fmrQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hiYic/r3xZ+shhCjEZr5GckXDIVeGSZt14jtqMT7harZLV5TWV8ATKg4cvc1hQIdemELoKOZTc3p2/hPkvV4ke0LWq9EhXLpXXRgZplcIv5r7AhujOM3N3cYFMWJrRUI9k/W2uwy33OCRIPjRLPXlkrynxeKJz1eK0x73NOXfSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkr/iCD/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkr/iCD/"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-490ac10e337so42760585e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 10:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780938783; x=1781543583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUpt/EToVTToJvd7YASG+3OoKZxNxbXoqptfVbb/HeE=;
        b=bkr/iCD/AbT5kMfEEc02CxM786jsvA1Nz2/jJdbfvfMrQ2dg+mLcw9Lx7YaIUlf70Z
         oHzpkCp/I00uyPDcsN7gGv8zR0egau+UlSNTBB5evHFxNwJKTCaWhUdkA783i+zVThN3
         boNLlLu3i95jNdk8y/cTguC30whCTSM2VlZBxKo9/9Wv5Iy20tUP0/Dd86Tq3ewyzBKC
         29BzOzJSHw9hRVytFIKluyZIXgOwu+LARdY/j6eATaTFMtm7Nc0S5rIgZYAEwOSvXrey
         FoJWK6th6hPMPHeRw1WjBpCEKZSVlTOD9jvumo2VeQzLyqc4WNmb7R+Mv006lyRItyDL
         xktA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780938783; x=1781543583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AUpt/EToVTToJvd7YASG+3OoKZxNxbXoqptfVbb/HeE=;
        b=qbbIzNMnjqOnazFRllIUKuqVwIdj2C+z0URYbFgGLsXIEJ25O7SnzgVcdtgxS+tDO4
         Lop7LXJfJriO/qnZC4PeCMIzdMsMpgYTJAMML3xEa40QTH+lASjLJS2/2yxFOzounMdR
         OsGxokVtfn0nI+IMAORsE2gRLUkq/KZJ2j0W60XcNsKIqzCXUHV0K2WXwq9ZX9Y6Rmog
         7s68Ugwc69QSz76AG96qFmqD1PY2QMame0iDZz828QUZ1W/BpFXJIEAPUnk6fhHOTWoW
         F5rR6KoX6ZyYSsAa3b4ihy5Z3eKDCF1hj+0EYvwOtToNKXJdwzS13ovF+KGu2ZHCGfHQ
         M3Lw==
X-Forwarded-Encrypted: i=1; AFNElJ+IDDpeLyCreTHTZEgLP9u6U347neNQIThi080ZPYm8XZ42cyJk+LWsBUau+YthRc3OF0F1RzKXEK/ELcFj@vger.kernel.org
X-Gm-Message-State: AOJu0YxB4dUPM2u0HED/tWTBzfR5xFmQ9uGz+zdBjutPLgIGU+t0heKU
	/m7TOqAwoTDT3XIaDq84VNtAaEVPFKXH+qxm0aXWxUq8VvVqlTP5rPL7
X-Gm-Gg: Acq92OHGnTepEOhkS4dJThlFyRqFHlcfxgtB2oGVmCQtOQqzYWApQKy3xrXHTfT2/WC
	3ub8fIH7E/xgkx0jx1dlZHrMWFI8tIZMIlZX2k8eAW+IbtJABmRTTgLPIUtpTYq5oWRgmrds0nl
	V5/NSrl9S06/DbuVXhYFPhY7jn7O0S8VRTGelqD0W14wbsTVYAWqlkITwUEmEau/Ml/ABc89lpE
	WC11/rN8Z6wHa3XlytHvoNjWDcgBEk/P/XutZoFl+Kd7mNEIhc876Bb1D9YEWQoorcvKxIxCTvt
	UaDa7nKM/6OSZTH+VAqPCvqk9eTncWwcbDOUaTbInYcTNNN1kgcuTKFx7tPkDz94qQFx3+eYOpl
	z96A91ANkG/oxcKoG5oVdTphI6tIV47fz71EqUbwXqDB53CQO6CaK0QIKkv7x7msuyErEEtTY2F
	3axYD+2qjo82c2Ih3sqcHvCzPS3oVDKnHKUCorqr0F
X-Received: by 2002:a05:600c:458a:b0:490:389:7644 with SMTP id 5b1f17b1804b1-490c25fbd78mr244360025e9.17.1780938782731;
        Mon, 08 Jun 2026 10:13:02 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4601f351ac0sm97432933f8f.27.2026.06.08.10.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 10:13:02 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: andrea.cervesato@suse.com
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	brauner@kernel.org,
	collin.funk1@gmail.com,
	david.laight.linux@gmail.com,
	david@kernel.org,
	dhowells@redhat.com,
	fuse-devel@lists.linux.dev,
	hch@infradead.org,
	jack@suse.cz,
	joannelkoong@gmail.com,
	kernel@infinite-source.de,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ltp@lists.linux.it,
	luto@amacapital.net,
	metze@samba.org,
	miklos@szeredi.hu,
	netdev@vger.kernel.org,
	patches@lists.linux.dev,
	pfalcato@suse.de,
	rostedt@goodmis.org,
	safinaskar@gmail.com,
	torvalds@linux-foundation.org,
	viro@zeniv.linux.org.uk,
	w@1wt.eu,
	willy@infradead.org
Subject: Re: [LTP] [PATCH 0/5] vmsplice: fix some problems in my previous vmsplice patchset
Date: Mon,  8 Jun 2026 20:12:31 +0300
Message-ID: <20260608171231.1480447-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
References: <6a26aa28.283787d8.1f1282.ba36@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Andrea Cervesato" <andrea.cervesato@suse.com>:
> Hi Askar,
> 
> the patch-set doesn't apply:

This is patchset for Linux kernel.
(It is expected it will fix some failing LTP tests, among other things.)

-- 
Askar Safin
