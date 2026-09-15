Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C463F4BB5D2
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494305; cv=pass; b=j2JpRK6MU7R11DcSebwLmr8pUG/KpCSNj9BmhOBiKIJTrMFmxFCQy+h6sK7paS9oiy5tn+NGB0LZ3X6twIInqhGUbfjFSZK5O+h46Qp6jYuLWdSi95bwx0ZF/nICUNutzA8um9qhwp8mRK4yDkHDQ/X55Z4Zz34Hr3Js9jtk2m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494305; c=relaxed/simple;
	bh=qLsONXS3rVfAxLm2IhQyHKIDHJvREIlv8BIgfU7zuFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kryoVTP+MkkysqPNrH32l/lX3TX32gEsG+q2i+LX5bA0jlBbQpwF7vmo3lkoYfdvoc73GXd3xerS5VFpwQj4ytBRL4z6TXHcGHWIppF0zFURX2Q0LrL/z0ou7qxIj5yjuzLt2xY64mE3do6SegCpyl78WXrOx/7uftdQmZfCgX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adknD9V7; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adknD9V7"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd84862f2bso6955ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 10:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494302; cv=none;
        d=google.com; s=arc-20260327;
        b=VZvvXT3ci1PpICd5WQNu4AUO8ew8le0MGXF8hftG39bwWC6h78RLctAX/XzjSaxy26
         TkixQqLMRtwikTGxGGMcg3RualzmjYuoSyfEn6czCDX78GiHEY0ojNT1xZM9kRQSZdkJ
         TzeP1PzRlQdiru4y+J3K2DxgvgyjxZ/w6U8JWTwOvCuHXnaiIkEmqVXEoBhESLbiND9E
         1ZDNe65HPbgJJ0/EQur+6Ic0zjnfCPAYplztxrqOq2yt9DPSUpMzMZDTNoTOZ0CoxQqe
         +Zu1JVDB+mriBEZYrgOfa1TEUcXpn2NFfW0c5yOnUNuHH/u/nZt0viFPMVH9ZvZt8uMv
         MjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        fh=rgu4C+q+KcR9rQ6icSUtNnDUYCLkR1Poy3X3kd7QKgY=;
        b=CcjU+WDzaxCptbbS8L6WuLo6M5F7cbfE8klKScY2VaNfq7lDI6dhipACKVQXokvD0v
         cN1c1g9YR67DKxsqTQ8dT2dFdGumy7esXV8FSvilA9Hxjexv0fzd/+uJdfog3QCP6Kxy
         9VXqS67g8JRy5VTWotc1b2Pm2jShlx1zvclckvEPziEweIoGi/JX30s7aDjWnGBP+Q7j
         kEKs6PCrp3rKF/eMPRySfb/hVgjQ372mbs9drxdzZDPQUDwKdFsx4F5P0io3uPnxo790
         B9GMtCWbDZmjvLbXHYriR6iZEtVBSxJ1i6ocYZdSe52dae4n4KqwrNzvjJhQ6jeaVcaV
         wdxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494302; x=1790099102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        b=adknD9V7jyfpjRwECoSNo/2J63D9lwfwgVKhMURNsK+MXIgq7zUXIcJw8yNWHtFOz/
         8jLS1PjaWnzesfXxKaCKoFVhIRc3Sf386mrhFELwYZ0EGfG/T6KbFhSfphIHQNZT/hxx
         bLyOiHiEHuG/CJxE9YWiZHnWf4yfVAL1j/M39bzKBd1S7b6ZAg+MJ57y93l/UqjXALYC
         MHj6wU0X+2++2m/LbniE/vIZd+6uUPw/lRiRzHl4NCzruJ9l5QnduNUDvZ/5JdzR/zE4
         Nxs09BqJV/Tgr2n5Ilvzacv4mYgHllpxMw56rdBgBUmvIEDv8Y8ebw0gyMaQmXqHBHqO
         3hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494302; x=1790099102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        b=PxDMhVKNZY8nJ1mIb5pfqOqGk1s2zIJ6Jn+xUVZZxc/RtV2x3Uq/W4nhc2TO9b8CI7
         fn7EUCXmRrQPnlD+tnPn3gLO2QuaPK+AKYXdiRck32THM1OC0GhfnvjKSW9+eNWNQoGT
         w3ZJrxo/gv8+75Jxdt7XTIdQW4r227gnRaqiCGZVtRyJ8WYxjOZ/GV+G8VJMKIhIkFuJ
         XEMQhOSoy6IUi5C8nOdLFqo4nlMMpB7VA7iuNAtN4BVLuq+6JxbXkkO3zhZTyJBop7hm
         v/bimiHq1VjqRXd2RNQr1Qy1oPp450091/d7egs2FXgUrYc6MdRrZxVHFdArgKIaKoN4
         TtxQ==
