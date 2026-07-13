Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B7538AC92
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 22:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783981677; cv=pass; b=QNbbnAHbMoBC07zOmOaVxqiA0Wy1h3466+rB26J7TOJNWX4fZMJ1t4WCglXf98uMZIbnlbM8CN1cXY4E4yidyaEzy1menWxr5IxNXBA5EiPgW/CC8VQpt1UnDReP86MzRlk9D6wxP/lyPPHo/FYFiMN7ja6T33BmJ1YniWzgTlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783981677; c=relaxed/simple;
	bh=fbjane7tfgJKd+yHPImlcewhWxOYomgF7EIsJ/qW25k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sUqre+w1OWwAebjj/8q/8YSKekSFCN9vtUAuOJlqUsbQthfDYNdwsEK9d/qpWDq3U6joquG/m04zbg7giF+2vznGOO/C0gYYpDHn8NaFBXkvmt6LBCaVU3LUNjyVS3nW0jWIRCJjHGpYJQSm/7OHpYxTZroOHCkF7lzfP7IylK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+G678hL; arc=pass smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+G678hL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso308036a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 15:27:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783981676; cv=none;
        d=google.com; s=arc-20260327;
        b=eohiIIWSYTSSEIN5RRBoOEPBSokmWVorYFdWiPCAMacaxvtyFm/JV2ht/j6675tfjK
         ZaKEluXozMY0GbuZ4bLKVzPILElgtaA04ONPv3hqO4BoWJY6M0B+WISrAG6/f9mLiXbo
         /5t6k6qMJ2At3n553QTdgjjQlaxmrmjQF5JT1dZdRVpgrjlZS8Ob1J0WuuEz2j/v2kLP
         1ejGz3fzN1IkMdjYUJ/w4mpmeY95LNOvHy4lefvim/AH7ugjz7zGqNvep83BW0/xM3sl
         lVIDUjm7/bYCMPvEREt1G1Vo8CgI5vk4eR3LJB1j4kOa3O7+oSBKBHBoyizmx+Ue2gGk
         DQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=YOd9mExyjtslY9x3KYTXq5oCKN8VGg/406f26GPZg2w=;
        fh=1DY3kfsdojrCOYTztFkzZHhBZIXpp+FTmSH9nacJXaA=;
        b=bYn4UjpzOf2crAbMDPFui6BOT21KeJ8xejdEQJBTNZjGWPwTeXTZWI64vd87+iG/wy
         S0AhP6uR+zSN2sfKX8KHhvx3Us238IBHC2f55UFOdpyN/sEuYxnu3K4/3XDreXEJXCKy
         U304hqxrnmMkBgF23P7tadVJ7mNqOsKh6Wbbl/2iZltz1RTpvXO+Hjqqx5m0dyp/EeWZ
         QZBOmLed/pkk4QzUeNkZY8irbAJaSo2djwVcORKs7IooD9ekKvZeRoG9nr2fsq/IWRiR
         hyuVLAKUeB/YjdKewAdNlgZWq5m294092Wzyn8khBx/OgnJOFly4lAsTov1qGi4nOx8+
         WteA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783981676; x=1784586476; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOd9mExyjtslY9x3KYTXq5oCKN8VGg/406f26GPZg2w=;
        b=q+G678hL15ZjVXp9f6HBc/pHNH/IJOaFEfaBdauvl1HVJTezUCEtOfX+cVeEEE6don
         qbl0OYt26VQclHrRzR1gzFskvR5o9aRghK09Yr/FYEhMItvHir4scL6+MuywomN+uZd4
         4gx4a4sIjc0Bh/vMbhyAe+MNrDlR4Px+IBgEfkVDUJa3F8mQNcA3WA3uy82shu1HM+Wy
         HnRySY4xhJSawlHKKAoEa6aGwiSoV+TYTIkPb7Is57R74q3bLzr7NWa1dBAv3TnERUQu
         rU5mGmWaZlpJMLa0Ttr8+Q3qL/t8YpyCTc4cytFGjKtpMbKTjhZc/4XmCR1GiJthlJsp
         34fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783981676; x=1784586476;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YOd9mExyjtslY9x3KYTXq5oCKN8VGg/406f26GPZg2w=;
        b=cHQgzFOFIpefPJiajz1eKAcsQF1ZPzq3F1n+V928hqn4mzRhO5WR9uRFW6PtyQbXyT
         5Yvqoff5VW+ED+pg/Wy0O/isg+6+RO9vDIlNqlUHBmePaUEf3C9sdudpK85zNTv7E19f
         GZfj1NWp+gIIPHrM1ZtqwgqvCiW61iADNNm7UNZrbUy4GFPhjQv7awyoJdKPIuUPN6bp
         bvmFjJ+aQjk/9W+JQpHmkj7NpU8+zzmZfqLLySQJGVipOI1i3MWh5L1jLTtMwssPJ5qh
         NyZZBRFTsp+3U3i6PVujGAblr/81hjGRAD++mBbDLntj3DlwFbJEA/O5R2QRQFni3S/R
         O0nw==
X-Forwarded-Encrypted: i=1; AHgh+RoRIx0/OBZJ+hOCBS9sCaskxdt1EBvvdUQwQM6PlDI8lWFjl3hCl3jEd1ngdslKjiTfRzf2IcpRWoF4ADxZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzzviWyHfME8SB4WrPxGD+DLJV8ubDmyk1VlvDtxlYZ1q/xW5/A
	vk5lozFAWBXDVwnYdHlV5XU2T6KIAagnzIfGaAmanQbR4CkEQAHzdiE2LYCiDtLsksnsU9Fkv1t
	YNv/ZEEyrm6b8Pb4F2CvU1/QSFOhpWG8dHO4Fm0hu
