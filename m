Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C92E3FE
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 02:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783478796; cv=pass; b=g7u540TR3e3g//wlMsVPMruUPijz1hYnswBBWvODOVFOJGHZxiVJKmuUq22wfGf+dLmGXUFSHSY6HSZNHjCBvCb7hwsjwMAghiXk9xtYJ584D0OBQVW4h/nJsuEhctxQfsL97GBwjfH1g7ZwL/qkGfbcLGzfNgRqMTPunqlUHSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783478796; c=relaxed/simple;
	bh=lZeKcVP5n5d1tdfP9Qo97u25G/PeW5B5/8MmklyL72o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUVRv7ppqlzs0C3jsKI6CDCAoqO6I7ZKS88HmDl5pR807tSUugQKTm3i2ZRRFnJibh7iRy4D5LfLwaBBhEOermAvHBvjLU90tSVDDwxb44j6gp+33fLdWiVkAABHHx8fMLK1PvvKRImdrxZqz1iJEP42+B1aw0qSGFppOZ+c4Hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UN2tXiHg; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UN2tXiHg"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-806449d108aso3763477b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 19:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783478794; cv=none;
        d=google.com; s=arc-20260327;
        b=JHAQCOS/IT3K+nbcr6y8acNr5aEicnqvCittR3+JmMS7ZH1jt+QpcIBnTsOkK/KOMT
         +OrvLjzJ4vdAMwovVZ88TCeiSSbz+T6vCKivJXpR2alvl3ayCEGT7bzlCKzce7ugWBAl
         u1S1wrvKQ8kxgSdZH9DKDXBrIOXG9X0ebzkC2rN+CpaRMx3B02EepSeJ2Q/ieUljpWkk
         0FkwTiA9yCAkgvb89sATAQv8lpkZk4avmnpEjRPbfHgqRFe4D1IwzTLv+Cb8UETvp9r4
         ESlne/gIKi3HrJPRT5McV4EX9bXV4m8kXcx03WTOO61qgwj5YFZnXV7Qr3Rgk0Gwbjft
         dVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DAqLHrk+9TdVQrrOVG5vJ8eFuY+Wniky/ctCdzFa8Co=;
        fh=NZdpUm3a4IEYzczY8Bazspqx/j5EyaTnSeL/7jq6kXE=;
        b=pctZGFFl2IUppYj6MhVCx3Jma94Md3d4fiZ2JvUonCAYxQR7oVEzEic5Ia5YHFRNUm
         EBbGQdiv+NoUSQCWscoBNJqZ3HQ7VK0cj/EJVJ3zZGPWU6v+ys0+1yAGSdeB6a9R9N9l
         9fGJY249nf3vCD5N9nEX75iV5URjDY8ApZlr1DJTVj81LnVV+gnbMBsFBh81qxxRL0ix
         3vWrlMAEJ0XXXsHt4SCoKWj+fzDk0uOwErN8YCTLJwM/pXnliNgytHpWXLJEPKlNX3r+
         0zYZtTrfsvG6Gg3ETRJtRsD/VXDS2DXJrPLyfe/cpRevvtw92wprA0V4i/0Kt/2fil94
         RphQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783478794; x=1784083594; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DAqLHrk+9TdVQrrOVG5vJ8eFuY+Wniky/ctCdzFa8Co=;
        b=UN2tXiHghCXlqUxpvqN9DPnVNVWDcKjRrXV9M9pEHljISrYO9clG/akjWEV6aum6Sj
         1O/RPgNQF7DL1e1NPF66IQC8FsY6bWVQrfES6zx99xGNoh3l2OZ99CqT+nJBFg7P2z1b
         ZP6p2KUmxuiWWn0HjIngffjWOKsXdz0P8p0r36d8UxUSTV3izyomkmJsShI2rRG5YQrx
         7J0ofgmPxg6TWSotOcMgySeoOEIVMdpUBU7aYP9zMLyq4t3iMSlFYyRmKy5ksvcrpom6
         B1MlhQ6sqvGbH0CRpUfEb2tcbKF5HsSrac/A1iR6crlMVSDHvZQ2o/1QCTCKRYhXds7x
         phaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783478794; x=1784083594;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DAqLHrk+9TdVQrrOVG5vJ8eFuY+Wniky/ctCdzFa8Co=;
        b=bQyg5bbVE4oZmvIoCLLszGAG7I+nlSC+iZI3p/64t2WEiBk6ZI3k5aJHRB8I2laLJz
         1tK6ZUmOrW04rtRNc4qSJNPcSaqwPAfrNeCDdjSgJ/KTrvXatNqRcHCqyDDxHtfPr96f
         j7hyZnSiCzqjn8Yp9m8xlDy21L9BpgmOszGLFxD9CqjAvpgDHtIZSx7P07HhrbrcL7ru
         NfvQzui60vrAm0AAjSdaSDZheH6rvuBa7kZqIDHAvEeG1dGS0K8dPkYaxWISKFTCqaKM
         XpEAd4f5X1Hu3AvrHKS/7M6hqi7E0MH6oUFa03s6WBQweR+R6lRkqMHPhU8SvYh9O6Jm
         3+ZA==
