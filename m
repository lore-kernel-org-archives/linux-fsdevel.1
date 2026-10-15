Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA5A261B9E
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 05:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792043178; cv=pass; b=LgHWL/pLClZbFzJWTtEjhUNSCNKjZjhhaKFnl0++riWJ3GSGOaKmeN6d7G612TP/t2nQNaUJBY1RGqEo3xRBtJm3bX+UrPAg2rwDZPrgbpVTzibUFv6jtMyDh+FHVSAuvGCIqqmgmzBNhlJBkwBsHE07LzETe373My9w/+lAEE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792043178; c=relaxed/simple;
	bh=qezJc4NEIZrhsd5+TuSsc3OnyYFh7Gr+9COlR9C28hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QHT5Z/44YccDGz3loheQINhocppt3LbCQTOcAEur+VTmwbVXHBwDLuoflDrxYGkF/4dm3xnff3Vry/4DaEFYjYDQLc7Pm2E7R06I6/89Ev/BiVMDqImb/cLfUpqLtu5A6Bb6okWTg89+7c+TwJv4p8W//RwvvmZb1JmqjaYzba8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqRhXJAz; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqRhXJAz"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35ca5244753so306461eec.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 22:46:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792043176; cv=none;
        d=google.com; s=arc-20260327;
        b=fA19qdl5JdcL04L12YWyoZvGAvzXV0LwHQ8/bwyzMV6yfCAjBXHb8eyg2NGKdAf4kG
         oTd/LRsjixQy2PhaCc4jSSOXzqGv3v6lfMmQDypb9uwSucB0umij11ZxbtEiO+5OJSj0
         awhT5p9Nt9T55l/TDCLQbPElSgsaDwPD2Og4d6uezx8bE+b5lKE2rL38oV4ATSMh3VVk
         LIQ/8GRxP1bhNgDQcZsMvsPb1W2+rQd6Hiq50x9rBSlSNl20TSSmFtZBBeYR6dI88Vf/
         FGXig4zefjjaPgAGOVHlMWbY1zJV60cPXTrLWtYzC6TZouV+1LtbGtejD+PcPwFTIxGp
         MaCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HeI0uiM52DuAwWHa/ijjOCM64Bu6o2GU+woYi97808c=;
        fh=IeS1n7NKGSxEY2Adyq1DdNXRfLaFLeUY2bNpFamzcQE=;
        b=fPkIY+cIWDljKet6Mrn1oPqqncoaAgbWN1I6tK4Hn4yIJ9D2NWwV2Pa+cwvuzBfWBl
         OsGRHqwL2yHi04TzrGlsvjYpW+0DZQ0Cuy99OHZd8jkvh0cpuTsrvl8GdqWUu5K1WZxf
         PqoUUoBGotnrvccCpdvNhm4vMDjNOaobIvLHXN9+E/bpVfjcC27rMaZor/j3UXEHVPv2
         5nvFzTD/6RdKu/SmejgQsuwjFb8ynm9TuxTJNe4lUFkz7uyxCuUufxFdIrg8005oBDU4
         nLFo2SqpMjz185hGLEL6SfhbByg/R2IApPb0LUBec8zKgDy5P+q71WITiJBHCbacI3LX
         wjBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792043176; x=1792647976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HeI0uiM52DuAwWHa/ijjOCM64Bu6o2GU+woYi97808c=;
        b=bqRhXJAza1Yrp2/eRNvbssEp5MR0j3Z/JI6FUrVfNY9dB94rODj2a6opuA8FeB1lnP
         nWsNTv0PFeu1CizxuP073ENOufz4/5n6swZ7YKDdtXRLjJUM1cUUaqmSloNMv231Ghia
         GNAYBURTZmV6CgAnEy8jyHM5PFLdB69dwRgunXDAdb1QlRbMmtemCVXyd77WY+j2SnLA
         LZhEFVSC5BC+RMjchcp4rBJXfw0NoxEbyxn9WVk0QuBV5K7BrcRTljhRao4KosOAgdFZ
         Qe2BGExLNhFW886eY327ysw+o6yt2ZiqqM6EUAANOMIMN1qWGPGryd0JtzFXw1gj9q2b
         PJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792043176; x=1792647976;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HeI0uiM52DuAwWHa/ijjOCM64Bu6o2GU+woYi97808c=;
        b=aUN6Rjm7NNW5fv8F8tLxa5zutRt8+nfxLl9mI3aEij+L4ZmrxZOMC6zxIzAoypc+t8
         +YXDVPRkhp7tSv+376LeDHVRal9kRm5EeUyMs/6aHdo8V34QVi3VVG9urNhq+RVxvsX7
         1uRymtZNjKp7efWRjY96BoaJIE8rp8M9Rldnn1EaXASbNkASpgdk3w/H8JrTwm8H+iC5
         FXxM0gSHT28DNWqnsX6ixKcJugnjWcG4KhBLcunjaT+D4SJ3PPQSKP7uirApGaaLQwAP
         ExSno1B1CYpXngL2k++eyVHuE0quJ/YhtYFVh1k1wzc+Q1H4+jRndclGjILBi3W7eSIa
         EWqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgGFgB/FkGeWLpuM5E0+pZfrkd3U4EXbLyaW4TSi6XohvK+KWVhgg7PZz99DOM7nx6fP96ieoxe+1+Strl@vger.kernel.org
