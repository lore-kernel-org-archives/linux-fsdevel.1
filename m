Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02031364029
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 03:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784865493; cv=pass; b=gcSS1NhiPPAHg/qb+8OdDGF/nRjQ0wamn4L86jWBnDm/8tqkcycMawvx0dLzhR9mL2LhuP3DPRM3USYSQFX7vcssfCmlmiLhPxIz4X9FtZ5ImRJ9L0/FItgpEEMjD6qpT3FdSFN4PO8ltVV93DOPLGZ7/nlmBLshR6o1apTe67k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784865493; c=relaxed/simple;
	bh=Er6j2BQ79ywPHO/bPdJCsQ/wMR+qPlt909KeHnA4smQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUIzpEBFJsmAuQoR++rhgSPZnq4bG/0qwt5KGh7TKoyyIV9DIZTF5rv2i/3nsAiSP/8QaNz/FD/fVV/nsHCl1hNSZ7lVuQeOIB0mGz7vjvk0ZLMjRV5BpiilkvOcTqEB7B+Swp+fowvVFYpeUoVkKpYI47t5eeUvX4YSUfgRKBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWOZNFRs; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWOZNFRs"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15e2dab83eso1345166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 20:58:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784865490; cv=none;
        d=google.com; s=arc-20260327;
        b=af0X3nIZJYiRtWfReTS3SayM5/UidylAHVXgrEwez0c7o148Qse9FDm5gPAzikkIVj
         gKy/uJsmxmrDgKLP6bsDOyhAInIh1Y06wyigbGMs4mPuFOUENcjtCkZ/FVRinH+Hf3ty
         Ng24AYXdtsbCxhn+FctTcw1SDdkSmsT+5jpFgQyuSdZ0h5s7zhj1gD4zOpigo+ePsKYD
         gf4JWzNNImXO/VZXahFheXheLnYbavR1mXuQnOSJzwU+QbRhceWnskuX9kRjMugxJVjP
         YEVrSgzLLkpyeyqM0UQAXMaMYbBxESv/VDuZEi/9Ad8jAaFa0Zu4JjC18K/+Rfe0to/s
         VJpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LTscAmBqt1cQJadJc/qOKx7Fjs2i1QrmIbh+9nwETiw=;
        fh=h/gROYqUOJbutfmcHh5KIbKyZt167q45GRTiXP8tt0U=;
        b=sru+SXb3oSkQvzAx5QnXIP6h0J2+WnxMlws0VWTH3V5Pa5kXxbzXRx15vDE3gTKfZk
         g0kZbbcccSyg+8YGtWOCDn3DwFI6QXe7ER/lOub1U7OrxJ8G9ZZy8DdLVBNkjBfDaZ1q
         QXqziyhzlcoC8VSUaY/+nrpK+mn2POPzc/qX14QWsP/NriUeKp1jtszM8bIZH28A1uK3
         HqhE3d2dgULVdLC+ayM/j4jwogUraL0JhXW7O8QX1aLRXcaGfPbENuLkymzMnTk4kzcx
         Gh7uDtw2ibHgXDfYRKgeVOArohbodfVYHqP5sdBp0uYDcTSvZyUbCAS932rVR/oWh2yo
         om/w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784865490; x=1785470290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LTscAmBqt1cQJadJc/qOKx7Fjs2i1QrmIbh+9nwETiw=;
        b=NWOZNFRscL9kGXS+I1u9ZbNDpS4mJV8KKjJ7Qe4uCjlAgocNfHx61bR6ELm6vodqYE
         iv1NMYcmEjDDp3jg6Oe+y4sqHQTb5yvd9bXTKoquVmlC/6qsVOeUj0Fxjlh1d6/x2EWJ
         QyFbOsrFa4iFI25IlCPjSGUnYgJZP46Onma8OIZfXsNX0t6qEVuuFeavhMO0X612jU0L
         hT18cOLp+NHItKeSveMNcKdhl8QBUDSBzQK1Fx3a0ciCkCeJtTvK4f0oN9vvUH5qHqgj
         WgMMuYfpcu6rEeFzgJdRkufAriWnUkPscm9ZD9TtV/Xjn5MYSJYHcywndmZ0URIEO5OM
         AK/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784865490; x=1785470290;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTscAmBqt1cQJadJc/qOKx7Fjs2i1QrmIbh+9nwETiw=;
        b=cOeiUjoSm4FqmnpWHOmIYdgHOGVpTwGkZWL3L5V7wjCY3VSjO6KIhU6UFJnR2jO78T
         ejh/txj+1zNdZvGQCgsSGbqBTGVJGTeM5bcAJbVUOXbKgI1nZikLNaGWJ/vli8s13Uhc
         RzNVU6lki4ZrFzsK6jOhNcrB0L7Xv08kH1rLmK8ghcjur/6q0pAp9a8UVBNfoxMnejqv
         Pcea2R1j5Idwys8NCe6vPdkbuYRp+3+bhZ+rm+UdIST2nOnq440J1NKjwlY0o493Jgxb
         jE/LQPFruX7ZfzixbPsiX/tSh3qX0ySEw6oPd1kIWOo1Jwt9sb11zWoFRVu24cZisyXc
         3W5w==
