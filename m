Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9A27FD74
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 08:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792865; cv=none; b=H4qR8+aNb88kQwNN/wtUOFXNXf1myM4Yien8FBt83hei7QPjOwmrG4l6N46zhjlfiedkRgLrJ93+8bfFeNcmZ0pGW/W758/kzczcmjTYX0csb4qobRpCkkbdlSYApIipitQMJ9TIjG/aKdl48WrNbEzZO7iSpm+Xh4ooICB07y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792865; c=relaxed/simple;
	bh=xxtcnQ2p520nCwaMtIRUXBpN5cKppQiHY+3psB1PDCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWo4SgRbo6BntQDaWxPvwbqfMxQUcLjOvoo5TNpMd7D+/DxdrzRzYMvHTq/P4w/0+ptztBFxKBQuHBTv/yCCOUvZByfJEazO1TLnm653EcDJztdxoy0h8EWwPjUsJf5aStSg3dAxM/e8M5XlYBgixvqpRGs2Zbh7xWOwybihd8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OHNsJntA; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHNsJntA"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so19526765e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792862; x=1792397662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TFWZRnIucg2NcWdbhXql7kmMuAfL5coJ0dPwErOelCU=;
        b=OHNsJntA7x8TkYLwIjAFIfgzF2DkkEh455WqtqdvjEIFDHAkMkj8BDQzZkWepfOTIS
         mjKpTCHoTT2V7NUJC1+nGa8E3JafzLFAyMLJYXc/TDKmw3ygIFoLDs8ejS+M7gqnra6h
         rxtyuuG6U5oV+iRnaSl1Ud3RIUjCgqvCa50+7jauspmI6FgMl4rNOR14p+V6UjXbUZ6A
         zpukyMkDyV/CaLEhWFougBRG7UvC3a30Kyv9Q/DruElFBouEIKXOm8ft51EC1iA8xWkg
         5/MkYuyqbTgVScrLuHQ/1BuMlA1wmo4AZI8Oj/yo1S5YNcANT+dwOFvvAeD6KtU7+us2
         xQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792862; x=1792397662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TFWZRnIucg2NcWdbhXql7kmMuAfL5coJ0dPwErOelCU=;
        b=zIA7Re6VYwGGdt/LfYI1xVQd7kyx2ehK9I5BWrOxDyk8Mmp1VHdKkpdjmzjkJoYXuM
         l2gqqLDrAAaIDK5Su5Ox5rm8daLDIXl8KqqWZ6v1FqTRNP3P6AAjfsDhRxj1Q788l0bD
         a8Y1Y3Pm/XhdXVfFRtUEreGuUrByV8B8bBlS+CM4cOHkEnSS9IHS9YgVnSDbDgs6BWUy
         yAdduM5qhysxrlPCGzk5EfFkcphIvaGlF3PmniC0B+A1pif0yJY9cV8cZ0/RHXTgfP19
         lENd6jm76Kv1rC7Gn0J5xR9nHJ/iudq+eZKsuvLCQOBuiigMYhg17XH9V1CQR/m8VdtT
         NU5g==
X-Forwarded-Encrypted: i=1; AKwUvBwcTlWAYf4T+cRluFrLxFydUqTvAgENx2KcxbnDmUAQ1L9PQQ+ZfEU03EvFv1grcq0wY2F6j/q3sOtAwGe4@vger.kernel.org
X-Gm-Message-State: AFq9FYJzybc2SjX8lHxt1GFOIyQjjqk0y577ZLNejj/ioYr7AADcUHgX
	MfnVKN4diMgtCHrjmHXslOVo9CCNyaCHy/yxjxSeAKaj/4r5IuNUfz0QP1ZYoA==
X-Gm-Gg: AYBFou1C8dRW77vNe8U9V4QWelODSc7KXXBARRKUB3FdZjuq5ZY1TgyQg7UFjkilkE4
	wPwXZkCgmPxwz9afeGiCJcK4Ewq6Pi2jQC/My0gtKSoQg1QpBeMwOQFpPcdASwoUxDQ+PwNuOQH
	P4z4mcCZfHZlXvpXypoI2rbgU31iZrMEj1aip+0hpy2Cj9v1M6nCXdD2fLFooMoRIFn9GUbe8B+
	+R9/mKINrmYoISD8Dtu6fYNIZ1fEFTM1bRkLMbDNKa73fOc2bwsyfxRKUDjZpQDgRIMadGzWxMn
	S8OGf1USSU3Gq7IAM686x2ziqG3N/tDjR69n0V+dseaX+kpdw1RcnzeTlZV4/aYNLcCRA/cOIfW
	tEkcv/qLwlpp6bf73KndBFaYPEaYVKZ+7emEqlJiOL05C2B0n5wU01eeQZd5+dE7iarIRCLtzKc
	1irTERzItltJjmDeHHQlT/Hq+8Zf1dSlGjIET0kirgoOH8KJqlcfAUP43Ozczm2poE67qwOofIP
	XDPJgVKhvCy+YLNdgzSzhSgoAce9ugvFZ1yVDdDdVAp
X-Received: by 2002:a05:600c:348f:b0:49c:fc6e:8caf with SMTP id 5b1f17b1804b1-4a18e4c05e5mr162095315e9.19.1791792862176;
        Mon, 12 Oct 2026 01:14:22 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e49792bsm432059985e9.4.2026.10.12.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 01:14:21 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	lkmm@lists.linux.dev
Subject: Re: [PATCH 2/2] Documentation/litmus-tests: add the mnt_get_count() barrier tests
Date: Mon, 12 Oct 2026 10:14:08 +0200
Message-ID: <20261012081409.7590-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011-work-mount-fixes-5-v1-2-a9b9a8ecf565@kernel.org>
References: <20261011-work-mount-fixes-5-v1-0-a9b9a8ecf565@kernel.org> <20261011-work-mount-fixes-5-v1-2-a9b9a8ecf565@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 11, 2026 at 05:30:45PM +0200, Christian Brauner wrote:

[...]

> +	r1 = READ_ONCE(*seq);
> +	if (r1 == 0) {
> +		WRITE_ONCE(*gets_w, 1);
> +		smp_mb();
> +		smp_rmb();
> +		r2 = READ_ONCE(*seq);
> +		if (r2 != 0) {
> +			spin_lock(mlock);
> +			r3 = READ_ONCE(*flags);
> +			if (r3 != 0) {
> +				WRITE_ONCE(*puts_w, 1);
> +			}
> +			spin_unlock(mlock);
> +		}
> +	}

[...]

> +filter (0:r0=0)
> +exists (0:r1=0 /\ 0:r2=0 /\ freed=1)

The "exists" clause requires 0:r2=0, so the "r2 != 0" branch is never
taken in the executions it checks; puts_w stays 0 and the "r3 == r1"
test in P1 reduces to "r3 == 0".

Going further, both tests stay "Never" with every smp_rmb(), smp_wmb(),
spin_lock() and spin_unlock() removed, keeping only the two smp_mb()s:

  Observation mnt-slowpath-sum-no-outer-mb-mbonly Never 0 10
  Observation mnt-umount-busy-sum-no-outer-mb-mbonly Never 0 9

So the seqlock barriers and the mount_lock handoff play no part in the
result.

What remains is SB with smp_mb() on both sides (gets_w and seq), the same
as tools/memory-model/litmus-tests/SB+fencembonceonces.litmus.  Should the
tests be cut down to that, with a comment mapping the variables to
fs/namespace.c, or dropped in favour of citing the existing test?  As
posted, they look like they check the MNT_DOOMED/MNT_SYNC_UMOUNT handoff
under mount_lock.

  Andrea
