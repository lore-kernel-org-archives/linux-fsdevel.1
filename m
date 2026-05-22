Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA3E23D281
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779412963; cv=pass; b=WJoQfeBdM8p2QXsSc79fKHOJeDyWUinx9SmuuBqEGRshkg8Ssf1uWyhrvAr8hwvtBN9jd+N770fX9EC+IgSB7HuT5oK7xUlzjezucmpjBicu+ez/MZMHOkNf4GvdB3KhCCG0sgKNaGWY4VL+JTM2oQyTMa38qq7SyDATBRImz+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779412963; c=relaxed/simple;
	bh=hf8aD+CTNM5WaJGZYxWH0QhWtVHrzHkL2z+jbOQkmRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlGQOPR/8DWor1nMr2sY4uaiUaaYsVR4uBgTiXEpSKUmZxwd2NNaT5I6THaer7ZX+DtYvCmVXl9XBtV2s4Fe2604S1lIx/blPCHKkrnPTYTjXjCsEG34lZjtnAhJTwsz+C8m8KCF/luG44FnmiWMX6pt/FjGSIfhU7tbH+Rz5mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3D1hIki; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3D1hIki"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65e4f6103cbso423809d50.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 18:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779412961; cv=none;
        d=google.com; s=arc-20240605;
        b=feniIt1Vu6prJKkv7YuJzwikzHw4aZIAWGgZpjmBCNJBQC/LsNFcIcs1SKE7XfCQ91
         2C6UR2stbZd/UuEA5/YXvS6jRuroSuqqUi/SAfFL6lw30bPLW5FAhOx6nKmtYOYIQMDY
         ocSoFiCX3vwleVBbAT/DxEqOsQHN4AUoj7Pfn/CSY8BotF04rnReU1uwlAOr4wocoNOy
         cfiMBLaa2WL3LFMkyY9XK2ysagKE1hh2dImoiIySBa+6L20DbNxHaUTG7dBPXa+whuqC
         rhfUFRM6ibJvxPINTZik20m/d1fCqTPLpO2oxGo9ZNpMrCA+eFglqua/VF3IKdgnbiRg
         xerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yTrKm0i2sPrOyuruFAbMa66ajkPaWi46kgfWjrtyQXg=;
        fh=XSLonaludvZ4gsNMlPDM50QbLhat5/F831mlE+2iBO0=;
        b=kSbqCGhnwxBGWGSjwU8/VypplTdNLackmnFl2EvqwVjTPpo1ikA/7kDd8Bjwh40USe
         PNBIOLGkTes/BNsCL7xHcGL6YMBvPAo3XzS7txqXs3OQtbw+n5s0tWrwwuGG6O5rObuX
         BwWM8K8E34igLmB3nD6mbwIMF+eS6dxTGcY4T1qeL16o9Sf0NpyNg1H+KAUNqg8Ohx86
         Ijk7UcZCDHH2N7pyC9szU7kgf8eitjVx9u30aiOpGlVDizApdfcagx8He2oWiR3TTlOc
         iLry5UT0YA4Qsa1k4FmRAz/+PiX/Kn/N7lajC2eot/p9XRbwyoaUfsY0mOBcOO4PcZw5
         G5cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779412961; x=1780017761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTrKm0i2sPrOyuruFAbMa66ajkPaWi46kgfWjrtyQXg=;
        b=K3D1hIkifzLocgugxKn6XJOPHWhuYR4Y06CwQTSVJxJG+Vj57/GKs6gAx7lYQe85vP
         ISniJdpgXT8uNZl1TvDPol30EMqXnLUrtflqdErM/bvtsj/+AtBLVnbtDsdaKuEh7uEK
         6WhvYfefMz8pyPU5augrqNjXXdfExuhw8y92x/pvbWeuOsxjzXG8BHxt1QRzu8epWX/A
         BHpWVCXyrOWiv7Sp+1dFUAyVda2jb7pLHZd2LGBzDCxPLETCl06ct0i+K9F95zOZdsix
         7iv9LU27uZ8yEd6ia93qQd97Dk66skZX+/rXA+ckMwOH/JWT92unDyAnfvD29cavUhO4
         GSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779412961; x=1780017761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yTrKm0i2sPrOyuruFAbMa66ajkPaWi46kgfWjrtyQXg=;
        b=kDmJCh1f+0wf+jXqBnLQd+cjfchFutwZPivY8nVt2zfilCEl49GZV0bAMUxEoOaU5s
         cg9Ua2/8yFIeI+QQvUM3BzINFm1uEDpj49YVo/ZDfRkf8MCWMSQ6SzlDnSWmk1w6bexC
         N83dbDkJl1asRO9X7bnUiEL6nRRIFZ6rxGHUBT7jrYV3ewl1xZ5OBQYCcKGEbD2X6/UR
         5zmk2pfWFFz5Bccrxnd7xfS2IQ0EBjFgncqoQHepNIfOvttu8vUpyGl5cdAV+U5emWjM
         tF3rFbNckKX7Ej4xklKlycxYWanTVUqmrSJnmapfqTp7DiMvnP8CAso1rrOYkPhJlNac
         a3zw==
