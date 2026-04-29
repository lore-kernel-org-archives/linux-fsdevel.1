Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF4137472D
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777496639; cv=none; b=tEe8Vrsa1hAiuosBBwIU47SroRxPIVCRQSiWg5kolGdtTVDViVexYoUMihqHrhYVBLNIjQJwdWWHOsyOQ/YUUnmXLbbYYnaZ98RoUheNQxtxJCeX+eL1gz2CTzeCvHC4tAlVXD0t7Ez8Q8Lz9LJIfW73fq7QoaE4KWElbnv3hSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777496639; c=relaxed/simple;
	bh=tKD1kZoqphx/1IqZo+FxuGf68uivswEb8Ml+8Wv6abw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ev4T7hCDz3cmTWAkD1qJJVCeFnJpjBVg3NxvmXkGabaWjGGeinI2f7wiPdKrUCdJQfZuiFm2iEwfa634XGyWO4WJC9xa/U1lXUYFh4kdYwne1ifgZ8TUO35Zal3zsbCMM95agGXJ/thlonBnAOciNhpbcAEHvswCMJf0VWRbvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RBR3I+Gu; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RBR3I+Gu"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ba8472c1613so33442866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777496636; x=1778101436; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HnqVnLYxhZQkXEJ+qyCw2Y174F/Hy99oiICnSXcEeRc=;
        b=RBR3I+GuArZP7KSs2BQDXI8594FAL+qYBC6Sm7zxM+aCIjT72MsGjpFV2wn0x6+To1
         4unXpsZjcFTX5Un141+0VNn4nzHLu7ZLLFJpinY7DM3SM6Ry8F3D2J7xOxOlwb1mpjTD
         cJeihOimJdLPGrHvSlng/vXtjL6AyfRZVueiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777496636; x=1778101436;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HnqVnLYxhZQkXEJ+qyCw2Y174F/Hy99oiICnSXcEeRc=;
        b=WYb5otK02RyzuzSYg7GW+6nxJuS51/glLbeRN1ZuN03fkZ3Tc51jXLv9sjOuMZxcgK
         oDh+h6mZYNgmbzMjzAi451N4KwrHpgGZLGw5n5bYG9EjAsF+v3328ipf/vJWab3UiVd/
         6HpdKdikGLgdANIh3yMZ2gQMwXitW9vPNEixUCCGbIkFNMqsgfwzAsONPBWTUaUhmssM
         yd5NWia6yo8cxdSBG0fEt+N5ODg2UCoISO1isytqAHu+Hd1HDKrSS4bjOjtDN0wzSR3y
         LVPfmy6RcTUAj577sS1Xfm6vGrCgMZwpfQIJ0N/3gph163/cZeJOuEToSJnxXsMVFsO9
         7l5A==
X-Forwarded-Encrypted: i=1; AFNElJ9U8jJbbLiYrdQZWGh9pQC/YV80/aXJmyfUQoZ0s/c9Mu3qJiogpJNhqM2e5O5SJsHAWFQV9jqGJsbyb3xE@vger.kernel.org
X-Gm-Message-State: AOJu0YytRyfrC7pZObZOGzP2EWz+J8sIA86JYB5c1y7UZUti5eWpmwfD
	LwV3AySYdz1KV+mgXqjMQKR0SekhlETAM3Pzp3cfhdSAEsJgW8w/xzo/ZITT0l8y2ddszP/B05N
	sTFUXhgE=
X-Gm-Gg: AeBDievySqhMjclA9MO+qnEiXApFNBx6USfW8mJLqmCog2xjw/jqP5z+QLgSPkhHVNj
	S9UPeXLz3XiWToRiu5UlxJhv2ff3uUIykcuIACazBYiU7/s1oH1gkSvOw7PO8QAGnrJog3FXLLR
	9w9cG4CwfjYdzdNzcUOMycLZswobtVyea0G3rrpmo8w3hFWegLJ1ANIKWYqjWR70fb90EfFV4b9
	j6/Y42uNWoNnpcfUqYhYJV8HYI95S+EOZSXm2n99WY6NPm3JQIhYmilrgYxEcVXKVCvm9F1iTAr
	j9SS5PjWHAh45oNKpRh35vMYN9rnQ3tpbCHKIx1mXEvcW2tcKEup8ol6QVAyrAZwPPq9bjSPEZV
	cpuuDL4v3JUF3pJlgxdn65ChQI7q7s8D/A04P2WPnaCwmhw6BbOqWgOn4OYwr1W4FIY6dSwZSx0
	WjneDa17RsBbDCTqQnQlPFZ1RUt79MezGYOdq+k/YGonUIpqQJeeLy4FgTno64GEX67/v6TEWNm
	9qO9riBhwI=
X-Received: by 2002:a17:907:26cc:b0:ba6:2c73:47dd with SMTP id a640c23a62f3a-bbac46d9b4dmr20909666b.5.1777496636169;
        Wed, 29 Apr 2026 14:03:56 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6fe30sm134529066b.5.2026.04.29.14.03.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 14:03:55 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba8472c1613so33436366b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 14:03:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9cq1lpBhSNWjxwH1XoSqCmlC4jX3JxikqHFbJun7OpfmTvRXXBw6+ubGcySZK0otK46GTD0aEYvsiVbP6E@vger.kernel.org
X-Received: by 2002:a17:907:5cb:b0:bad:dfe1:6a56 with SMTP id
 a640c23a62f3a-bbac6ac310emr20951866b.30.1777496634502; Wed, 29 Apr 2026
 14:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427040517.828226-1-neilb@ownmail.net> <20260427040517.828226-5-neilb@ownmail.net>
 <20260428033738.GV3518998@ZenIV> <177737511992.1474915.1952404144121931523@noble.neil.brown.name>
 <20260428142225.GX3518998@ZenIV> <177741881482.1474915.12527082398060370192@noble.neil.brown.name>
 <20260429052626.GY3518998@ZenIV> <20260429170731.GZ3518998@ZenIV>
In-Reply-To: <20260429170731.GZ3518998@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 29 Apr 2026 14:03:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgs8yAfaQYmeKWab7KES0jU46TvdBfQ3Q9+6+=E=vrx=w@mail.gmail.com>
X-Gm-Features: AVHnY4JtG_9GDiz56QzrtD5BrZqKcsiFlr8t2n0kWXJmeuX800NGv4Qx6DLxhBo
Message-ID: <CAHk-=wgs8yAfaQYmeKWab7KES0jU46TvdBfQ3Q9+6+=E=vrx=w@mail.gmail.com>
Subject: Re: [PATCH v3 04/19] VFS: use wait_var_event for waiting in d_alloc_parallel()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Jeremy Kerr <jk@ozlabs.org>, Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 29 Apr 2026 at 10:07, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Something like patch below (on top of -rc1, completely untested).

This looks like a clear improvement to me.

... but I obviously didn't test it either. But just looking at the
patch I went "Make it so".

             Linus
