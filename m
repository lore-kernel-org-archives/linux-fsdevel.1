Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3262637F321
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786967776; cv=none; b=AI7ZnPmUEq/pyIdhHbTUy2T2NfSHl87fTQ3JBSMQqVveEx29i0wLAMPuqLgzzTbhOWwONiuOwhVDpT7iGsyVLxbTZhSFMqFeRc8ueqB0b04iYV8XGEW0igkw31p9rxRIyc/cs35sZTnxCIpwy0+reH9zC0gsk7rZXwVfqb0YJu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786967776; c=relaxed/simple;
	bh=gzRJXBdV8F8etrfoI07Lkxj22HbM90aYLBdMyiU7LZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mPDvf4g1vf18hNY8xiSnFe32hKA0tBAUpyzc9RONaYPox2Zwgk/dv7X2RmLFn49rEHLXdAQuX9KHg97B3OxcqSrZpzhK2NyyqElF8rsTcTewirRZOebuAw4cwHKOV2djTRavwq+X1WHfmfWMgZnNLAGlw3TWhjhgXdXbt0oFFR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IncCM0R3; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IncCM0R3"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8485b358552so565469b3a.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 04:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786967774; x=1787572574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w+/WPa1H4z18A4Ns00WBv2mk4sUGPvZyOxNjtlFVYlk=;
        b=IncCM0R3/4IQcq5p/MRGmWURFUkqIHfcRZr+fAiUDArzKmwQz1nCmmInuhrWSpW7hM
         0L8AQNYNWoICzkFekBCCUMHozCdNGsH+D1gKnuq994maVd1Y0xEIIGXptUbfymGsoRAd
         2GLDoxUhuJkzgQV6xDnYt6+VH7UyWHkn7W3AROHilzI8xb8xZw3k7J5+mhbVBACoZJxz
         CQQ8lttKG5t5givQ1WBmIN9N1w/9a2YkAjKjSNO62pAeeAwWTyljGm53cj3MD2CJfhjA
         EwqbtjyBt+7cs05XYIUZYPlvsH4mQ6AxwetYXR6QlM3BHZ5aUgX013XSofW/+7UYN8Jz
         KXdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786967774; x=1787572574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w+/WPa1H4z18A4Ns00WBv2mk4sUGPvZyOxNjtlFVYlk=;
        b=DxqJe1C8s6kxDDd/m1gc91qA5tlmht5HIRP4DBc/7NYgoTHZGITsGNF7uQJS6gUSaj
         BED4966dIgmNWtH7KtvermLVF0I8SjuRSdDqwnSqEsoG8vzLPndFGWfV8OCOp9OcubFO
         +qiTXanDaQ3mumXae8TI/5bjCxIucodeFnqHGCE46mQIcY+VcHxVnXMrzelCt/Y+59ch
         ivNsxZ66MbodBik/8dS/KIuG4EwVZq9cIX3hqNOrubQ6ZWSo0dtH/nq8sqxn/hZFx/i7
         YCmvwxLGhaYrftZgfcJmGrnMd4z5KRUhgo3k2VTrj0dpTmqfqnqxoJfSM2xGABH/nEjv
         4kwA==
X-Gm-Message-State: AOJu0YwxpHuXE1ll3y7bHtZk2D+1zBGVZdIk3mPBGa69bMYTsqNmdKla
	6Fy+OMUxav+nF4Gc5rT56W484whv44T2cmc3AbwY4TM3k0s/WkPeQXZn9NvUI6jyhd4=
