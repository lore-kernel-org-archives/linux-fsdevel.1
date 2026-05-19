Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A66C28000F
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 15:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779205333; cv=pass; b=CK9GVdwYuSjQKwcomQX4El02SYzmAW86oNhgdqVEWzjpzGIN2lJOIZy7BadLAeNMSyUOR2hgWY5BgdafxGtgR5VrQcHMbd5ksXxj4Nzjniha+EkvT0moVY2pZuPwui1BjqrrqY7VzEdkFLSwbOSDdqozDJYGwQJ4EuxKlcJDpOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779205333; c=relaxed/simple;
	bh=IGhdNMGmhqiwDqIsGMKMjYg4siHGnTWYXEgLbA3AK5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qvyWm9OGWy3GF1FqnkCZnjWsnBfYf+7Zw386bc8QoiR2ctl3A/ChzCaq2aT3CarEk3o85jZvhApUUCH6hH2C/JzEkO8DS1YUrcknxjhu7DuoAEnz+Ur3e1J5qYsSkr0mMqPEpmqrLrRl6ZufTAFtrwvMJhagnYKxbL7w6fmwmdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fzU10xQg; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fzU10xQg"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-512f750d4b2so46142981cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 08:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779205331; cv=none;
        d=google.com; s=arc-20240605;
        b=GsgQ3JmflZcWfBEqThov+GiDsBaiEiWyveLuw8nSPk1guTE2NnU8AEc0Gb8B70zIiH
         0IvwjreMQCEBuxFAMXT/MJfqH2jElSVP/vJdRv+HFGctBFBXGlJ1LKZB1neg6o0Gqd5h
         14B4Z7oi9fy5mQNWAqfjucs+CXMkSZy+PUxMauElMl3Ie61FxEj04mnrTDLVVhkCJfPV
         UAj09dSVX4lm022WgFOu718B2v6eneQqFkUBxrDe7hBAPkxCA4s94C6gAl6yrFh+VEUb
         gavp+Pt6AomPgCNKU4mc4veAFAx/74BzLJAMJgGCbo7nga0J4pGXWCyBZHm5gkznZRXm
         6Xcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0DthtS1U1pZ4Fbe0dWrF5fFOKxVek98WD7TwcKkU6hc=;
        fh=TDUyx5p39Cu7wVUMXNS779fJxPwCMb5ERbAAeK1rZCU=;
        b=J9I0HmsQnwJiKeu4aHe0Tee3a6BmfZEXWMk6LDr+yPIfwSCvlZpRSAk+7VZ7XEEX0x
         Vr82r6JLFRO4H8vmzKdwaZ/oH834iwFW8qogKnBZSbfy/YKLxOUz7S5Jec0IVsDNpmcn
         n+jlilNPncQtsSgmG2FXtcYMkd8nE6Pxelzrlg5teJYyMLseuLWIU0WOyC6IupHiEIav
         jqx/0DIAMpyNVhZKEzMshu2RVAZOaYwT0Jv51miUSJ54Sct4/ZZofthwTJMR+cUpVJWE
         ZEwwGQ/Zbj9mP3DYDi75YUx1gNUc3ZUV8pjUz6FUMEBTnmktJ/6DEQC2hVrAxjrnWFGT
         6eqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779205331; x=1779810131; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0DthtS1U1pZ4Fbe0dWrF5fFOKxVek98WD7TwcKkU6hc=;
        b=fzU10xQg5bzlmWQx8Q3C9G4eXRlo3UQV+1Aa+Y6CPaQr8YmNSYATd5UMS5EbnpC7mr
         aDHixamBc8Xs7lTZxUfdraBiNH6WdQ4PW0hKsoBJ1O28d/1BYbRPlgUZj+YgIUYlhYEl
         vPkNpvO0htxj0FeXSFDvMDYaecYTwaxXqzTpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779205331; x=1779810131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DthtS1U1pZ4Fbe0dWrF5fFOKxVek98WD7TwcKkU6hc=;
        b=peLhCOJ90ELEmI41HCMu8zM/A0FMBWeqnOknrsO36CHCJiYUoKkG5iPt+O7h06BaRZ
         ig9rzSlrBjmQur165StemD2Ydp6tkzlYCM5P0aZnu6nfwOKn4m6nPNhT+HJ6oKKi1Px8
         +1xesIVcMeNUdzwjKffzrwxIbA9lsnJK27oQHlfE+SIa+VZk6T1Yh2NBk9pB8MimkGdD
         M+txE8iXqXMjrqXz+4B+0t9h46uczOm0fnzTLeIoCzvi02w21TW3pn13EnlH4fok57M4
         NGSCC8o3u7aK0o9YBtg6WOkhmVncb0VOMg9G5sToGRnG0ig+ujdrI3GZhsP8ITu0pEqk
         sX5w==
X-Forwarded-Encrypted: i=1; AFNElJ8FJpVLAB3BJf2LUIV6/kviVA/bdF1XmIKWvF5SRYM2Yb6rba2QKy+aUjp1xgvMvdey0RAizGkmVo4gP9hu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1O/PjuP8j2VCyyYtJkX9DMYWuvafp/6hlAp7z2kalZVVAqZEm
	wyWNvmfhzQpEYw1b4492JHQQuEWcvAER77SHb3esYcFIVsj17eDY/Gavullc9Y6OL/g5GXy3ioz
	mG9BLo7QSvRgzO/Vrc1nwPVqpdRdKERSbwmW45y2TZQ==
X-Gm-Gg: Acq92OExvfsZL1kM+bc0TwLZxMQcwcN7jjTQaAlBpna3KfpWqGEwGXIKpeAn9WlkNR2
	0nb/NaBwnAGMG0AtRPFeVm7Ro3n8ZIdZWQw9fxgrr3JOrC5OFAL3s7mxn8srFFdiEZJ1zYHQEWE
	9s3AGrYB2WXxH70OJlOK8JeC7XYHEQS9IUAJ/zZw0wtbNDGcblQ/ifZlTff44SlPVnFGUuFn1Po
	XZSgeikZRRlUxO30uCnSDy3nNBRlK3c6zJhIGCX+gSMvrB6YxKIj9nFBbtzw32djMb7z2FU3pYd
	nh4/YagXD5GpzEOF+dbFQm6jdYnhLUozlQLvJRc=
X-Received: by 2002:a05:622a:2614:b0:50f:135d:9508 with SMTP id
 d75a77b69052e-5165a30cc40mr246584771cf.55.1779205331232; Tue, 19 May 2026
 08:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519004746.3203156-1-mochs@nvidia.com> <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
 <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com>
In-Reply-To: <F3BA075C-8E63-4077-B701-63269703155E@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 17:41:59 +0200
X-Gm-Features: AVHnY4KcsTJrIRXcU7-IPyEiVnSNZcnyE9sN6B_1CphQIDbfkZs7nyMEQjPcuJw
Message-ID: <CAJfpegsJ+ZQW_WteMypErq31hggYsMMkBOPd0o+vifhAS6dPvQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
To: Matt Ochs <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 17:34, Matt Ochs <mochs@nvidia.com> wrote:

> With out_pages but without the byte-size cap, fuse_simple_request()
> still returned -ENOMEM. Capping the request to 1048576 bytes / 16 pages
> made the same test pass.

Can you tell why is it failing now?

> I can rework the commit message to make that distinction clear.

Please remove the request size cap from this patch.   We need to
discuss fixing that properly: limiting by max_write, while might seem
to make the failure go away,  is conceptually wrong.

Thanks,
Miklos
