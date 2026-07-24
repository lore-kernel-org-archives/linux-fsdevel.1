Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F073264DF
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904908; cv=pass; b=oAu7K1n3BLZ4ZpnQ0ZgQdKDtZcby4ZSGkPPv3yrrc9NcM5xZDUpOmpMWQ5pKJDP4TgZhVkykgxzhs+USIQoR7YAOOK7YYJ4pFTICfQ7rPHKO32ePAmrsTYBJqgcqdLkjyPkJzFpGLsNzd74hJrBRv3S+pIFzx+k4jD7WG/nhe7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904908; c=relaxed/simple;
	bh=kpMjNZNgdYIQYqPmqnipeWZQzRgR5fkO/2IZqrlrU0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=No5Hgk34W1Mr+6v/PtG+VEP3sq5MmufhCBOKEhLQHMvBP8/boC75skQE/RNfKkpwBFVu1YjZbmHuhY4QfjW3QmV6RXCoCAdQAwG6+G2x+feVIQOWRp1/wzXD4UlwSlemlibZoEzqIDVEFVmO7zOLfnaxECnbQQ8MOOj97U8ACWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gWoUOUwL; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWoUOUwL"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15e2dab83eso90521366b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 07:55:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904902; cv=none;
        d=google.com; s=arc-20260327;
        b=Cyr8aZqkj7k70552e71WuGxdke+QQg3tQ8r3YhCIa4yZ/vyiGJGWXO14oa82m3EsH9
         QSXLdNFaqHGcZ3IiE15l10OUEn6v1mBwtmw834gxzKzwKWMvCg5FN9nZ0DDoSWkTKI0w
         4EKFa8d96cIJnWURanlXpIa0mgSW0qWxsZWYu0k3uer2iaOtGaawpdITe0pNXgvz1Mw2
         cp/qZ5CKVjV71VWmSJnfFsxlA+HecVMkS8U8o1jJLNC1liygkhAei2twwQY0tRDUDIG3
         B/JWWxMryYhi3je7PIXa/Rp7Ybl9gp3D7tklOnZItiKZLMl/6bLfKbgbDWAvfX5z2Ta/
         NMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6+w9Cqa53E/ogCLTFqoVQ0g0mEA6Gg2KV+D9LVQmZsI=;
        fh=+UBzFLcHUNJuP0yGmDK2l6HkyfhpOhmos8llW3z35wo=;
        b=gR6yf8cPyKlp+OEiDXRgk6loPqtbtM3Rg+CxIv1keHOM2Sa3SU8/JsSTg6gZ+6Fcws
         sFRgnm+9621Iev8ZMDABbxWHtEDZbwL64Z7G/oEq3yC/5jqI7gd+/eDi5i735ESFAa5r
         cfai0iFrRPxC4VFxrTIi7+GjGMFf82qOmg1WbHjRGi1DoyiVtZG6N5ByT57si8SDA50x
         iiWI0yGmWu0oTDLZk/GiX6pgEuWlSH201i3rkoa7JfT7DvA0CvsL2/hhzxLTM1E1YoaJ
         Bb6S1aTON7Oof4higFaGJzau7mIJ1ahbP/YLjn2fgWHlN/Qzqipq/km9wmXYZ0EfVNvK
         Fp9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784904902; x=1785509702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6+w9Cqa53E/ogCLTFqoVQ0g0mEA6Gg2KV+D9LVQmZsI=;
        b=gWoUOUwLAeQ398aafUFrK21fPzFtmDn35jgX7LEqcgYnFn6juQx7Va1nUD7+jKUv8g
         5ecGPvpGEywTt1YK5oEt63obQaWUlnqXmUNW0ETNJd4aN43+PZQ6hkkF/jF9Aw7x5d+o
         TNuywdSP+E+3z4c1/il8QjfN3/iqwdNn2zDINAnlr38+ioqCC0cEVd6aS8acppIfOKqA
         fpbH5loqmhH4kjnJW7bQ22HWr51vnweUxzwxcBOtcxoh1t2NJCwsd1/L4A1e6+bLlqxZ
         vYjWHeZMbztMIf21w5g94Q0S+JuOmELlsrMSSTjSdJ9h9ABwQSp9vxp04NYxejD7aSCX
         An+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904902; x=1785509702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6+w9Cqa53E/ogCLTFqoVQ0g0mEA6Gg2KV+D9LVQmZsI=;
        b=qNIPoxkrT5zzgFWkCzDToBiGNSKlmjZZkzSN5MM1Hn3Gl/ahH6nIBGgpXWwBqdJ3fr
         moVCScPzPuu23q/OpbbZsVzfyWMJRArl+W4oklDV1kpIhLUYXMzs69izWUF0CiT+3I3E
         6HMmgBDHIyBKhGXyS9fvLjjLnu8zgQW66sGOcWtJyLATO1RHf/Jo7haTtWvPfKGQQ34E
         5jLdewVb+zHd4oDEfysGVbxkCQHL7XLG1pui+l8iEyXbGqpIuax14aAwZ7LLMMlV2WsF
         lqQc+/t7gY4YKzqOECp1koAV8+ZY8MBC8dXqnQI+F2OsA/Z2A+JnqZZtpIPlNmEaF3Nz
         l0Ag==