X-Gm-Gg: AfdE7ckVC8SEEVhBW11mQpi32Kd9WEMVM++cOe692lWTEAck1JZonivfBp/6YjmhEq2
	5/IgA/NrkCKVBT+tNkd3Jzmt1RURLKT9c9PKecdTvVj/WT2ck5UnelFLyNM9n8PR0Urs1GMqv9L
	/g5WYsVWVbHtraRz+DPsWO3mEZwTpeEmmn/NWvyu0D7Mxq7nkecUAIUnjMsuGu6ii+9JXyfjs1z
	2e1jNjCraOT7ARlHeRbhHr++nG+x8xRTjfrzlYgG9SnFKe9TVwvTkXJP8/PqeZn499zQCUvEPx4
	ys/T5Yjy/8UsaBZK+74=
X-Received: by 2002:a05:6a20:734a:b0:3bf:b9de:8570 with SMTP id
 adf61e73a8af0-3c110160a19mr10849033637.19.1783981675450; Mon, 13 Jul 2026
 15:27:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260712165610.366474-1-timday@thelustrecollective.com>
 <20260712165610.366474-2-timday@thelustrecollective.com> <alT2yHlfzhTZ9n4T@mit.edu>
 <20260713164417.350710-1-timday@thelustrecollective.com>
In-Reply-To: <20260713164417.350710-1-timday@thelustrecollective.com>
From: Marco Elver <elver@google.com>
Date: Tue, 14 Jul 2026 00:27:18 +0200
X-Gm-Features: AVVi8CelYR5CFRDO3rcKViR68rwlP0BhhN5oDZiKHJ8mDbFXztNS8i5n-0eRql0
Message-ID: <CANpmjNMfQT6Z9ke4x49sp6z8+pt_5ZLUoSh0da-99bwos5-8Lw@mail.gmail.com>
Subject: Re: [PATCH v1 1/9] ext2: fix ext2_xattr_delete_inode() context
 analysis warning
To: Timothy Day <timday@thelustrecollective.com>
Cc: Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org, Jan Kara <jack@suse.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jul 2026 at 18:44, Timothy Day
<timday@thelustrecollective.com> wrote:
>
> On Mon, 13 Jul 2026 10:32:56 -0400, Theodore Tso wrote:
> > On Sun, Jul 12, 2026 at 12:56:02PM -0500, Timothy Day wrote:
> > > Clang reports the following warning when context analysis is enabled:
> > >
> > > fs/ext2/xattr.c:829:6: error: rw_semaphore 'EXT2_I().xattr_sem' is not \
> > >   held on every path through here [-Werror,-Wthread-safety-analysis]
> > >   829 |         if (WARN_ON_ONCE(!down_write_trylock(&EXT2_I(inode)->xattr_sem)))
> > >       |             ^
> > >
> > > When WARN_ON_ONCE() wraps down_write_trylock(), it adds an unlikely()
> > > annotation which hides the conditional acquire annotation from Clang's
> > > context analysis. This triggers a false positive. Pull the trylock out
> > > of the macro to silence this warning.
> >
> > Does this mean that using Clang's context analysis means that we can't
> > use unlikely()?  That seems.... unfortunate.  Is there any other way
> > we can fix the false positive?
>
> We can't wrap a function that acquires a context inside unlikely(). We
> can use unlikely everywhere else. AFAICS, I think the trylock functions
> are only problem right now. Grepping for ".*WARN.*trylock.*" and
> ".*unlikely.*trylock.*" shows a few other examples of code like this.
> Not a huge amount, but not zero. I looked at a few other
> series [1][2][3][4], but I haven't seen anyone do a similar conversion.
>
> [1] (block) https://lore.kernel.org/all/91cb8c790fc8b26b8aa742569fbf8c2c1d099dac.1780682325.git.bvanassche@acm.org/
> [2] (drdb) https://lore.kernel.org/all/77d0fd75811d7f604fa80b5c93172b5653b52880.1781042470.git.bvanassche@acm.org/
> [3] (raid) https://lore.kernel.org/all/20260708090614.1431014-2-hch@lst.de/
> [4] (nvme) https://lore.kernel.org/all/20260713115444.465704-19-nilay@linux.ibm.com/
>
> > Even disabling unlikely() if and only
> > if Clang context analysis is enabled might be a better choice, since
> > we don't necessarily need to build with context analysis enabled when
> > building a production kernel.
>
> I don't think we'd want to disable unlikely() globally when context
> analysis is enabled. Only for cases where it'd conflict with the
> context analysis annotation. Long term, I think we'd want context
> analysis enabled by default for Clang builds.
>
> I think we have a couple options:
>
> a) Current fix - it's okay, but a bit ugly
> b) Teach LLVM/Clang to handle this better - no idea how practical this is

I'm not quite sure what's going on here yet, but
__builtin_expect-wrapped trylock function calls are supported by
Context Analysis (Clang's Thread Safety Analysis). Some of the
additional layers that WARN_ON_ONCE adds is likely throwing it off.
I'll take a look, but might be a week or so. We are already bumping
min Clang version for Context Analysis to Clang 23, so I'm hoping this
can be fixed in Clang 23 (which is not yet released).
