Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8855032B9B6
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 20:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349071; cv=none; b=m1Ls4vVclLuwktYuTTHvGG+SOCFj/dx3BcQyKgZ9sc4aD6ByL3tdW2hdq2EENoEVbD/i0EGvV1U218U+244eNQCp08M98YIxbx8JU/heMhzLI29PnvilWhDjOWa9tSf4Uwy53pmdi4VSucbN/4iUwBPCLEepnrzBA9hLK5GhONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349071; c=relaxed/simple;
	bh=5TCU3IeL+CM9jwMcCHM5UD2nm48BrqqrHRJzKJccTi0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=fqb1roYgTCq6RsyP2yf+toiLoGC0NJp2ahQNbofLyzlcTf/Mk5QMh9PdHzjRXC1+yUzeyiYt+sa3hDwk5RRnxv7iu+HeBZRrxs015oUqpQDptsY0ncLqClKptnklecfydFI9Yo0AEiLaCGKVec1kq3hwNrypYPtASkykpBm6nvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jpdapM2j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jpdapM2j"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so13281465e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 13:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773349069; x=1773953869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TCU3IeL+CM9jwMcCHM5UD2nm48BrqqrHRJzKJccTi0=;
        b=jpdapM2jWx6X3xqrXHOuhB1/x6KB96m+9q/ReCd/ny5e/81Nd/DjpuAWL3KTOYhEWj
         d/r9d2ceZ0G8/euY+LewxKJVMZ8E8V4y/3RENSlG6YVXoBs204NE1vKCpkM2ft4IRbd+
         KOpcIJ+hxEUblzIvhAAoa6AUoJ4dx6PT4rXff+2lVl20zrv9AFUD/c3pf1pBrEtFd9rk
         y6yp3io4HgvLMi5hUihuiUwN548oj9hNL1a5qMKBc7Fyqt98L3bEnjwgqdNpwDV01o+9
         MeTwJmD6Mw/UZmetnb0kjasgbk3EFrtL6Mq2vXxz0NRy/gjuyLeqITtk3bwjUM1feR7T
         A04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773349069; x=1773953869;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5TCU3IeL+CM9jwMcCHM5UD2nm48BrqqrHRJzKJccTi0=;
        b=fTj9i6JNXJmEpeiKDBnhLgyzOv4sm457CkTTTFy0YnazErmyDEnrbptLbJ2svaLbUT
         iiGqjjWehlXwn4pFXzSmJaoHt0rCdpnneLGIwtmBib1/toecbpSQWONLwU/BnWDm9pky
         QmNqvm9K90d1VwFvnVs3YYB9ce0MMMm4AEK4HBxhbaqamv2Nv/gGlOu5EWLZ/7qpzA5b
         fURRFE+WTIE3jX/fmmsT1zvqLowEPNhpF3Gd7j9bv3404U5gaeImh+lqL+6XjssDfDJV
         NR2D/+iiI4hiqN2FWWZVFQ4dt5KvTJWomMML8KGKT+QEzpAIoVxADbfgjq4Lt//uzo14
         74dw==
X-Forwarded-Encrypted: i=1; AJvYcCVZFc9RViN0QHTicR6vgK6YY8eyVc+ZyiCZTdB5+k9T4r+kBmEOyLddh/JpEwmCmdNizITBEq0QjxrVXTU8@vger.kernel.org
X-Gm-Message-State: AOJu0YzuoiIA02jILEoPOnvscQxb3B/+rlkzHzHPl2cfbsM0r3B/59w1
	Kmo36qraJ9tf4VUhA26vQn9DKOD1Vtg6im+QOKjN64Svpg6L1yfSqjG4
X-Gm-Gg: ATEYQzynCO5I892FKUl+ysxQV5R9RceUmF7fyYadgYEQfmVQN5pXqmv1dQ/WKdUJl8J
	6AvEVmHAAqCWctF7AkLhzuY+y+0ZNQDCSdlfyoEXKjXdM7v8LofjFvzXvF0pLOTcnzrbSizbETm
	h9LA7wkpF6eRmdH8Z3gIRE6nFEFOaBCp/au9yo89dhVvBCpZRR2T6IQTQNrva58h6ywW3LfT1XE
	dMuj5W8PhZiODLMcKdryNpYq9gsHNJ1FEvgab9pu5DhimVqcSBzZjX4XTxZpHzseoT7Ad+dp153
	xte7NXL6DgLJGH0aFNaT/7HEH20BsYRNZUP4VQV4xngdhvrTB3U3uASXAdWF/lgjExISRWPZVJu
	hIY6NqnsHmITSESGg4vTOCgKMDr+9QSMHNiB3CMNgMcWmn/a3ISHIPCiqi/zmSZA4lGlv+axzKy
	W54vvKIRcwQ5574jNDhU3mzOD9og==
X-Received: by 2002:a05:600c:4f8f:b0:485:3423:727d with SMTP id 5b1f17b1804b1-4855670c095mr12566595e9.26.1773349068753;
        Thu, 12 Mar 2026 13:57:48 -0700 (PDT)
Received: from ?IPv6:::1? ([2a00:23ee:2968:90cb:1c6d:1979:bcad:501a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855725572csm6531295e9.2.2026.03.12.13.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 13:57:48 -0700 (PDT)
Date: Thu, 12 Mar 2026 20:57:46 +0000
From: Josh Law <hlcj1234567@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Message-ID: <43bacae7-3891-417e-9384-20cede8eec6e@gmail.com>
In-Reply-To: <20260312135514.e4fc0fa4c1f50e6fbda2644c@linux-foundation.org>
References: <20260312181948.20020-1-objecting@objecting.org> <20260312181948.20020-2-objecting@objecting.org> <20260312135514.e4fc0fa4c1f50e6fbda2644c@linux-foundation.org>
Subject: Re: [PATCH v3 1/2] lib/idr: fix infinite loop in idr_get_next()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <43bacae7-3891-417e-9384-20cede8eec6e@gmail.com>

12 Mar 2026 20:55:15 Andrew Morton <akpm@linux-foundation.org>:

> On Thu, 12 Mar 2026 18:19:47 +0000 Josh Law <hlcj1234567@gmail.com> wrote=
:
>
>> In idr_get_next(), if the returned id from idr_get_next_ul() is greater
>> than INT_MAX, the function issues a warning and returns NULL without
>> updating the *nextid pointer. This causes a soft lockup for any caller
>> iterating over an IDR (e.g. via idr_for_each_entry) because they will
>> receive NULL, fail to advance their index, and repeatedly query the same
>> state forever.
>
> This assumes that the idr_get_next() caller ignores the NULL return and
> just keeps on looping.=C2=A0 Isn't that a caller bug and if so, do we nee=
d
> to defend against it here?

The risk isn't just a single loop failure; it's that idr_get_next() breaks =
the 'forward-progress' guarantee of the iterator.
In macros like idr_for_each_entry_continue, if idr_get_next() returns NULL =
without advancing the pointer, the caller is left in a permanent trap. Any =
attempt to resume or retry the iteration results in an infinite loop of the=
 same warning because the index is never incremented past the problematic I=
D.
Advancing the pointer ensures the infrastructure is robust against these 's=
oft lockups', even if the caller's error handling is imperfect..
