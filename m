Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64F32D595B
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459871; cv=none; b=KEPwrk/TgxxQPrExhbWi5hFHE3YxQIMITE8VW1AdPRiaTBAUFqcraSMaHTDG4pps/UDLwKmy7xxJ1XgY/n5rBdPg7QmFdU2YOWpUJCuCUZ4RbCZGx2xbTszFEUhIbqThU/3a1tOMDaLL6NiFZEYVevFd1brHU3pBJ3nUwFdc7SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459871; c=relaxed/simple;
	bh=WirAJZo9ql38GCHjwxGU/VkDytVC/MTE2BUxxYla6o4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWHTuKLHDlQpOS52X6JMkXJ70KWD1Ac7S//ZEI9/Ctyhnd7oDPBdBh9t7zbh0FMiZlF7nAMgopLqxZwx3Ie3Xnm69WUEXoFBX6r1sBYo8Um+wohvUCbMhjB19kTjmSWreWrPLRTs/nAgqqE1s2XX2N5Yg24R2tq2/F/mQ8NdfTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DCc9rzEi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DCc9rzEi"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bd01481e592so1050990566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1779459868; x=1780064668; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=acKPfWIV0T2yO9gpmbaso6PA38iYfEEigSfflk/5+Bo=;
        b=DCc9rzEicgmFvWJW+o235NDuvj8Xm4ghp7nRQnoBLGolOs+LeZ9mSwixHgxpEOdwdo
         LqtuN908M7N6weiMPS8x7cuDhiSZnyahKAXTWL6FtQ9VCcl4l2B2D5nKTDSDWGnEl4sT
         hlucCGNGz76b0CCAtaJYBvFTwrEbN1hILUeiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779459868; x=1780064668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=acKPfWIV0T2yO9gpmbaso6PA38iYfEEigSfflk/5+Bo=;
        b=HDe3w8rcwTcGaw/gYFyT0qwdgHx/i++u1Q5xM9URQWj0A7TqhqqVcz/PRFy2X/kRcJ
         9kEHVpSGAxx9YbmjYA2zFwfj7/UH5BxEJ6Kqg5pc/QjEQMmmBJf26FGFm9u3C7oUgMTW
         DiujAAcu7UcbN1pnDUsW7cBCT97U7PGjRwJugspoZyqkSH41kdx/xIjVDSqoVvkzZ8l4
         d9ieVOb0OG+6n3o/RHZpo5uKA3mPBOcc4DSShJcrcuouBrzyticPK2AsqyJsmtjX5Z8f
         KdHN8g0GM6tJOuGrOT/9Y9xgNFNt/jOp/o1QGHgSrE9xAjy4yNJuO9vUdsYXRl9jaQdC
         PTXA==
X-Forwarded-Encrypted: i=1; AFNElJ+KPIjXbN7virdFCzEfUjGEhjUTbfIZE4XnDW/9hFpsu7bTY8+8x9Wp2I6kIs5le/FMUiDZm87FmZ7/4cX7@vger.kernel.org
X-Gm-Message-State: AOJu0YyynMYRsS9WQ9sSYa8j51tjunAm/jX+rqNchaP3y6DmP7FcgZ77
	/LO29LxPrxP8uRODL099+Wl75WMqDZG7JMvrlgwWCXTMHdqOHQgkxZfdcYBI3xx//nNmyNiquP9
	mDvi+chE=
X-Gm-Gg: Acq92OF25mBgRo6pHJBkvIMpKWfulH0NoQNZe+XS+VMbAMJZzzvuNo/Lf1WJyrBzMLp
	BqxxyWxq3XV69tQkAgJEtxIBU0Fq/59FoW2K3pdiaN45kNmWpqn1Ga4Qo1dchcBKcxGJrVDY47J
	2ls8HGfKD491XlV2viWwamvdbuzPMTcqxun50boSw3+ND+nvd8Da20KUl9ZVpfXHbxETq6Pm+N0
	/MgZOrL8Pff249NGmNvOzAkR/rJy3hFvErQAGquPQTJcmvqJxrO7aAGDYDCdUB+erhj3CzpCP9u
	mH/8j1MSLL9gXdzNi/0efrG+OAE5YZA7SQGMFHV8HSNNHVVUBszY1w8lGOHsLjYQmcw2yrBBO3d
	bRHey4mCxH/694TvRawuYXtJBnmB5dezKYeLkGLx6DGXx5lZg7+znLHYupn6TN37hX3SXZQebNe
	NL8iqJRJwObRosf6X/Bc4lkegT1Z5u8ec8PfTvzcrqv3RhKSKi+ilUMBGzskmEheMhebl9HIJb
X-Received: by 2002:a17:907:3e03:b0:bd8:6ac6:d722 with SMTP id a640c23a62f3a-bdd25cecef9mr254202666b.24.1779459867942;
        Fri, 22 May 2026 07:24:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc65db561sm57456866b.51.2026.05.22.07.24.27
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 07:24:27 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bd01481e592so1050982366b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 07:24:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8jCeHV0WBspuShFE7C69QVOK2Lf0cQNw2KPrM1hsZAVf5lVI82DkpAWI+HXikkO+Z0f8j2Y1VwYy1hPmfF@vger.kernel.org
X-Received: by 2002:a17:907:1dd2:b0:bd4:b787:cbc1 with SMTP id
 a640c23a62f3a-bdd22f2e809mr209060066b.12.1779459866766; Fri, 22 May 2026
 07:24:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-work-exit_mm-v1-1-bd32d5a560bb@kernel.org>
In-Reply-To: <20260522-work-exit_mm-v1-1-bd32d5a560bb@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 22 May 2026 07:24:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJRmdjDQExRP67GprmG7VLopuuaWMyZr4YNp2NvdNbKw@mail.gmail.com>
X-Gm-Features: AVHnY4JUO31ZsoSOcxsaV2rnOfJ-ubFfSCdy30po45mtvYrluJ40tMteEvAEuLM
Message-ID: <CAHk-=wgJRmdjDQExRP67GprmG7VLopuuaWMyZr4YNp2NvdNbKw@mail.gmail.com>
Subject: Re: [PATCH] exec: free the old mm outside the exec locks
To: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 22 May 2026 at 07:03, Christian Brauner <brauner@kernel.org> wrote:
>
> If exec swaps the mm but fails before setup_new_exec() runs the old mm
> would leak, so add a backstop in free_bprm().

This looks odd.

Why is the free_brpm() the backstop? Why isn't it the *only* stop?

free_bprm() is already where we clean up the new mm if it wasn't used,
I feel like it should be where we clean up the old mm too.

IOW, why not remove that whole thing in setup_new_exec() entirely, and
let free_brpm() deal with it?

               Linus
