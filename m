Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6033EF0A6
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562361; cv=pass; b=attms7zWguaLJAOPPm4d9QLTZ6ylQUh07UhkZDVnB70gA8QkUEXwuAj/GAiygwQc2KQUOevRVXWudOmdAonaVfKw/xar+UdOWhj0vGASF7xSBhkqfjCNW9cidu9N1spT7iw5GNmAHF1oZfw3422xUDC2EaHwvMqnK+YFaeTDCv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562361; c=relaxed/simple;
	bh=k1VcahloVqTMd2bS2EdontwtzK2WJK0zze95i6TSOFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oyMY+YdgcRbCz2I/YjcIfgCzkaeWZTEVYAlQCACFnsmMTLUILIs3juiJA+Rf/UsEdhkXtx5x5B04hR2yDSAQVcUOOSO0BvBiIRRaotc8kh6mA0oIHxtgF4E0hlenYLE1o8JfQt5oa7F5WtxhmZ9lCgfm2OwthRzthHR0KjNjbrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Md3V02RB; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Md3V02RB"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5b048375so137395685a.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Aug 2026 02:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787562358; cv=none;
        d=google.com; s=arc-20260327;
        b=W2qacCJ5wCgaipdtA6GJwAf2Sji0uDIsCG81UcPo+NNz6ZvV4KzIyAxMq19he/Ijng
         GTOS02RCuTj1nEWHEYX8lMUGw+vmKe4n+AP7Gkfz3Tj4vz1jyxYOkXEaiBWpDVbBTpv+
         RlCPzw55lIWn7hXdKKCaE+jLeeUMM55OcVphIbsSiLJokie7rkvyrgpFGO9dcmk9SEfK
         udJ83lOXAM5eOJudl6AjnuuDkiraUOzYYmzc8a5wv6XlcK6Oy4ikvNsV6NkELPYY9q7H
         S0WVfv/fTTO/BIExeq0Kk/7ojZYsu00x27Nq+N+fEQl0Jcet0MAWz3kPqIH6B47VDlio
         0p7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xjSchm007/sw+2JfMjG96f8T6RE12rgCCudebYixRu4=;
        fh=0QVDJIyjTIHeOlNGOYoJ5PlpW5oSkOnLU4/pWqiX528=;
        b=LPk+5ZC8T8CfK6c8USNpiT7vtvPEVmSq4v7dVSYMfNj+4peX3nOXSG8FFgRWlOFWvE
         o5eegjfY2Sl365gPAqXw8yzPI9qhmNdHm771mx4wNyaTR5kuJ4a7iJ385iKQpD3eGCYN
         ewdDow6VH/PkDQn7DM9KyadoCmG7L06QL/a5wBJofm2PWG7eQ8HAr9/qewxmMVNlNkyx
         R1ciraOiL8PZxg9LWhajRPEjy42i06YP07Xj0oo6Uc9TVVgrWKU9CorLYKwlPk6abmyt
         ss0uWw+Hhud1BjNvr7Sc3S1UCob+Y7KX9XYAMDSRAy0yQwnjPZhXd0NzvEH6oCSwouAY
         8HIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787562358; x=1788167158; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xjSchm007/sw+2JfMjG96f8T6RE12rgCCudebYixRu4=;
        b=Md3V02RBMrXT7++lZjkapZopD8qkdAFSHpNsSv6QmBIPKOdzQWCNN6AR4kmpFvkadv
         0WjoUBO4KWY/LQLlyBAjyM8JJ34zje3REjajNVZ3Gow34PJ4FI1D/qOFI4wkzef/51KP
         WjSj07LC1JS0zXh2vxVUSAXHu2k8KyBR3WWNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787562358; x=1788167158;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xjSchm007/sw+2JfMjG96f8T6RE12rgCCudebYixRu4=;
        b=XyZQUiFDtCMy5/7KHt5gbQEpZ65XESstxMyRKyBmka8/sEhXTIYhsjLZVwv65yt9qW
         /RvKw3jdcposmyKv/LS9EIR+P1R8KFTyjthIfhqJUytQ16/fen8LtGjVFvdfFbuA+FfD
         GrwFycMp+lYyxndCNEsRNEavA9p+Kcc8T/rhG8dUbjw3wI7tr3fLOlmQGRpVkrNakzaK
         hBPJ6O9OcGk6JRMxb4RftpCihmzuRh8hIbbL7ij1IZp048TOhYd9pX/92BzZSfzPI3Pf
         6bcVAWxdXS65x45tz1FUrEsxBo+xeRfwryOp8GPjlf8sMSfyw88HSL0tvXxHah6X6aj3
         rW1A==
