Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1ED2E2840
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873089; cv=pass; b=fC9TJEMt4EvXmQj3/aChloLJzRp5q5uGpMBPqS8OEnKvx8QrXPAVTL2nfgsv907uhT79J4xWTYz9hMvq+fZRpaVU2pr4nNEVEkk614uzw2KBPYcb2JzNbxwynPftSP3wGzhtUkDmTa5gMB57JZuHpil6YdtDs8dCIWJlCwqeCuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873089; c=relaxed/simple;
	bh=aFeoC8lzxo7yNh4+5NpJ+4/MJMN2RzuA2RxQg8zUxdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIdzvJeSGuFQk0Gq4UsWASXbwOPkeGX20kWZoAIpeutssj7JsmW9vcm4fY211cFhaJOy5LQYMlmSiuA3GKF+OrHBLVnem5M/tdHK7Dari9yodN9ia8ZTii+mpUPcWLaEs2XkSvOMxMvJn1US2gUcRh/MSvGdzkgRJCJTmH4agsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=PaS8kR/t; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="PaS8kR/t"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-505a1789a27so27853741cf.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 08:51:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776873086; cv=none;
        d=google.com; s=arc-20240605;
        b=dAb7ygFsrzUAhMaa3NO8OVqSoUjlJpzucTQlbx5ofwwIfRUzqOkJbz+hGEV6m3ljBg
         yNCJ6ry810ASaogWLDNdvLeZIxSJNIFpahuzfH5DiooAqKAVjTzOtHvO/XkhDxHsb2NA
         bT250ZyS0cXHvNbnRGJFtUDD2oOOtYcDj4w0Kg/U3Lgy/srCU127ugI53xChZ5MbyFQT
         +riTxbSeVHUr3xM7qgJqiVQpSbtrnHeKQa+lA3w0Ch2CiVoJn6e5YF1/M3JX8okZtPAX
         lhMi49YYTKqj0qy3Dr96uYRXIXXiWkIS4mviscZ0eFjh1zGQkBMbw/Lj3sHDD7VRET0e
         XReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aFeoC8lzxo7yNh4+5NpJ+4/MJMN2RzuA2RxQg8zUxdY=;
        fh=JyeOEjbbcYaihdnT4H2WF+9QB2RnTYPSW2Rcjt9V184=;
        b=W2WKFQxFbCzJD9AZ3y51LBEKbscUli42J1UolODArkD7pcI345g8rTmjh9OGlj9oxo
         TITJtpE9FPjLvb/diOgMY11CtbDXiWlNZ7/kuVH5zr+PhXPOJ8GjBRnJQhj0kCiuDO8I
         bnqhJbr3mSsKRrWVYTpHOqana1mzQFYry5+AYnfrRuk5g1oiJ2wnGm7wvtm+OFU2XC3k
         k/svynyHlNQ1eKgiC+7cjdf4dAprNVt2idPlr1fd3LKVWDhq6h6d8bwn8Rs0ku61EcE9
         7o6353b51yK+ujSLwnh0BnZB+lo51+kBqhYsLYes39aoY+id6HNyGGxx6HmJ4Ff9hUBb
         zRuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776873086; x=1777477886; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aFeoC8lzxo7yNh4+5NpJ+4/MJMN2RzuA2RxQg8zUxdY=;
        b=PaS8kR/tJLQdPNVTA5mIkoq6Rr8qv7nmJJ1jibCfiLeemeJtKVtKgyB/bItakcp0GV
         DBwAjdStGAGlsKGUb3S6GFgSeRm5IKLs5+J/rel+ImrPPHEVmqZ2wJLwokTwUBiBQNOD
         JpwOIDa5l7/lSIDHeeB1zTKGzRG/OaNIM27+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776873086; x=1777477886;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFeoC8lzxo7yNh4+5NpJ+4/MJMN2RzuA2RxQg8zUxdY=;
        b=e9fpWE7nqMRiQqFe5+LXPUZYcg4nVWfKhRLDNgMKO81SYm8X2sDeYk/AEf7BqnRh2Y
         Ww5OOEfE7eQqI3XShzseVVrhtkg7yTTgAATUbWpyZiH/XR89aZQg8I55m8/u7IL8IFvi
         eQa7ffF+njkJ9WYQ62OFnIuVpcE/VLuy0fP3TJCmEUbzQGDOQ8teRdkC9FnvhWaMNVGg
         +ceS04rv+DfchExdD+X82/Atv590bUGb9Fgd59R/7Juvae86q3KezNLFD1EjCdu0v43P
         qOpAsNWll/LnhBV4cScF1v+G3yxibG1KrWNje6sWjbQKJ69dV5DgtaI0uhDNhWUYovXF
         GMPg==
X-Gm-Message-State: AOJu0YyWPKiWW2mo6UGYzZyuMXn8MO9zphznCfhMxoaJdrGGXcqMbxpR
	PF7Y2iazbOTxOPizMb4IxBl0XFFoKTi/gvw4XZNiqg3vXZSHgNUc/WED2+7e15ce3PAfUsxAzVE
	wWqwrmyhA8TOseaXN1hYBwTv6DjmOXZkZmjNA2Wc64A==
X-Gm-Gg: AeBDieshLh+nP5rPRwH00WowRGFS5uPTnnRxtrB1wobzPYYNK4S0IEtwuzjtDioyq+u
	0nZaqznCXP573zMLagjS/3tYc8CvxUeFKUvbM7maE4IMO7E6TMVtGvMSF3SZXr4uARuCs/nHQ8Y
	nDujy11gSwk1fY2wEO/wNLGn65tGYsDYKN4Yl4EAbgSi68u8ChSpG86OG1eFLCbGyL39D/DElL3
	LtUyRHSokc/0mC2AUsCouOXBn8J/yZpWzA+CfMQSkL2txbwmbcAw7ToYCf8OxkTpm6ilLwcKUSe
	qYFXnuuuNv6PldRkv29EkjnFzdDVI4TbkbZ2khB9IN18hMujgqWFRfR8vOQS8Q==
X-Received: by 2002:a05:622a:1dc4:b0:50d:6b13:bb14 with SMTP id
 d75a77b69052e-50e36bd4eb0mr321070431cf.34.1776873085761; Wed, 22 Apr 2026
 08:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgcYCOE4uWE1tAaVUPLNqmbp88_0MvM=gqiDtH=jBiW_A@mail.gmail.com>
In-Reply-To: <CAOQ4uxgcYCOE4uWE1tAaVUPLNqmbp88_0MvM=gqiDtH=jBiW_A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Apr 2026 17:51:14 +0200
X-Gm-Features: AQROBzCUfj-d8JdNK06jOEsx3iWCL2QHTcnka3lBvoT2DbBteiHX1BjYlxXITXI
Message-ID: <CAJfpegtMV7gG8w=+8Jza2QnV7o+4tCkg2oObE5BXZwaOXOGP8w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem breakout sessions
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>, 
	Ian Kent <raven@themaw.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 at 10:58, Amir Goldstein <amir73il@gmail.com> wrote:

> No need to reply with specific topics now unless you want to.
> Just keep this in mind and think of things that you may want to
> bring up during these breakout sessions.

I think these warrant discussion:

- too many negative dentries on d_children (causing e.g. soft lockup
in fsnotify_set_children_dentry_flags())

- and the related issue of d_count overflow

https://lore.kernel.org/all/20260331012925.74840-2-raven@themaw.net/

Thanks,
Miklos
