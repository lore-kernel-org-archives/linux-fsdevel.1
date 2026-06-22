Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D854342CB3
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 17:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782151064; cv=pass; b=uSN3N+juWW0MAXULlUBm/FSCMd1Gc/fcuTWYx1ppNZuw4bTgOzpXctE1UFTuKS6h5x+IVYiRaQ3LyT3q1OB+OqIrF3FpkZSYOqAi1+GYNVRKP+ys3BqkqxFsa4zpTIHwUKyiHuOxrkR1RotuxzKZdhFxPaBojFrJoIPGSVWYQk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782151064; c=relaxed/simple;
	bh=JRRQfOPr+epFbIXl0oYYxG05263MwT5wCocJYQAfxPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=djx256QM0Jj/CktBQy7Eu9p47tvtoNBEV5dxp6ScR0IMiCE/Uzpq/feV8vWO/uTb8yekq8lNNpUXvfpzPDVKvm6qctTT79R/8+JFp52i069EO4JxjD9pztIeMR1ICgbcce/nazjroWBtFL2P8z/47YUCn1NrT267lRvNXM3PmCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufRPggfr; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufRPggfr"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51765531803so31501cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 10:57:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782151062; cv=none;
        d=google.com; s=arc-20260327;
        b=UHvWa+D5Y/XVvQMJGDwaOkRoteYUJ6g5bGFiDZUzLymMtBJbosLPVMDG/iQ9p/X4Oi
         5jy/OoQmVzCYUUjX2cTuXdocNKM+M3qmroZcR0SXfBjIAmxZhwHZ+bpSoAjYL16i+/SH
         y3cPoswQKnuIboawHCQ0tgvhXA3F9SPFiEDoOneu35jBOSzRlLgbBktjFvE4dq7w5C1I
         wel6WgU3WNmL2XQ95KnmYcxpFuKLCpHarN36j25vMU4MB5AI8d2pU+Fefp29Qszu7WZo
         qxqPS2WibX/fOpfhyh+2mfKViAn1oLq4oOkDIUjqkkG0OP45m4ur3TBKdHMxK3qd9aEE
         +NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWMkkw80MANt4r5YV0GD44Um7JLS7FMoaybOL0CoS30=;
        fh=C9XKEyHACCcmj3Kx+o3yCnkBAaabiKQusu4pF9OKTfw=;
        b=eEGkxJtv/qbvEnD9UOfXlLSnS32qjG1CZxmUya+M1EN7J0DsUTSgv7bbNmS3EqV3SY
         gUZhrLERCgkZifdAy9uqx/qtnD5kvK44YSmBfyRpR+ffyWSQzALpCwTg4umzXwya0zET
         kHEYgQHk/It3OIhwKhVnG8iYH3buiqQ4wYIwUDP82oATNu7QfYuNcubbKLMkcwqfUTbv
         vRL3OcHJp3+CNCz21w5Pb/m/bTWm4kLf4IW1uJf6/2LhEscWglizT46bwYPJ6zo968GJ
         RpElau3dsEHZa+/O2zAhik90IQboF19pG+mi/VOwYVWi+5bBal6G4wicp00x+7jcYBQU
         3kBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782151062; x=1782755862; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWMkkw80MANt4r5YV0GD44Um7JLS7FMoaybOL0CoS30=;
        b=ufRPggfryDrIt6uAHfHCUTCAvM35QOPfS8VQhuV2KPkEafvqf7Rms6H8FAGcxa9Jwe
         2/7NAB8QW9abEAyQIJ+4bNh8Okg4KSCb3jdyZCb7o7Ov19kXizZOWC95aLMZeP0H7UYB
         tpxCxfKzCpdL9WGWwT0YTz3WrJR4ijM0vttABXJeZ7dCjW84nhJuBDjEVnAb2fJSeRhW
         XZzVeMNO/O0oan9ZwmQgs/QID0nehXpqUO+0TihilBtwVvdXzL2aDrKAUm6hCab0of5u
         HvcLlxkrYP8ph/vAAlwcmbZKt8VmnxwUiOsdHRMjX1NaQcRkjlPneChhQXBCqVGJekWb
         nW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782151062; x=1782755862;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWMkkw80MANt4r5YV0GD44Um7JLS7FMoaybOL0CoS30=;
        b=sDl96kSsggop1IM0fZj7Tuxr/25Xp0h1oYjmzPqhv7nR1fhu3paE2qYRDzSMlQcDVT
         yoNdOKQ3FnpI3voAjNFIhJUXs6G/fOD7c5mmwJk6IHVH6LlIofrD+ZW6R5Rm8JlyDFde
         agq8umJWj+f11H5UORN7jNbKqaI7Yas31B8zJH3z5ny5oGo6IrdNAmaIbIhjaE3/eqQ2
         v/L5iM0x6BfkIc9xLPEsIOsaQh942BqlTCnrJmEC5wWwhtQzOPu5Do8kJmfB3scDpZsU
         Qd2cpsfQXSGEHsAVPdEMx4gdQmOcj6JjC+4CRw0JMI2/h6LJsbZxkdnGpobQFlbYG8eg
         enhA==
