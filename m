Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792763688;
	b=v+yknj2eXFsjv7ehU2JZW9PX1wZ4gzvjirC2H07ioamO2qeccHBoNjXIlmeMxyL6mpZs
	 bdoYsiixmsJsyhS3jOm9wgH40y52CQtrQ+6+jJse9NL0f6Xvk4HW2ukrdj15vcVEbo+a1
	 lkFR4lAGhLUR1UwfRF4eSwK5POUvNKSezaBhTyihFfT9rLwzP/oJVu+nYphcC1KP2T4c2
	 6sCPJup7sEGNRzHIl1UAbfUaWxtD5QtLmQcdY7YQIxyv25EsO2VqCkqORfxAhpACBs4j/
	 L/3hHr11+hSKbc75eNjL0iMK+IRtvtlHDQgEVreHwu/fWsfqvpgvtl0Fp8PbKL7bLPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792763688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=2+AhzJ7L8tQJlY/aZD4qLJRxC1d8AyZMihzE03ThXFg=;
	b=4uu/hRLonPtupL6UCrPxSdW3yPtRFjq8JaP9xYkPELpcUS0MpTMINWBGXPYclE1PYH3e
	 2/2YeDda3NrVmfwESIHqljSB6AcMxFfAgX/TELKtOJ1GGnR4AJI82TUSTg8vWi6ju/J/x
	 CfurI16suVE8iQJznCaWjLf/wmNMgpH1biIQsipYfLE2KFk348rRYh9xQhxZOqSY5N41S
	 Yq8eZJZUgViCRr9UnPAM/mPh+nLW7VUdg39Rp/LDibgXJ68XOPIvplQfLZDl9fbZu98GO
	 b+m9XY6JAFnMICitSthHRma9MX272hc224Yivv0iKlXeEyyw80wxKUY8fM8HIl+E4Dg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=r2Zn7V1M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF71606A31D
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 13:54:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF71606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=r2Zn7V1M
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso1164480a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Oct 2026 06:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792763686; cv=none;
        d=google.com; s=arc-20260327;
        b=U0vao3H7WkfLzHm7/9hjhFTZDPT2JPtL9qPeiRq6DPDP57zuKFS1Yf+hvdtwxetQAT
         xsCqUqT4tIrnZd2MKQisFNzm1JbukrVT6c54keea5eZlGVl6HiCtAbxk4b52+Te5ZhKB
         RCN+1YFAKXDUVeldXdU69freY4HU/SxZXvL+n2sM/RFyY77/zx96dWKl8cnDhEZQT0/W
         7Y/AlHfS8OYkO7v2vVtLd5wkXNV3oh+q69flpbElsBa1sF5BVdWRXmBWsdgwkDRrpCtb
         GU5n3dtHGfqBefsaOy5LqaLM6vJONsEyLcIoGxYV3xDf3JlfoVFYh+YM3P3BoUfBV96z
         dodA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2+AhzJ7L8tQJlY/aZD4qLJRxC1d8AyZMihzE03ThXFg=;
        fh=POaA8RlCNWn/Bc01IU/mb2GKA0i3Nz2o29tbopu0PCc=;
        b=nY5QM5Vrql+LCHsAWQxQuqUH1VdUbO2oitUfR5Ms5Bm6osoKFGRLAncy27g6Z+WXRe
         cYTkrFV4cFIIFuN8nicB37L0849VQJKuQp+XRg2SD2bwbSxqoldjEge1WLMcg1Bhw42I
         i3i4EgAKX+pMn13v7tWu5w7ZHD/qNnEVjaBnVls3AO0A1ZW7XJjXXgjfFP3cGjbJNq47
         mHGq79C0uXlVvFSXPvX3Ym0XqPiDmiMPp4oOvVLvcKKuKoIMrgkA9LDw9zUbQ/QvYC+g
         rUKc5p6Y5Wbc7yy2CER8wMaipyZQbWoIEO3BbeLhvGURsqWFu9yKN4HyU0W/yw+FzAHO
         LZWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792763686; x=1793368486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2+AhzJ7L8tQJlY/aZD4qLJRxC1d8AyZMihzE03ThXFg=;
        b=r2Zn7V1MeWwdfM/XmXgX9Sb84phDtlFGMHpyF7f9b9hCLBBS/fiDx3QC3JKDSFP5MD
         LWQ0mvzZR2ib0k5Sh/fltlQ0/NnyUUVx9ZzWYyzdbJiDuDizFcQdztFRtnyvrG6Yu+Cn
         dvlCigenjv8rIBI/nDd/Tx9ovJlyN4m0YM5sxFEF19gvlPGiYeJRAhqohMyZb1roVg/C
         qdD8SuipZCYMOJetG8RiUa1eJCvCukyHsZ9U/TL5XxFMe5MibuLwLOcB8om7U2NNAWKw
         bzGhi3rE0IuDTA677sgSXJrswpj5FaoBdyAz0AEfJsArOSE8Irdz4hc7IqLBw0eFAEHK
         eizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792763686; x=1793368486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+AhzJ7L8tQJlY/aZD4qLJRxC1d8AyZMihzE03ThXFg=;
        b=SOgtqxhHCCSKJPRlvce7TJYMcmEj1CEL/Y/Pf1qvpUrueKrxTfRFd74aIh05SzFz5j
         nNNawm8YOF2cgxHzTLwB8LHHDqWKRyB+X2DxOyWMiHpGma6wj00uwES3Hu9yRUfnUTDw
         RFs8qY9X83+NrDtUJ1ofqNJ+s/ipMlQVd8sfY5hL8DkEVic+3C+TxLgWayz4oUaqjrZp
         cQDfronIaD8V1sSRUiy0mIxO1BV1beCrrdSz7smxAFJrGHVoJ4uV2v8bfqVaDEA9+lYg
         fmalDh+RjQN8c4IJuSbPxtp6rUH3GEhDz/P+Ei0WI1e4RohAeujBUoOrXWzbpkQSUl+b
         vciQ==
