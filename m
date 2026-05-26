Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614C9358375
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 14:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805028; cv=pass; b=QaIpw8lrjzVsf5UlniydddyqmMVrsqYZ6gRRppd1LAc6HAHl7hUwQ2UDEDyT0PmuiLNWpbXymXTQWJ7uJkfTdclTQCzl1/BpXGHo5tNgnLVg+U+fykTLCDUvGLqkcApjXTqQYROuHJ7z8ab6EZtHvCc3/nEIprxnlNhkO7xPWlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805028; c=relaxed/simple;
	bh=CPjvAUwnknL46Tj325qM1LRtHgQmjQzHZUIto+uk0zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOsQBQUeVgHUI+EKph6RgvEDFynHQ7qAuENf/jVmJLD//gnVhn3GgivMdJV1skcvSfggKJ6EJHgtCmffMjzBn4wbD7MAbMPkwBKJ0RPWeIYCDFha7N6MltRLf9ml+n+041Fkc6JjmN98OJRN+IgvWaF1n9IgjSgeDPPZPrSYNuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SeYl+2x4; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeYl+2x4"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c7a459105so11454817d50.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 May 2026 07:17:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779805026; cv=none;
        d=google.com; s=arc-20240605;
        b=DeICyj+BzbtL78IuUq9d6iM7nibxNGZfUoJSvj/Ug7wHasj2mdR31RbJdIMBhMsmXP
         sl8iqVudcoRM2/QAf1iAMLTj5f5p90k5PrDzSmWdsGqcwBn0CLIX1h5VnUsKlKIGPwPZ
         jMkBIwLurKFugnM21Z0zH8p8zMH384YKM8C5s6OT8gtg7oEI8PQn1ymmbkDq+KFHcp9C
         YWEi/6XjBGA6U3R9A6RGjn/Xvy2xyCYiR2/3PkR5Ped0UpnKtVBTHjw3mtbYQhHBZ3hx
         dV2kd7rE+kw0y4gjVbFh+pn5+BEpA+kJn4P6Yw1MGzpKs7cE1zhrEk+f9jptlDWfQ75b
         M6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CPjvAUwnknL46Tj325qM1LRtHgQmjQzHZUIto+uk0zs=;
        fh=W9yRahhXEEWdzY5cFbDUXUvhNkpaDgmi9uOJcTsJwq8=;
        b=L1c48ORMGsTjpWgHhKarVnRbvB1yOtcot7Odo3/vmhmTA3EjJLN0/xdJxFmqwTgWz1
         xmbVBRhAk2WBywZ704b+UvUqxw49Eeh4BUMuqCpTxadcjrORoiagKarvC7s2WyKXXznk
         yw6O+zGj+5EG8D3IVwVXAoY5XO2iNnf6moAM1XNe65z+OUYrytv3SmuoHHV6udAmUIg7
         90r5RfRkDM0RV1FYldDNZSR+/cMEwKNHEt1K7grvDTeVAM8AFoxtAgrBNFfSHqe4HKG5
         S3lu7hk7PIoRF5HZOHJ4d1gewceIqnRZyNgJC/8Os6tfHkrDETPz9k7R/85ZJa+EfEW6
         BxLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779805026; x=1780409826; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CPjvAUwnknL46Tj325qM1LRtHgQmjQzHZUIto+uk0zs=;
        b=SeYl+2x4NR9bitLB3WXlvIMi3Ps/E4DSwvcIovLBRwutuGuMwSPZFe29wHOzcRn9c+
         b4zOT8k6v54Y+II4ccp70okD4wZtkRxXCMATg76vLLmlWOGbdMObwFmupwOHbwqdW57h
         NYdacIB4gcaveWYviGn8m8YV2K1Lp7Nm3FuoUPd5R8UT869Ptl4ODn7ka0H5ljLGx42c
         NUhfFTyAzwRo7S+hGvP4LCjSPvUikI5TAcEbVGQaIJNlmWrvRs8uNDlJx6VPq93YzYnU
         AcOwveUto9mPvpCkdOt3nqU+yr9KbIvnWU5yYmhvj5f79lxc4DHoeprZvjKFUmWTBjNK
         8fyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779805026; x=1780409826;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPjvAUwnknL46Tj325qM1LRtHgQmjQzHZUIto+uk0zs=;
        b=BZ0QNAWXIWR4bIYYLDeALOGqfMCo5CShNfHZt0GewxT55tfNvbxXxJnRLCpPu6VqpG
         asNj5lRvqzH3ggBnaA4ajjUr0Grlo3fnxduWkfb5i8PeZNcUpuhIy4/GC/8K3JEx92Nk
         xju9dzzSgno2ocprtAasLzXE7DJbAcZrWmiZLMf5XU8h5Nnfu6qYI9ODZXFL3FF+XePn
         GgHHfpU3aran7m779iPHE1Txt6QPpGGp3YBcH1/bYZdhspGC4wBB6eZFgz3e/mN2sJBZ
         eFz5Npmded2l4fEqCCUzIGmte5wt53Yd3B3hOOMkLFCITOh8QUewvSMl4xIgyjy2hRG2
         0uUw==
