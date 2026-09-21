Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082431E822
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 16:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790008481; cv=pass; b=kaptWFA8WMNMXCo9yrYaEI14eN6bR5uOm6f+FJTr8FhFHBcJrWOnNkIIC1W82TuVk8ZnBbwOw2JLIIPJwYWNni+mGhQFZb5LVfF12tZ0Odx4EM9B13fqtfd3blmmKDZy8D8j0u5O7FGYHCr9gYJ00PM2QxadeXsR5QvcRly6qNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790008481; c=relaxed/simple;
	bh=kuiDxrSEIN8J9ezICDNKd0tquVfXLiCXEOA4Ftd6YBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QTpyAb/lFCrRoJjWDla/be99IWy4Ybp0BG4I06ho3H1O1MFho3mVTT2xkOkushC5ZVOfoYJTDzxg4ApRve+U0QpSNnsD2Cfyw/5X8qgOc6+t8z/4DkBl8M8hHcderaygx5NvXkYrEM0c99khdEr7tY9lMyqmttubu0wNe+8b8wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FBLkmBzt; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FBLkmBzt"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2db33db4de9so203055ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 09:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790008478; cv=none;
        d=google.com; s=arc-20260327;
        b=L6PglZWr58hD8QeqUjnr310tR3/ubnlAQ3f037T8v2UzWyZmHL4X4LODDjpAbTt/cB
         QximGCYtnbcN7ip6EZOXSUUdanQauJMpO93iPOJbUQEM6uH3Bkg7IYKBJjVxDnsSjThe
         HV30l2QdSfndID9CZz2cIDuWr3pA49FGKnqXa5qcbDJgsbb1iCo2UywRPTsWtRB2txEQ
         qkB8hR09MeaXzYQuZAoZD8pDDVPQmj6295at45rXag8GiilfTJOQQriPhIB+AlPuZYvk
         4QIEoUmCTqUPHLYqknv39S5KXFwbHcE4euDptDZAQzWnbTFQbC0JJmGjuOxjClIEcvZM
         BFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kliKxOI53d9NkLdHEKkAIfr8jGGob78nnqNash+0m78=;
        fh=O9JqZhOSuA+41b32rqMntnC2Ig7mb+8IjuRt+QcNG4I=;
        b=LgTrKBUHF7IN21H9abcIXpphLsaLhRJUEv9laMuYJB5W8+ZzT3bY32amqToneC6ApG
         7Vv2xA6WOwKdFUwBQ/GgcqR/YlEAGwkSEYv6v9Zm7vWRbZ2Ds6CQlCOaRWnH0yVP7EHI
         fJzJ3OzlaBe1l8ztZ/x5Z3aLjqJZWBlrW6W6Djl4d1DJCGHDFodbAEfj6AvR1MPEKNZy
         nfD7eNhawkbYHFUKYRi59Q/I7TeiONrbDZ/Vf7C+68AL8a5opClBSAIQ36kMjlFJwAsr
         qDoYbF8ScKW3iRfdIaxMA5KvhP2k1Mp9y92QX6d9KLy90LxN09tRoz75BJpGz1l0SVnJ
         n+wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790008478; x=1790613278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kliKxOI53d9NkLdHEKkAIfr8jGGob78nnqNash+0m78=;
        b=FBLkmBztRNkV4OQki9A4fg83iZrGQejbt73vDAazxfwB29HMmWGoGWCV7tgXdQ+PXd
         l5KCxfbe2zo1z/nkrDVygE6EIQL6ySWQ3aJYazwKPq24aAJp8qvUj/jLCZ2Wx46lcMt2
         mq5JwQ/NLin5ueRe3syzP3G3YGWy2YupV6TH5api3AO/ZQ8rAKFMKmaicOD9ZyAikaDq
         0T0i45V19wseCJdvoz/Fc7j+88TWMJNK1WWFi6sZncavBOeDolGOwOVRTXVk0mEiz3AQ
         NrqeB+xlVyVSD1IKG5wwO3hjm5SmYtIWgZYhMLTzoOkgzqkvPPtn69WQJzgWM6SNphs/
         xY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790008478; x=1790613278;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kliKxOI53d9NkLdHEKkAIfr8jGGob78nnqNash+0m78=;
        b=fK8EQVTwe6bVrc6xuEM563yMx+NsYv5ukggKWfeqAYWlqFNKwMOXOpE5lX3qzOQYqJ
         VSCU+/lAdklhm1N9Ik2rpA9m6oFZJgFPpowGtfcRYWruQe1Wt3Vq8jgQeoxQr2Tv+ww5
         lEB2/gOUbaIDHywBCNRDN/1ZTklYDaRpcD9DbIhgfez5pCc65sp7240URy7dhfYCd2Gl
         9QDhUB4BrrDk8njxKHBICBBjcdn7MhfV9MmmG+fqqLC15J+DuukpNeFstm01hJs4HVuP
         egagNmjU5aWNiXOpGC8l0wRbg54a8+Rd5Gnz8aG+XWhU/hCqtwwmHRjn1UEEKFTGuDYe
         3IwA==
