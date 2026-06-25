Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB023E867A
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403968; cv=pass; b=TRbiM5F+Mv8s229DtMmVSN3EAMNTFVFyaZRLtZav2Q8nwN46hUkCEqpzgO0r+Mq2CEDrgNDvoVeskAumFqpjomOtezCDA8nUmUHXSTwpBJrWt7c7AOw6+fcL7nx0FGjfPpu+2imiEh2piUAhA+OfyMtE24yD7fJTk9r+5/u1poo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403968; c=relaxed/simple;
	bh=eXt9ABDO783EWacDInE1oNiBLyj1Dhw+23oyO0+eAgc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WicJIjoczeHlHITi9RWNfeZyk7bCh7QQRcvQRl3YKegUrNTe0zQgPQGmqpg83RH7anodallQx2jBp7+r0tRFyDgfjga+fWoj/AS3wLsDjFCZ/jkAilX3Yyim5lqaD3JNVFdIm7DAWvD4X59isPM067XyGe0W5T6+UL0a3Nn0Xkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f4DMGztG; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f4DMGztG"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4624c1409c9so2043605f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 09:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782403964; cv=none;
        d=google.com; s=arc-20260327;
        b=bDZIAQB3X6JEK43JrwJJgUHzoY5dK4pfk8v5PmmMPHzzI6hz7uImeX4VX8PoW0GJm5
         3UFEfMIQLWegZ0ao+0M7OCHdJbuEe87/JXjCZdnLNaq1PVMiWj+lYiNu2XZGGX07RaBr
         C/FsBBNqcgD3YFlKarusGsKIfYsnPSNLHe8DEg0vr8FejnvA5BI1BR4b67nhcD9cA2MC
         +5+zCpg2zOGM0clrZ3dG0/bLy7z0itgToQmuEjHU4aUSf6onKDxffdvV0Huc95yy6Hne
         kcBaMZwbB3wSUSCkMt1WFnUHzq70vyiVx11pQ+Fz9hstt5gX4dU+Y6WEd8E0tcFcoqpN
         2PAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CUBIaAU4SjeKQvA50OYn7Uvq2LX5djfRwg5zsqpr3iA=;
        fh=/t9C0i4/A0cPMPAFtQqzdpmmVqqbswhUSqnRT57Z4ZA=;
        b=p2KHPzKq26cL140fJooSS0KLSpjaoSrNCluCBUsUnqQzCOQGoskr/C23VKwNXI1uuf
         TcgqwzH1Xr4UBmCN3NLfs93pdynZwMchBJWKyAwgacVqK6czMRTkIWzooFnge7EM3dnM
         zpEo3SIHrd39U2ids8SVabHV/I4XQ420Yd6Fredsp5591tCovf5QEDQoo9h52bHGW5r8
         j2o5uRexvg7jLzw37NEtWk/7nXGVRUydwNjbjC4Mui/njaEWI7nyrlmCTXiMIIS3kBDy
         iNQcpKxYC+/8D324QzfyLIUWxGytj6lUeW8gBhz1cQEQ9CGuiJ5/OYtnGgXv/YXmgagx
         zD7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782403964; x=1783008764; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUBIaAU4SjeKQvA50OYn7Uvq2LX5djfRwg5zsqpr3iA=;
        b=f4DMGztGMthA12Y49u2OIH/xR/gEfBSbRh+LVXv1O/l1HruR+NNt0r3m71HxstJwGX
         qkZ+sgvkP2zGpb6G7Uy7eHYVBvui3N5iq9K24cViZ8d6NJ0M797yjVtpYS7aZSHAsOLj
         xJZ5CPW8spTde0D2ScucCtwhC1MICHJwHpDD9wzxCajZcTJW49XaR0N4LL9tLJr9d5/g
         Idlll1HHleiIdznevqRuJT8bGq41lG0twhJAgG70D7yo9DSfi/TCvpHb0Dx2O19GlrSJ
         rE1266ycoNTUBlvzDfeqNHgGvtz3zsYFTPf/n4NnaUaFeF8haaUm1EKB7buGJ/nHb2AE
         xy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782403964; x=1783008764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CUBIaAU4SjeKQvA50OYn7Uvq2LX5djfRwg5zsqpr3iA=;
        b=dLv9RQHkKPnBbfo6ku74ZJS73AC/rV85rC54YCL43kA3FQlVHFZgsaUaGRuKvvnvJA
         cdZdsGdGSRx8qdPiQNbgXbYCrlGXCXrvWLRd4LkvzS9ypz2TRenN8bbCQx3APjHvkOmm
         E8uRt+Bb7Pf4Ah7Jf/vDvj9xyI1TyxcJid0fr7UybZB39CCcX9sLErSpMf+sv+dHGkkS
         zpVAiPJ8jEOvneJKlu2urSBeccEEwWRjhtMnji/zhfut1w7M2tTdfBJM+wJjmy0bQaBL
         VLEeLTZQTpj8NEuoy3O9HuSl31L93AhKXdD3JTpYTEtFKo3wSejt6/3t4tY1Wjnp2dVR
         sidQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqnh1lvMIcbCLQ9Y8MJ7cXjT7QM8saqZXoexeoVCsh2FayEg1SGAs1n8BErKGz5r4j+z2uoaaZ2jLeLQgyi@vger.kernel.org