X-Forwarded-Encrypted: i=1; AHgh+RoP9cM27ZaVFWDHl5ou9mjifQ4bkxzIN3mJSPOc/HBTL1NgI01SvJnK3hxBaeYwrIYZK7SGT6cfmJmUowfQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwYHjHCRw+WD1UkcNmH+aLaYFgSHzCjrPekhfpbqNmbLyUtpWbc
	Fl+5Pfz7EHFb28EhfuqDF6oOX1OX25YeWWOnmi6iFYfWQO/jJHRo1lnCCQ0tQqfDc4HVmSQdT7H
	yXhB1T8ePnAcD2ymBVx5BhEBRe0gWgtS2iQa53vw=
X-Gm-Gg: AfdE7cnX3vAlBDQkn72FHme3mi5RE+x5cahjvzcSrYioLMFxJNJRz9l0ST8XXJss7ck
	MZ4MhcKZM3Dba7SRRrzzA9yln9eqy+3pD5czUgUNYIkC2Ycihk+kU7f12reJpTAl85NBMiXHxiQ
	ypsDRQKCYvTRrOnfvgHAIJIbCcZFzJjjLtsYp72H/3eSL+TpRRCIlJYRoFJ+3Ucao13cxk4lQiw
	SSueojQVy/FImo2N+bA5mllNfmJZyQRrMhS+vuiMVzeWaFtITCwhiLqEkd6RB3vjNRxfNmJPZeS
	oI36jgh4Mw==
X-Received: by 2002:a05:690c:6088:b0:80e:bd63:178b with SMTP id
 00721157ae682-81dbbc40ac2mr5679297b3.10.1783478794353; Tue, 07 Jul 2026
 19:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704160229.1725504-1-zzzccc427@gmail.com> <CANFS6bbdYdn=1rt1W4aPue4RqLLxFhHHOG9eTX2Sj0gcs+QH9A@mail.gmail.com>
In-Reply-To: <CANFS6bbdYdn=1rt1W4aPue4RqLLxFhHHOG9eTX2Sj0gcs+QH9A@mail.gmail.com>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Wed, 8 Jul 2026 10:46:21 +0800
X-Gm-Features: AVVi8Cf9W0LaLs6ah_RgGQAv74s_H4YRMPfWpiUfyiPIRS6BF43YxOcpddV9Rfc
Message-ID: <CAFRLqsUC3Mb35efqcXTrkhxUDVpNx__rfeNoKOG4QDvL-phdhQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5] ntfs: serialize attribute-list replacement with lookups
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Hyunchul.

Thanks.

> Design A:
>   * Eliminates the raw pointer (ctx->al_entry) entirely from search_ctx.
>   * Instead, it tracks the cursor using 'al_cursor.off' (offset within
>     the buffer) and 'al_cursor.gen' (generation counter matching
>     base_ni->attr_list_gen).
>   * If the generation counter changes, the lookup detects this and
>     restarts safely using an exact search key (al_exact).
>   * Since we no longer carry raw pointers, attr_list_lock only needs to
>     be held briefly during in-memory list operations.
>   * To strictly maintain the lock order (runlist.lock -> attr_list_lock)
>     and prevent deadlocks, functions that previously held attr_list_lock
>     while calling runlist-locking operations must be refactored.
>   * Pros:
>     - Short-lived locks.
>     - Narrow lock scope makes it easy to maintain codes.
>   * Cons:
>     - More complex implementation.
>
> Design B (runlist.lock style):
>   * Retains ctx->al_entry (raw pointers), but manages attr_list_lock as
>     a top-level coarse-grained lock similar to runlist.lock.
>   * We must establish a strict global lock hierarchy: runlist.lock ->
>     attr_list_lock.
>   * Pros:
>     - Simpler implementation.
>   * Cons:
>     - Could reduce performance.
>     - Wide lock scope makes it difficult to maintain codes.
>     - May introduce a lot of '_nolock' helper functions to avoid
>       self-deadlock.
>
> Which approaches do you think would be better, or other approaches?


I think Design A is the better long-term direction.

Design B is simpler at first glance, but I think v5 already shows its main
problem.  As long as search_ctx keeps ctx->al_entry as a raw pointer into
base_ni->attr_list, the lock has to cover the whole lifetime of that pointer.
Then attr_list_lock starts to spread through many helper layers, and we need
more _nolock variants or nested-lock variants to avoid self-deadlocks and lock
ordering problems.  That makes the patch large and hard to maintain.

Design A looks more complex internally, but it avoids the root problem: the
search context would no longer carry a raw pointer into a replaceable buffer.
Using an offset plus generation counter, and restarting the lookup when the
generation changes, seems easier to reason about than keeping a wide
attr_list_lock scope across many NTFS paths.

> And please let me know if you would like me to implement it.

I have limited bandwidth at the moment, and you know this code much better
than I do.  So if you are willing to take the implementation side, I would
really appreciate it.  I will also help review and test it so we can move
this larger fix forward together. :)

Best regards,
Cen Zhang