X-Forwarded-Encrypted: i=1; AKwUvBylN8+ubSiul6CMGCnL7XlRDSSNze3HC+aZs4u4TESzJrAR4MhaYSmGXLk9MNkyrPiF9Gn34t9DGId1n/o8@vger.kernel.org
X-Gm-Message-State: AFuF++kyxWVvYG231EHpxwgYvKYadMjPk/1JxSYMXMJf9NKLU/IL1hNC
	INUV1Q+beK7VTwzTciUMWC4G65V8NwciERt34pbJzOuTj3TI2WGBVVmXNd30tNy9Zvr7gTTyLmW
	rl+00YCVEtqgYZKliZruP4qjrVzYTuyM2QZ/VeKWA
X-Gm-Gg: AYBFou0l339cDXpQ4yZs0GjORrvjQJl6+SzQHrLIv3yELh6j8KAGPtxDWuffxKAoC7D
	IdOXJd6FCOmjRYTrib0gevFrUwKy3YgRXTzUaLLmPQmxVUzK4ToiVi+YdVuqvOSr6AV2syhruU8
	vPi7RmHfEifjI0mGkFme6qwtSVmkux2fSdPS5rCyllL0M+Uk50iQtAIO4BWvpjGDsGzhcw7nvFZ
	r9v6zdyT00NX1a6JdsFobRw9lKQNIcOkn+wdPx8PO15zZKdyoJ8slZ/hKHwzc+coRrxXf2voB+l
	ScOR7nKzwkSsj1mFb5lwOww1RY4Xdf3NwvAZMDENMsWhElIjAMeVZP4RjLEcHK8Wef3ofeHOVLR
	GzA+8g3baK+WkoZ00vOwNO0x5gyMKCf+yUtPRu/NMmQ==
X-Received: by 2002:a17:902:e948:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2dd89d9ed00mr120845ad.13.1789494301281; Tue, 15 Sep 2026
 10:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com> <aql6gyQJoxEjx0xY@shallyn-amd>
In-Reply-To: <aql6gyQJoxEjx0xY@shallyn-amd>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:44:23 +0200
X-Gm-Features: AcwNN1XRdfxLKSy49OGqywbafRdvs8vOvOcncc58q2Uu2XpqGH8ksJIePZ107Ts
Message-ID: <CAG48ez3THXFA=jF_R-wRNsEA=BfD8X1=pHm7dtVnbOto+rXW3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 7:04=E2=80=AFPM Serge Hallyn (AMD) <sergeh@kernel.o=
rg> wrote:
> On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
> > +/**
> > + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> > + * @subject: credentials using which /proc/$pid/mem was opened
> > + * @opened_by_owner: whether checks on open() were bypassed because th=
e opener
> > + *                   has the same MM as the target
> > + *
> > + * Check if FOLL_FORCE is allowed for accessing process memory through
> > + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was=
 the same
> > + * as the target MM, meaning the security_ptrace_access_check() hook w=
as
> > + * bypassed on open().
> > + * (Current current->mm does not matter for this; for example, if writ=
e() is
> > + * called on an FD that was received from another process which obtain=
ed it with
> > + * open("/proc/self/mem"), @opened_by_owner is still true.)
> > + *
> > + * Note that this hook is only designed to be useful in the opened_by_=
owner
> > + * case, where the subject credentials effectively also describe the o=
bject.
>
> Given this, would it make more sense to call the hook something
> like `security_mem_foll_force_self()` and only call it in the
> opened_by_owner=3D=3Dtrue case?
>
> I only suggest it because it seems to lower the cognitive load
> when looking at this code, so it might make it easier to maintain.

I agree with you, and that is what I did in the previous versions. :P

But given that two relevant maintainers disagreed with me, I changed
it in this version.
