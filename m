Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3FA30F543
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2026 15:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777649856; cv=pass; b=YLyuBNbNbsul25qIZKL83EFoSjtZB5rFdKyvI2zsWfhZEztbzekt1cjDfmyPC42HRr0lcIFToFzLg7dY5gOEMtfnlayBBluLW+IeuN9/NACThVnEvB4/BmLw+pZB3XM6pgl6dqLE9CqtN22ZEoLprb5fSyLjIAUiCsYnlVtftRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777649856; c=relaxed/simple;
	bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+2Bb2BJzGIE03cHq1zrDs5oJIwtEKuo9Gvwnfbm8FIf7AO6gdVXUN8ED01ud9VFEuj+hdAf9fqkVxaXms7WRSErhU+jbyao2puCzTcZYF9JzYDdgcwEorKnCg+i2EgIw8vtjM4/rnfDJJDpRLyR7YyJzJfNuW+mUW8/wGdA3Pk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXEE6EtR; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXEE6EtR"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5b55062fso13486451cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2026 08:37:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777649854; cv=none;
        d=google.com; s=arc-20240605;
        b=NcSbTzq+Semzejm0Kkn4I99tY7olDe4c17yxViqTGflUSkShSU/+cHmMa/g03zJU1X
         4KTQO0E9LrZKcdLLkXHKhGjmZaSJa7PTGwtw1tWaIXmFqW7UQ7DcwAskhC0Hqei+8ltl
         UkUykRud9T4jUV9VLex7i0VEnUYSdvcdulQyB1CkvPBDo26cxxt5xZGNtoGVU96AhjiN
         +zp6xpA/9dbsuQhUM1MBv936Hk9NP1coYrngJzK7s+zapqNnXgrRKTlo3AYXtrH7K1Bp
         d+ngH7agkHfjlc5Ql5vPuxR6sNC+odBM0Tet3KNgqGGAUk2wObkGY5076m4C6/lRo+rt
         uisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        fh=J6MWnnEDByIPOl1XdLEqTyYydg4nA9EylGRKY+dFFbQ=;
        b=ZMP0uoEAbfpLJ+8IY3O4eskuBnFCwj/acdvLqchxpVRRhZPT3Pf8ZkgMG1biEUGzc8
         mYyEP1jn/87xyhomT8ibildBB387diom5yXRluDeL2O4iWHT1l4d5EAspxIt9fyoek90
         L21F4T0usuXBqYk9TpQei1AkDAJhhC1SgUdxXpe/lC3T6nhn5l1vdmk3l7NTckzFpO2E
         49Pbw+8RNFQcyJQyo8ya9nKjnqSldQsFnMqMM6+Sf1vV7XQJshwnhPmKJP36l3YPSmdN
         FwobaUut9Wqf3Sc/scjXkvyO10S2Fs4cYy9+RaEXWbS/FwzCF09f/EAucvPAVSWnxQUE
         T8mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777649854; x=1778254654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        b=FXEE6EtREwYj4KAs1LNIJ1N/UwhJG0PZ7wgEEEvZ7H/ieYXQqZE9B91k20MCTkHwVb
         nrq4yqaZCSvDix9tSJwSVgyjiadaEIGkN91qw3HS/EyVzEKX1gdqbRETmnLar8ldIJ4W
         js244wvNIEnkSWXNcCtdTou86m3rrW74e2r5WC3aikTzH+ObvLrnwStoce5evLSlgRrk
         aR/I/3s2Onm0sFaIQao7dUpCW03Vgjg/FJQLV/RYlt6ZtXvsVj/uKHi3As/5O/eoD+Xy
         aQFqsCfAN1hqAzkp6xDsKuvfOnu9699HEjlQu6Q8PdL7RVTrP1tMLfRDPLUgfjunJ0Ah
         GiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777649854; x=1778254654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmZOkd4LjdDYloHzxeaTkn/dgtYW8v+Yk+8UEv1tCuM=;
        b=DiO0z/J9/28KsDvJWz92yHvVTtenEVdXtiHrvGcOUma1HUwzD1gtGm7A/9nKPq+yhD
         faE81knPs76oRQHXeaH2H70/h4iJFihifOwjyVHf10AtQP4XTMx76QWsyHkVbqxPNORR
         vdUcVyrdgQ0A1xt2uDIvNHY/ny79D3QKbr00WX64z1JfGICwP4QI2ucb+vFtakDbK9Kj
         +Qfju984ANMQuEhOY3km/KWpY1986bu+bAh/qD4UH4ruZrvvbmZyfNZh1obrMmnHqxGC
         1B5NIksPVXSUQniayDlpMPuUa0fGagktZ2txzD6TsnDMKW1y2Apk0lS4KTocAPi8sxRB
         Wn9A==
