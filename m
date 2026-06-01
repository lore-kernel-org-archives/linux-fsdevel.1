Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27583BED5C
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 14:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324424; cv=pass; b=Pl468UQKV6+gNOTZub584UCJpU5pQ/GfW4UJkmESXZMs/Px6XC3bU309f7O4R+tCJeGg/4codb4TMLF9jZVHa9wdOi+RBtEJsfF8xhoWh2YLiraJbv68GPtUp2Z6VScTvguSApCOe67zshzCk3uwz93kgDjFLrxECzykceT5Coc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324424; c=relaxed/simple;
	bh=GULR8GTNYjJG02pu1RxUY4afkjoy1YBZ+KVu4i0ogU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7OzbpZI43QZz/5nfGjb1Ub4kWPY7cXAaLuAJvmsYWNOJG0OFlkhEsyygfWKIpnUbZsMCtVXWt7V0XGo6gTj/Btqe+Oh+7Idm22ZBQFYir9EWS2bJE9vHCm/UU+W2ed+UGgTP7xRntM4p0cb6D1zhcS5jNBqoNc8Bk7PNwz2zL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ee+8qSGK; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ee+8qSGK"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso2171a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 07:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780324421; cv=none;
        d=google.com; s=arc-20240605;
        b=foE6Twbk9mZWemG6hscGqppw1ZXf+lPBgYtJiZ/mf8Sd+OuKfoptP/RqLLFoEvMMG2
         l6h+LvEji23ft2Y7rttRQ/NiEPgW/d4HNfUzagDMJH8tNuEpXdGTUdLob/FLAaG37Lo9
         jFqEHytRikejx6y/p5gV6Pa7vfEZkz6Ki14iei5PY6Msq6LdYuU5RKn6W48CWi7kPJHv
         gEKEgjSWOo6TQyCw1o8c3zt+7njToukKe05UI7yb1SulfcH7OmVm57dNhPb3dajNIrZu
         qwpchehuR/n7TbDS2uPTJz0W9e1I0XyMVLe7fCBhn02BOP1YYRZxKUY4vn7z1CKBC3uk
         ymtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pGyKaSsj1ZUT9pEo3HgQz/vu5FVFN+mBDg80+RUxJzk=;
        fh=C3VJj0+0Jbwpf0iQbwsRBUuLUeShMbMEoEFyqm31wDc=;
        b=V6g8agUwkks4PVjgOiyN2yndB54kaynsFhm15JSVBXSnhtTUsviynMeYGoSMXlPfz7
         UyfPNMkhQijfmGoDMmPU7HNqm/Ae0God5hS6sJrqHu7pYSxbhu7hiLPDJbZe63qKK7ve
         MUfyJfeHOaKfJBHdudXBRM7N7+pNo6cD4d2Z078f4TO4ofY0+DfbLwae5SBVnH6midwY
         nr1s6SojpiCYUtFpSkOkAqX7NZbomTqVNXZF4W7LXZS25Kp4WmnVQ/TXEVBkC2GIJzv6
         lMNUuqX42RARBPMTVAfFIYES7yQsvcLwbvdBF3p4zn+VSOlsl5BzxVkQQA16YtRlXESV
         s/gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780324421; x=1780929221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGyKaSsj1ZUT9pEo3HgQz/vu5FVFN+mBDg80+RUxJzk=;
        b=Ee+8qSGK2NBOp1CIyw7GVqU2VJYBvRfPVmGCntCd6k+pIULSd4gtieP6COdvmwMVMM
         xSxH6swOTIv/A9J98xQJmtsmYV4GA6eeU/007A0hiZBKqVwAplY2ceFgJ6ANlgIwL/0a
         u+sWBA26/O7M36TNEIRWqUUgnK1k6vU2F63DGV0ZmtNf33Pm00qL+FqZOKHDJKlLvBiL
         XjaVoyn7rSgQ0SE3ImRyFv0XP//QbcDxWVEWjCKx9FWHHHC9sIMyQuuhZ3MyrKiNbOEl
         7/9omz96RW5pGkrikphXGGVQJ207+zT8ihN2vaNEfbxdyYGNBsZwRp4BQl0ciolqm/xm
         peSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780324421; x=1780929221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGyKaSsj1ZUT9pEo3HgQz/vu5FVFN+mBDg80+RUxJzk=;
        b=NvaVULkwtjOt1hUgZv2KZHJwqsHscePXxQ8iBDLtgdaHtzo7bXSxJQjff3OBzh8S1X
         ls+zFm96pir8Aeu9Wbj9F4bJbLIbQWKg3fu7ICn56xglzKOOTeXgfO92U1T+cwUuV0rD
         7OfFlEpefpWWQt+pzUzhWRNqzQju1m6ODIW4DPv6HzZMIHQkeUpSQFPB/wn4kk1MwfVe
         xQejY75mQPQlwjvecqlJ22t3jEjJi8oPj95rHcihiW3shfAQOkW0yV2pvwlMNSo3LvvM
         7heL8ySruf58r6mE9SE5KorQpE0VU2Uz//iyzqW+3tn1fDoh11YtHlyei4s5/za6ls2U
         AVrA==
