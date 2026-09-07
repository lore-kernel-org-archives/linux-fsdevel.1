Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8882B36655C
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Sep 2026 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816668; cv=pass; b=DAWC1/cAT9tNKko7AlGHZv1qkC87XXNXh6jxgZQtREJa2eTtU0Ibfi+dF6H2qy1DgrmT2bGVxG5b8p/QZ05fZw8kHEdQbbvHySsRVWXv26ekyNYP89b6Vx90fvDP7Beut2o6+joWlbE8d/G+mYi0llAg1xKcwby7Le/33V6KpKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816668; c=relaxed/simple;
	bh=KCfQ/o2jQIWmDhYUMFPoTF8OvDrs5HT3JWRI8Lf7DuY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SsHCG6WaJ3UnsR2+fQ85TSENiWd8XpBGNJyLjmYG9lL24GDREEjj+swEH79RqSD+vF4tqSll2YT6Ex4BfCbqWCn9J3yiOJJgcq2u+UXxAMqoEWBp2QOi1oImnoqJnhYuSwn2QH4VALvkK/91DMo5inHK4fYC8cVC7vkL/5zQu+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LpO6jbpx; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LpO6jbpx"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d6ff3aca07so166555ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Sep 2026 14:31:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788816667; cv=none;
        d=google.com; s=arc-20260327;
        b=NAkEAKbiYNQ3YOlzs3excuxHTmWCm+3sZWUO054ehpSCLB1ymlW4b8DyIJVRFGefVE
         /sLDrK76BI6xOLXL2cWatTTuWaOPR6jPmFwi8bKQV3q01+QOYYqvAJOxJL5zmOuygdx8
         Fi/3S41VBjDptSuGdP458HfS5aDd6EXkAB6L6mp9UjCvu8c/hVz38V9UB98w1qGSoZ/j
         Pu8Nxjhkf+QIhyRTwGobPWpeUM1cCDcVsZvcmUeL82C+v0yWWAF5VsOeaDZKcgZlRdzO
         yZTabvZdwMbngoxNADUmy7qCuawkM/rKKOgxsGUZuqXe8TEn954sKEgatiQqiumZz7QI
         Ye/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tMhB9/vf0+R2BNCntM8XD0je4RadngbF12KBKt2v40A=;
        fh=V5MnX4Xb7A5nImfFzE9tybgTfJKsVR4zi27UbP85b9I=;
        b=EuGTqJDPf/rL06iwRXXXl9AOy6QMAnteJxQtRYKOokEMcHfr9xFDQTcBww0T9tQq4c
         3WjNVJrVMA6kRweBeEPDZoPH9SnDxdkizVWM3wUoPr0YmIoYS08ApQAsvI4mIfiaHwky
         rIUFLxilaMX1UB5AoBReEd95zfJZElDqx8P6HCFgEIS8KYg2oLgGxrQXp3RINPSSrY9V
         /aHG+UoM52FE4yHAZSTWFhwUic9rn8zc+MCd3OzcQMmt33vYeZI9aQULw2M20v8u+pdY
         qrGulUamr/3fX1iGWV316HsN2W0X59tme45Seh7jRb83xuj7x9aXFtNBRufY3+Htwnf4
         rcgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788816667; x=1789421467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tMhB9/vf0+R2BNCntM8XD0je4RadngbF12KBKt2v40A=;
        b=LpO6jbpxb3ysZVqrwaUfXpmMZYK1kfFL1IzhoqFQKV+7qo2D0g59Rj4NGEUBGR4Bjn
         o59ZnX+94vIJDVHSMqDmytGOj0xYdYJ1PKRuc2ToFoG6I24s7W8555Yc1Vn5q2brPGNQ
         Y4nq9jDHovsHc78Q0jlQgrVaDAHBMQ7f0HagVf36TxOrIg6P8w7G2SbyLDNnaPnKHxhX
         lS6mSu0nSKouwGqTXj+RzQ1StYyjxoCykJPv07ICO4TJ+5d4xmfZYfHg3A/V/3J2fpqL
         4sMQrcoBJgvSRCoD+BaEmVaWQgVe2Lj9dCNBVlJbR2VWASCrHZaDnMkwMVJBx7OFOoWH
         5EgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816667; x=1789421467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tMhB9/vf0+R2BNCntM8XD0je4RadngbF12KBKt2v40A=;
        b=PuHxfTOHGBaSW3BO0GCSfLvnIK+uHOFHcLXamotMDtjIBXnYsxeGAuCGzzVtnJ6SXK
         UcvKcOH0qgv3mCRZGYJGsYClLhTmxRXw88xEaUuXlMOiD9841pn9EfCkNRqawbfUh0O0
         NRLMpIVD/yuWLUMB5FI4EWGKv0SHvSV3q8mcoKPITVGdnICWBYwl6QDgAm/gJQOG7CNZ
         BVqlYXcQvGJZ6SkKuxPfrxqAiOqvlKGT90ZQS1dszlCp5/GsdPi1q/EBaVBBsrxWdIGP
         Ro23oWSZwsSJ766HqGs9vziJfyKRMnTxGpT81IrKHiKlVMACyTJUtmsbBp3eIAjU3h8L
         2lSg==
