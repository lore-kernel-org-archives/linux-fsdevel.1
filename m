Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA64E3E0C58
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217878; cv=none; b=qCryXz94QFwbeTecFdGa928IBScQTZNhV1YwjAplIbOi+TVN2gAOUgQT4ZB0fSvShgDbgsVKfIk8VmZ3Vidd0sjDj1i6hSz1eoFEzP6BHTIKhWEIGsEwwL9qKpMT3rAuK4/fUxe04YM6gfYtDqJGO23u7xc2R1vVEXSXMYgDrr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217878; c=relaxed/simple;
	bh=klXFhfncEfqfgBAeaxYMbdKqMYba0lqahrn8tgVU45c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DN2NO73zmIV3TbcniFpZAcVkZD9N0AvnotbSLC3jjM/lieMFMmAW2KO8BSvFSwGg42QnZzXOaRej54qYfn1TKRv0L6iwAtFlWA3xQhFxwvNdus/llHhBl2XqL5OfgPjYZt5Em5BraUxeqCapa+Ha0PejXzsq1g4qPrisTV+QpJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=D3MBWFMc; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D3MBWFMc"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-382ef647e20so1975057a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 02:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787217875; x=1787822675; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JUgWPkpfVwetzI+lBlGmW+f/TRLvR7v5NBOCskWpSaI=;
        b=D3MBWFMcsxjSS8MdFcTK8Zs3l9i2M+N6VgJtCdC2RFzJYzhGfCVpOPjkrpBw/E/onc
         x3vCXyLR2RhNj4VaHoPCs1Ng91y4SWEMGHaXzLFG5R0mWaHqtTmPKfalHTdHpg9C5++5
         uXrUpEdUCyTf5ohD2V+PiU809J3/ZvROoO4qg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787217875; x=1787822675;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JUgWPkpfVwetzI+lBlGmW+f/TRLvR7v5NBOCskWpSaI=;
        b=sGe4hqXq5VjKJTxG4Mmbpl/efjauzF74X/or4FSzqmbMpC40nSZ5AKLHO1HO0a0NTt
         IRkn3iieQ3GXrxcnhTpVZYH+OWfgLs2BmYkmDvajt55Wr3SFoENFllknak132PIrq29c
         Yze2KTmPaMZMHwjLQ88OwnTpLIwhYVjmzHpwpjOCdlrH57ZdZQRojAfCmloeX+LSj3OD
         QRboCijbzI53BmpCjVI4jX7xQC2rW1jGTf+8eRJJQ4s8CCg1YthWCvfrVxHCUjQZqZjF
         xXwqfjrP39hV3ACCGq6kMD500H5qPl16kwZzoNQX6QiF1b5QX3nhrY02q209H3+7cKSA
         O27w==
X-Forwarded-Encrypted: i=1; AHgh+RqNm3cXMWrgBFrVyqW873OH7O3rPj4t5dKviVMmC110xyr7PY/ySEDQgqbapGSvEqtLXUdmI3R8KV1heDb0@vger.kernel.org
X-Gm-Message-State: AFuF++k9frvMHcehG1FsZi+YzpsvfTlp/rYJ/W+iPq8CL0KETzqR+P2a
	k50rClemUS2DH4b+PCFoz5vqhso9bwfzHKwsg39gIbce0tWVFS0/gO2WF09JQ3nC3A==
X-Gm-Gg: AR+sD12p9aNARXQ52rtTk1Hg4xcE/lt8veTxxWJG5X4tR8mpf1TCIYY569Bx3vaJOlK
	LaYGX9n9IjOkJKNfQc3Fw2HJ8mEYHx3Vjp5sy1mB0PIhBq+w083HBFy3NbpnQ28Jf0cpA61g/2C
	O/3/LfBrdwfILXMzS3EYrQ+6JTv2uKvUXRksM2qos0R1o2o4ILj9CqebOQ9pOWmP75KNfSB7XVq
	aJJrEReskwFa5EfQtUgs/GCJG+l0gcsgO/sQOcsnDKmc4O7sJW0zLrw6Jh+SOmzc3ptvzL3btCD
	5CJUbJU26CyXKlr8qCJx/pVKj1drCoxblXC3y5m2p1FB5i/rPZKZcmiUsOJtA9AQTObx4QwzeWF
	UA3+0LyPxaWW4hqbbgUzSt/WkgfanWxwQbrdSS/3stTL3Dsib37ptFcOxKskBXSt0pzk0HjOVmG
	+9gR4NkRj8nm59RjG4KByxfp9bhauD2UHxWbZnGt+UPSPGWkobVSMmuY+MRdd7yNt//dSMIp4gd
	KIU38cdiD5qqpLTFDK35+PfQ0yX
X-Received: by 2002:a17:90b:380e:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-39581212176mr20716008a91.9.1787217874644;
        Thu, 20 Aug 2026 02:24:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7beb:7701:c87e:f611])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395ada1deabsm610991a91.2.2026.08.20.02.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:24:33 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:24:29 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <aobGRjc7SE1rwIHu@google.com>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com>
 <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820091018.GA4120091@noisy.programming.kicks-ass.net>

On (26/08/20 11:10), Peter Zijlstra wrote:
> On Thu, Aug 20, 2026 at 06:07:18PM +0900, Sergey Senozhatsky wrote:
> > On (26/08/20 10:49), Peter Zijlstra wrote:
> > > Message-ID: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
> > > 
> > > On Wed, Aug 19, 2026 at 12:03:32PM +0200, Miklos Szeredi wrote:
> > > > Why is this unsafe exactly?  Does that unsafeness apply to
> > > > filesystems?  If so why do we allow freezing while blocked on
> > > > sb_start_write()?
> > > 
> > > Getting frozen with lock A held, while another task is blocked on A in
> > > an unfreezable state results in the system not being freezable.
> > 
> > Right, but then the system says "suspend failed" (tasks refuse to freeze
> > after 20sec) and just thaws everything back in?
> 
> People don't like suspend failing. People like to close their lid, throw
> laptop in bag, and expect laptop to not cook itself to death.

Sure, that's exactly the problem I'm looking at.  Throwing TASK_FREEZABLE
addresses some of the cases.  Failing laptop suspend because of uncontended
VFS lock is not an uncommon scenario for us.  Ideally, however, we need
some sort of server/client aware suspend, maybe moving clients to cgroup C
and server to cgroup S, and freezing those in strict order.  Or teaching PM
that some tasks cannot be frozen in random order during suspend (e.g. a
special flag PM_FREEZE_ME_LAST).

fuse is not the only subsystem that doesn't fit current random order suspend.
Another troublemaker for us is notify, which basically has the same server/client
architecture (where both sides are user-space processes).
