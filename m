Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F142B31E
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533310; cv=pass; b=rJEztjhA5GW2DtBqm34CxCbzcW70CdGhiAfDBg5ofUPnuGQO6wIH2xOpkUYaNvOyC/4qtmBvJBNjyEsKZuAGlm8Bi/0iGHS3BlG+zEsftfHQYdFu5szchelCUh5TehGhQNC+AXYZXHbsbsZUz7sZApkJuW/HMFI4t/iT/99i5Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533310; c=relaxed/simple;
	bh=KwUEegJBmzEyHRWT8RaGNXlv+ltBtx+LzUysKofndao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nn6SOZzOZHovhOvdN6Y1+r4Cc+1guYrVzb8lEO3WOUpGlPfWJiiTA5FlU1SnN8c8CYHnrgyKMxp8ogZh+veB7oHA5ey/NCnGG74tB3pcMuIqNZYheu2OoFfskpTbiNaHMT1sHniayd/DRS/OD5MhVucs67huuXiSH0pmTFWflPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpnpEZNR; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpnpEZNR"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso597328a91.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Aug 2026 04:15:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786533308; cv=none;
        d=google.com; s=arc-20260327;
        b=MEQBgO+sbX99K+8ecfOcuMljpL75W9wI9wYPmoBaxDAwfX/kF06PjgqG1XWwNokiur
         YdRK7JaIbZ1MibewUfDH00nzTMYQQ2tpOLAX+4UG7SSqgTa2qYPLK8Se2+5uf5pNbmoV
         ABCnkYSJQJB0SIQNzxkeJnh1Xk0ygOdXK50LUc2HWU0iGxhLLIDuRzDTH16OikSUoHRi
         9SMDcaqlo4VIkzKYXvFVrlLXg9bjs0u1BMR6OSWHr5R8wxS1fdFtsNj5l6VRd4IJZzEA
         /De96UOFYzD83l7dWA4boUcdJEkStxXXiCDQ4wpOUbEJd0xmCa0Z2OFW+JJabvhkJN/d
         isJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZdOT1GptfK2kRtjaBvQzbkIIUWBOb5UFCdwV/7cWWjk=;
        fh=elW2pXjuDPSQTbbNH32Y+PTIQm+Mo7lRQIO3dMqZHbs=;
        b=jhCxe0ARxdwmshfWUxIK4Xw79qDrUuDz3BST4aM+KpqN8pTU2g6b1oYv0xUQNB3u6J
         /Sd4ww0JpDQFGmYS/nz+o8VRZLj/8hbZJHPfhZ0lmICi0nTCbVMKUFI0aSIGXg7FJE6Q
         adAKf9xQCaD20vZM0wrR8bIGGublyTRgBtt94qmRiwq42j3XxwdKTcpTVgzVIocWTd6N
         8X2tMu8B0Ru60q6rQDMRh8Hg6P7rLQnXchdQCAGM9w4kcRWxWIJEdq+sn8X32devbSvu
         Y+Fx7OHpx9CsU9rv9TYOx1VWl2sYC0awuGIxEXck/nIfSdEDSm3uJUB+Yqd3CrLpLCri
         cENw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786533308; x=1787138108; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZdOT1GptfK2kRtjaBvQzbkIIUWBOb5UFCdwV/7cWWjk=;
        b=IpnpEZNRLftamW8W6RxTnCvvEDTecGPzIBm01AI4x8PPla9/gV2TclFqjTYKgEZehC
         sy84aZnNOBRZbxt1HaOqvy1k10eGOZVhwmbG47PjgTFI/UQJYz+rlJbnZIjPBIuv8mrY
         4xkh4/PwPzhbJPl/87F5BZlvSpFhwm88tlni2Eqhb+iVPILwXkO6icVTl0MpbJyAwESy
         nQ+ZPhVrDMqq6TMH3M/9DlEU1Lt1NSrzBxK4Vbty7ez+dKxodvhxITkJzMOE0v2WEvOI
         ejGQ5QjbVnbIvGx9se0OVcAMnC5iP1PMw4Jr5XeLeuLC7CvUPmY0VXKiY5YBofV5kS4Y
         76UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533308; x=1787138108;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZdOT1GptfK2kRtjaBvQzbkIIUWBOb5UFCdwV/7cWWjk=;
        b=DS9ztGWhbkQ7poXu/X205xl7rmekjxrQj30VYfpgEkP/p6tfLQ+3pY55+cb8jd3jYE
         PEXNME5X/5DWp9e/LPp6TW0jrpJQpkMQbTIhRQBcvy924poEKKtOYx0yiv0dRwqrUcVb
         witdPokPZgJZ6zpJIM1Max9JnEyZ//ekVBny/tpfJCn6W2Loly6x2fw1to8MwGcEUwhD
         dFyjydTO7ckzhCFCNK83uTUaHfaAMnuu6LwRz/ytv0sIrC0nrWQa2XGjTXY045zBmEnZ
         2NYSgQ184NV8ZOFxim1hX8wdkQzDdYP0y+MoYjdnGaUuEh3mTHj8OvZeTZwbyg26KNJ2
         P7zA==