X-Forwarded-Encrypted: i=1; AHgh+RqaG9QtVhRfP9h6OHOeo+Whla53tUervIdU+UlT7dUtY6QPiyimqzBJ+ShycKBBUeqimXDO4QClDr5rMOwY@vger.kernel.org
X-Gm-Message-State: AOJu0YyXnbBi6lrDfyewmA8qpThxkuiZ+TCahprWNGxXjMGNXbOoGdYR
	fY2mkmGpupp0VrRhjJFQjUMpmIGP4UHbP6ecNU8TBp1WS+0+ANTIfmGUXpu6E4EoanwDrtPM44X
	kXa4mvC2gRKo7zSZ5mfr9nTcOePpaXws=
X-Gm-Gg: AR+sD104d682wH8V4LJ0TkmQTkwriIFiQg0wceIWRe3FBFzdC+jThNyLxqcGAsTs1xd
	LY6I5Q3JATJvS7JobIUMuBpqSAcTg9Mqfc22O/55GcKbdB5aZo3hPS9KKTl8OvaU0EljtIm/76X
	H9i+2pIc9PBbMyAWI3ugUhmZ1OXTYXrcUWbj4e2S3DVTCfpnbXo+arnx6/YRPOVnauSTUv80Sai
	/soURMnNXxtmeO4rSHR3OnkiXymU8Jr1kKQt1Gl5eJhCqvt39+X+CmI3dCD2QuIhGvniBOdsAMg
	EjPpq5iXWEq/O9MBjw==
X-Received: by 2002:a17:907:e1c9:20b0:c12:a588:4113 with SMTP id
 a640c23a62f3a-c1c509eb941mr238536866b.29.1784904901823; Fri, 24 Jul 2026
 07:55:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718104406.27897-1-2045gemini@gmail.com> <aeufm5ugcaps3rlvbii5a3gbjo5dqosatv4tyqjuyekt2ibl5h@xkbmjuqfn53x>
 <CAOPYjvav+B3pVhSEFdBRSQ5nfLMhZcfyGATb61+CjAF2YsZ39Q@mail.gmail.com>
In-Reply-To: <CAOPYjvav+B3pVhSEFdBRSQ5nfLMhZcfyGATb61+CjAF2YsZ39Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 24 Jul 2026 16:54:49 +0200
X-Gm-Features: AUfX_mwPCNLflx_eagmko6gl2HH1dxP6oKjWjyhE6V-G3v8RdIEZRzSsz2r4Oeo
Message-ID: <CAGudoHFoACWSwNTiDrEhav2KQOGsAdUmirxC7gcxzrV5ujw8Mg@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: pin files while checking reverse paths
To: Guidong Han <2045gemini@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Qi Tang <tpluszz77@gmail.com>, 
	Junxi Qian <qjx1298677004@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 5:58=E2=80=AFAM Guidong Han <2045gemini@gmail.com> =
