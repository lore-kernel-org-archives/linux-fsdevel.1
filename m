Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84F3AC0F3
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 01:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783473218; cv=pass; b=jypg82Umo6BZmsdwkTQS8ehSu6ap6Pyv/jmcqNTrjoBatJbj6QMtNStuJlZQRZ1pNbKE2LPJRiDFucp/TfBArdXmTrymTSKm9o3xy4r4nzBhrKwt0eMK/V4MD0CHG8lbOFdnc+7+pFvNu4f2hd4z5Ay6pq0oGmnQmXqyuSf1sXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783473218; c=relaxed/simple;
	bh=qTi+RLpP7J2eFQtb0sLQC3INLbbm6wZuzuArBjwmhqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtdQc+DQehqSMHuIlXodYcvuBsO7NCmiK9ABzt5WvRMyDo6gWPA2EoJ6R7jnQy51EVMc0fAKA55y9UUsTi5Clbstw9G/z282EuSxwT3CgsFab+cVodRReCv2huvCxiU7KlxX87tp3R4NPNQ1Wc4VB9dq2MGF10XaM6hx7vVnvGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eWQw9zha; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eWQw9zha"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aea0fff535so133449e87.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 18:13:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783473215; cv=none;
        d=google.com; s=arc-20260327;
        b=KwjiZYQ5Kzpz+W96XqX9waXyXVGcQdkPzDUhFwbepCXlLD0dJ+8rErG1ftWVtHacKY
         D+F4L4bV8TMTerkS/cq0z74VvlA45GycQ/G0oR58DWYcmdPt0oFH2eYbv0Fe42ceU7nj
         izw5zY34NWA9pADbffuc7/x4uSvB0WeCCHRrje7WY9ZRKl4Bw+0NsmZ0CM7bkpv3GMis
         4Nv05oMkeOfAxljiFubjrREE/hxwj/CR7IW21XnNKM/DqoO8AygmOLAHLA+HiVsfc2IZ
         Mg5TS85SFILK4D7fWkt6RtEl52bik/vnPjzY8luwqEqHkFPWZbYCj4+F53vBO+f2LhNG
         A47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6NIHVl96rxdBrigGLqESQHzSd8rL6plfNOX5L/2KDis=;
        fh=ins4axWdmI1F9yJXIIMTk8m5XV+CvVhVALf0QgcEs30=;
        b=Y+do6osxWNus0tx7jKxAL5waYE+oyO3f+XaxR1LnN7AV/Mz7+G418XMVATDbLs45jY
         zuWL81znooviNbBdnMFuWv3JUHqRkOlkWtNqdj6SLvTuWy2CaD6B8rtTwEIJnt6/y37G
         u1yHXHwMTUEkr5K17DHbnL9XkdSfPz5RjpG3mmcs7cfVH6ZUT8jPGExaC99DXUSIf4A7
         tuTSO8Hf/gGUYhTq/B9PHBpqayWiENai3FJHoR3zRrPyGKDuRrVhftR/16q2CnvjqRji
         ELMuWU0rMlDk6vuGqqQDqIc5nrBiWOVp4Eu2mggGOxvc5r6hNFGPDY2zo9aF0w0NEoIj
         NGYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783473215; x=1784078015; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6NIHVl96rxdBrigGLqESQHzSd8rL6plfNOX5L/2KDis=;
        b=eWQw9zhaStpzoAJ5V7E7cglSPWPgW7Uiy40Hu+4yMxWgrWEm+26SIrOsj2+9dwA6qX
         zpYGPrP0M74bCXqAhhkFKlT1wvsKRx3+o6TQNiA5qysz45JfwOvsugRDDQqUrHtmUA8a
         yv1fpIXkiB8XncC/dslM97/Uj8tsKrXOeh4ZhXVqlnZXr+SSsjlDX49JVgKe9NhuaFyy
         PvKm03N/uLGkmDb8LWpRcflczRQBgjXDGwM96JPV0iawW+rEpSU+7TpCAUXP6XNyXWz7
         EAx6lHlw6e74lIfyFuIerO0JXRjRU2XvALLMG/PjUq/Z9u+/QPunMFjWy9TLMVx+G1TE
         c+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783473215; x=1784078015;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6NIHVl96rxdBrigGLqESQHzSd8rL6plfNOX5L/2KDis=;
        b=iC5Gw2nQ/Qfs+0o0ltgHe5efFOt7ucy9vCwJHMsqHRqMj04uLIyww1xpxzi7bhi6VA
         0CdnCgiUjBMCVNQFTxZwt8vx9/dDjNRuDInSja6GEki4BhqH3UdjQenwZlPsk4+yVR4e
         cfJ3x4HtHVybig0Q+NQD3kBkxem94/EH+iK74ah7mQdy9LKE4ekV+6BOH4mAwD/pvPGi
         8jD9OloaJ/XOQT7as1fTmDhNzS9mKjg3BgNg6LPAoYavt6vp24emyAq+gWlBVQfP9XKE
         wW5D3Nb2ZDvE1ZY8gnmQVU3hRMvLNKh6TAl2shFsNO91dzVekOpzWiPLklZO4S7kBnE+
         PTLA==