X-Forwarded-Encrypted: i=1; AFNElJ+vEqRLd6FgrQnby6BmVOG0huX0XOvpv56xsd+ox94Hw6vIt5SiQX/k7RXYZh4/yC9FHCO4jvvtmcbihZa+@vger.kernel.org
X-Gm-Message-State: AOJu0YxflLOu1CXf3iLSdPsW+qclOGyyrcQPbS27BctwHyWldbCpAnIn
	g+vzRfIAgoqcWO6ys2CrbKtrujK87pCCLaeuLMlhQrqr/Sygr6qKu4ItF8HMHg8uoFf4n7DMXta
	n3Y8KqHAtzpjDB2Ywdd/hvuXDMFaxXQe9ulA07zcQ
X-Gm-Gg: AfdE7cln5qvHWXSIS1Fn1qriviWcozrwsJBn0oOp8BDPgBvOVAfxAvfELJpfaVOdPwx
	vXZXtTou6dkxdLvdfsrK5AMiFlwxbf/j7ck6JM6ODcKDfQQG3FcHHk8ABPWr+li8wm/Y0st5tOU
	4ei1GziW4bI1HJGTLLwRytVqKWeGBgv1wxmswZxjcx6hfMCJt7HpOOPhqKud0b+DhJCpM3VqvE3
	WAZb5boflbqM4EBJz7d3DxQ+TKC+6EZh/+RMfX1n8V0R0STJiJZrI8w6uUBFvIPQm0tJK8=
X-Received: by 2002:ac8:7f0b:0:b0:517:99ea:ab77 with SMTP id
 d75a77b69052e-51a526f3a5dmr378051cf.23.1782151061635; Mon, 22 Jun 2026
 10:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ajV0TbwEyaKMzoa6@lucifer> <ajV49Fyogfa6aIjy@pedro-suse>
 <CAJuCfpGdxsPDbxOwQFdY+Xt7mZGFvoKWmed6FteTongvFgjgww@mail.gmail.com>
 <ajWAYBXHJniJAO4u@casper.infradead.org> <CAJuCfpHF1qtpHZQzLmLi7xz06OWgBfduHqBHF_-0Vkx7OtBmcw@mail.gmail.com>
 <ajWXEn7gECvgG7F5@pedro-suse.lan> <CAJuCfpFfr_SQ4ZDFojOkDKWbO2dKdL3pUPA06B2ZC-usUnYRgA@mail.gmail.com>
 <7ftrqtta2bw2xxtrzelrs46t7khr7tf2vmh2ur2mhdphtymlsr@rqbd3pfjxdp7>
 <ajk-NMghY50F6Sli@lucifer> <20260622095855.50e4276e331cb2d01db7183a@linux-foundation.org>
 <ajlsum91zeh-oRz6@casper.infradead.org>
In-Reply-To: <ajlsum91zeh-oRz6@casper.infradead.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Jun 2026 10:57:30 -0700
X-Gm-Features: AVVi8CfXgyRAyliFo4Za0NRqWcCus8s-Epc8nE_M6ZH607LHMdm7JUR2m8-lFu0
Message-ID: <CAJuCfpHaBFtgAyE4jum-=p3u8X3STi3e6i6==fQR+0ksaU2wwA@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixses] Revert "mm: limit filemap_fault readahead to
 VMA boundaries"
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, Jan Kara <jack@suse.cz>, 
	Pedro Falcato <pfalcato@suse.de>, Frederick Mayle <fmayle@google.com>, 
	Kalesh Singh <kaleshsingh@google.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 10:11=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Mon, Jun 22, 2026 at 09:58:55AM -0700, Andrew Morton wrote:
> > > > much as I personally find restricting mmap readahead to a VMA a sen=
sible
> > > > thing to do). We just need to figure out how to improve the Android
> > > > usecase.
> >
> > Would a helpful heuristic be to do what 7b32f64bc512 is doing, but only
> > if PROT_EXEC?
>
> I was wondering the same thing.  But I think it's right to back this out
> for now and try that after -rc1 so it gets some time soaking and
> bot-teesting.

Thanks for the suggestion! That sounds sensible to me.

>
