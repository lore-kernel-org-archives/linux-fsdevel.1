Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0055F407CE1
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781095361; cv=pass; b=p9lquI/l9e4ZTzfR35RE6wtV7YWSTSnWJe7RHGN2dPrpcWpGcJVsFgoouKa4iVYuFKe4dqmqQRICd6zyn6t4HvXjMPuQpURZ9eW1V62ZiteqpPZbRQeBWBfFaM9AXfap/U1pd3qScDf4PJZqnTY8/l/hf9h5RDgUMa5gLlEqnj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781095361; c=relaxed/simple;
	bh=+pW/nsoW7Cj2culB83pPpy6kKRbTsBuToHyYs/boxkw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cFy6CUoh5CoSYA2YTp8yujK2eVsjmlFX82acOlqZ928P96E4wT8gz6x/p/FtS99+Sg1F/pQxrjw/5VDMeNCuYFrU8Ok4O332xjzCQ+NcZ90dCTxAJfvdRF+RzGqxhF6pgO285DRxlewVcpKIOO+PEpu/pb1idJpBUaRMgF+ulFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fTSFilQj; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fTSFilQj"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so6498977e87.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 05:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781095358; cv=none;
        d=google.com; s=arc-20240605;
        b=EDvX7wWunQDClnuS349974QR4P7vL7BeI6R8/AvYGlYTBOCgDgrLYvrmABPuYNUdCd
         63f/GCFI/S8IarnPjjEGulpZMbUdGwfftFUm3LuQnYO2/on+3Kv9uu1DyHbDbL2cHjbq
         agnl+j1P2iZbbSoY19VUzbs/qItquKkxnNlozeWoz9g/uCqMqxZx50RyLJs1WY4bGiex
         E0eZWAwuDt0HdZ3g2InjGF8q7AJ/nvZ+IrJenYDTMPBUEL5zBqFpwQvTI1bJZla4nj8y
         21ojQ9bBNOwAVYaTvst4t9bdZXa0qIaC2ZtCZ3mSXLRdBsJxUumH11ScJi5Y2Z9kelNx
         veyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mDJkHhDfbR5B0ByqxT9qzv83+c9UizfDkoKu8GlqWyE=;
        fh=m6WLBw+Xd1JFqS9WByUoXZypPt3qBOjCoRMEEYk4h6w=;
        b=WF5YVr0/nzAKZBgxX3wJdJQGTA4lOgxpHFJP8gFSI4WaVy2Gdqy+kRsIr1MblTpcLb
         xEq7r9QmKA5wbbdfg+BNHEIqD8pQogafJ/9DhTpNSjtEVWpzkIoIAs9GWR1eg9Kz8jTM
         R4QDZfSCcJIaOx+eQDhjyqWnQG2+eLwOQEhLsqQQ+J/9KAat1U7+Bh/X+r7+FYuJTCiS
         ArMYuXb+mIgmL+WfL6/uGq07JD71oWJKIVlTYCQKSuOPLz+VFpUmUuleBpcUVdXcEs/7
         d3l8YpAH7keqpeA7oQWg4OAUJvBNA8PKZ8KGSFminTdgmIPyPMgy7cuHqIyVvF0F1Uwz
         kpIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781095358; x=1781700158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mDJkHhDfbR5B0ByqxT9qzv83+c9UizfDkoKu8GlqWyE=;
        b=fTSFilQjDyi25mr1Nnh3Y4Eh6VAjK6xlWKbX9gYMz4yG3CnrPiZIF9OXFsP3bMeBM5
         doR1Huba/Ow4RHEiO/UtLJwFRmGHCPi5s+IzqhkvgzreU0S1sKGLUW5GrjKxY1VCTuPg
         43tIgbuI7aGTPLXiGYNCvAjbOqs0Q0bsCEijIU/TZNbftDcsCRUlWOpYMQVELV6SG/x/
         M4xiREFZ5HmfaglnV+6UNN9XE9DaAb07ccMr7g9pQaoj+sCOVReNH5avM8FafrK6ai8A
         yeHv626/n0SkC3iN2Qa7H4gDUwRTZlznG/MsrCbqiimZEhdD+3LDSlZ5jf6i6TxbjO6S
         6+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781095358; x=1781700158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mDJkHhDfbR5B0ByqxT9qzv83+c9UizfDkoKu8GlqWyE=;
        b=ZXK3dIC3Evf/BlO2RDPJxUuNfaObPzzUl1R+e91t+ZTJ4Ev6KifrKcu5o/YlAuTOda
         XsAFBu3lXfA5es3vQRj8uPllieH+VO0HIJ9hlHeu7rmrZ9VIRuMFia4k48eDW9PFtzMF
         fDI06A+SdPGO2tLn7ZOaMHPgQYc91KHahv3KyBQ7zPEMoHLT1zWygx7LbXbzNERODZe8
         Xfwg1EhvC7e6csvd07iK4uL7foHXYy2eK8/Kx+ajmpXylVsL4duzmTDCW/oX/TFhJu9r
         Vxo231HmvEJFJiGV+pg4PTfGd/VKzMQT7R1wmqEIWEd2PrWBKEx/hRomWBMsjz85HVvV
         BLuw==