X-Forwarded-Encrypted: i=1; AFNElJ9MAJa1mOSpPah15GZIVSZ4N32NQI2vkmvVR5iC8KKL622g3a9Feo+LETW0K9MJ5hQBKhtlLJv/c80i3G7p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy13tc7uLxj5vPHmB9cewKJQw+bFsVyp+dOIwZMtaDcu0kDB6IL
	Z0Q1JZsFak/9GAZC7F5IY2s/4lvCN1XkkgpPM2LLK1ZF0qFnmGJNNy4bnfDqFCWAWt5yp454JhT
	l/cpC7NZHerDWAYugesZV6+6LxkF5be4=
X-Gm-Gg: AeBDieuWeB6MG0RRDZXmU/NunAtmPzP3+titI9G03NfFfM0S7CuwwpxxzUkBm0CGTY1
	XzpsEtbVeJzZp+3Y1s1boleyacTBmRpuqHbhSaxnx7qwtTMkFMUXpNLTYDew7FpsT52zaQHWPo6
	nd+wlxDWZg+SwY1fw0b+NpUjWdCSygwe03cnIOXzAe+QCui5xKG6Kd+kQ4dC1k10A7v8q8L839D
	6qd9n7cOU9ilo4YDt9VZyT6/Q8yMVnd+zv7XW+I7GR6zpvymQKEBcuO99GEbpHwsaofQfXh2/9E
	Yut4fCfrI3yN52ufYPQDg/MBTX8ks9U0PfZGuvUcl7Sg1QydJOMVcQRKwvn40Q==
X-Received: by 2002:a05:622a:1390:b0:50d:86d9:4c24 with SMTP id
 d75a77b69052e-5103e801278mr51004741cf.12.1777649853785; Fri, 01 May 2026
 08:37:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com> <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
 <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com>
 <afCUADdbNrpbEPMa@google.com> <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
In-Reply-To: <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Fri, 1 May 2026 11:37:22 -0400
X-Gm-Features: AVHnY4LLx68NFbw4R6d2DByeiT2ksgjJ8FlMA2rRsoOrBqjrTHhEtUSBsgoGVxM
Message-ID: <CAEXv5_jkPwf1EGCd3OkCzsnL_dF8fF=x-RNKSuvNZn24Ns5erg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

> >
> > > Even if we wanted to ensure argument provenance was stuff loaded from
> > > context, the right solution would be some kfunc flag that constraints
> > > the argument to be derived by following the ctx pointer, not whatever
> > > is done in this patch.
> >
> > OK, so it is provenance-like tracking which you were initially kinda
> > alluding to here. Currently, I don't believe that PTR_TO_CTX is
> > preserved upon any subsequent R1 (ctx) dereferences, so we'd need to
> > think about how this type could be preserved such that we can enforce
> > this kinda constraint (__ctx) at the time which the new BPF kfunc is
> > called. Do you have any ideas on how to do this?
>
> I think we'll have to track in the register whether the PTR_TO_BTF_ID
> came from a PTR_TO_CTX load. That said, I still prefer changing the
> prototype to pack the array and its output size parameter together. It
> is even clearer to have a well named type than int *xattr_count in the
> prototype.

Thanks for your feedback, sorry I've been busy this week. I will send
v2 with this change, as well as Matt's suggested change for guarding
the bpf xattr namespace.