X-Gm-Message-State: AOJu0YxQsOvebrUSMptGjRZCEqPqVbMSUQ3mJYKOfvsk7BEe8LMsAbcD
	GLmsvilgl5nA0FKoNw0qOOW8I+cNl6CNO3DWx4T8swnt3W4zUykrDgZ4AU17xSx6D+glfLu1i8t
	sbfMYevD/r+D9kQbrfATNkMw1D3GQyiQ=
X-Gm-Gg: Acq92OEP4B+3ldBR8abSZCNFnOUlZdz32Htv/h06PpMHwfUMNAVdfxjmDi4Aiy2Qq6O
	OfT569EXb8m0xmvZfk+vWKpsxwhHRjCt28zM14oSlKPGoAo2NqzlaVjNw3Bv88vEcAX3azSc3ns
	VLjj094ce/lii5kKcygIIuPZI1gBly/cGECDircNGEjpUS7g88oHHWSeTdPpyVM28X5cgp7hcp7
	O6aA/d51DWZp0WJvy6LyK+LH/zHd7fOwltH3Ou2QphblC/PccPxSP+yUGy0ZJcmWbHpExsmxdPD
	LckIrCTcQht1VenYQOVpCj8ERSCpwTY3hsJjVsKZnw==
X-Received: by 2002:a05:690e:1285:b0:651:bd7e:c04c with SMTP id
 956f58d0204a3-65eacdbcbc6mr17674347d50.21.1779805025924; Tue, 26 May 2026
 07:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMw=ZnSaVSzn1RGtiNRG+iNj8M1e12rZtA98i4jL8jYP5UyzWg@mail.gmail.com>
 <mcm5gloab3zt5duszhtk4p472rsvmrhnesocg2n3kghqunwd5n@2izhebvb2gvo>
In-Reply-To: <mcm5gloab3zt5duszhtk4p472rsvmrhnesocg2n3kghqunwd5n@2izhebvb2gvo>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Tue, 26 May 2026 15:16:54 +0100
X-Gm-Features: AVHnY4K1Ck1F2aIxmhHouFWAO3rkhXrm9vXX1726CrwmF33F4hGXerbXZzKiBYI
Message-ID: <CAMw=ZnR4TaZvobAE5Pr+9MUGBswTmHdus5uPJ_Ae+dGpDuNoMw@mail.gmail.com>
Subject: Re: Occasional 'WARNING: mm/backing-dev.c:636 at cgwb_release_workfn'
 when running mdadm
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Mike Rapoport <rppt@kernel.org>, Christian Brauner <christian@brauner.io>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 May 2026 at 15:14, Jan Kara <jack@suse.cz> wrote:
>
> Hi!
>
> On Tue 26-05-26 13:01:11, Luca Boccassi wrote:
> > Hi, I've been told to report this here.
> >
> > In our CI test that runs some mdadm commands we occasionally (maybe 1
> > in 100 runs, not reproducible manually) see the following kernel warn:
> >
> > [ 15.769393] TEST-64-UDEV-STORAGE.sh[245]: + mdadm -v --stop /dev/md/mdparity
> > [ 15.786033] ------------[ cut here ]------------
> > [ 15.788632] !list_empty(&wb->b_attached)
> > [ 15.788634] WARNING: mm/backing-dev.c:636 at
>
> Thanks for report! Interesting. I haven't seen this yet but I suspect my
> rework of cgwb inode switching (happened in 6.18) could be responsible for
> this.
>
> Since the 7.0.11 kernel we've got a couple of fixups to this code. In
> particular 6689f01d6740 ("writeback: Fix use after free in
> inode_switch_wbs_work_fn()") and now also fixes sitting in
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/log/?h=vfs-7.2.writeback
>
> Your script seems to be exercising mount/umount so the above fixes could
> indeed be related to your problem. If you can run with a kernel built from
> the above branch, it would be great if you can verify the problem got
> indeed fixed.

Thanks, it's very occasional so can't reproduce it manually, but once
that new kernel version starts appearing in arch/rawhide, I'll report
back if I see the same warn again
