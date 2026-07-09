Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1E83B5843
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783639702; cv=none; b=bIUyELNSmAv3UjKGwPy+Kcr9zHaZtHhfBU1sdPOzsTeejMtOHB7ajQVjiN4z+eow/5Xs9kT3bLutRz5cHmxIPvj7/Fktb8LlNHkTTGWns04j9XvzqIvVxqwJAe119CSo5wooNoVibVy9tebIaeoX8TBQhVPytd2iNTrAGW5RylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783639702; c=relaxed/simple;
	bh=1CnXqjtIxtC+2DeJLHhsOAqFIp22TdJa7Z4Cd0ilUzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MV4/g7pN/x5n1MZMYACOlvG1sSTQMbpkIbLuufTJsvp5wA2YjumvpOdA16TfsOb5FDfORiJVtjjWuq1NahTKtuEQtbrvcqmwad4q3zQrqQYhBCnnjUjUo9KKeDTc+nLX9+OCLTcF5xGvnF1Y/hMEAtp51M/qhsbbJ4RSsQW0Y34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyeVMPlK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyeVMPlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8621F00A3D
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2026 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783639700;
	bh=VnEWDzkpJDdab93DctjKcy+iRl+tSdMUNcz4cbIL01E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XyeVMPlKK+2ugMiNqAcqW0DSUaYretY0munWCo3/pMbU4eh+dv32pLdg4L7k+2hDT
	 ETTSBND7LpIilZ1eZ9AT0zxb6CkwiZADjcw4Q1ybxM/1wAqfsAx7jdiax3UrJnV2o3
	 6JqUJW2H+9dMGNUbe3OXAWZIcaG7dEekZf40UaLUWlj9+blhiVeICMes40BPL+CKxr
	 s3TvKvmexvw2XIJEQRHfgWcqwdRYuvXp4YggIu+v1R6HpAG2X1owoKwcsMuMDsdreI
	 GCe6unNy9Tpx1/XhTLiv6nVbzwc2Amv6BjO9J29BRq//RMhuBfHKuoAXGHucF4Wofq
	 DFlYUPD6fKjug==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c160420289bso7746166b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2026 16:28:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrqpgUWXwRJJHJS7hUjySlSXSSwCYqUsccrpoiAWemCg7aDcguCz6lvewrP5V3S77RRhSeT7J8h6nYonsYx@vger.kernel.org
X-Gm-Message-State: AOJu0YzfMEHog4ysJnnWJ5AMn+uVHciSyff/QlySRBucJLEgyXcaEqrN
	C7Z9aCqHBq0b+EWSyTMH9K9EH5g37L3w4M5qf+muBToyZu7xnzsQAFkdBwtrIieltaI0uFLgCS0
	Kc98UPdVKX4XUXzQcupyZv5tUMdQP11Q=
X-Received: by 2002:a17:907:1c2a:b0:c15:da6a:c27c with SMTP id
 a640c23a62f3a-c15da6ac90emr301540266b.25.1783639698946; Thu, 09 Jul 2026
 16:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-3-willy@infradead.org>
 <CANFS6bYc5uSSYWvwJZ4BgjzF0_bO9rkcFNvX2vVHnzWDi3kpuw@mail.gmail.com> <CANFS6bZZN6455QLhPE=yYi5fAHMt+MuqumtW6BCg__pESLiLaQ@mail.gmail.com>
In-Reply-To: <CANFS6bZZN6455QLhPE=yYi5fAHMt+MuqumtW6BCg__pESLiLaQ@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 10 Jul 2026 08:28:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8qPHHNrDkJ29NwR7NrOj7Ny05vRPKzjUPckC870ULeRA@mail.gmail.com>
X-Gm-Features: AUfX_myErJ-4JtqUD5YjlzwNbj0oPPyCpuzOLKwO5B11tKGPbSGvpJAOIzk-OyQ
Message-ID: <CAKYAXd8qPHHNrDkJ29NwR7NrOj7Ny05vRPKzjUPckC870ULeRA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in handle_bounds_compressed_page()
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, usama.arif@linux.dev, 
	lance.yang@linux.dev
Content-Type: text/plain; charset="UTF-8"

> > > diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> > > index c904858dff3d..b279f38636d6 100644
> > > --- a/fs/ntfs/compress.c
> > > +++ b/fs/ntfs/compress.c
> > > @@ -105,13 +105,14 @@ void free_compression_buffers(void)
> > >  static inline void handle_bounds_compressed_page(struct page *page,
> > >                 const loff_t i_size, const s64 initialized_size)
> > >  {
> > > -       if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
> > > -                       (initialized_size < i_size)) {
> > > +       loff_t pos = page_offset(page);
> > > +
> > > +       if ((pos >= initialized_size) && (initialized_size < i_size)) {
> >
> > I think the following change would address the review comments for
> > this patch and patch 3/6.
> >
>
> Would you mind if I continue working on this series?
> I would fix the above if-condition and add Co-developed-by for my changes.
>
> Please let me know if that's okay with you.
Could you please provide the updated ntfs patches so I can apply them
to the ntfs tree?
Thanks.
