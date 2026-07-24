Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BCE43D516
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 21:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927444; cv=none; b=pBMM3sfYLwnLWBeNYpc8zZOU5TCVwvTdVwedhD+oWGWJcOyUzkxhj/SEA0uzwkQGmOB5HzN4SRb8JLOnJPhSb4E7A2wY1MUhluOEk26bRR76euwqoQhMtlEKvYrdzE1Wi/7gCUuePTOoBIFhWecXdwdMV9BVmd5SNhP03JZg9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927444; c=relaxed/simple;
	bh=80pVOvLhx+Wdn2FQlmGhXjRbHTitdSLioqC2O3ubCNg=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=Whm7loV9gbx5rfty2o9xI8e/X2i3V4483V+t0L1Ilevb3TCpKTZkGWLVxmuIJbP9wl3SHVD0j+ZvyHXraWdi3GJ2pNcvGLrt1XbzPNdtFlBj5J42SDtjImqFQ6Co4e6QBDrXYuhxVwWdChTCgpYTtXeHlgxKBClPbw2Yuh8h9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GsgTI+hk; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GsgTI+hk"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5c92c389so69965385a.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784927440; x=1785532240; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uhsc75Oo6AuEhvOwEPNfuq0mbfOFTRMSybKBRxOVKlw=;
        b=GsgTI+hkHZ8VmqwdycBolYwd8MAMkyuNZF/A+K2t7KBqJqUidBRThjwV7HnfkkibJ3
         msHHPvb0nmhZdhv/aRTscPRcdzMN8oeCnxagwJaEcH92q6e7hoIvhwME25JXHWLZ5TCl
         jR28bKTd8Lf/tx2+68pdLvrj0wGa+iTL8/J0QGnp9o4gjP/Xld9auKLLAYliAk0cC290
         omly/ZMeIfggI/rX5DEGpNlWP0tZKJlOasvDJ1wVXio26fN/InyVJFwuelEqfyjxADTd
         lgdMOZWf7y1au3iqjPRQ7j3HgDZHROLtt5/PTfiP7lUKO6XxryOim3mOZ+dli0rgwYSx
         1K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927440; x=1785532240;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uhsc75Oo6AuEhvOwEPNfuq0mbfOFTRMSybKBRxOVKlw=;
        b=Sd1TlB+PiuMNi/5J7Q1J1hpfZF9uecl6iOXO+cCLho6QvyXpboRQbPh7N+vCTnjOn3
         iR9JRf3iRDUr64K7OjmqsMtNa3C+WhldUMZuVooSpXFwckImnQQTc7itsek+PKkpn7e4
         YGNuiLL6yXhg1HxpNLPgYlBL1PBfMjxeM9ErUiV4wXF0XWEnAsVOt7Hys3lBzVKeU2W0
         BsLsi8hGw+y5IGiyu6Trqn4CImB8/oqknAcNmBlIIfIWuzKd6bkH6F2gO1+r0RepFKtR
         7KOlJOxCbWrjmpfBThPTRMqADLn3g0qAnEicZ3p2sEu+5k5nzs2Ba2cf9FkYX37GgsiO
         Fb4w==
X-Forwarded-Encrypted: i=1; AHgh+Rq2jdfvK1ulwzVyfkzkw1KHaw2FZ+6DbwOGbg5KyfLy995LeuZ2k1R8cTa01ASIYeCQgNBOE4JAPCB+28Zn@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbg3XD7rzoZsiuM27oDF5+/XVfOq4S6N0754nqtLcKAovwOxAU
	4V18+KDe+OFpP6BMNrvxMwV8mYloDPHWM3fzvwntDztxd3Dm3XR1iNY137pXaZDW07N1P5OhuNg
	OwhLyPA==
X-Gm-Gg: AR+sD11PG9AaOU9QX/6B8U+5RdaX6bqOCcHFu/nztvaCnqiFjyFs3+kTi8GzceX+IWs
	W8V6z4Tn9qnFYw4qzzaq94l551StqaCd1uN6aCzDgXF/K3HQnnmsYyWYTps8pG6Eig+JHyMvZC9
	b/iBm9Xqo093DNELjYBbiDhh45mP9yvRQrMtT1+WNryGmyscN7oEZPaceqXHBzx04JV8rYU9SMy
	hLeK8ubEdQviTD07vJr6+u33ykdwT7P2g3qIOxaQiAxps4/4sEWneqDFofywgXVDlGv+TQn2bec
	PgvVKoi35rE0YdFGiskQ10I9f52csR5hfVrCEZrkhKlOV/kB2r05usevpGe63/8aCSDjY+SC+h5
	o7SkPcDtoJ474Oxj55WYVUI0agHmeo+qDEOjPn9xz3oOVDMz31sDPJyEImC6OOpUQ1B/QRcQK/0
	R27VeXKD9XSCnJdLBQ0jPS54pynp9u9R3/kOUXq8oCtQ5hv2U=
X-Received: by 2002:a05:620a:2915:b0:92e:7ba3:740d with SMTP id af79cd13be357-93103a568cfmr1043858085a.68.1784927439959;
        Fri, 24 Jul 2026 14:10:39 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-932de676a41sm5540085a.46.2026.07.24.14.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:10:39 -0700 (PDT)
Date: Fri, 24 Jul 2026 17:10:38 -0400
Message-ID: <0ea73a164fb2397e58ae28a2fa35266d@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260724_1628/pstg-lib:20260724_1535/pstg-pwork:20260724_1628
From: Paul Moore <paul@paul-moore.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, linux-fsdevel@vger.kernel.org, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH 3/3] fs/namei.c: update kerneldoc of atomic_open()
References: <20260710164233.827744-4-jkoolstra@xs4all.nl>
In-Reply-To: <20260710164233.827744-4-jkoolstra@xs4all.nl>

On Jul 10, 2026 Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> 
> The comments above atomic_open() contain several errors:
> 
>   - atomic_open() does not return 0 if successful
>   - @path is not updated
> 
> Fix those and be more explicit about when FMODE_OPENED and FMODE_CREATED
> are set. Change to a full kerneldoc.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com
