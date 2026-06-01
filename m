Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D6368277
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780356990; cv=none; b=jDTLJ2gpn4vAcTuzSUXXpRSlCTVentGXjaM8IcI3sfOP1L5TzJg93tATX2EYkZab6cN4Nl3PLBEHgwKLGkGscqPf/Dj36oV1qIsyHiHlpOD5DRKXrjFVKM6JwQAU+0wpIB/fS+UAeIwLT+l+6dLRKRwpYhQvXFXj9ibyYO/CD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780356990; c=relaxed/simple;
	bh=ubxfeLPdcu1tVOhHcYgp2xMfaoJ97BNsAlzIcGHV6/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNK3ptUEVzZv8jh3zJBKZ3ZU6qmWwwChmMQ4H13MLJfHdWdXWN9eJyLwLiu0fR50pUfw3hCn+tdmnCppaB24TS+WNtinUuGwar++6sVknjXwoUXZlNaRqOfnaMc6ON5fO1Zjz2sSKONrQk4Had1SQLEvcnlB+YBQdLt0iuJizxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddwHSC9V; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddwHSC9V"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5176465a4a4so6872331cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780356989; x=1780961789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Auwu0u4sLco5ByZK6OrYXLLV/GCMBjlydMcsMEYP59Q=;
        b=ddwHSC9V9/TqoKM1sk0TKX+APtKM3XPoAaVruNWBXQXs5Ps+BhIKIFnJvBKhgqw81V
         6OnNpKSjlKWIAppTM9ST1L9H0hBaGBcxkM6BXePPCitpsQRzm6ewwDtmUqw96wiLFD/0
         sp1gDOMM64HA/yLiPth/HZiJEaparID8bEOwTFM5IuKAP48J4+Voh7O9IWEai+EIepfq
         pKcPaAhJUa5NaPAN6/ZcfJB4ajKEJV1FZ6ReZmaZYESI6Yi+3sX1uWQXE9lri/Tc8h55
         NR5LwTHlptvOwspP6PIw5CrtkUmLqBT7pvMVHSMwpQkNIKIDm4QsI+42iUSiIoBLd74F
         7N8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780356989; x=1780961789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Auwu0u4sLco5ByZK6OrYXLLV/GCMBjlydMcsMEYP59Q=;
        b=SjjiZbgdQzIOhmWt1gnrFeSbTBEW13hlZeiqdk1vbxeAtyQKPLjYOad1leB5FE1m7Q
         b99K8ldQoQMuXdCvBc2WJ7Py2lWcPakTtji2zeMTl2mZ+0GbRxBAqWmamOUhX6yGEdNY
         OW8UOHfSSZoKlLwYHwfej0DxhM+OBtBxzgdC/d3/BdopvpsXkfd+o7QWNlhDxmNdzssN
         w8m4y5kSwHRtxEWvr1sCG87XuIXTdAB5Xe4ZonCw70BUP2h/B7G6h+xw1M4sRIYhDlmJ
         Jpju0kJzrQ8iJdBEaYgZVkXVNjyrRSWyzoktzJUG9oOQpkZtO+iN/JtDsEwztj4ntHZE
         c3MA==
X-Forwarded-Encrypted: i=1; AFNElJ9XcsHUckpQhGVJBq/y0n9uMLatEK3do5VbkL6nPwIB6LyaT5Ji2fsXgepguVpX9J4SwAp7msm5TAF6PqfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYVrOTyuaE17uO1bAAUhYhFpXZ3BgNLt75uMtTQXWY6MY5u3O
	KfUeZ/iqpNf5JZ2aFioyiuNSzEIg/wu6rM9Wtrvq3hTb2SIlPQfYtJPc
X-Gm-Gg: Acq92OGxtOd2ky/Lm2rw0Z/8z4q7BWwQQHW4PdFcOrhENiu5/u8wq3Udc8qwVglf6l+
	OR0ei6wSQyenlWzVRseBOi++1tohMbiE5qtDMjQ9xuCDx+9EfDHlgKfeDf5GJqHjKVM3aJyHO14
	zi2CtASyLNkl64IrvUoeQsNyKB1muaLj41peHnuGQJCjFu+c76Nj5OecP307tlr37DDjIjfKmKe
	t9T9yAUCtlBDcLQQ1+bEEPUO8YbDFEy8KRAkhsjFJd/N+p2b30fKPGPBzIdMX5GSFVz7fY/BrWk
	Iu17f+FBwCJnW0ukqoUVMIpcEA5ObbYTOhdE6bqzlVLKlIgsizHlDXMf677+MBs4z6rreHtQl/6
	pUrwH9V74D2XCz5qgEOSCK/ffD/g8RtDA9z99XGSF+Df/hd7H/EnKVB9y0L6jf7CBc6+XgyD34Y
	BAZpUW3OmNcH5Jhdv+P7tuE6yWj7OaAOl+9FsK4b4lko3Q+1zuNPWggUmehKWnuYieYr4mZAIVZ
	PUaROidBNtGw7V7DyD8K7O7YKde8VpsB6I8ruHe6A==
X-Received: by 2002:a05:622a:299b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51758f642edmr75885911cf.32.1780356988761;
        Mon, 01 Jun 2026 16:36:28 -0700 (PDT)
Received: from fedora ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042bb5sm105823496d6.8.2026.06.01.16.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 16:36:27 -0700 (PDT)
Date: Mon, 1 Jun 2026 18:36:19 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Qu Wenruo <wqu@suse.com>, Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
	linux-block <linux-block@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3] loop: Fix NULL pointer dereference in lo_rw_aio()
Message-ID: <ah4Xc7OmGle_C5M3@fedora>
References: <ah4EY2nhPxEETufZ@fedora>
 <20260601231731.1403-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601231731.1403-1-hdanton@sina.com>

On Tue, Jun 02, 2026 at 07:17:30AM +0800, Hillf Danton wrote:
> On Mon, 1 Jun 2026 17:14:59 -0500 Ming Lei wrote:
> > On Tue, Jun 02, 2026 at 05:51:26AM +0800, Hillf Danton wrote:
> > > On OnMon, 1 Jun 2026 10:29:25 -0500 Ming Lei wrote:
> > > > syzbot log shows the null-ptr-deref  is on WRITE, instead of DISCARD.
> > > >
> > > > https://syzkaller.appspot.com/bug?extid=cd8a9a308e879a4e2c28
> > > >
> > > > Adding WARN_ON(!lo->lo_backing_file) in loop_queue_rq() might capture
> > > > this bio submission context if this req isn't issued via wq.
> > > >
> > > I suspect this makes $.02 sense given the check of Lo_bound upon queuing rq.
> > 
> > Can't lo->lo_state be updated after the check? It is totally lockless...
> >
> Sounds good hm... do you mean it is UNWISE to not flush the loop workqueue
> when closing disk?

Quite the opposite, it is wise to not flush wq in __loop_clr_fd(), please
see my previous comment.


Thanks,
Ming