X-Forwarded-Encrypted: i=1; AFNElJ/rzjNqBe+Oa4flpbaiVDLwQVgkdUcY+kfQ+m74e8PbcPXF6QMf6bpD5N509oO35CYMZjpzGw8drYP0d85V@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZzmPumZQ/DummZgPBQmM3zFcFeTyvukuA0cptZEDmYpArlSd
	jeEfNX/ZFPtgAvbLSzoe008Fr0cpj4qGOhZlkA4xuckwM+ABdLwtT/ta/tsw04rish0AoGWMWO/
	Rgjapl7jZ8nNH2tkKAwpCtZ0RAu2O/5/Vv2t4A0jGwOyElXNSRLSlHTNS
X-Gm-Gg: Acq92OEGx3F7drmHZJc49H3028Oghx5sJXEOMUc5R7o3XvBDOgKRH/1XXRtVK1/uJxx
	8ZgKG/PMZJ5MH4HLrvA1yKWtytnTArJzaW14wJ7jsdPA2Pz+iT3GO1JPoEYDrXWu05VUaW+W6h2
	7WLkmG9m1K7qj/inPFVcx/fygD2/wM6T8SoQ9qzoyrKL5XsOlbSfSfUumaf+1jpYnc2YnE4ZZCK
	/hjvy5g7+9mTvKhV7YoRMqC7ShECtZcs5LlDqPiaG9+e/BDgKTPQBzM+D5Txla/C0+Mo/HJomW0
	FOjYxIb6X6IJvneKqMaMCl0gsv9eGSVrlTrL3HsU1WmcnEjVOyR8zvQvtw==
X-Received: by 2002:aa7:c1d3:0:b0:670:9e9f:1a5e with SMTP id
 4fb4d7f45d1cf-68ca1154309mr274389a12.2.1780324420762; Mon, 01 Jun 2026
 07:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-vfs-mnt-notify-comment-v1-1-5becd17a15c3@google.com> <qyxetdsywarovuartxqqeazkqpdedsiwam2pke4ocaqgv7sspw@rgkyf72i57zo>
In-Reply-To: <qyxetdsywarovuartxqqeazkqpdedsiwam2pke4ocaqgv7sspw@rgkyf72i57zo>
From: Jann Horn <jannh@google.com>
Date: Mon, 1 Jun 2026 16:33:02 +0200
X-Gm-Features: AVHnY4K9vTpEIg-RT3pHtu1Yu90udfdzT-BmAu9MaDGltJuN3VT-3WT20fxfEqY
Message-ID: <CAG48ez0d-tbu09=nNWx3ePbhrvKH0VAdFHFmBoGyr=V_UZ71Qw@mail.gmail.com>
Subject: Re: [PATCH] vfs: document locking for mnt_notify_add()
To: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mszeredi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 3:04=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
> On Fri 29-05-26 21:38:08, Jann Horn wrote:
> > The locking in mnt_notify_add(), which was introduced in commit
> > bf630c401641 ("vfs: add notifications for mount attach and detach"), is=
 a
> > bit gnarly.
> > notify_list is protected by namespace_lock, but there are cases where
> > mnt_notify_add() is called without holding namespace_lock, for example:
> >
> >     __do_sys_fsmount -> mnt_add_to_ns -> mnt_notify_add
> >
> > Luckily, in cases where the namespace_lock isn't held, the namespace is
> > always freshly created and can't have any fsnotify marks yet, which mea=
ns
> > the notify_list isn't actually accessed.
> >
> > The existing comment claims that not accessing the notify_list in these
> > cases is merely an optimization, which is wrong. Fix the comment, and a=
dd a
> > locking assertion.
> >
> > To allow mnt_notify_add() to reference the namespace_sem, move it into
> > fs/namespace.c.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
>
> Thanks for looking into this. Adding Miklos to CC who actually wrote that
> code. Also in cases like path_pivot_root() I don't think we hold the
> namespace_sem so the locking is even more complicated if it is correct at
> all. Miklos?

I was confused by that code too, but it turns out that actually does
hold the namespace_sem - it's just really hard to see because of
__cleanup() magic.

path_pivot_root() does LOCK_MOUNT(), which is a macro that expands to
LOCK_MOUNT_MAYBE_BENEATH(), which expands to something that calls
do_lock_mount() and does a `__cleanup(unlock_mount)` declaration.
do_lock_mount() does namespace_lock(), and on return from
path_pivot_root(), the cleanup handler unlock_mount() calls
__unlock_mount(), which calls namespace_unlock().