X-Forwarded-Encrypted: i=1; AHgh+RpggfULETDNwFu1r4fksgsq6yrAYGUumDf14wTZf+jlHV52AdawmZDnnWKuBbQF06RfNfG8dNG7nIrP9HTn@vger.kernel.org
X-Gm-Message-State: AFuF++k+LflKfx8XP8A9jEuq3b69NZAe7C3p+PDEjEmOKbuTCesjbmHJ
	F5V2c2Nv8EwDkhD9NwZfAuMlOd8QPbrPK9750telGIvsWLWQEPr1n1HWFnkAhxPNK7y62xk99dh
	joe8byjatQScBPkUtJHs7LV+tcLmOhPtXmJPWYtDuKA==
X-Gm-Gg: AR+sD12jIWmxEHqTubWV5iGp5x7pyC2e8CBsVn6LBlTJWpsMlPmGb6QXoqvcj7toXbu
	vPuZ9uEexvjcZUre1LS5NkD1EKVxooNCZNjqoXQGFQ8bxgy1G9HMW91Dxi60xgoTpv8qHYdWYui
	pY7ZAC1D7BlR/O5bH/r288iYF16RJ6eI4dWnRkhkN7KmU4h8v2KEhQRoEF2DZJzoXEdrveY4LzL
	jHxnyLaDE+d9LS07uSOuvboIxYD38ZRwtccaC4R0heYiDw+81qi3rasF6UsOIl6DpmIwJYu9wi8
	grjXCfdUFZRn13Ip2bIeplgaCkN58j1YIQWhWHReb/eW3WwlRbs0iCww0ufehsvUDxo0Rlv7Xtc
	HxN8=
X-Received: by 2002:a05:620a:a2c6:10b0:92e:bbd0:260c with SMTP id
 af79cd13be357-9373957655amr1668397485a.36.1787562358062; Mon, 24 Aug 2026
 02:05:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820193343.3852967-1-willy@infradead.org> <20260820193343.3852967-3-willy@infradead.org>
In-Reply-To: <20260820193343.3852967-3-willy@infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 11:05:46 +0200
X-Gm-Features: AcwNN1VnwXUZIDZ1PfaZZEyLrhKwB3yAlvrDYfoxcRnFp4RHIk-2JE_xMlB98T0
Message-ID: <CAJfpegvP3i8ZJc2T=+f4rAhZ4E1QcT5+jC6mQPLxtB-yoK9Brw@mail.gmail.com>
Subject: Re: [PATCH 2/7] fuse: Use filemap_invalidate_pages()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>, 
	David Sterba <dsterba@suse.com>, Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	fuse-devel@lists.linux.dev, linux-nfs@vger.kernel.org, 
	devel@lists.orangefs.org, Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Aug 2026 at 21:34, Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> FUSE relies on invalidate_inode_pages2() / invalidate_inode_pages2_range()
> doing writeback by calling fuse_launder_folio().  While this works, it
> is inefficient as each page is written back and waited for individually.
> Far better to call filemap_invalidate_pages() which will do a bulk write
> first, then remove the page cache.

filemap_invalidate_page() suggests to use invalidate_lock to prevent
races with pages coming back.  I'm not sure that without it the
behavior is identical.

Maybe add a variant that takes that lock?

Thanks,
Miklos