X-Gm-Message-State: AOJu0YzGJDYZm7NE+w+haaqy8Xe9idfGCZ52wz7H5rEvsTpTlM5U6L7D
	vhr3qFT56psF88m5/heysU9PzgCc2otb2yL39mZM2bZvmY2AbFDpFsnOCjg29Ghlb6u6HSMXkj7
	W+toafHh6P6HOWzXuG8jkYrPfW8oo/uU=
X-Gm-Gg: AfdE7clPDEL+7PL5Tj0tCTEvMvDBNfd+goCZv60JOT7RCj5YAWiXIrtoS7LdaDvUXFQ
	tBfHuCNBey0FkWBCgLXSyC2QagdaBj5dJ5T1VWDweDW5qtsg7OVBnPKo+vbK16FUGKEKgeoegtu
	gZIA45koGSh+5mp+83+Cy5hN6eCMulj63qkJnT1/VvIO39Z2yEHecNespZjARdjKVu9y9/qJg6g
	JYDq7gOpTTYkl9iIQrYF7kJpdmp0toO1XTl/KQDvWXRBmdc9FZ4xignDTfpDomCnx4Npt1r6SCr
	F4Xbq1LiDrpd4pgMqkJa3J50VA42
X-Received: by 2002:adf:e011:0:20b0:46e:6210:ad4a with SMTP id
 ffacd0b85a97d-46e6210ae29mr1543499f8f.5.1782403963978; Thu, 25 Jun 2026
 09:12:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623111533.2285005-1-ptikhomirov@virtuozzo.com>
 <20260623111533.2285005-3-ptikhomirov@virtuozzo.com> <CAKEwX=OaKTfNqzwa=djLxZDeBbR1+DKdqDnxdfPfZFKB-K+ECA@mail.gmail.com>
 <c390081b-7b2e-4b83-9bca-5f93eec6a939@virtuozzo.com> <CAOQ4uxhPROaeEyYceKNsL5QVwVPkTjGtbRr1P_TYXTA0fHvRoA@mail.gmail.com>
 <CAKEwX=MedyK8aDM=oe=Hbzo77mJOEp0Pmo0u8N4HhvikosVbSw@mail.gmail.com> <aj0ku26XNT7Xc8x9@casper.infradead.org>
In-Reply-To: <aj0ku26XNT7Xc8x9@casper.infradead.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 25 Jun 2026 09:12:32 -0700
X-Gm-Features: AVVi8CclkB7MBq3wqVoG0kXa1O_Tzai8KiVnn_7BdwN2N3gQweVrg3KGSb5MSwk
Message-ID: <CAKEwX=OAg4VzZ6UA0BFOhnkz9EYNF2H1FHsEAkfFZObcbc4dFQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ovl: support cachestat() syscall on overlayfs files
To: Matthew Wilcox <willy@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shuah Khan <shuah@kernel.org>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 5:53=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Jun 24, 2026 at 12:06:54PM -0700, Nhat Pham wrote:
> > I'm more concerned with undocumented/unexpected behavior (error type
> > in this case). -EIO was an example that I saw in ovl_real_file()
> > itself, but I'm not familiar enough with overlayfs to know if that's
> > the extent of it.
> >
> > But I'm OK with just updating the documentation with a simple note
> > that other error maybe propagated from the underlying fs, if no one
> > else thinks it's a problem :)
>
> That's ALWAYS true.  POSIX even says so explicitly in section 2.3:
>
>   Implementations may support additional errors not included in this list=
,
>   may generate errors included in this list under circumstances other
>   than those described here, or may contain extensions or limitations
>   that prevent some errors from occurring.
>
> We don't generally bother to document that pretty much every syscall may
> return -ENOMEM if it can't allocate memory.  That's just ... expected.
> open(2) documents the possibility, but read(2) doesn't.  I think it's
> the same for EIO.  Any operation which accesses storage can return -EIO.

Ah I see! Admittedly, I'm not aware with this POSIX detail. Thanks for
the clarifications and pointers, Matthew!

In that case, I have no further comments on this patch, and defer to
overlayfs and fs folks for FS-specific correctness.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
