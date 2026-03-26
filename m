Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE5378D71
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 20:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555925; cv=pass; b=IC+4wf2UDIAH0G83dvt8blsw4x9eUZcLy/YWO9AahsEHfJKhUIOTFJAwEjqs8R3pFg8xAxvePCq8LdyNoscIuZrhSmZKO2eZo6tkpcUI6D0HnxZ9la77DhC620fxoB2+4cazBVqK1lNJXEnV7DMMxwXXtLpJaFCXAkVMTvOkuQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555925; c=relaxed/simple;
	bh=aQ6Aq/POQfqqEmXu9zuXl6Xin5wscy4aVe2hMd0YT8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D0NJidZCNwihctJahuWqjO23G580bNPwKU9rXSs/Rmk+3sXtmp5aVF+ZWtOtV9ySMJEJSRaDja4AS3I/yuGNtx1gmgfxxazBhbmUpNpkKwVtIEPapNnHQU/IYkz7RrMG6uRBYSVwHMINqCORevmvVqSA4KLUMqwsjLCQS5UznJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOpa/SrV; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOpa/SrV"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b4f48c47cso1034313f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 13:12:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774555922; cv=none;
        d=google.com; s=arc-20240605;
        b=kp4OFaMXwA+pAszBzC1xkWlky4JlRVnFjogpZROd00Q6jyOAAoFc7Rau60SE/0Rvu1
         uMwRT9rhqYIMTWh30gesD8onrx0Rvy4r1NdP43Q/qOJRHzG2x3JuVl+h7NZhUWcITAyq
         YnHR9aH4XfHF37P5G4M/WPKf27yGqSMZJm1u8skzeM3RcxJ1Dc6wXaoMvd7YxqHokE3K
         QNRMoALof3AyqF+AAJhh1yLaAlF0dlk7bzRqzAReTxacJAxrPT55do7B2JfLpZFfvTFb
         Bl9CJkkiFbAiseuic91d+tRP0O8nGPeQjafXIBh4N2QmQdK8JOefDQWyPLZgsNiGzhf8
         NszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aQ6Aq/POQfqqEmXu9zuXl6Xin5wscy4aVe2hMd0YT8I=;
        fh=eYN11BsovOQUL8wFVHL4vOfmf55aYiFKwH590I/vRl0=;
        b=lFTHR3z/qkrxY+C4laCOE6WAWnXqPOVs79sj2Hd0di0lBcWHeH54sIrTQSUAM4gl8X
         2Us9RdEj1lbxk/vr3uXo4gYI0/y0wC/mklAyGtZAtRE+eLiE9+t32aruYRZ9+5e2W/+u
         AmfqjE60KzaBJlyhuwL+kloJ2sMPUewUResLL+49P+9UvMwtNJoVk4FSe/mgW8qJZsMa
         zfE4RJQ1aXcW7xQPFFc7kUwblYCM9AO42GKc2xH42+MAz+aFOVVFqQ78LdSkCUJ52BEa
         mdl+3YBnQ6yZFH5oRHzAs5KZ5PqudlSirWsOOSJoZ2LhGjT4FcuvVDoHVrMYYQgAvEbZ
         ORig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774555922; x=1775160722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQ6Aq/POQfqqEmXu9zuXl6Xin5wscy4aVe2hMd0YT8I=;
        b=IOpa/SrVSzfjkxzWDu6zax++eMmuHtlcf5jwKPZvzWYm59o/2ehRorit7rMi/4C51B
         JlXRfMPc4MrtaT7NsbZc1q1EPEYwEbQrtmKrpoAFqVZ9Vbwb+lQS1vFzALeXV64yLd+P
         aQtVMtufOXNI0qykQMdIHJtoBhJtIbRNP0COzJfS5dyLp5B9o041vu7Av2tC3rb+OHXL
         859wyXVlbb7oxr+BIbJGq88jiu9lKYnH8Xj0bzkurYg2/MZIYF30eZtfX4QfSie9wUL6
         fe6/v4FnEhOiSpQo3ktrJWHI6e0MQ2qV4yDP9F6onYExbHuG3LCQGwGAaGLDNXSIjJ12
         DlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555922; x=1775160722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aQ6Aq/POQfqqEmXu9zuXl6Xin5wscy4aVe2hMd0YT8I=;
        b=qUXoXaN6ONdZTdeJ459HfI9pexQ1KBZgBKQFc3RwHdUN/HmsRxNHJc7gsZXh1751u4
         K5FI6FqN6YsKpDJDUDIAGy7xakShAiUwwN7KWjMZgc9IUaJgF7ZLMstweoamxT5/mITn
         17qf+AddsldFvKLijXmYEph1Q6/8QjdP89Teb1Q5IolUm9YwYuIFMxGJFLKLrNXNcwI5
         hHzv0atYVY/1LlUCceZCpeEp+kq0hIsEU0Qcu+I/4Xvu/3uUVP5FZDhI6C+Vyc0XR26V
         gefuC6jVHuWe6F9PJsgoh58n8/VftfvAwmweJ/hKinu7bOhXAt0ZIu54/8o0cdoGBQY4
         2nnw==