X-Forwarded-Encrypted: i=1; AHgh+RoLPvEWiydObLNpe5jeKTicuItizdrVLp9UUY6prKBUxr84H3CsSiHmS1ZnHmqjv9/v6cKy1wMlexZLPQJT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09se1v4ZROMosZCf5EdnOCCUzisTkGpANTgUhAHYhML3wYt0s
	TCOnJ7ylgP4RJawBF3zve4djetexiK/kPy1oBF3zKxJC0j/bpJ/rVAIT93a5GGZveVsizWTnoBz
	/1EKBNmzzQVLRK4cJCaO8HPU1Durrfvo=
X-Gm-Gg: AR+sD11SAjx0H+PDBTbnM+zzMOZzYzGzl20VgItSEYLAuArvPZhz8EnDtZZXP/rSjgi
	kQ99S0qiYGJz92D29fFlvrywmYaiDxO1BE15XU/L7EzO/Za8TnK/VySrFXEo/qTuWPMs/mL517a
	OPAgN5zGUmZc/jFWLruYNuCy4IzfP77sqo/opUOXy37tBlVvG0GDWMJ1boI/FNxqDPLbc8Ep8ve
	R2VGnuZI6ZFq96XdihCk5Phfaxfw8aeYwKmg4MQWSyRt0cHv052elTFrjZ03I/6NLwlGv6vnRTq
	BxTIVA==
X-Received: by 2002:a17:907:f495:b0:c16:5b32:32 with SMTP id
 a640c23a62f3a-c1c50bece84mr263709966b.31.1784865489990; Thu, 23 Jul 2026
 20:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718104406.27897-1-2045gemini@gmail.com> <aeufm5ugcaps3rlvbii5a3gbjo5dqosatv4tyqjuyekt2ibl5h@xkbmjuqfn53x>
In-Reply-To: <aeufm5ugcaps3rlvbii5a3gbjo5dqosatv4tyqjuyekt2ibl5h@xkbmjuqfn53x>
From: Guidong Han <2045gemini@gmail.com>
Date: Fri, 24 Jul 2026 11:57:34 +0800
X-Gm-Features: AUfX_mwAZ3bwv8A7bfNoMqy7Xg2WrKkPlOYoYlHNjah-k9aEwq4DVYps8hGtqFk
Message-ID: <CAOPYjvav+B3pVhSEFdBRSQ5nfLMhZcfyGATb61+CjAF2YsZ39Q@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: pin files while checking reverse paths
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Qi Tang <tpluszz77@gmail.com>, 
	Junxi Qian <qjx1298677004@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:51=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Sat, Jul 18, 2026 at 06:44:06PM +0800, Guidong Han wrote:
