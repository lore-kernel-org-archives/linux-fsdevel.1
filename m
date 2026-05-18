Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDBA372B56
	for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 12:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108741; cv=pass; b=V/Wx/aCvK4m036usMvriV9Fh9JJ/+MyvNAiJB9GquVfd+/lv2lpNUWjT9NlpqRoGfUr8lyo+eQk2rlwZN1rNY3N3QOcpGWXqlDp+FIywK1i2SFssMIH70mfPVYI3UkHccGawcW87VzkHnc35YtXtKovVQ1c7PIhxjO0q0iSA204=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108741; c=relaxed/simple;
	bh=QqsnQODjb1vVOQmMAFQqT/jpb6GsqIMTyoCosB3DobQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAs28krX5cSmSdx+57cz4/oljK84Inq8VZtjWTOTmlkWfTEPAw9dgTta++18OTi0S0Wd9X/kkkUkHZ8nDTNtMfLu+AMiliWy2Rj0b1cK6urWNICZGYEymX+4cY8SlRMdeUsaan3xvOzU5Ocfaq4JSiScwMFNG0br5oezOQW3x5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPG97xMT; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPG97xMT"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bd3d7c29b4dso328673066b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2026 05:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779108738; cv=none;
        d=google.com; s=arc-20240605;
        b=aYh7ok6gSGjitgeTTQtC1Gb9evVq4t+qs5Ki1Z8kH2vwFC7sx/xgHNGlPQMf13kKti
         OW+zeH5SwY7udXEZnhhlqDL1rbzA89zMOPh8HFcCLpxThsM8Tj5IJqEFDzoN7kzKVkuI
         /EXQCBDRalOiYs2tSB9spjze965Kh6DRK+KOQXU2COn4iX4R1B1TaWD0+y2VzOctHTD5
         COZLLktVDUy66lbcoIdKPQc06jPPX3llbmKRZFyb2LDOEr3FMjQQOZiuPxS0LPfwT3N3
         Hkxi45l9ecQOtzdE7fSDiZdasAf1PpxKbgQ7c6asjB+WbbQmu2G38UzPiWDJ5pigAa67
         rf9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uk0jN7fHjAJcSWGQmqxwe93wJ3rBUwrzkL1tnsgo/iY=;
        fh=iMZp/dHyT9ofe/I7qv4yuUS3dy2Vlv9GCc4W6ex+kmc=;
        b=lctw+y1Ywp7R4zrtagf/yaydSkDo0SU6IY5pyFzpKgu3Ze6XVZEgErkM2pjjj3+7q+
         YsmC521BdfWVub5psPBsjBMt3QFqYJqc14CU85bh3LMj7WZJgITRknqmuD+34wr2aoV+
         +62/JiTOexKJ7k52tKsQAPXD00EVvL4L+drB/g3Uz6UWJfXWKKn8+IA/7FjaNd6pEPzQ
         k3n2K3igTvhOjCjKxWBrw/4zSpnsxlb9Wvcxdx9Db/hD7wrUAUrAZfCsrs1j7+YQfwLS
         ke8RZWvZGD4Dnp1vqT7ASjabMs4P+BOv4CnBRhbSsZvwrWPmiIJntzZbPizszIFbK23J
         YfkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779108738; x=1779713538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uk0jN7fHjAJcSWGQmqxwe93wJ3rBUwrzkL1tnsgo/iY=;
        b=UPG97xMTPq9UQO0AsWZxb4L/3xvgBii13vovLD2cXcvO9ib1P/h+eeWNxb3jHzm5vH
         zEx4w8+yfR/MYJqZ+oVsxPaHemKLhViMYV/7T5S8Rw3zqASmgNW63ULo+Fd2ZxPW6erI
         FCCuYVCZkwfV0otduUhzLi42ApGJwwE7FeIezDJ9HpqeMDFyi1T4MoEQjnd1zBMhGFY9
         UMaL76Z+Dz4Hf54iVrtD4PQZjgEgC50l8usc5EVOlBWWMOn3dTEcWsVwfKC3DrOoOVhw
         vIbMn66Mn5zP0FNPXg/yd2ESiLrlZlMZ19MgZgmwlyg08ZzbSNgTqQ502CFdE+tCQRKh
         stLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779108738; x=1779713538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uk0jN7fHjAJcSWGQmqxwe93wJ3rBUwrzkL1tnsgo/iY=;
        b=a9dcS/+5h379sd6PRhZGF1bzbYTYJvSYZf0yc3xPh7/wKPlPW5yYjZgFArJSTQKf2q
         JEyE13G3K8mZ24IDDhds2dTFRimFhcAb3WxfVrx4M4ao09waPH0HZx50P8TmAY+K7tVl
         7BOP4/Lhk3bQUDavZaeCVaN/6YXC2Q4LMUaPwvaQ4rqQ6OKDsTXcd9K/TWs7959Bqn9H
         s58MH8/L4X3+u89pyUIsWgCykI/0j+VgGv9SUZnYBjTWFrUvnKVa4lAVNDBn9wI4eUwG
         qOkFXW7v1ISTOANT9GzRHvTKoVIZcDzKzVZ0z9mYHYbmSmMlXesIe/egn5shQ92n+52a
         60SA==
