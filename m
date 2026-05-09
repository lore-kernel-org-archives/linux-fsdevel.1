Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E1E208D0
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778299404; cv=none; b=jHp5s2IxK497LdRPPMkeyEu9oaYZR/f3x1A1pVXy3CUMhUanN3mwA96u99i7PbTbuaegUXiU8COGOlznupVYdeHh8Ie8dprvZ8+r51DXxMMCJwlIOVRNmDoQYc/4k4sst/liJ/Hyd9EQBSyLeHIQpvW6hcY0hakZLQh5DlEajb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778299404; c=relaxed/simple;
	bh=USrxN7dbiizxxzLCqAEPmBz/dzSMw19ueg60+sjE1yc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNO8zCmJcygZbNg0Y4CYNUtPxSrc0d+ukIL94gMW0yiL0ufGtfdmq7z4CU5V0QWq0KxLXdk89/uHCBP0VlILvWN2lkJZBB5DIMR7J9o+whCqEs5Lw7lj8RD5IIbaSV/yL3AujAG+nE93XTiSyrweI6RyDYR/y4ZqpTurhVOWIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hNxyXq69; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNxyXq69"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BBCC2BCC4
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 04:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778299403;
	bh=USrxN7dbiizxxzLCqAEPmBz/dzSMw19ueg60+sjE1yc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hNxyXq69rWcZyEaEGqnWRc4fCGH0Aq+Z9mgi/Wf6pDYAvoru06Eir3QTCIHdfJlyM
	 ea95gGeqYT281i7ij1S0zC7M9fuWCe3kenMiNILt+yu18hqU8/BwEO/P8t99bvNqir
	 vzTREcnJTrP33pBoNrBwSmfVZuumCrd/V8/YL5acuE2El8sOicQAzlhtbEpWw1rB+l
	 RW9q8Omyrn0KlqDn3FQybLndTyj7wlMt4Pn2rEymAXsbaISimdYJbbd8+iC6zrJVRo
	 XFkqBtlFXHkFx0jVrfVT/ALRwSpggovxaIIBU9whS8Bcl1OXDji+znm0zVoAWnImW/
	 TNpQnB2QiWhHg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-672645dbfeaso2879436a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 May 2026 21:03:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+iu713m9mffqZAUgDHawkLgP81yIi3KOd1JDv9P8OEZDvDtkHywXT4cDLClUEt6tLXM8SyDV53HvFEvKgC@vger.kernel.org
X-Gm-Message-State: AOJu0YzPt3XRv2GCyVOWoLlynE8G2ZxxrxhwRSxb+sIRaWt9DIGN0dZz
	f7MIpPoTnjyvl/FdSLHlRTB7hMxQJwzFGjOpC500Coo0LUiLs6u7SXeW3Fyu5i3LweLRjsGQmTr
	ZctEKgtNOqgRJ73STvH4m4i5dAkV2Thg=
X-Received: by 2002:a05:6402:a0cf:b0:67c:a5b4:91f5 with SMTP id
 4fb4d7f45d1cf-67d63d85102mr5753966a12.6.1778299402317; Fri, 08 May 2026
 21:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508153410.2624801-1-charsyam@gmail.com> <20260508153410.2624801-3-charsyam@gmail.com>
In-Reply-To: <20260508153410.2624801-3-charsyam@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 9 May 2026 13:03:09 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8d7Y21GqeoMYrhRhNyT44uRuqF3hZVO6_dROS1JRFZRw@mail.gmail.com>
X-Gm-Features: AVHnY4IL0BKWDdAsr_RDAhdbhPHW4Qii6qTEOa_0dFyTs46UBr_sXOdoOGxVkpI
Message-ID: <CAKYAXd8d7Y21GqeoMYrhRhNyT44uRuqF3hZVO6_dROS1JRFZRw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ntfs: fix MFT bitmap scan 2^32 boundary check
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Fixes: d3ad708fecaa ("ntfs: Initial commit")
The warning from checkpatch.pl indicates that the commit ID you
provided in the Fixes: tag does not exist...

WARNING: Unknown commit id 'd3ad708fecaa', maybe rebased or not pulled?
#67:
Fixes: d3ad708fecaa ("ntfs: Initial commit")

If the Fixes: tag refers to a commit from an oot version, please do
either remove the tag or replace it with the correct upstream commit
ID that introduced the bug. Other patches also have this tag, so
please update them all.

> @@ -1279,7 +1279,7 @@ static s64 ntfs_mft_bitmap_find_and_alloc_free_rec_nolock(struct ntfs_volume *vo
>                                 b = ffz((unsigned long)*byte);
>                                 if (b < 8 && b >= (bit & 7)) {
>                                         ll = data_pos + (bit & ~7ull) + b;
> -                                       if (unlikely(ll > (1ll << 32))) {
> +                                       if (unlikely(ll >= (1ll << 32))) {
>  #if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 6, 0)
The kernel version check code is not in the mainline, so it seems this
patch was created in the oot version... I cannot apply it unless you
remove this.
>                                                 folio_unlock(folio);
>                                                 kunmap_local(buf);
> --
> 2.34.1
>