> > Commit 319c15174757 ("epoll: take epitem list out of struct file")
> > intentionally removed temporary file references from the reverse path
> > check list. At the time, both epitems and their files were freed after
> > an RCU grace period, so unlist_file() could obtain file->f_lock through
> > an epitem while clear_tfile_check_list() held rcu_read_lock().
> >
> > Commit 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU") made
> > struct file SLAB_TYPESAFE_BY_RCU and removed its RCU-delayed freeing.
> > RCU still protects the epitem, but no longer keeps the referenced file
> > from being freed and reused. A concurrent close can therefore make
> > unlist_file() lock or unlock f_lock in a recycled file object.
> >
> > This violates the documented SLAB_TYPESAFE_BY_RCU rule requiring a
> > reference before acquiring an object's lock. The race was reproduced,
> > causing a wild unlock of f_lock in a recycled file and breaking its
> > mutual exclusion.
> >
> > Add ->file to epitems_head to remember the pinned file independently of
> > ->epitems. A concurrent EPOLL_CTL_DEL can empty ->epitems before the he=
ad
> > is unlisted, leaving no epi->ffd.file from which to drop the reference.
> >
> > In list_file(), acquire the reference before adding the head to the
> > check list. The caller either owns a reference or holds the ep->mtx for
> > the epitem leading to the file. In the latter case, file_ref_get() can
> > fail after the last reference is dropped, but eventpoll_release_file()
> > must acquire the same mutex before the file can be freed. The dying lea=
f
> > can be skipped because removing links cannot increase the reverse path
> > count.
> >
> > In unlist_file(), epnested_mutex excludes another list_file() or
> > unlist_file(), while head->next prevents a concurrent EPOLL_CTL_DEL fro=
m
> > freeing the head. Save head->file locally, clear it with head->next
> > under f_lock, and drop the reference after the RCU-protected operation.
> >
> > Reported-by: Qi Tang <tpluszz77@gmail.com>
> > Reported-by: Junxi Qian <qjx1298677004@gmail.com>
> > Fixes: 0ede61d8589c ("file: convert to SLAB_TYPESAFE_BY_RCU")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guidong Han <2045gemini@gmail.com>
> > ---
> > SLAB_TYPESAFE_BY_RCU allows a slab slot to be reused while an RCU reade=
r
> > still holds its old address. Once that address contains a new live
> > struct file, KASAN sees valid, unpoisoned memory and cannot distinguish
> > the stale object identity. CONFIG_DEBUG_SPINLOCK exposes the failure
> > instead.
> >
> > The failing interleaving is:
> >
> > CPU0: nested EPOLL_CTL_ADD             CPU1: close/open churn
> > ------------------------------------   --------------------------------=
-
> > p =3D hlist_first_rcu(&head->epitems)
> > epi =3D container_of(p, ...)
> >                                        close(victim)
> >                                          __fput()
> >                                            eventpoll_release_file()
> >                                            file_free(victim)
> >                                        // the slot is free; f_lock rema=
ins
> > spin_lock(&epi->ffd.file->f_lock)
> >                                        open() reuses the slot as new_fi=
le
> >                                          spin_lock_init(&new_file->f_lo=
ck)
> > spin_unlock(&epi->ffd.file->f_lock)     // wild unlock of new_file's lo=
ck
> >
> > CONFIG_DEBUG_SPINLOCK reports:
> >
> > BUG: spinlock already unlocked on CPU#0, poc_unlist/150
>
>
> Well I'm no expert on epoll, but on cursory reading I think this is
> fixable in a simpler manner and without the extra overhead.
>
> If you were to add a constructor to the files slab, you could move the
> spinlock and mutex initialization into it. Then unlock can safely
> proceed and maybe that's good enough (as in there are no other issues
> stemming from the typesafe thing)?

Thanks for the suggestion.

I also looked at other struct file users while investigating this. A
constructor would make this particular stale lock/unlock safe, but it is
not a general solution to stale file identity.

For example, commit a6dc643c6931 ("eventpoll: fix ep_remove struct
eventpoll / struct file UAF") used file->f_ep and is_file_epoll(file).
Immediate reuse could select the wrong free path and cause an invalid
free. This case happens to use the stale file pointer only for f_lock.

I therefore preferred pinning the file, which keeps its identity stable,
limits the change to eventpoll, and is straightforward to backport.
