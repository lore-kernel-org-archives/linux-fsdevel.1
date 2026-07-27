Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A673ACF1B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 04:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785126043; cv=none; b=Q8j9Lc1NS18bxMyLfZhDR5Qyjx3tRa/DVyWhWHV1Yq8N760Ymb9Bp+apK8j+q352C/1HIlTZFcqPq58LnE30G5BHjM8a+4WM5uTquIpf3e+yx9LkwHI3Aiyvy01zPqQHgqmlNZAhlo/C6R4urNIbdQEMQKk2NgnGkk+hJ3ytuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785126043; c=relaxed/simple;
	bh=aWBy8MvcQBe7wO5IRYjsDNmzmbd0f6EfpSRDMgJ0Y3Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/tDTVIuC/gjl87YPZ/pO2lmhzWrPPSmOZ3iloLg+dOXCxgdkjfPtb0ke4dgid5uAGZGY61nJkBb5sbkrK+HjPjJoCumJTbmY6HNo63EF8eldk17fYzT87oUe6qb+T8TfEv3X08Q87HUWHfNn3gPRWsdOlw30ZfGiRjudVDLJvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pOTtaeqR; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pOTtaeqR"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5276d598b96so13977841cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 21:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785126041; x=1785730841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HRtjz77w8Vz7f1z3O8tUeRdMvuT4xbXaziStD0dymQc=;
        b=pOTtaeqRFaCl3SiACT6pCTQtSFUO5fS+3C9E4BJmxxO9cxSMMXBTMd0lyWDampu3p1
         ai6FksQ7+LRsm6hc6PI5vb2rRMhpjC+MglJEQ+BV1QGugvZ+5rdaYN8VvXRLeNAfQUef
         Z9/gMY/XmHeVu5KK5BU5w2o1ltlwblsn2QOMld+Db2yOVnr1dYA1+w4/MB11ym9+r1/c
         R5pX/BFvr029nYm1oezclfO2fH45Webhf7jnimt+sjbmT0E5zQNH7ZOgF0j2rTWc7EJh
         rOmy7heiBpoqUG7p5gkNHMp3MXEEYK0JfpVgrNoFQs8DKs9RMHqpFGOYWk2WH2ZmzAaL
         CQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785126041; x=1785730841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HRtjz77w8Vz7f1z3O8tUeRdMvuT4xbXaziStD0dymQc=;
        b=CI7EAyzzLOw/DlfzARs+rnh8+Vybfoga6TH0qSQnFjQ051K5yq7qAkkxa5873j6LMf
         Ub113gCPZkGIDuyhK4mpl51ZGxjMCQO3O5crMS35fxSUH0bR8H/ELJxHJnul861ePyVO
         3/VALBUZlR6NEJAwsPuCghs3o1WwTMV0A2p1qgdFKoAr8bgIPwV4oKsbaLGMhB+JCm9P
         bxZ4hzsK6UCf/4hM6VQkgbLnJnolQctXdI8axIUyLKEttHIPIcAZ6YbyiiOYUF63jalP
         NC2e6TPrhBIdtyNmqrS+8n6jP4IA8sMVSLXNp+VUklwNgWYi0dL8DVKG0HU+7ri+19fr
         FwBA==
X-Forwarded-Encrypted: i=1; AHgh+RqMCdJU8x36A/a6ag9mHfUB9T8VR0WdIeLW+S2qnBJcPGpVxEh3lxXXhfkGyQkEC8bn7qY1oHBHegZAFQ19@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+XGhm2PQkKArkUDvZxVPoOrne11snDsXHx9sj1GC6b7MX2+TR
	kHQ2TlSgHFMLFklEl1WP/rDVG7mBLJwq1hA5pwBiEQxstUHHsWbZ2Tbq
X-Gm-Gg: AR+sD12ITN/eXKRkY++I+TVymcgByTKvuB8mzkxDRgkY8/DnoYuAVyCN4SqNSmP4xsv
	nW/uMyBnOZBVZtZwt4E/ha0ylseYc/t5HfWhlOao0kwxpo9MoLE9kfB/F+v81JaNorIir/x9Z6L
	45ld6rD1ScfpVp189eyViuQB9XJu4Nb0zMiTrEKMWlT9XuJqj6flmuXP6gm0Od/AHrmxRrPq5Rg
	8rc+yclu8Wc34bczRBumCjfHk3E4y+GHvTL2F33NXU/QWzrds7oogM84NgkqnUGmnQRSuVuKR4n
	CTpwNHq+w4jT+5AUUwhs99ip+eNno9t6Hiy5Qgy1AZwAjI882sh9qZbcu+6uRDCVuOgFD/Eax5e
	M1oxaj+i+nTdhWRB2GYo4/fXcxlH8enyXYtyUc+qFufA9rAi2t9oR+/8f+mlwwDzPkB5eyElx99
	thWGDsA24+RqzSdfUhs3SuAXToceZny9T3LJENGOvhTTt5Ojq00Jb6f4dBMtZpWfVAkleNIo73s
	MF/UHjqnUqoA9pC
X-Received: by 2002:a05:622a:120b:b0:521:5c5:f986 with SMTP id d75a77b69052e-529a84c3c59mr70062121cf.33.1785126041192;
        Sun, 26 Jul 2026 21:20:41 -0700 (PDT)
Received: from zhangbo56-PC.mioffice.cn ([43.224.245.235])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-529a27cdc4csm46594951cf.2.2026.07.26.21.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:20:40 -0700 (PDT)
From: Bo Zhang <zhangbo0325@gmail.com>
X-Google-Original-From: Bo Zhang <zhangbo56@xiaomi.com>
To: oliver.sang@intel.com
Cc: jack@suse.cz,
	akpm@linux-foundation.org,
	david@kernel.org,
	fmayle@google.com,
	kaleshsingh@google.com,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	lkp@intel.com,
	oe-lkp@lists.linux.dev,
	surenb@google.com,
	willy@infradead.org,
	baohua@kernel.org,
	Bo Zhang <zhangbo56@xiaomi.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5: pts.svt-av1.Preset13.Bosphorus4K.frames_per_second 45.8% regression
Date: Mon, 27 Jul 2026 12:20:22 +0800
Message-Id: <20260727042022.3503727-1-zhangbo56@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ama/sQIK2O0MphL1@xsang-OptiPlex-9020>
References: <ama/sQIK2O0MphL1@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Jul 27, 2026 at 10:17:21AM +0800, Oliver Sang wrote:
> quite sorry that we lost the machine we reported this regression, and since
> pts running need some specific settings in our test framework, we still need
> some time to setup on other test machines, we cannot start the test soon. will
> keep you updated.

Hi Oliver,

No worries at all, take your time.

I should mention that my patch may not fully fix the regression reported
here. It is just based on my analysis of the code path, but I haven't been
able to reproduce the exact SVT-AV1 workload.

To better understand the issue, would you please share some information
about the memory access pattern of the pts.svt-av1 test case? For example:

  - Does SVT-AV1 mmap the input video file, or use read()?
  - If mmap'd, are there multiple VMAs over the same file
    (e.g., from mprotect or partial mappings)?
  - What is the typical VMA size relative to the file size?
  - Is the access pattern sequential, random, or a mix?

This would help us understand whether the regression comes from the
async readahead blocking I described in my reply to Frederick, or from
a different interaction with _max_index.

Thanks,
Bo
