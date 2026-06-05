Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE69282F19
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 16:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780675597; cv=none; b=KbBqeZ5NtcTfqLzalpOAHhUisBFf9IVoWsEYAp0vcYi4tPwX+dduGME0b7RBAL5hzkHyHZ7pF+k6IkgLRQxQSMnmdMEvfrK28wN/ivFX3TGwetYBBCx/qrYWTl/w9iNQSk4vYiUUnnXjStgDuEuajVSey0ntWPHZXaoXr2kgnKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780675597; c=relaxed/simple;
	bh=cHDeiU+5q6zHW354GymA6FXFmgmlOGfgwP7cdr1ffak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yyb3EUpOCBP8Flrkh9at8njxvFGV+4oboK3oTc8Jhp9cQ1jSTMLIVkZkuq9RDcrhsCfOf4bLaCCG/eQzX2uduAkvHFxLpZTbaTRfJWgOIg7VhErGTn1rSJ5OWjI9khF6otk6uhjBleELMkMR7MEnXYNl7fERnGvZcfrBZySE8wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VdHDNQbJ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VdHDNQbJ"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bd167797dso3188176a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 09:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1780675594; x=1781280394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OUZ5QahFiUWTYdBZUTA5YwtlfS/dH2OxVTaDuMHjYEI=;
        b=VdHDNQbJQfWMdn991FegrQekea2HMTFzrHCglC/YJRiEesE6rfDcmPUPA+LtPOhqxx
         rN9IGIf0/BaLVz0cz9W7cE3Ktz4Y+aEKMouQfSzZlPinTko2pVEYTkVtuoIrUq9EqYPB
         PlZccpAgD/3vf76ZhQXUSmf7boDEk0Lrj4d6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780675594; x=1781280394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUZ5QahFiUWTYdBZUTA5YwtlfS/dH2OxVTaDuMHjYEI=;
        b=Q9i58PV0KQoN6W4xy5ZAgJw5CNaZifcY3tecqVXT0Uz67MM5vunk+GaFdxxISLv9CT
         xXjWyRuJAn+NCNoLx1i0GaUYY6XIbOieoiCqLp4RkWELie6KkLfzIbgp8BoqrIvky9RM
         8eIHm1oa7m+8QwaCUDu34irwpF479mI8PsSQUOcuKbTgG+XX1zQdf2goTa2eBydt+HrA
         skKcwGgLUGzPIDYRxcJHrYwTsln+d0HyakCjCgyP9fhBe+xvFRwZ5JEO2GthDhKJH2OB
         A5+vxS9uhNfAokkoCpO0Q5zlCF3ojXdEXyxuvZJUa94vpD3X2ZZpsfcNjmNePNw6qbEs
         ovfA==
X-Forwarded-Encrypted: i=1; AFNElJ869zWaoxZMsViKykhAHaWz8it/j8B4uYqNiHTjlJMT1mNvvXM8CiQj6ZmSulpCSgmiDxJLH3OlNwsDUCLf@vger.kernel.org
X-Gm-Message-State: AOJu0YwdtN9udlRDkQLkcCHQmkYNDz5dRr8svHpH0nHomEbSDEeKFcFp
	DBLs2Mn+s3kJO5j/WiYUCZCbti3yOpUH2QC1WAFWyOmKH7hwWh0Y91drB1kYd4L2U7B4M6xP10B
	oOyKZQ+KbMg==
X-Gm-Gg: Acq92OGmGwT0Lq8VDciMyz36ctTRyYUm2Lh8j91F3gb/ZDqXy6FSRwDRTJYewBg9qiE
	ftuHjOfIA0HDhN+G2YQf4BfPi21nGW+BlbFCWVatCHbH1TyLSXnJL4EaOSUg49Ui17l8Mtlps0K
	kHxnHP3Pc/WZDwfKhqzo8lquU69FE/Mr3KvbspFltsdYOw3uch0N42/763xD001Tcaa1WDL3ySa
	Ie1XG9Q2cqGG0rA2xEg+rcWIZdHK6CvAnUiD3E1k2hqVuqPcZ8O0HUaw3+JM9PE/iK8bOEQMDfh
	E2zBf4BQ2TeoMDfPxdqYZ7HSfC38A8RLuh7t7wWKla2KKQ47a9SjTWtnN3NptiJNzD+hM54rQN9
	grRqOKIld3B1Zc2zCAwdGa2n3RINmlKdXd8LJg76crzNWeYE9httPG3Yd3zxyqBo7n4clysf6NW
	6oT9tSLB3GTK2WQRmW95fvV3pRY6O9P7vUx7xkzpZ3olmO8EHqH4k4T3fXzWCxcUZfEhYeyjmsk
	5QfhiIIJHM=
X-Received: by 2002:a05:6402:5384:b0:689:92c0:22b0 with SMTP id 4fb4d7f45d1cf-68fa4c0fe1emr2255533a12.3.1780675594534;
        Fri, 05 Jun 2026 09:06:34 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm3953269a12.0.2026.06.05.09.06.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:06:34 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bf0170c80f7so365021766b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 09:06:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Xs3Wf6NPPZGBqeZmPNOB2YoxzWmRETHcsCvvzHUl6JGsqHGVL1O1tAMDBExaTet1mE8pK142QYOTtiTub@vger.kernel.org
X-Received: by 2002:a17:907:a03:b0:be2:dd37:facd with SMTP id
 a640c23a62f3a-bf370e6211cmr221318066b.20.1780675135190; Fri, 05 Jun 2026
 08:58:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
 <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
 <CAHk-=wh5bFj1a7eaGp9sixDg3UXu7xUGfU=YJo+ckpGxGAyhXQ@mail.gmail.com> <f1c7fbbf-5be1-48b0-8927-2d9b75a35816@samba.org>
In-Reply-To: <f1c7fbbf-5be1-48b0-8927-2d9b75a35816@samba.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Jun 2026 08:58:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whL0oLvmh3FO9SapDhgrXMT_d6qkP2V3OBjysOWXod2Og@mail.gmail.com>
X-Gm-Features: AVVi8Cf0FjZlqJePEzD8bhzCDc_NK8sni3u4Z9RMJefCrCHFLhBrwtWwfg4F_Wo
Message-ID: <CAHk-=whL0oLvmh3FO9SapDhgrXMT_d6qkP2V3OBjysOWXod2Og@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Stefan Metzmacher <metze@samba.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, 
	axboe@kernel.dk, brauner@kernel.org, david@kernel.org, dhowells@redhat.com, 
	hch@infradead.org, jack@suse.cz, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jun 2026 at 08:15, Stefan Metzmacher <metze@samba.org> wrote:
>
> It means the most common workload, e.g. a file only opened for
> file serving (or simple opens in general) would still be able to
> be optimized.

Nope. If your web server opens files with write access, I'd be
extremely surprised.

And if you don't have write access, and you're sending out data from
files you opened just for reading - the onle sane case - you hit all
the existing problems with "I can certainly look up pages, but I damn
well shouldn't pass those pages to the networking code without copying
them".

               Linus