X-Forwarded-Encrypted: i=1; AHgh+Roc4h0maac4qj2vjq9QNCip5VvYZ13/qWZO8rzvpuDYin6ATQQzOrvns1XAtWQH/fAmDoZYgRd7e5mpHcG/@vger.kernel.org
X-Gm-Message-State: AOJu0YxMGBZAgefAE72Bf5LTvb6d4wY/L2n+uvrwsCO8YmCjdJGyiCyW
	dxHY31ypcGALnq5AP3bRcVnffIDN4NvgQ0k25cqxZ1TN4cma9kKJeLg7mrRcmVVZvBSXoqC9+5r
	vHuOSd/XGy91AFP65iOVTluXKipbk+iA=
X-Gm-Gg: AfdE7clvZkMUsy2kE7g6VvtcOuyNBBeAFEFBhKOzRC7lmqloT9eSQO2TvojvdCl8Eiv
	bi0CPNpDXuE6NZU0ImHpFn9Oxo7rgQivUyoKBDpcPsCqCeYt7Hu6dMrutVkmJeXfqosgT/427t9
	CX969y4VBWwbA9tM3Wa6NC3rTsuvpxcykCA9uGXI8EDgPeuqU8a3Z6FZnT1g0GmNo9PVW5WvcI7
	5weoY7xMAoqjpCo20OnciEp6fFe7KJEgUGXy7ixyayE0vZbfm3bW4VId5NzkoNVLVz6pxiw
X-Received: by 2002:a05:6512:10ca:b0:5ae:ae6f:1c4b with SMTP id
 2adb3069b0e04-5b01144e8e5mr97072e87.25.1783473214560; Tue, 07 Jul 2026
 18:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704160229.1725504-1-zzzccc427@gmail.com>
In-Reply-To: <20260704160229.1725504-1-zzzccc427@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Wed, 8 Jul 2026 10:13:22 +0900
X-Gm-Features: AVVi8Cej-mVk9TePf5FQ-T4TFAjgReLYpfjtV_PthO83MwcgONz_4hBt4Sl4Vm4
Message-ID: <CANFS6bbdYdn=1rt1W4aPue4RqLLxFhHHOG9eTX2Sj0gcs+QH9A@mail.gmail.com>
Subject: Re: [RFC PATCH v5] ntfs: serialize attribute-list replacement with lookups
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Cen,

This approach introduces too many changes. I apologize as I originally
recommended this design.

Therefore, I am now considering alternative approaches:

Design A:
  * Eliminates the raw pointer (ctx->al_entry) entirely from search_ctx.
  * Instead, it tracks the cursor using 'al_cursor.off' (offset within
    the buffer) and 'al_cursor.gen' (generation counter matching
    base_ni->attr_list_gen).
  * If the generation counter changes, the lookup detects this and
    restarts safely using an exact search key (al_exact).
  * Since we no longer carry raw pointers, attr_list_lock only needs to
    be held briefly during in-memory list operations.
  * To strictly maintain the lock order (runlist.lock -> attr_list_lock)
    and prevent deadlocks, functions that previously held attr_list_lock
    while calling runlist-locking operations must be refactored.
  * Pros:
    - Short-lived locks.
    - Narrow lock scope makes it easy to maintain codes.
  * Cons:
    - More complex implementation.

Design B (runlist.lock style):
  * Retains ctx->al_entry (raw pointers), but manages attr_list_lock as
    a top-level coarse-grained lock similar to runlist.lock.
  * We must establish a strict global lock hierarchy: runlist.lock ->
    attr_list_lock.
  * Pros:
    - Simpler implementation.
  * Cons:
    - Could reduce performance.
    - Wide lock scope makes it difficult to maintain codes.
    - May introduce a lot of '_nolock' helper functions to avoid
      self-deadlock.

Which approaches do you think would be better, or other approaches?
And please let me know if you would like me to implement it.
