Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8544543B6EB
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494731; cv=pass; b=eYgBs6Y/8LW4qWRrTWggJfJolRb7czVllMmCqAYSVNAD2EHywLxxKrECzGx5xhVUenCvDnm6kbb7K4R2o73tVurEzUs43Om3bo9yaxd4fkc4DNd87WH1BLCbN/sCk1c2prfKrsUPfCBw2c3aP2Ilp/wzXbRw28KUOq6a6PCkzZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494731; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQjsuqpLuh89DLGq0UIMVPqGWaFF7rDlCTyx+a0nDGp7IqOWW2qfh3YyQ83QxS3k9IvJ3cTdARVbHTU8OOdLNI5Ybjk0JFhGNkFzKC6DSd2iVE/X5F3WLjqsGHnjR4PplrrS6HCXX8jNj9nNST/1Wo426slVDHB+ySEqGQIQXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12075ad.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=GK0mMj9fVpwxB9sqH97WHbt3qe5OfNoCWBayG4XvCVNsQ/Q4aVgnB5jdQ2El8Ogryu
         rwTk+ry88bbKfIdPK6Ea/seezXfmjh025NfHxJMdPG+Xd3DnJ08yGiPlUHQQp6305ZPl
         Nk8Nl7/Pd40pner7nARLhGGqQerRf0oKd3SR69eg/icMrTDYapiiyCfSaUslMBmldFvt
         pm6nPxR4yG96LUgnEwrUZJ/h3y9/7UQr1vvu63nuYGNv7M0N1jL+0BLCEvJ4pxY/a96l
         Dq8lWhQMwElyW0+T4+fWj1NptwZORi8OrogK5hgAxzZc0vcctD/voLzWbI5rhnn3UpXi
         yUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=9iPMEacPAvT85a1n0dwxGPznlasyrLyxV9YtSvLNqAA=;
        b=dLL81A7Dy9bQDQirFSAvCQeJrJyrzZ3BfMbCY3d99bdw0KfbGnnratft0DA9ydT0DA
         RJNb6/BSTXb5rKDdSW57qs31Zf9dishvNbSeHZpqw51mBWfTcv+318JyF1wyyJ6i6hLJ
         f5z8qwCjszRvJ34c2xhD1VND6sSsCq2AohGCLZAf+TWqkEsK32BiqjkMrY8Q+x7dUNhV
         adqJvuZ3oR9vbkvjOXcPNaNgBFmgfH1SMlJTqBfOSS3n0NiJ86Na5Lw3W5oqd75ZkJOA
         qDvhXnRL7la8L0aGinJHAH6hL6NfiwDeo9HqNvtxJG6mBAoexArmAWWQMYzt0Rv+mqFy
         qAwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=joQyXR+vLK28hM6zlstwyjaeworucyfH4ECPgjciA01dV7RNPVaSh8lun812h70vz8
         B8WDbxOBcdQyHtamjjGtil3AOBvJPzc84QZitJFV2JKhDbjCaSfweL8vmEGRe04xMdk1
         9gaC4mkwhSRT2mXP97cegA2Fe6f/H0mxETxq1+N1VvwVN09a22NdhyoG2StEwI44DJsu
         mjpyqtCmruFGjxXvlGa4RWp2G+R6RwKWLIWCVRlG4owayGPTtqMRFFC9Rp5Z1fptEfUR
         Vci1VY2ExHUI0YK5fx52mFq6vCMgWwitmfS1HdmwaLNzlXPumr+YqOU8Jcy6VvVdZbh0
         2rJg==
X-Forwarded-Encrypted: i=1; AKwUvByTGclx+SMUwMTM9oneZKLtPnnEYcDxJlRhTezhlhYrvtQf7a04V/oII1DGalS1jVyaGtBy7UM+290kqUJE@vger.kernel.org
X-Gm-Message-State: AFuF++mBQ2QH7fPYhudtHeY4EBDNzIKKGDQ+/B27xYVTH8E8MTtlJdFm
	yXy/LqKnZyd16r85VkRGknepAECidepZ7nDkJtSoLGSvcd8xJlK4me8EZV6NERDoCrW/2LdxPrD
	YRkKX5z+Y9UDtVW96jWbegbcytXmDiHn3LAutj/t8
X-Gm-Gg: AYBFou1artXl88x6yNaYw+BdRgksdcLckYLD1iE/mLh7s5D0BliGP8yjJ8HY5sGVxNt
	BXHTb7JWR1tvbJwLnxVAb8ot7B6YKby4tVpHQxRvayO3CN4r8V8so0CojtGF4CbRELy0wkWYGFV
	QXe333DovvSUBcBU0t3utNMYhCO6TDm60zG8x4qmpEzuhq19ukZ5tHdy4WdKFswt6yjjCEdgn0q
	lfH06NzVJb7jqs7U5KSaXSAFF3bRmFxqLB6vPCUR4jYrZrqbYIRZqii86qRhzwseI0FumeKEq7u
	092Z7XH1/akp/TjdGvQHT7pzI+36l3X77AN6sAwO7aDLqqsIAoqBiicNkZR2qH38Zqt2/WOOLt9
	36lUFxt4v1YiXm5MUiasJbsnL3yFlG6W8hcj49ssMOBko+iytOSE=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