X-Forwarded-Encrypted: i=1; AFNElJ9oY61gD7UpI7VDS0zmyebr7RkU22+n+i79OSkwtjUt2IlGYEZvv/zlRwANrVJS/9OGZVSbuF1TWAyLUCsX@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8fNW3vNsauCfdOjtm1orDcBG7aEP0ZuEZXxb/z/97rmY7mtZJ
	nAdXpdg48NQzTr0/reHMLltk7pkpM+hg1Syz06XM/4K9bb0kTuLQlrLClv9IsY5Iat5GPlAWefD
	pBBJBFCqJD3gBpRVd2QJXiHZygrv/JbKeJiOa9Li9Eg==
X-Gm-Gg: Acq92OHMikaLlriZD4jJymXvJKThFNbOzfNSxsU0hFzcnONd3j38C4EN3bYMV0lbf8C
	Kna4NDWAti0pFyxsB8plFhQveaxEA6fid08MflEGWjnQEEi1fmffmAF51UL7aWSqYQ/dlp5J52m
	K1l7zkCmIgFosYweNENbjx1hXjvsc6+QdpxlOzxyns23kRdvhegOJPs0v+1NKoFqnj/mieJmpBi
	nMJdbdnGeCJ7QuExqh+5vpYtgT1fB6ScPvB2Edh37Uy2ta6eT527fAMqSkFQs7gAzjWcwQMsJUO
	r8fA50Wr13i5dDdWPGp0pbKYERuGS3r3lGVqLflvAv/TNtwf0yY=
X-Received: by 2002:a05:6512:3b22:b0:5aa:8822:b875 with SMTP id
 2adb3069b0e04-5aa8822b8abmr7700453e87.47.1781095358166; Wed, 10 Jun 2026
 05:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508134541.282073-1-marco.crivellari@suse.com>
 <20260508134541.282073-6-marco.crivellari@suse.com> <CAJfpegvW1yoVEfzbArHye4KmDgOuqeVHNhahR6Q25cvB-hHfmw@mail.gmail.com>
In-Reply-To: <CAJfpegvW1yoVEfzbArHye4KmDgOuqeVHNhahR6Q25cvB-hHfmw@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 10 Jun 2026 14:42:27 +0200
X-Gm-Features: AVVi8CfoRHjPMIzcjKp5oGkBjjPzkUXsg3dhQ766nBa_pJbwcvRf_LkjXjqXb4M
Message-ID: <CAAofZF4ryNQnXKy+GyXdu8icnGUFKOj4gM6htDYpMjiU_CjwCw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] fuse: dax: Move long delayed work on system_dfl_long_wq
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 2:17=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Fri, 8 May 2026 at 15:45, Marco Crivellari <marco.crivellari@suse.com>=
 wrote:
> >
> > Currently the code enqueue work items using {queue|mod}_delayed_work(),
> > using system_long_wq. This workqueue should be used when long works are
> > expected and it is a per-cpu workqueue.
> >
> > The function(s) end up calling __queue_delayed_work(), which set a glob=
al
> > timer that could fire anywhere, enqueuing the work where the timer fire=
d.
> >
> > Unbound works could benefit from scheduler task placement, to optimize
> > performance and power consumption. Long work shouldn't stick to a singl=
e
> > CPU.
> >
> > Recently, a new unbound workqueue specific for long running work has
> > been added:
> >
> >     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound w=
orks")
> >
> > Since the workqueue work doesn't rely on per-cpu variables, there is no
> > obvious reason that justify the use of a per-cpu workqueue. So change
> > system_long_wq with system_dfl_long_wq so that the work may benefit fro=
m
> > scheduler task placement.
> >
> > Cc: Miklos Szeredi <miklos@szeredi.hu>
> > Cc: linux-fsdevel@vger.kernel.org
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
>
> Applied, thanks.
>
> Miklos

Many thanks!

--=20

Marco Crivellari

SUSE Labs