X-Gm-Gg: AR+sD11P/4suf1FuPVDQ8wgA4VSYNQjhmcDVO7qRB2xgBk0BMNxBG6StIjeCX/4Ecar
	eKPS9C3RU09DY4nXXyc74noLAHJNojbh7I9o7drw9UJHM5+AXoVWQfpdVYJVYZZaEg5Q+wDIKz0
	+GDVFQoy7oPKtpf9oJHQgLSecj5jsJiCGnyCnzuOjDghtxbzhgIG4ylHCS9CVMksvZAhB7txgK7
	WokbF/S1wScg8c2gtXWTc/69IGQn2b0ASC/oCrKi/nXiKsoL8KN74/uEgKw8Rdq07YIB6Bpu1I9
	Sqk82Z9xHAunvQ3ttbeJhyGf0c6tpw3r8y5HerWv1HYJu2qKIo470FjueA2WdOqeYhNKzJvesjp
	94N/laFEznI4E2+5IKoKVVoahDo15Pggop2jFnpYKxJKpwUtVTLQJe8h/srZAHRvLura3n1vFv/
	Gk1+BfvxzHLaNcJ4OgsIkCHkhuPodNQyOllIe8srA1+s3nESPzLoErstPXuclZzxtxIDKSyTeyG
	Ei5+DrNn790iVpEVPWlEcOYnBdGRIPsGVaLCxrE8BJ6cPRdJCNmZ0hoODjoPLoiq+k7uThJaXta
	KwTnvoMf73AI3hDw0whxq2OLJwcOKw9kRGKdO3Z9fubWrHH+RcJE
X-Received: by 2002:a05:6a00:4186:b0:847:82db:9046 with SMTP id d2e1a72fcca58-851b885b6f0mr100714b3a.26.1786967773708;
        Mon, 17 Aug 2026 04:56:13 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b6f8cdd1sm161099b3a.36.2026.08.17.04.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 04:56:13 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	ansgar.loesser@kom.tu-darmstadt.de,
	djwong@kernel.org,
	david@fromorbit.com,
	amir73il@gmail.com
Subject: [PATCH v3 0/1] vfs: add FILE_DEDUPE_RANGE_REPORT_PROGRESS flag to FIDEDUPERANGE
Date: Mon, 17 Aug 2026 19:56:08 +0800
Message-ID: <20260817115609.3586664-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814082326.3756669-1-matthias.goergens@gmail.com>
References: <20260814082326.3756669-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since v2 (<20260814082326.3756669-1-matthias.goergens@gmail.com>):

Adopt Darrick's three-case semantics for bytes_deduped under the flag:
drop the -EINVAL on zero progress (a zero-progress success now simply
reports 0), report a safe advance step on FILE_DEDUPE_RANGE_DIFFERS,
and keep the actual byte count on FILE_DEDUPE_RANGE_SAME.  The flag
constant is (1U << 0).

One deviation from the sketch: the DIFFERS advance step is capped to
the requested length, min(i_blocksize(src), len).  Without the cap, a
sub-block request on files whose ranges end at EOF (permitted by
generic_remap_checks()) would report an advance larger than the whole
request - e.g. two differing 512-byte files report an advance of 4096
- and a caller following the hint would step past EOF instead of
stopping.  With the cap, "zero means no further work" holds and the
hint can never overshoot.  Measured on a patched kernel (btrfs): the
512-byte pair reports bytes_deduped=512, and full-size differing files
still report one block.

One point I would like opinions on: where the flags field lives.
Repurposing reserved2 needs a name, and there are two precedents.  A
plain rename (as fscrypt and statx did with reserved fields) is
tidier, but it breaks source that spells out .reserved2 - which the
"must be zero" documentation invited; I verified with installed
headers that such code stops compiling.  v3 instead puts flags in an
anonymous union with the old reserved2 name (the io_uring_sqe
pattern): both spellings compile and the binary layout is untouched.
If the plain rename is preferred as a matter of taste, the code change
is trivial.

Two review notes worth surfacing rather than hiding.  The DIFFERS
advance hint's safety argument assumes -EBADE comes from the generic
remap prep's compare, which holds for every in-tree dedupe
implementation (btrfs, XFS, ocfs2) and for bcachefs out of tree.  And
two independent review passes attacked the one-block hint itself: on
stacked filesystems the top-level inode's block size can be
degenerate (overlayfs inodes report i_blkbits == 0, so the hint would
be one byte - v3 falls back to the requested length there), and a
caller that only ever advances by the hint walks past identical
prefix blocks that a subdividing caller could still deduplicate.  If
reporting the examined request length on DIFFERS in all cases would
be preferable to the one-block step - it is simpler and needs no
block-size knowledge - I am happy to re-roll that way.

The paired fstests v2 (generic/806, on the fstests list) exercises
all four flagged cases plus an unflagged legacy-pinning case; every
expected line there was produced by a kernel with this patch applied.

A man-pages patch for ioctl_fideduperange(2) documenting the flag will
follow once the semantics settle.