X-Gm-Message-State: AFq9FYJcJ+giV5KLUfWl0voAO9V3tmae2BaeF/KsDlFnYkj95JTRVkVC
	eb65bq3i/y2thNACsvqLwOKAYEFUYgoziHWkeeUVlbpvO+rNociY9lyCVGgwskr8xg/E0Zoyo2/
	6GOWmFeofy8ZPJfAftRG2iP6pmpaFUZ0=
X-Gm-Gg: AYBFou2WKLt0a0Vbv/OAyWdXTt7yNosfz+2l0CRjxRNt0KUyCyQbG/s+bSylLFIyhi1
	tdf5Jj/LTqczRUjcJXzTl1PPKS6F2pVZMlomkIbtTBfP9EcoYE+1qDZoRscEuBe9dTyslNFoMre
	1S1dptsaBn6uz1/B8IQc44kyCuMGGSGDsJ5RmW/HCXmwEj4cQsdoSLikJ1PrXSQCXMFXkjaGtjw
	XZNyB+1BmefKeN2QWQC9YmHu/33WfhW8K4pfNhbfiSpSWMPqE3OD3ThVwpxRqdPwHk7/stI9Z94
	P5kLwc+X0kRCeKxpaShKdu7tw+JP13nph0Gs2qfkVZNaOkjSCM7O8uMIeIcEIN7jGOqsUCJnPBT
	lfNci8Vt5XbjiFpuj3/hFWs+XeCYgGhLZszAhs/ulxUDUYshvLgcfTRvigBsA+lIMF5fxvK0kXL
	mPGr7E6q0g+l5CoyRWNY66QlBP8L/q7y6MAUhg24XIMHTMUePc6Ug=
X-Received: by 2002:a05:7300:da12:b0:35d:4c5b:766c with SMTP id
 5a478bee46e88-35d4c5b7a5cmr10711045eec.2.1792043176087; Wed, 14 Oct 2026
 22:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014225811.i.852-kees@kernel.org> <20261014225818.3457479-2-kees@kernel.org>
 <2026101517-profane-opponent-4523@gregkh>
In-Reply-To: <2026101517-profane-opponent-4523@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 15 Oct 2026 07:46:02 +0200
X-Gm-Features: AclHuK9JUbZ8Kk1BEvh1a9rSCsQ_67UzDaXAR0CwzEKJckJP8Us1pVzDHAMPGB4
Message-ID: <CANiq72m_iyquf4Lc8AWvbsBp++ASz4+C_MQ5iYQW-fHd_MNDxA@mail.gmail.com>
Subject: Re: [PATCH 2/2] seq_file: Require explicit initialization of struct seq_operations
To: Greg KH <greg@kroah.com>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, linux-fsdevel@vger.kernel.org, 
	llvm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:21=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> Anyway, I don't know.  I like this feature, and maybe it's going to be
> used so infrequently it's not a big deal, but feels clunky.

Perhaps we could call it something shorter, like `__explicit_init` or
similar -- I don't see that substring (even without the double
underscores) used anywhere.

Cheers,
Miguel
