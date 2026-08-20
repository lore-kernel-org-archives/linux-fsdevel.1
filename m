Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929133E009C
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216873; cv=none; b=NnYGno3Q83kBE7AzDeI7OZdl3iXvr1mjIwgveX2JC6HIPS/4+5bopHRjEaXrD3psT4/UCEuSDXcIvr8tjlyQsvh3WtmGpeuFSHt6EowWGYlj/e5yHFI3YO7DcMnfrauU+HSMkJ43CKpDrJ1IQD/4QYQvAbsJefYGxKXT2878oQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216873; c=relaxed/simple;
	bh=X4bUaEQ1kMXJ2IGQ0N2R4Va26Sksm8adfTXPYgGoH/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a2LzPvGrshTaQ468eVZNE+5XmTSuSHnJrtrz7U0AKDILfv39pKxGjK+9WqO7AvoiInaPcpDuvCi/avKocnGMRsj8ALpopxOoQ+10kUWm5dYXaN7oQSD1+6lUBNDoVRTQY6/cBeoFQWZL7sEscwSVPRaTCLZhbJ2lEOY+QmaUc4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E6Vy21ky; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E6Vy21ky"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d58efc7356so21660685ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Aug 2026 02:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787216872; x=1787821672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wl5BSRIINtWqri27Xhx5y8Z3dhvGGW8LdsZ+EJy7sAQ=;
        b=E6Vy21kyFydlEnrqKAewM3+BWymASBj2Ribu71Y8qL4E/aR890ECe47s4qF+gdZaoM
         Z1TDY7St2NxeQ0vYQ+Z7zc6qrQQV7CPAw7+aaYKVWiABxIENJ/XpwrT1z+OEfOP6R49+
         v12PUYNgAdDpOrc2zLIVMSTom6Xrcre4Me53I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787216872; x=1787821672;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wl5BSRIINtWqri27Xhx5y8Z3dhvGGW8LdsZ+EJy7sAQ=;
        b=QZ2Al4LYH72oePpmpJ4o4/KWOSTkrUWUJr4oOU6zSJhwOgKzV3Cj9yxutpFEd92wAl
         gAdtHX4Sbrm2RVFCMi2gVVz7herK/KeWfTUmessJoh3dbS+pAaRMKVWSj7sOmXs8DZ0z
         hlPG7xnaKUyVIXCsyBV9NG2bRXQrZm+J/9jnL0ZiFWM0d3zw5FCtSdSRrlr6HZCLlSKB
         eWH6aVY1OmyrwVG6tUhxGiFga0OPqybZJjJQ5eNeYmHqIEEA8La5E89UKOXkhZnyhUPg
         CPHQmDtFcrBZB9TfP4WvXKDeAeXi+67uXix1OGb9onkWsf+uV28WWiZ4XdohRb6P9eog
         hb1A==
X-Forwarded-Encrypted: i=1; AHgh+RoCIBuM2Gawj1Zi6ZJ9jhkqSRcy+b0rbfburCQ/wWzb4Iz5/fIlixajoQAA2m0jZdXE/AU/LqQt6IRBQb+/@vger.kernel.org
X-Gm-Message-State: AFuF++kNJ5ZpujnOqBTowLbF1KT/7HURCTQtgkattoApYxLvlXy+HHRP
	oBuRWtxuNTP/gVLqdfipdBTYv3no6sU2//u+7dDbh3i85t15ifItQCzJ3lj/g9yZDfHYPmBRxVr
	BtuI=
X-Gm-Gg: AR+sD10ggQg6df8cXnNJis0/sV/9k8f0hUublWzsyo84D6klHdEXHMhgxqV21Px7GND
	fB6mYq8E9x1HQaSrA/L5BgrxF0HIkgEJzFyMU+xdj0uV0P0JJ65LRlShRsHcB+PHglPu2rPNLip
	VsqgJr3+pYrE4QPAF/5+S9RotJze6o9vmXAIMeSJRu6yHyNf760gFfnVbrbqEqQpYGO1+bi8R57
	+6qXj9mQgo0UVpqwr3YeLeTN4pezniOsb+nJsuZj9Rthqd+JXiwzjrNHozuqwWYWKmIAhJGW0Du
	I5nZFtNdyrvTnC/T1HHUz4Q/r5bRWEXHz8d5tS0/FOb3BEDcLOGf1RkX4RWz9MN+hZ4HC/05jrs
	xMzWLsMpcyNvPWJlvGo2J96FS5z4ySndJdi3ReN6cCKKFq/uT/asjp1pW+D7pYwj5yocUZjeQHO
	rHdxqARAFmbx7rT/sURVg83rGev+oGKF7vx2Gh+7XTKapTGAgehWt6O+UAx+2oymXyIchvVpOjv
	5o39CWg3Rwvy6nblRObbSnETgh/
X-Received: by 2002:a17:90b:2792:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-39581212156mr23367056a91.10.1787216871962;
        Thu, 20 Aug 2026 02:07:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:7beb:7701:c87e:f611])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb3069csm7198882a91.15.2026.08.20.02.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:07:22 -0700 (PDT)
Date: Thu, 20 Aug 2026 18:07:18 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, fuse-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
Message-ID: <aobDGgivy43cz7xQ@google.com>
References: <20260819023542.561653-1-senozhatsky@chromium.org>
 <CAJfpegu2wOG85R6KSvCwHOuxe2fWczA1KbrFcCZz=ofUch4K=w@mail.gmail.com>
 <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>

On (26/08/20 10:49), Peter Zijlstra wrote:
> Message-ID: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
> 
> On Wed, Aug 19, 2026 at 12:03:32PM +0200, Miklos Szeredi wrote:
> > Why is this unsafe exactly?  Does that unsafeness apply to
> > filesystems?  If so why do we allow freezing while blocked on
> > sb_start_write()?
> 
> Getting frozen with lock A held, while another task is blocked on A in
> an unfreezable state results in the system not being freezable.

Right, but then the system says "suspend failed" (tasks refuse to freeze
after 20sec) and just thaws everything back in?