X-Forwarded-Encrypted: i=1; AHgh+RoW9gOeZ+T09AuVEJFJZ8huGDKCw3Wqz6D/wWegFQSIoJj/M1jqrtku106foINQrqBHJoSxyHoWErTT/YGz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9hd7/vDSEGu/Tysdj6kC7YmgxDTPKESuylnG4vMjPW2mBhY03
	bjfH3P/eTbRPvBDCf9YJvP+vEo331KAvmvagqmzUt2EFJIGYwYlfgdO7furBb7RpBEQPBQKJgwI
	Qc2R36eCwxkums9MyyygJANn3/3n95SBzdaeJ8kE5
X-Gm-Gg: AR+sD115vnnY52sDcq1ldm9npQ8lOoP/a7OFv6o21WdX82vc04Pq0e1gFCalXxwiVod
	cadTcDH3AYhgVU+9nxGoOKHU/Swvk+6Hw1scINX/FSDK7MkIxKnPDqb069Ft/yBz6ncfN8AacDW
	g7lgsfsAWJ1SzBAnnTGrYNh+Qg79c6+3GZ/YFt9OQWHtnUAyCIccorSSyFDD5Rhy/pdWlvfTJPV
	YPSbngr7mgXlorvbIcAOrXJbQqaNgUnqGEdO4LP/8QKDCZ2MhZCOqsokg5QRP33VXNFS3M/12Vf
	VBygDAKcRnBxGPxyXNU10zWrXcv6z+5/UY+Mc4OSBx1ZqPe9dE1ffeEfSkUHSR2xImRWchlQwWU
	=
X-Received: by 2002:a17:90a:d647:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-393013d66dcmr5008436a91.4.1786533307285; Wed, 12 Aug 2026
 04:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811160336.782342-1-timday@thelustrecollective.com>
In-Reply-To: <20260811160336.782342-1-timday@thelustrecollective.com>
From: Marco Elver <elver@google.com>
Date: Wed, 12 Aug 2026 13:14:30 +0200
X-Gm-Features: AUfX_myPZ42mV2g_1d6jQzHOsWPbwlDbw_iNRf_zK9PQxPqWoyuCWI6anHmlcgQ
Message-ID: <CANpmjNPOY5D9rdGVCwPhS5XqQuJvnP+0zG6=XNL2QLqOE6iJag@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Support Clang context analysis for ext2
To: Timothy Day <timday@thelustrecollective.com>
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, Theodore Tso <tytso@mit.edu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Aug 2026 at 18:04, Timothy Day
<timday@thelustrecollective.com> wrote:
>
> This description is mostly copied from v1:
>
> This series adds annotations for Clang's context analysis to ext2.
> Clang context analysis was recently added in a series by Marco
> Elver [1]. This allows the compiler to validate different
> locking patterns at compile time.
>
> This series enables context analysis, fixes pre-existing warnings,
> and adds new annotations. It is inspired by similar series in the
> block layer (NVMe host driver, for example [2]).
>
> I'm starting with ext2 since it's smaller and simpler compared to
> ext4/btrfs/etc. After ext2, I'd be interested in converting the
> other filesystems and infrastructure code in fs/. I think the ultimate
> goal would be to enable this by default across all of fs/.
>
> The series was built and tested with Clang 23 with
> CONFIG_WARN_CONTEXT_ANALYSIS enabled. I based on 7.2-rc7.
>
> Thanks!
>
> Changes from v1:
>
> * A false positive has been fixed in Clang [3] and ported to Clang 23.
>   Hence, the first patch (silencing that false positive) has been dropped.
> * Use guard() and scoped_guard() instead of context_unsafe(), when
>   possible, to express that certain fields are being protected by a newly
>   initialized lock during init.

Acked-by: Marco Elver <elver@google.com>

But ultimately up to maintainers. Also, thanks for helping improve the
Clang side (FWIW, Clang 23 will release August 23)!

> Link to v1: https://lore.kernel.org/linux-fsdevel/20260712165610.366474-1-timday@thelustrecollective.com/
>
> [1] https://lore.kernel.org/lkml/20251219154418.3592607-1-elver@google.com/
> [2] https://lore.kernel.org/all/20260706141452.3008233-1-nilay@linux.ibm.com/
> [3] https://github.com/llvm/llvm-project/pull/209796
>
> Timothy Day (8):
>   ext2: mark s_next_generation as guarded by s_next_gen_lock
>   ext2: annotate ext2_update_dynamic_rev() as requiring s_lock
>   ext2: mark statfs overhead cache as guarded by s_lock
>   ext2: mark s_mount_state as guarded by s_lock
>   ext2: annotate ext2_init_block_alloc_info() as requiring
>     truncate_mutex
>   ext2: annotate block-mapping helpers as requiring truncate_mutex
>   ext2: annotate s_rsv_window_root as requiring s_rsv_window_lock
>   ext2: enable context analysis support for ext2 filesystem
>
>  fs/ext2/Makefile |  2 ++
>  fs/ext2/balloc.c |  4 ++++
>  fs/ext2/ext2.h   | 19 +++++++++++--------
>  fs/ext2/inode.c  |  7 +++++++
>  fs/ext2/super.c  | 35 +++++++++++++++++++----------------
>  5 files changed, 43 insertions(+), 24 deletions(-)
>
> --
> 2.43.0
>