wrote:
>
> On Fri, Jul 24, 2026 at 3:51=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > On Sat, Jul 18, 2026 at 06:44:06PM +0800, Guidong Han wrote:
> > > Commit 319c15174757 ("epoll: take epitem list out of struct file")
> > > intentionally removed temporary file references from the reverse path
> > > check list. At the time, both epitems and their files were freed afte=
r
> > > an RCU grace period, so unlist_file() could obtain file->f_lock throu=
gh
> > > an epitem while clear_tfile_check_list() held rcu_read_lock().
> > >
> > > Commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") made
> > > struct file SLAB_TYPESAFE_BY_RCU and removed its RCU-delayed freeing.
> > > RCU still protects the epitem, but no longer keeps the referenced fil=
e
> > > from being freed and reused. A concurrent close can therefore make
> > > unlist_file() lock or unlock f_lock in a recycled file object.
> > >
> > > This violates the documented SLAB_TYPESAFE_BY_RCU rule requiring a
> > > reference before acquiring an object's lock. The race was reproduced,
> > > causing a wild unlock of f_lock in a recycled file and breaking its
> > > mutual exclusion.
> > >
> > > Add ->file to epitems_head to remember the pinned file independently =
of
> > > ->epitems. A concurrent EPOLL_CTL_DEL can empty ->epitems before the =
head
> > > is unlisted, leaving no epi->ffd.file from which to drop the referenc=
e.
> > >
> > > In list_file(), acquire the reference before adding the head to the
> > > check list. The caller either owns a reference or holds the ep->mtx f=
or
> > > the epitem leading to the file. In the latter case, file_ref_get() ca=
n
> > > fail after the last reference is dropped, but eventpoll_release_file(=
)
> > > must acquire the same mutex before the file can be freed. The dying l=
eaf
> > > can be skipped because removing links cannot increase the reverse pat=
h
> > > count.
> > >
> > > In unlist_file(), epnested_mutex excludes another list_file() or
> > > unlist_file(), while head->next prevents a concurrent EPOLL_CTL_DEL f=
rom
> > > freeing the head. Save head->file locally, clear it with head->next
> > > under f_lock, and drop the reference after the RCU-protected operatio=
n.
> > >
> > > Reported-by: Qi Tang <tpluszz77@gmail.com>
> > > Reported-by: Junxi Qian <qjx1298677004@gmail.com>
> > > Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guidong Han <2045gemini@gmail.com>
> > > ---
> > > SLAB_TYPESAFE_BY_RCU allows a slab slot to be reused while an RCU rea=
der
> > > still holds its old address. Once that address contains a new live
> > > struct file, KASAN sees valid, unpoisoned memory and cannot distingui=
sh
> > > the stale object identity. CONFIG_DEBUG_SPINLOCK exposes the failure
> > > instead.
> > >
> > > The failing interleaving is:
> > >
> > > CPU0: nested EPOLL_CTL_ADD             CPU1: close/open churn
> > > ------------------------------------   ------------------------------=
---
> > > p =3D hlist_first_rcu(&head->epitems)
> > > epi =3D container_of(p, ...)
> > >                                        close(victim)
> > >                                          __fput()
> > >                                            eventpoll_release_file()
> > >                                            file_free(victim)
> > >                                        // the slot is free; f_lock re=
mains
> > > spin_lock(&epi->ffd.file->f_lock)
> > >                                        open() reuses the slot as new_=
file
> > >                                          spin_lock_init(&new_file->f_=
lock)
> > > spin_unlock(&epi->ffd.file->f_lock)     // wild unlock of new_file's =
lock
> > >
> > > CONFIG_DEBUG_SPINLOCK reports:
> > >
> > > BUG: spinlock already unlocked on CPU#0, poc_unlist/150
> >
> >
> > Well I'm no expert on epoll, but on cursory reading I think this is
> > fixable in a simpler manner and without the extra overhead.
> >
> > If you were to add a constructor to the files slab, you could move the
> > spinlock and mutex initialization into it. Then unlock can safely
> > proceed and maybe that's good enough (as in there are no other issues
> > stemming from the typesafe thing)?
>
> Thanks for the suggestion.
>
> I also looked at other struct file users while investigating this. A
> constructor would make this particular stale lock/unlock safe, but it is
> not a general solution to stale file identity.
>
> For example, commit a6dc643c6931 ("eventpoll: fix ep_remove struct
> eventpoll / struct file UAF") used file->f_ep and is_file_epoll(file).
> Immediate reuse could select the wrong free path and cause an invalid
> free. This case happens to use the stale file pointer only for f_lock.
>
> I therefore preferred pinning the file, which keeps its identity stable,
> limits the change to eventpoll, and is straightforward to backport.

The difference compared to other typesafe by rcu usage is that
destruction is synchronized with a spin lock.

In principle, the code with the racing unlock should be able to grab
the lock (like it does now) and verify whether the file got reused, in
which case it should merely unlock and bail as it has nothing to do.
Keeping the spin lock safe to acquire at all times is definitely a
missing ingredient, there might be more.

Can you share the reproducer?