X-Forwarded-Encrypted: i=1; AKwUvBxi+Zs8ET/PDCEgmIFJfaKO4YXg0mvErT7WAE1KjaZgUOmBxFuKQAvk1t9XREWGQ6pvlGgcjZlwOKe9vgFy@vger.kernel.org
X-Gm-Message-State: AFuF++lIb9taluAOndVeJqHeD2sdyR4B0En7Evunk8fa0tlk07zFKrC6
	ohp2wXuVdPr3khrqTBPtCJdlwa7+787o/E1v45IiGSoYyJ5lNO6NipQkVEEPqS09mejT23530Yc
	xolCsUQQw3KFEYXxt5wsdGLjnS6Boj8+2xi9XqWc6
X-Gm-Gg: AYBFou1kBTbeZHtMsRdtDNpzB6/17wJvTJmkiKRBtrqNz93DzNYkR20SkGGSpcQ5cJs
	ggoLaY5GRo6GU0kttRkSkBLCREEgpM6Z15I6DJeSpxkPBbxB5qr/pXf3RcFS7HsTflASn/dZZ7k
	Phh5rqgeXPlDdv76MN2M+DVvJFG6xiDQ/4TKfW2tsACYddYYYT/CQz7s8F6b4TM4Susexai1RO8
	remPivCC/hIbhYQr0ythr78zJyn3zNwMZKyusdrIw0W7dzBX7aXDqYbRIvnyWAGvQRVW8hOEX7A
	WRnxwJMGmXxnh/93bxp1FhPUC5U/YwrQ7ETx7Zh2ytIU80t9JNRWwWpN38AMlKy6fCEnkFRwoiu
	y61Klsj571JS5svLSBhBJSF/t2do2azYK+OgMifj9
X-Received: by 2002:a17:903:1968:b0:2d5:db38:8013 with SMTP id
 d9443c01a7336-2db290965e6mr11954785ad.18.1788816666098; Mon, 07 Sep 2026
 14:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f5e8166a-88be-46c5-8939-1e5227ffe4c2@app.fastmail.com> <CAG48ez3AYt=dYMYLEEhkrzO740wNsD1_3zZbKqo7MXThqEA+Zg@mail.gmail.com>
In-Reply-To: <CAG48ez3AYt=dYMYLEEhkrzO740wNsD1_3zZbKqo7MXThqEA+Zg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 7 Sep 2026 23:30:28 +0200
X-Gm-Features: AcwNN1W46hwdEyXvSweES1CZaIcz1YKihPPLWsHsVoGKqpFlrMy2I4FtskUerj0
Message-ID: <CAG48ez1n=BKDVJB2j-bcSLe_AwWsFkhOwpomaJpqPWaqzQemLQ@mail.gmail.com>
Subject: Re: deadlock from exec_update_lock and reading procfs
To: Benjamin Peterson <benjamin@locrian.net>, regressions@lists.linux.dev
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Arjan van de Ven <arjan@linux.intel.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Jake Edge <jake@lwn.net>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:04=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> On Tue, Sep 1, 2026 at 4:50=E2=80=AFPM Benjamin Peterson <benjamin@locria=
n.net> wrote:
> > After receiving a kernel with 6650527444da ("proc: protect ptrace_may_a=
ccess() with exec_update_lock (part 1)"), we encountered a new deadlock in =
a FUSE server. The FUSE server reads /proc/PID/stat in the file flush callb=
ack, where PID is the pid of flushing process. This can deadlock in exec_up=
date_lock acquisition when the flushing process is closing O_CLOEXEC files.
>
> Ugh, sorry about that.
>
> #regzbot ^introduced:  6650527444da

This should resolve the issue:
https://lore.kernel.org/r/20260907-cloexec-before-exec-update-lock-v1-1-801=
8c201a7df@google.com

If you can easily test the fix on an affected system, it would be nice
if you could give feedback about whether the fix works for you on that
thread.