X-Forwarded-Encrypted: i=1; AFNElJ/pWXLC3hBs3X7vaxfZkUwtLcSFo9B10dnIypyKQFlqQ9dnl6Ux6GT1I33hwQa3ekTH91kTU8t3FqXQhC52@vger.kernel.org
X-Gm-Message-State: AOJu0YxGv/ueCOeLdq8IDgnLp+LPf7V/SNoiCYFmlnmPVdNFw9fqYsdb
	I8KzBWVOhRIA6foBV9jFV+3OQ6+/oHVHevAKcTspuI1omK0ZUTcwhtSumZwa9zvfWBwI+0OeqLI
	PeBuZe0/GGxpo20lLK3NggfaVdChG7L0=
X-Gm-Gg: Acq92OExKFK3qSQcI6qbHAzCj6uB7PkZCUHjCK3+QHQpD1rqJ0UbjGT7obDhmY/+nFN
	YdwUPK6j+Br/nB6kbtYGsGyjRa0Q+d9Zhlo4Ua9VsHAgW5Lmmhkzmy0PiBMBD/6cYenFyI/Y4RV
	a7rhQNe1CdyLGg+s9KDRrRUhNHw9WZkzNEw31ONeFGrAXpKa5OQfOxzNf7KCRFO9KSRjlY4VchF
	v78bSX//plDNsBi9gYOlwBBsA1UFTDxRZyKwRYVchmWQuNdClObdNMnVt4tCpQGi1CgFvi/otRK
	vkpF3dp7avej5d2aMXJnHgAtXTr8NqrIahkBCd2XTw==
X-Received: by 2002:a17:907:e15c:10b0:bd3:417e:b85d with SMTP id
 a640c23a62f3a-bd5177ea873mr616199766b.13.1779108737330; Mon, 18 May 2026
 05:52:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514200129.94862-1-amir73il@gmail.com> <20260518-rundschau-rohkost-e591e2d0deb9@brauner>
In-Reply-To: <20260518-rundschau-rohkost-e591e2d0deb9@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 18 May 2026 14:52:05 +0200
X-Gm-Features: AVHnY4Lboiy6hcXUvu8bN75d27E9a-5HGF8fzd5TFKP_HqGPUJsSaCs9Ihp7UhM
Message-ID: <CAOQ4uxgy5Vut5KYC4vj_wgXiyghT2B9nd1YAV-a+hdkz5j1gqQ@mail.gmail.com>
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Nirmoy Das <nirmoyd@nvidia.com>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Laight <david.laight.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 2:39=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, May 14, 2026 at 10:01:29PM +0200, Amir Goldstein wrote:
> > Code using ERR_PTR() is almost certainly intending to produce a value
> > which qualified as IS_ERR_OR_NULL(), but this is not the case when
> > code calls ERR_PTR(err) with positive or large negative err.
> >
> > Introduce a fortified variant of ERR_PTR() whose return value is
> > guaranteed to qualify as IS_ERR_OR_NULL().
> >
> > We add this in a new header file err_ptr.h which includes bug.h
> > for the build/run time assertions.
> >
> > Subsystems may opt-in for fortified ERR_PTR() for specific call sites
> > or by #define ERR_PTR(err) ERR_PTR_SAFE(err).
> >
> > Link: https://lore.kernel.org/r/CAOQ4uxg=3DgONUh5QEW5KJcyXLDF15HbLnc9Ea=
7RKPcgtyfPasTA@mail.gmail.com/
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> I think this is backwards. You can of course do whatever you want in
> overlayfs but I think as a first-class concept in err.h it's not that
> great. Then we have to separate macros/inlines and almost no one will
> use ERR_PTR_SAFE().
>
> I think the correct thing would be to add an assert into ERR_PTR() and a
> debug-only one very likely at that and combine this with the static
> analyzer thing mentioned in the thread below.
>
> diff --git a/include/linux/err.h b/include/linux/err.h
> index 8c37be0620ab..6bf768adf157 100644
> --- a/include/linux/err.h
> +++ b/include/linux/err.h
> @@ -38,6 +38,9 @@
>   */
>  static inline void * __must_check ERR_PTR(long error)
>  {
> +#ifdef CONFIG_DEBUG_INFO
> +       WARN_ON_ONCE(!IS_ERR_VALUE(error));
> +#endif
>         return (void *) error;
>  }
>
> I'm not convinced yet about ERR_PTR_SAFE().

Maybe, but
1. err.h does not include bug.h, hence err_ptr.h
2. I think CONFIG_DEBUG_INFO is pretty common in distro kernels
and it means its ok to bloat the kernel object sizes
but it does not mean distro is willing to pay performance penalty
but David may be able to share more insight about the performance
cost of your suggested variant.

Thanks,
Amir.
