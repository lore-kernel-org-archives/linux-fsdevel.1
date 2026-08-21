Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CA739DBC5
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 16:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787329277; cv=pass; b=QiqRFdtqtcrBHKqp9Mltar2EDY0QS74Hs98jwCIB/6sRV2wrWSAIcjOyWqJ1UOrUASwPZJ/uoBn8+5nJmxX77/ZXP+maSA9zYbjstTzZ6zsA8i80lokxVcs6Ml88WFwfE4KYdSR7b0EgiIQpxxI0PT1T7PBwnqIWhYiGPyLSY7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787329277; c=relaxed/simple;
	bh=4Fv3YLgfqFB4xMcyVps8htWqIR9LU00sYfuz4ZAAk4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq1hn6FKrieyCmUxpCQdHU3YyzdaNQJTTGuInEqeaqupr3RJszfaXgEedPUWt03FHW+tUr5ZhPCQCabASGXJ0SOKEygnqEwNqF5Im7J0g72KhPmiPjxTcHDiwV3yPr0PiWqOq+5M20spHRttzwbEptZRADy4ntCmZdJNxgmp7hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JAgnzEYi; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JAgnzEYi"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51bfad59921so6996291cf.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2026 09:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787329275; cv=none;
        d=google.com; s=arc-20260327;
        b=kU2FfXYfdVRlu51/p7wJAEi0CVfYbh3vo5r3b00ORn3biNpUaIiAOv+rUirYAhRohg
         rLvrXJY7VXeh0oQEhlAtt5k/fiO8yhC3sAaEzIEkx6wOlnWoeEJZiGZjsvftswbAoLxd
         vMRjyKMrTZ/tKWujP5w04YmPpxaG4WuHsVDUNgbaXi1grarBEIljHYAyPFr0mhtVMyTy
         aFio0tYftP9WjvkY8poDKDOKZtr9mpCE+06gu39r1YUzaV64yPESOa0VdTU0IF8xKBeZ
         QyfPzBtE75dfOXpigngapp9hBb/tzwWYUFkFSPL/6w0s+4NGErtHeRssendS2bC9pMG3
         laYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EIsN5rKzbFhicm7vK6ZvsuC9whEPX4hvy3159fOEQI4=;
        fh=Brprf1ox1XfEVJwgCKqhCfZsinFGnOpLKfufwMKk6hI=;
        b=LVHdRCTiIAwoJR0BQ6x9Ev0zrsUh63Wbm1cdPBA6qW9pbmvgYjdNoj3PDGo/f8bkP9
         YLl1CA5Wv/IfmGHwhOX444biLzKj1l4qeN34MCYomCXbVuVxy7gGnOsewwkIB05pTNeY
         dnLC9KkdqRQO68uBXkNtOc/x+QxxD5gRKfhIDIpyqxFVIZDeLk6yVZZPNMRjZCC+3XYZ
         P2H8zO0AAKXl4IpOb0ZqWKdokFgEt7nYvuESLz23pPQgvEVO4ydVcYs/Cgy+R3txpQmv
         lpT9sBwOzxSTC42WozDZGesQ9bTWPnOFa3hafDfag27RybyWJCh2AKhaDwUMbWZBM0vs
         PEZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787329275; x=1787934075; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EIsN5rKzbFhicm7vK6ZvsuC9whEPX4hvy3159fOEQI4=;
        b=JAgnzEYiYebUaIclvAiE4YOAIAl9NKsP8CGYCZlDERI1Of4rZvvrB8imSTHhyrhDR/
         YZ+18ahgiYVzXWNdjnIIgBHaNXwjWpKRhF3zNioM/EqD7QIAExs6/EOss7leqMKazNZ4
         CizW8/lYx7M+dl9yqbsnFG78iAYDb3hMB2IHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787329275; x=1787934075;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EIsN5rKzbFhicm7vK6ZvsuC9whEPX4hvy3159fOEQI4=;
        b=Vp8Vgou3XzhhpWnceOh7VaXd9wh/4nPdugG7C2iV5R+DpK2RJ5Myu9hPYWrf0holZP
         Mhui2I0uuT/cmSp4yCOfySv+Fg/ohcNN9E3RwF5tvNhOArwdPDEpX3ybuNaHaspvVXKq
         8+/s7SEDeI24zyxWjkycoL8er00XFgnSuP8AOucvN3da40lfP8c4vj4cB1IO9L8Jkshf
         MNKHhgA4/nLY8/XpzKiGl36qHxv6oxyRW3eGLi7l9QXRy4z00N5/S55j1EW3vRKy3+Qn
         BsEKvLqMEmK+ZzYsHgHo7PTPDzE4ieh90HBz17UBqmPhkT6xViJ/JyKiPtpaQxrebTCr
         go2A==