X-Forwarded-Encrypted: i=1; AKwUvBysYBNJvX8NsClJgu4/A/7woQbS4QHiJX8KkEYBSljtx/rqkZCYhxLeWAGGMlgyaV5xzHucTuA967rqkTyd@vger.kernel.org
X-Gm-Message-State: AFq9FYKdBIpBBkQ7+fvOoY5dm1Wr+Va2v2klsNIJ1WeW6EQih7IMjLn/
	a5XOskneSBnFL4yMryVcN7UwVIHTxwHs7ZHikn8DEe/bycYPGb6RAav0EYmu3893LXCNloTs3je
	SJUd61xCyPmM69oH3+T16N7eKKesVGezKLXjIXVBktQ==
X-Gm-Gg: AYBFou32s/8J4dRZCQORaypXUFvezbunR9FfN3dQlZWbMUjIdTq11Q2gMQJhaxcp3xf
	/fJaDguaWBLpmZ1qRWkz2mgUHaPtpi0VWsdHdSE8rUmM6WbKqupXl5yYgPAgBGoryaPNRCSLvgH
	lYBWKPHSh57ofjwsBp5rk/TVOghaYlbZO3G6e62GtzjZupghMr15UGLg7Gd9MmK3NT7PhV5N+Zo
	I8AYO1PkYHjnDCiuiXmfWV47C5DGVo+NvLSUYoGM4ZYA256/ave95lxEANpNCelgSpBLJaDlNiO
	L6hOmWNxaLqbiSIKn4akEhXLGfXu2GFtwRRKU2MKmbsIa2U9SB95aqBG2QZL83u/cqr7sYYy/U1
	ZWr3T92T9GOTXwua/hqyGkIwKLwoMuTtmycZRyyvkSaoDimY4dUGZz050N8xgf+mInlG7ypKs/9
	cUlPrpNJKD4Ht1BsLY
X-Received: by 2002:a05:6402:1492:b0:6b4:2aa6:2bf7 with SMTP id
 4fb4d7f45d1cf-6b432bf16e8mr2720618a12.17.1792763685720; Fri, 23 Oct 2026
 06:54:45 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
In-Reply-To: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 23 Oct 2026 09:54:33 -0400
X-Gm-Features: AclHuK9zlK4tzMFGd7noBnaTxOTknDoJhgjCCtyLPmJXdPLrb9-AWs7tjRyMZTo
Message-ID: <CAEzrpqd6bW5tDMox92VJEMVJb6ohzg55KFzZAXCiQNGxvecWaw@mail.gmail.com>
Subject: Re: [PATCH 0/5] super: rework super_lock()
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 5:42=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> Josef's two series (cf. [1], [2]) left us with four ways to lock a
> superblock and two ways to wait for one that's being shut down.
> super_lock(), super_lock_shared() and super_lock_excl() return true on
> success while super_lock_killable() returns 0. And callers that need an
> unmount to be over pair super_lock() with super_wait_shutdown() or
> super_wait_shutdown_killable() and have to pick the one that matches
> the lock they took. Jan pointed out the bool vs int mess (cf. [3]).
>
> So fold it all into a single super_lock() that takes SUPER_LOCK_EXCL,
> SUPER_LOCK_KILLABLE and SUPER_LOCK_WAIT_SHUTDOWN and returns 0 with
> s_umount held or a negative error code. The first three patches don't
> change behavior.
>
> The fourth patch makes sync(2) killable while it waits for s_umount of
> a live superblock. Right now a freeze or remount that's stuck under
> s_umount hangs every sync(2) on the machine and nobody can kill it.
> fs_bdev_sync() already works that way.
>
> The last patch adds a guard for super_lock() for the callers that take
> and drop s_umount in the same scope.
>
> This sits on top of vfs-7.5.super which carries Josef's series.
>
> [1]: https://lore.kernel.org/20261021-b4-super-lock-dying-v1-0-2b35e86706=
ff@toxicpanda.com
> [2]: https://lore.kernel.org/20261021-b4-super-lock-unborn-v1-0-0265eddb6=
dee@toxicpanda.com
> [3]: https://lore.kernel.org/tmw22jj2hn6g6lklme2j3rsfjvmstzpoicvibvmmv6si=
vd66oj@nhc4lng25gti
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