X-Forwarded-Encrypted: i=1; AFNElJ/Kq9kDXb01pBmCQtSY0bbfP99itTMP+yPwGBSqwOqu7MSXEMfbqcugczFa4/sWIjH2/WYG6C9778LKo7xg@vger.kernel.org
X-Gm-Message-State: AOJu0YxBvdhCej8v0CohJSSbkaF0PN7TM5PozXnnrF0C+fn6bsDmz+ga
	Onq/6ibq/s8bBXgRpi40+j5kGJM9o+2zI6fmQdIKQZf9J3w44/LXHz7xqpWA0KEWdIf+r0y/MV0
	VtzjP3ExvjDYsZzmgsOBr1h0W3Rx4HZU=
X-Gm-Gg: Acq92OEOvaH4V6JTaSWBx+ErTORUpK8BXoftJ/Z5NsmncxYPcIEMnxNd6wtabIMfXMh
	tHdWgYKLf8ud3KPJ4/6MAQSowTSVOPd6Wy93zknvumw6HDt/UDPG5t8mgieUTPBccBAlSYUVaq5
	RMLgYvIUuQtz8PUkiUKCuw1/0SuIDu0dpBZ+CwYUMkL10QhXCHpLwhBeuVSU3DeL6++U03JusvS
	lwl1bukMtNQGs7Myo/PJ5guAxb0bTnrZ/ZmV9Hwup6fYgBwOOKw27BM3eklrYcSE+3RTAo8kyyA
	TJ8JyXvgnFF7niEyhn37ZiVxZzkFZSPd9IHt5/cq
X-Received: by 2002:a53:ac9b:0:b0:651:bdff:db07 with SMTP id
 956f58d0204a3-65ec99ca005mr1256274d50.7.1779412961468; Thu, 21 May 2026
 18:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520170151.4115308-1-charsyam@gmail.com> <20260521101751.591345-1-charsyam@gmail.com>
 <20260521101751.591345-3-charsyam@gmail.com> <CANFS6bYVMzKP2uBV=-XMJ4JHyoBNfzqHDAteZ_8gj4t_C3e7xg@mail.gmail.com>
 <CAKYAXd8QvChDOkXobpo+1iA4TW9jpLW1sCw8zOFaqS2UsFWLkg@mail.gmail.com>
In-Reply-To: <CAKYAXd8QvChDOkXobpo+1iA4TW9jpLW1sCw8zOFaqS2UsFWLkg@mail.gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Fri, 22 May 2026 10:22:29 +0900
X-Gm-Features: AVHnY4JuyBVcepl4CcwMjZ-nbmxp5-c0THc311rBPLcrspV6wY60s4DEOoPok1U
Message-ID: <CAMrLSE49sUi=BodYybCJ4rvzf--9VLF8N__ESZwE2hUGHT31Rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ntfs: avoid heap allocation for free-cluster
 readahead state
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the clarification.
I will rebase it onto ntfs-next and resend.

2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:28, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > >          * Convert the number of bits into bytes rounded up, then con=
vert into
> > > @@ -1985,7 +1981,7 @@ s64 get_nr_free_clusters(struct ntfs_volume *vo=
l)
> > >                  * Get folio from page cache, getting it from backing=
 store
> > >                  * if necessary, and increment the use count.
> > >                  */
> > > -               folio =3D ntfs_get_locked_folio(mapping, index, max_i=
ndex, ra);
> > > +               folio =3D ntfs_get_locked_folio(mapping, index, max_i=
ndex, &ra);
> >
> > This line modifies the __get_nr_free_mft_records function, not the
> > get_nr_free_clusters function.
> > Therefore the patch needs to be rebased on ntfs-next branch at
> > git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git.
> We can change__get_nr_free_mft_records() in the same way as
> get_nr_free_clusters().