X-Forwarded-Encrypted: i=1; AHgh+RoOCc4bAXxf12Cuvh5uAEqEsVR0vOSpPm9XGqzwgG1Oo9o401MyZ3sAHwFKOYqfkUlfuP/y0Sb9i/7rVtwN@vger.kernel.org
X-Gm-Message-State: AOJu0YwLxGfuQbS+Nq8biJa+v+t+Bh2GGIuQ8K98stiPMjyXnSP6wipU
	61iw3vqYtvaDoBMfPYHLp7SiTCIIALmK1PH+Y8d9qVoRnDkCdkZxWhd1BI/A27fQdhKDatg2qDj
	WhB1ZihYwCGSRnH0yCQCAVI6o0wP5ECydWHSgzxWltQ==
X-Gm-Gg: AR+sD12htADnW/zGJe2RHCKp1Y5bQcKjbFaQoYUwYqstLDBvKFelpvJJRkXUQ4duDQ4
	pPO/Y2f3fN50o9r6a7s2Af1iCQj3FDO0bxgErF5LiGpnLgqwnZUtWPU90RuvwQTLxAksR8stIN3
	pYZ2Blt9spa/YzplpKghAl5fSg1qrdMpdmUqzxCBmwURCa47O+6ra8VGWvKCS3iK9yZIVY7FWDw
	w86PaCgxF65/PCbZADqg2wNvwRyNEy8Nc5comntitk3j9HOWxp1dySfWBNXmW+r678sTPX5U9sn
	PKnh0fCtJdkS42UkAh5kLOsHBrQecB6N6iFut5chFsEBUJU0nkDXZGLtzNVGKdKya2N1DpvbQ77
	mXv5SpCNJtc8c
X-Received: by 2002:a05:622a:c85:b0:527:f4d0:4bb8 with SMTP id
 d75a77b69052e-52df5a3285cmr73316191cf.22.1787329274626; Fri, 21 Aug 2026
 09:21:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820084933.GA4036497@noisy.programming.kicks-ass.net>
 <aobDGgivy43cz7xQ@google.com> <20260820091018.GA4120091@noisy.programming.kicks-ass.net>
 <aobGRjc7SE1rwIHu@google.com> <20260820093402.GB1837346@noisy.programming.kicks-ass.net>
 <aobKfyGHkdMcleoc@google.com> <20260820104111.GC1837346@noisy.programming.kicks-ass.net>
 <CAJfpegsSzOqs1zkhB9GZxsT5HT1zXDbHsZNEbA7P7mxe0w2dng@mail.gmail.com>
 <20260821083000.GF687043@noisy.programming.kicks-ass.net> <CAJfpegvRw0Emd=2hsEeg3AvYaLgRBUbMdo-=eUMa3FRFfnetgA@mail.gmail.com>
 <20260821145752.GG687043@noisy.programming.kicks-ass.net>
In-Reply-To: <20260821145752.GG687043@noisy.programming.kicks-ass.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 21 Aug 2026 18:21:03 +0200
X-Gm-Features: AcwNN1XIGk29rOsZySV5Qx_mWnay4f675UKPGMfF70APbIOxK_wUlQlG-iEgkZA
Message-ID: <CAJfpegtv6=40SEsbeVU3RpmjwZSY-FLvCg7mcxf6k7djFZrPHA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: permit freezing while waiting for request answer
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, fuse-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 16:57, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Aug 21, 2026 at 04:33:57PM +0200, Miklos Szeredi wrote:

> I suppose I'm not at all sure how it would differ from having
> mutex_lock_freezable(), or how it would help in this situation.

This patch allows freezing with VFS locks held.  That allows freezing
in some cases, but still fails in the contended case.  To fix the
contended case we need to allow VFS locks to be freezable also.    We
could just replace inode_lock() implementation with a freezable
variant, and that would work for fuse.  For other filesystems, it
would could break the freezer due to various locking contexts.

My idea was to make VFS level locks (i_rwsem, s_vfs_rename_mutex)
optionally freezable.  By optionally I mean normally not freezable,
but certain filesystems (fuse, nfs, cifs) could make them freezable on
initialization.

Adding mutex_lock_freezable() and moving this logic into the vfs would
mean that both fastpath and slowpath get the branch, which probably
doesn't matter in practice, but doing it only in the slowpath is
nicer.

> Anyway, I suppose that in this case the fuse server is responsible to
> communicate this dependency to the kernel -- or the sshfs fuse server
> should use libssh and embed the ssh client inside itself, instead of
> using pipes, dunno.

Quoting you upthread:
"Also, you'd be putting suspend success in the hands of userspace, that
sounds like a mighty fail right there."

Thanks,
Miklos