X-Gm-Message-State: AFuF++ksmsSf6KxXMm5UGG323+9KqZzmaG1RDgIcwUpm7kqkTnJlQ+L9
	OQxsYcmBMWHgr/BqPvvdn2ywwF6NdSy722fz6NaFfGtrFIl93vEYnowMv0chBXWOZEeo3hW95gR
	VzM233Cg9ARmS28WbBWwTDSJC0Wy3+hPF5/2HPLhW
X-Gm-Gg: AYBFou3MTTcAMzDr/w5TEr6G9Ic93l5d+UN+V7+e3dwUCAlJd+DJ1waBdxyn3CUcU7K
	sNdlQdO/dHBhlIUNQyefsluuaH601f/AUub9/WD7RMtPtv3eQ/zvB+Oo288YN7XTuitrszXjyjN
	2GZIykpPbhqKD6ja1PcYHB733tP/HJQvnPL9Mzo11fvGm0x19EEw96N5LRoGlwrIGYPn1dfEpqf
	XkKFHOKPBuW5Vs6ch834Z6mvkudzvEruynmkt5J0cnSTtetStaeMgaO9XsSc/N39vaLst80JJ3c
	Z4B2FmD3BCbfOa9TbvEjS0hYmXD0tJi34+dOmoqxXvEqDxNTap0LLSiJ8rWevL9faTSxoJU93gv
	B0vB++/nusO0Expu6c+paljvfw4dHxsfHlRZReGsf
X-Received: by 2002:a17:902:f70d:b0:2db:a1c:be59 with SMTP id
 d9443c01a7336-2deb4653afcmr12695365ad.7.1790008477460; Mon, 21 Sep 2026
 09:34:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Sep 2026 18:34:00 +0200
X-Gm-Features: AcwNN1VeasSVEMVLdNaPQEsL5yQFDdVZirlUdYDc2hCuV-bTIiAE646ed6GAv40
Message-ID: <CAG48ez1Otqb1DTYOqUCZUoxQBbawxkNqhjY7TcO8n=Pdf2VVWw@mail.gmail.com>
Subject: Re: [PATCH 00/10] files,close_range: add CLOSE_RANGE_{CLOEXEC_ONLY,EXCEPT}
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Neil Brown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:15=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> close_range(CLOSE_RANGE_CLOEXEC) marks a range of file descriptors
> close-on-exec. It only marks them. The file descriptors are only ever
> closed during an exec. This series adds two new flags to extend the
> abilities of close_range():
>
> (1) CLOSE_RANGE_EXCEPT
>
>     While regular close_range() operates on all file descriptors in the
>     range [fd, max_fd] and not on any others, CLOSE_RANGE_EXCEPT makes
>     close_range() operate on all file descriptors outside of the range.
>
>     When combined with CLOSE_RANGE_UNSHARE dup_fd() never takes a
>     reference on what is dropped.
>
>     A task between clone(CLONE_FILES | CLONE_VM | CLONE_VFORK) and
>     execve() that has the descriptors for the child in one window can
>     shed the rest of the shared table in one call:
>
>             close_range(lo, hi, CLOSE_RANGE_UNSHARE | CLOSE_RANGE_EXCEPT)
>
>     Nothing outside of the window is referenced by the child at any point=
.
>
> (2) CLOSE_RANGE_CLOEXEC_ONLY closes the close-on-exec file descriptors
>     in the range
>
>     Whatever the caller deliberately passes down, stdio, LISTEN_FDS, an
>     inherited pipe, remains where it is.
>
>     The handful of close-on-exec descriptors the caller still needs for t=
he
>     exec such as the executable, an error pipe, can sit in a specific
>     range. A task between clone(CLONE_FILES) and execve() may do:
>
>             clone(CLONE_FILES | CLONE_VM | CLONE_VFORK)
>             child: close_range(lo, hi, CLOSE_RANGE_UNSHARE |
>                                        CLOSE_RANGE_CLOEXEC_ONLY |
>                                        CLOSE_RANGE_EXCEPT)
>             child: rearrange descriptors in the now private table
>             child: execve()
>
>     Between the clone and the close_range() the child holds no reference =
of
>     its own on any file because copy_files() only bumps the fdtable
>     refcount. So a close() in the parent takes effect immediately. The
>     unshare also never takes a reference on the fds it leaves behind eith=
er.

Nice, I think with this we'll finally have a way for a thread in a
multi-threaded process to fork+exec without keeping O_CLOEXEC FDs open
longer than concurrently running threads expect.
We probably can't make the UAPI better without introducing some
entirely new syscall that operates on file descriptor bitmasks /
lists.

> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

For patches 1,3,4,5,6,8,9,10 (everything except the selftests):

Reviewed-by: Jann Horn <jannh@google.com>
