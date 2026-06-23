Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A54934753A
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 17:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235768; cv=pass; b=Iedbfmm51gNq9b7cvd1G1kb4zuCyvEsq8aAmaWW6HQj8WiTBnpyGp5e6UZ1Vbr28ZVnKTSbyi1cz8VU0YZMTG8ugyQUKE2e/OJEoPNWfwzUnurUALTVuD0u45b0DB5B8ZOHjmlYBFVVNkHx1hJwIz+PRqtFdCb1/Z7q9jRg6Ri0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235768; c=relaxed/simple;
	bh=R/Fe5SnmFz4pInrDHbvj1u/lF1jaDqBAJE2REUZG8sY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgvbH4yL8I1hHS2xpz9H8N2BPTz8AJY/ZPK1U2JzTX02G2UycxijWqV9h6lQ/L3i2K8EG781jUHOqhrHjdBv9i6a0PT+ZUrHUsI+kjC1a/ZtdRTp1LB+RpkHRQ9oQ6gbmx1fHet4XI5sI6zFLjeaGM8AlYLwn3sHN9MYhx8tQ9A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+h9W57Y; arc=pass smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+h9W57Y"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4471b489240so86505fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 10:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782235766; cv=none;
        d=google.com; s=arc-20240605;
        b=NskvmgKv6VcmqE5VagypIs1pZRa44m1AwN19P+etP1nFxkYoUjXMuiHJDlm4tAnrNK
         8VFNDXIMuchL5bB5OYVaOG7zuILPFNkofEaz1UzhxbmwY1VudgaH4si1/sUQNA1afvFv
         y26mwbclZ5n2c3FdSISXvBo+T4Uy30kdRduLUmOo08HzfeoDIS32u1o7IiKSagdXV2vZ
         ybiyF4+5DzOXo5O3V+tLbH+RtSw6WwkezzqH9JIFOFvj/WRjYeKBpkyWCBnSIzRN/B9a
         6WnXg90zykpQDFvhyF0KUw1ErM4c4jdOxW7rFiEVAppuKWespcYIh0BlUhhVR1n4JM0a
         uhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SOKLBFVXea5OkC+RzUd8udE2QmUOJ4Ga+YnSpSPdn2Y=;
        fh=NMxhmlEbDsxd+bY1FMlwktKCWGyswc4QzwCDCte9AO4=;
        b=Wda3+23OWJCVB/xRcZmQ3wwmHM7WbyQnk29f++4M7QeKhgKvUqsxJgktUUcPqm9mY8
         Q776WduFAXBvQ2SvnA6SvpyGuSLa5LQnyFCz2NKsdM0Q79Q0mhyZhT0t9JKxauzBOEa2
         IiojkvfWTTNFA3C6lgz8Cq0HPI95FUkTcw/cgAsYcKKNvXi2gIIps6a8rt6dwuCATS7I
         72PwQEZZvgbFVXMf81w+2LD+0xt22hjS0TksvejpMneGqvna97wxZ0tHcX3Znof5zMV5
         shOG/MVjvDxycEYkoaKUpngyTAlLkaiG8EkK6mUQhut2+Ajho05b8SzS308uR0LPD/6d
         IvkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235766; x=1782840566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOKLBFVXea5OkC+RzUd8udE2QmUOJ4Ga+YnSpSPdn2Y=;
        b=i+h9W57YyBRyyYtCHPYl9/tnRJUtnRTPfM16N/cco/qK130BDC4MUMVg2u9JZYg6tA
         stG74N9TiPZ5FBHi7Hzes1ZNSG7QnZsdLA1fmMvXyNsWJAv0xHvrNNAfJJygvfa5sp5h
         U8ymc4hP3oJuJ0gpPdHMNEc6/sUEfrKVldijc/oh8Fn1cv1xtLhKIi9UZe9LS5SzDsy+
         olLPcUDO6HRp3uvLQjVIUP/lXlCfOfOmgQSGtVDUmyTJpmgI1/Mbva0mdg+LUyToPf+n
         6m6e8i/9SoQKVRZHH3epBe0uNdk5uyghFyOoaM6iBfswtkBsvBL/xQ0mQOHZ6JTAFmLe
         ZY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235766; x=1782840566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SOKLBFVXea5OkC+RzUd8udE2QmUOJ4Ga+YnSpSPdn2Y=;
        b=qwe20J2Rt4cesGJg3SlP8F0+9nxcupA1COYvUhoY4clMHOy2nSnBXa+6O3P4OCl8ma
         Eap8DylutPehxgmUnYv6nTT9jO+hiLA62xGLez5B2v2QbPr2cyWfIpYjxUZqp6vgqAff
         On4L/3Vmd/SGFgqU/jMs+sYnpfv8aTeXApQaXpHTAyDWqG6PmZGsU/5Qtl+VCzy8J/tb
         iZGZm3iyHlGe3M8DsFaVg5wuX5xKT27QcCRMsDGr2EHXG6R+Y/Ou2N88koqTENrJssTL
         kHDFM1+TJLxw1TxNBP18g2OPU1rQ/rIVW7UcCsElX7vtHcte5fi85HnNiOuuA0+Uw50y
         uSDQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpr23QQWE9hRs/CFwRJHbS4dEStdDvNQx9phDeQ6IfbuFxyP3P9aOHFAdpZbOBVtOZ5ZrqZAS1KMYTEYdW2@vger.kernel.org
