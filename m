Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A723859EF
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429417; cv=none; b=ni2NszwymTBykNVmM12Pa1Ppub6/E+yS5XqhS+S90/kxDip2yn4e6IaSHgpd0UG1YgBMb5UbPZMx0Vp11jCSME0Txav4BSqE5gnjjgeO9XYW+g3bPMtSVR7+fS3tfRDrp3xb8uLHAU33fyINRB+usv0aPleHF5N7WvbaGgSAPd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429417; c=relaxed/simple;
	bh=p0/z5/vKgpWuODVZDg2GMYm3qZvaKvu5WtLgAINXr4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNzn+UbjYRMf1JgSZg3L30EidJrX8rgEwGfmBo3FtHt0Fl8FsDOxiyIi2DnzV+0fmjTCUYdczqKUSyBVLS9NKzR1wQeKB70ou2AmcOVINdSG+IDLMCyr7yedhc6IRdLIvN1+7tCtLzz3LDCrD9J75R/jPgcxwnH7ICve5bbl1mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dX/3VGIy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dX/3VGIy"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c167aa9500dso312652466b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785429413; x=1786034213; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+pRs1V9SE4B3gxS7ytnfpQktSDKoQYwBV7VfFfoFRTY=;
        b=dX/3VGIykjfFd2uV3S32jwcxL5i5mczs6lKc43isRWbG5pqQJskdy/kqeHCWuzdUv/
         Vly2CQ0g2FmUKyOVxEu1PlEpO/5VwtC8gtgRDAPu8zSoYytlKUNbDwzzb8/ZsfvhWOk+
         9RQWPTOFCVR0wfJgeYS9g7LNqLa6Fz41KTuOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429413; x=1786034213;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+pRs1V9SE4B3gxS7ytnfpQktSDKoQYwBV7VfFfoFRTY=;
        b=OnOeCbcFEPUWNi8sOJTMfoWY2odjk3e6zokHYuItX9rGD08dNB+FXr71LZbM898Qc6
         ZNut1ixjoEBNTqZnZAYiukwq5Sm8sCWMSm0KzK3aXliX3C6TBh4E3SWC6Hto0LhsoEgJ
         LUHcFXmhroHdAQvUAAM9C3+HBfVWGszJtr6LJKLygEcoHM7/1KT7kLZJ6Nz644hwin9n
         USIteonUvtAgug5+9Xh2gvgyN/d4eygbFzS2F8bpTPyhHcsrhWQcgpX52BirkkmumOgJ
         A/tSc9SOsDZF9v25iAsb11CiJYyH/RipmvFoAs26V3nTey+LEsS252F2/N70GLMteT1V
         4P8w==
X-Forwarded-Encrypted: i=1; AHgh+RrCewkYAp2Yru1geOuPYC8u+gx/IkcbmW4kyGiRF6nP6JQbRmdZMzqDyGsehVLBDLiep1hilHsnm9+I7qYG@vger.kernel.org
X-Gm-Message-State: AOJu0YxrVz4YhB8hML4NukO2me9gLUUzunr8oCBE+Wn1b4GdAXjl01mk
	Qwi32kl8UqbLNK5YsXgfAE0F1nVgCVcnfqRGW8jc3qf97yav7jEiZGtknqLmtfzWsvUL7JHQIFt
	+R6L9EmA=
X-Gm-Gg: AR+sD12RVBMca+O/ZAS73EeEDbjFwTIpvu+thkHkhCcsA3QM4NMMfuyWxnfamWLVqK+
	v1sxkkww1fZQLYfRXCgJaoMWL4nLzO3W0c7NHCKG0N3h7wtEND+cCc1NkU2iDd1wYIWDIXo+hka
	YSvalzWFyep28/Wbb6AD0J4o3070Qybw5s/HmW1AhmxWnXaJCH2JTcTEMPw1EXc2R/TIzurTohh
	t3gThgZIahldkeapssL0WzQcjBte3NN39r3qIX79qpCstsBKaKUFenUhkQA/1X+TnbC9vV3Irjc
	qASKSTU43S+Hj/7B88dxGuOS3hkbLTW6DK9KSLcM3N/qp3C9Q5Qq8AVrkGqybkTZyhqfiMe3Xk5
	qqVFpxgOEWJ3b/tl65BQjWOP0hTZmSGhF+B9FiSP57J4ns7MtkAeq1Z1CtKy64UZODupTg+xia3
	YSw3eJB+2Ai4o8L+gUgVC1MJEct3046djTxPPR3iMmFmL08biNtgvlkBldodUbtZ+zGGdugGLIy
	WNcg4TfcC6hF/dCuEJvttI6hPAPWOp+qn61UYDOyR1PFG4p3btgqRqnAToT
X-Received: by 2002:a17:907:c13:b0:c1c:4fce:6518 with SMTP id a640c23a62f3a-c1fbca7b02cmr72137566b.24.1785429413578;
        Thu, 30 Jul 2026 09:36:53 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a07cb79672sm961724a12.13.2026.07.30.09.36.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:36:52 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso282221566b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:36:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro49kEUW81KZhh60mS83PLHPz1t/Mz/97wORleq7d/r162SDffMlXcVQyetb9gs5UEW2vhsacDByc7brCSn@vger.kernel.org
X-Received: by 2002:a17:906:fe46:b0:c15:abe2:e1df with SMTP id
 a640c23a62f3a-c1fbcba971cmr78194966b.43.1785429411650; Thu, 30 Jul 2026
 09:36:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amtbpwrhlNGJ9OK6@redhat.com>
In-Reply-To: <amtbpwrhlNGJ9OK6@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jul 2026 09:36:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
X-Gm-Features: AUfX_mzy442nCbl6DY_JVeWofFI0DxIj9F6qbkbC9XQHAttzTgn3vgqCFq2lWPU
Message-ID: <CAHk-=wi7EccGaeo2Q5mdcvcQJ8VX7tcJWW2fHkg6vfmHGGX8AA@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] pipe: only enable the extra wake_up(rd_wait) for
 edge-triggered consumers
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 at 07:12, Oleg Nesterov <oleg@redhat.com> wrote:
>
> Let me repeat, I do not think this patch can improve performance. In fact
> I only hope that none of (micro)benchmarks will suffer, they are often
> very sensitive to any changes in pipe.c

I like this patch mostly for the renaming, not because I think it
matters. I think "poll usage" was a mistake in naming and doesn't
explain the issue. That said, I'd go even further, and make it clear
that it's not about "poll" itself - which is fine, it's about "epoll",
which has that broken crazy bug where it calls something "edge
triggered" but then actually wants effectively level-triggered
behavior - wakeups when nothing actually changed, which is the
*opposite* of an edge.

Pure garbage.

So the real name should be something like "epoll_pseudo_edgetrigger".
Because "et" isn't really helpful either.

             Linus
