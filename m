Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8D36405A
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238465; cv=none; b=X6CqF5nq9wrlHE3kfOU2lona2o0dPVoPDhAlcZo2avFlG49ZU/Gzr7fVY5RvbpmpjfwP6PgXHc7E63DSzqOycKjZWq3+bxd8G1yayD8HGG4CSJ8BUhC+Xbo2S0BmSAJ8Y56T+TzdiPcTjiJuBvE9eZWUlaXh2VYSkJH0keJAwhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238465; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaO+o31EPZE1LTZfA6/c3fWiJUNo7GmrauoLi7S67EpxYT3WMR6aUK698Er+Vs2TmEPhZ9NFzysasOIzUuwZKihUh34DTUbTdNRfvl9w6qgR35InvQVW+NDI4DCum2Ym2d8bSed3mc5KQeoM/hpSwMSxJNd0zT7pBcecmcy8x8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b942b36de08so190880866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 07:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238463; x=1773843263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=Ln2YtNsgxTg0OjRuDJCCgCoszjy6ohIaF/P/TfFtHcuMxVBkyh8JiP+q6dDO31g4Yj
         EGY81BVDyGNs8dUrTPxrJip4/nV7LELrHx331MJGlyYywuLcnlKfkvWNcBLSwpOM6GNW
         U3Otx4ICVatsFu1YTLdArtc+F1GTYeaTpo9Fnm33/vwRPGaoyPNdlNuu8t0o1bx+Ktrw
         IOcEC0BRB6hXW5GjovtFyjXW+Bz4Cl+kaNlCuBI1kT+kecchI+KWoZBRe16lvJwZmziR
         pFhiCf+Uvqn/eVXnL0gPwV62RhYCNnc85F5oFe/y5DU82e24I7Jpnt9CsMaLd6FJ0RfJ
         VJKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWb7WyK4Sq2OYccMbx3qZXwbA1OTsl5vzb7mKM27pm4q7iQM1CIfnR/dPSOGU05Dh1GrKEi3P4r/lFIIEte@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp2x451c9fUuaaSn2iwCW2Q8O9jxwYG4WMctK5ZqQ0tN3lQGAB
	pH9RQ3eo0LvVz/NhQWkS3OH36MjsdF6Gv/7Ykub2pd+ENEfD85ULQbFhexyZT3elIsrO0Q==
X-Gm-Gg: ATEYQzxNXo9prLSiSXltfsDO9r7myXsCwyDpAAWtITFmk52QAHpUUUmRLA+y9ZXXEXI
	Q8z5boy0ja1dB4tzzsJrBbndZj0ADp7hUIcEZj6I3Y0yP8gAqOH4Yb/HEAwcQ7Bb2Eno7uKcrsE
	HUKpxVBjK3kPhtTP5AI1TPuo5iwoOrlNbnleCv/07pCzV6uc9ppRouSSVGhRX6omjc48dQbOLJj
	jRAA8AM0aHrpf/XcGH7J/QCRrrMWwVIqpGk/A+2ochudqlQj/4qKRDtjurCbZty5Gv2GCcs4N1U
	azn8HOA5Q40C60ow8xyfe1xELxA8gpU4QjmV2DuobDy98SBtvSDilSYLk7oyIxA9PVud6ROxOlq
	YjJb9tKpW7J13gD0O0deMqIxlMYQgzcao7go9Cgu+Nu894uKgui9B6RI4u+CaJ0tBo1GIi+HMrk
	DZC8IceHflNhBK6QwpnW98GgCzWeO6S4CS2I4vxG4b4ooteqolWe2QNDomUwPg
X-Received: by 2002:a17:907:7b95:b0:b90:b959:4c72 with SMTP id a640c23a62f3a-b972d3d4fb2mr172434366b.6.1773238462528;
        Wed, 11 Mar 2026 07:14:22 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e14aa23sm59296366b.40.2026.03.11.07.14.21
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:14:22 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66325f30570so987115a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 07:14:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW8dOW0B0w6J8/OGUkToc5kJS9i68HySXcaB2CrPSL3i3pEEHOOkMF2dAzaNqjN+qd8yy85pygfxJxQ1Wm@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