X-Gm-Message-State: AOJu0YzmhYeJO66LZfeeKD49REtJDdVuJTBagnNFwzU+SE6AZvteu+yU
	atwBF6/wplRCks0VSEgvJw1WZZ7Uqmyh20t1kNszzvy2khrgN2GW7DHzPTvQGWFsYQWHQ09dWne
	GXLqKFoMbisLsVJZw6kTf90IQ7xq8pQk=
X-Gm-Gg: AfdE7clUgG0V0jdO10HUv2sNY2qPOmss3pWRfIsYbvoZH2PV2bZOHmgte0MyzM0Z6GK
	OswwssxwuTyTQEFK13TXI8p4qlsvSKRdaeZMhmIHXaaMp+k4coZLuD/iGUcXqCqChx9xKGl29WM
	06PxsR2PslktcVJBqgTHLXL7DoUyEualqPbJVkYmkpfBX/sOsTzUpryueFpcIqxjQGsOx0t/QnB
	xgrsKh1cgjhuziiBrpOG1311ulUkKzjp3eMM0MZjXw4YJ+olOMVNRwEDsjQiE6mbFqaLCw=
X-Received: by 2002:a05:6870:c22e:b0:430:29c3:9d15 with SMTP id
 586e51a60fabf-447b653ffaamr2576825fac.1.1782235765975; Tue, 23 Jun 2026
 10:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
 <20260623094211.1080873-1-safinaskar@gmail.com>
In-Reply-To: <20260623094211.1080873-1-safinaskar@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 23 Jun 2026 10:29:13 -0700
X-Gm-Features: AVVi8CdxhzkHtkOXOPWSv5LcqN-nC_Tc8xPzc65F7h69_IRaRTA8RjzQbS4VMPM
Message-ID: <CANaxB-wcNOSs9vHpZ_wG7Q8WJVV0D2nhtCFGyZ1_5Rg=+256cw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, alexander@mihalicyn.com, axboe@kernel.dk, 
	bernd@bsbernd.com, brauner@kernel.org, criu@lists.linux.dev, david@kernel.org, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, rostedt@goodmis.org, 
	torvalds@linux-foundation.org, val@packett.cool, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 2:42=E2=80=AFAM Askar Safin <safinaskar@gmail.com> =
wrote:
>
> Andrei Vagin <avagin@gmail.com>:
> > Actually, this change introduces a performance and functional
> > regression for CRIU.
> >
> > Here is a brief overview of how CRIU currently dumps memory pages:
> >
> > CRIU injects a parasite code blob into the target process's address
> > space. The parasite invokes vmsplice() with the SPLICE_F_GIFT flag to
> > pin physical pages directly inside a pipe without copying them. The mai=
n
> > CRIU process then takes over from outside the target context, calling
> > splice() on the other end of the pipe to stream the data directly into
> > checkpoint image files or a remote network socket.
> >
> > I ran a simple test that creates an anonymous mapping and touches every
> > page within it:
> > Without this patch, CRIU takes 9 seconds to dump the test process.
> > With this patch, It takes 18 seconds...
> >
> > Plus, it obviously introduces some memory overhead.
> >
> > If these changes are merged, we will need to completely rework the
> > memory dumping mechanism in CRIU. Using vmsplice() in this proposed for=
m
> > no longer makes any sense for our architecture...
>
> I just have read some docs for CRIU. I found this statement:
>
> > #### Why `splice` is Better:
> > *   **Consistency via COW**: The `SPLICE_F_GIFT` flag ensures that if t=
he process modifies a "gifted" page after resuming, the kernel performs a *=
*Copy-on-Write (COW)**. The pipe buffer > continues to hold the *original* =
version of the page as it existed at the moment of the `vmsplice()` call, e=
nsuring a perfectly consistent snapshot of that page.
>
> This is wrong (with released kernels). I confirmed this by testing this o=
n my current kernel (6.12.90).
>
> See the code in the end of this message.
>
> If you actually rely on mentioned consistency, then, it seems, CRIU is br=
oken.
>
> So, in fact, my patch actually brings consistency to CRIU. :)

Askar, unfortunately, the statement about "Consistency via COW" is just
"AI imagination". The under-the-hood docs were recently transferred from
the criu.org wiki using some AI transformations, which introduced this
wrong statement. The original document can be found here:
https://criu.org/Memory_dumping_and_restoring.

To clarify, CRIU does not rely on page consistency for intermediate
pre-dumps. The pre-dump mechanism is designed to be iterative: During a
pre-dump, tasks are briefly frozen to vmsplice dirty pages into pipes.
Then the tasks are resumed, and CRIU drains the pipes. If the process
modifies a page after it has been spliced, the data in the pipe may
become inconsistent. However, any such modification is tracked by the
soft-dirty page tracker. In the next pre-dump iteration (or the final
dump), these modified pages will be identified as dirty again and
re-dumped. During restore, the images are applied sequentially, and the
final dump (taken while the process is fully frozen) ensures we
reconstruct a consistent final state.

But what really matters in this scheme is the vmsplice performance.
The proposed change significantly slows it down. In the case of CRIU,
vmsplice performance is critical because the target process is frozen
during these calls. Minimizing the freeze time is the primary goal of
pre-dumping to make migration almost invisible to the user workload.

Thanks,
Andrei