X-Forwarded-Encrypted: i=1; AJvYcCX8spGO52VzHkT3JMv7Bb7mu9wx0RYU1/2VwcdYznzfuDl/uIVM1BpV2dL3NW0sK02ie3PPOc6l0TM+OVR1@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj5PBD1Z6rVnJ7qbj+2puAEaXwTGxDmgGWOMb2xLaNJDNiZcwP
	ip3ROHF8UymcGVRXXEEhSf6obBAUiTlh2VoqNW+aD5+/BG2vZa46GUY3FYigxure1AG6F5KZz63
	8nFxBNRIk3ZtCcb8YFs6rSYQyapGigkw=
X-Gm-Gg: ATEYQzxV8oKtmtWIijkVheiGYT4OEDpjeokom5+ektqZ6cIx5lD7FkV7S8QM6b+0bqC
	Mn1aCi8LV6+eR1LmWJhXwIpadcubbRXi8cga3EzzjOt06myrTmuZ03lcoyG4dDeOmu4X9hFY86c
	71Em3QwemnOBQmqYeNbZUCN80hCtDDjhmfXDUiAfgw3St861sfbcha8aTz5VmltGS+PWRX6r7rk
	fteBDVnKzUa2kLTNlre2J+R5tDM2gRYym+uEDUf9MF6HV7v0t/DghN7layBf09HbEhWkHZ1HoZr
	hjnuuA==
X-Received: by 2002:a5d:5d01:0:b0:43b:9986:2fbe with SMTP id
 ffacd0b85a97d-43b99864385mr3860955f8f.49.1774555922211; Thu, 26 Mar 2026
 13:12:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306003224.3620942-1-joannelkoong@gmail.com>
 <CAG48ez0H_Z-NQvfOeczECz_sO=MzVDvu+8m+msB55rcAPfQOgQ@mail.gmail.com>
 <CAJnrk1aTnoDwDVdgYrcN3tHm-_j79GKYY=8q_Lu=xi8=Cxi4bg@mail.gmail.com> <CAG48ez2o=OzSjuPYm44gCDrG_tqzXC3=PCJHXCBVJyYmemtzsw@mail.gmail.com>
In-Reply-To: <CAG48ez2o=OzSjuPYm44gCDrG_tqzXC3=PCJHXCBVJyYmemtzsw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 26 Mar 2026 13:11:49 -0700
X-Gm-Features: AQROBzCKIqfx2y0xdE_s3cDvS-5ttLByg-r-ogTcKv2e1J_I2Ot6s_Y1MeHI0DI
Message-ID: <CAJnrk1a3xz4fcA+rB7Y3Cvp=D24-4TOF7bE5O9KTTZPjqOwfoA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] io_uring: add kernel-managed buffer rings
To: Jann Horn <jannh@google.com>
Cc: axboe@kernel.dk, hch@infradead.org, asml.silence@gmail.com, 
	bernd@bsbernd.com, csander@purestorage.com, krisman@suse.de, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 1:00=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Hi!
>
> On Thu, Mar 26, 2026 at 8:55=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> > On Thu, Mar 26, 2026 at 12:33=E2=80=AFPM Jann Horn <jannh@google.com> w=
rote:
> > > Am I missing something that prevents normal io_uring operations from
> > > grabbing IOBL_KERNEL_MANAGED buffers and accessing the wrong union
> > > member?
> >
> > Hi Jann,
> >
> > I am going to be submitting the changes for kernel-managed pbufring
> > compatibility with normal (non-fuse) io-uring requests as part of a
> > separate patchset. You're right that there is a functional gap right
> > now where trying to use kernel-managed pbuf rings fails with errors.
> > In those patches, an iter_kvec will be constructed for
> > IOBL_KERNEL_MANAGED rings instead of an iter_ubuf. I'm intending to
> > submit that patchset upstream in time for the 7.1 merge window before
> > it closes in mid-April.
>
> Ah, thanks for the explanation. Please CC me on that patchset, I'd be
> interested in taking a look at how that will be implemented.

I will make sure to CC you on the patchset.

Thanks for taking a look at this.

Thanks,
Joanne
>
> Thanks,
> Jann
