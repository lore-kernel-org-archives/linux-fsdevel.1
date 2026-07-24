Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BF6362130
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 03:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784863474; cv=pass; b=MNpM/dbAebMZx1fdI8SnoS+EgC/Y9FwzxWyr9vUZUbl6lnpL5W85IalF6auedWK4n1GzIMGll7c+btpxaacK8fW+4MEQIogd+/tPzAJoaALKPd35J9OFLuINHe0OpvA4iSD0+GUlOVNQqtXLpvJChbxUWmnpkUM3eZ5/nXi7U0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784863474; c=relaxed/simple;
	bh=/Oy45jlWUuBsyvkNnFkGYUTUhOMYip07Di0m/JfWZGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cpu/VvC2fc67Bf88t3p5+51/Hjo/fbtyy0JQLXZUL9JdXW9vFGue7HiorON2C5GXTh05CpVCegHmxQRBzX4PDR+cnzzRbxgqUs/sUiWCzv71eiKunEgaVcKRy/DWSwGT8Wa21NqhFpCgV8UcI/lyuhHnG9GJ2iY+3iupD5FfJqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aoyOgtTZ; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aoyOgtTZ"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69eae037da1so2002657a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 20:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784863471; cv=none;
        d=google.com; s=arc-20260327;
        b=SrM4yMHx+HDId9HcJNMXwtRURKwuZYJkuJq9Obesx4ErJ2XMLTCp+AyG/mh1BMJxdY
         DGBJ5UyUf7w3bEVwt08MsJV1eK7/gdgU1t6g4/AIJxTrVeH9DVBjRUGb6Zz33UQxyWoQ
         95k73SOCBfMO/7b/YDyHFp1nlHsNUYgtYzKwbSTcvmc06T4SbBxyIbLVoE1o23Q4M0LJ
         H7Nr2vVe+L7TiRhj7aXGuMi0Srj1Mw4855FUHnO9c856nNrhwNAP0w6JiOk/VRXKrRY3
         aPe6u+NAW+0nmGBWyIt5DK4EVAXMzlQl2xBjpr+12Vqh2Bm8QdYrToS6EhahnFB4GZWO
         U0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Oy45jlWUuBsyvkNnFkGYUTUhOMYip07Di0m/JfWZGo=;
        fh=+zCKx/FVNpZFH5kd3vsHMF7dsuZcCr6igyhp7OJFvsw=;
        b=CmToxOAyQrlaMG2gIGflQVsP9njoxlJfCysegE3Gt3xfTM/oceDZbXVa1TlUpTcl71
         EetCtHwJqyprOegjtZOnZ7/w1kCMk33BycmkIpP79XwQWG4UYIK9lGRP6QnpKqjr4hbh
         ls8BksIT40oTRB6lZEhQVPi2qazuZbUEZbbJxguxog0HXT6WaxdULVnrL9r5XOvdNfKb
         Sx3D8ZuoIOWyzkoK5owfsYkZcrx9VM3ZsHjJ6EkanOiFhhcFfvjuyPicngfhlx+96YJO
         WV1Sb1JU+Cscwo0aWK6H8jIRudeNpbC71VaAOHx8yZ75prm7bd8i1F1fm9Dk24wZJTPv
         n0Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784863471; x=1785468271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Oy45jlWUuBsyvkNnFkGYUTUhOMYip07Di0m/JfWZGo=;
        b=aoyOgtTZYVdX1obgQVT75gkZToa+3zCHiZCdY/BD4AYexH5g7CCdQoySGF20vQy0Ds
         dq678Pdk4Ho25xywsBXYRjkMAFkPr5FbeMoNqySLPEGB8ZlAU0TJeagLrwm0O+jOR2+5
         p1sg72Y1I/X1cR/t8v/sJtnmoFq18dbcxkXFJrEMRaNo4Z4facX7nEbiXP+4tmD21N24
         knxzMo3xzEzIpxBiwCGgyyC52v9wnSyB8qXc/JSVkRVFAF0wMZAK5deVTNmwlC6EI6nL
         0w6bJ9wW3yuHRncJ5/QEjpzuvJybCUWzDguUgUBaQtGmgFo8SlVJsXctQpXs69q0zwcD
         EYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784863471; x=1785468271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Oy45jlWUuBsyvkNnFkGYUTUhOMYip07Di0m/JfWZGo=;
        b=s21YZTFuGzuGvxnpZdDKZPbfQBgCRpxxcdA1HDbreu1hyftQ6sw41YhuX2unhhDDWL
         6cgM1KyO1/koYYxiWiOigp04HbF2I8wO5H/14lF5okXYDjtiLxhlt/seIJPGBeqLJ/J0
         wefGdMNiWM05nb7PLeFJrdpWsXKuuwnU2D0biWl2Cqjg8jvinY6PP4U0/KFf4ax4cLZk
         +C+PyF+ASLNfcsbTtbqctlcaOK4dVbiViKKMdXcpxIl/qncR6pf21liKkqPzT3way6Le
         U1KyQzvtOH1aTzSPTNeYN/NTAbc+lkBpx8cW3mZdih9RZEHOpeUN760s6Lmk+Y+Hpu0i
         Lcsg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4ud0KKP3uO9bY2qA7cAkLxBmhBOT/Gp2eBNwO7ey3O/Op88f4rqi94lA1Mb9isYUQhyAgoo8Na27Nd3ma@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8epj4gmyp6wrZPiHbt/fIFnZX30P86taDkYyabv1bh3l7vnS
	qvacMP8Ko00k0W5LyW54ICzmKrxzOVlJw2CZgS1TaM0pDpSOONdD9dufVRFxVT2cZxyYp4C50bU
	aZVTOc2DE0z7ru5qTkHdsvtiwJVifpC4=
X-Gm-Gg: AR+sD13vfs6ExRglHDtcwt3ca8//Q+QwQfTxq+S7TRVXC8i5zUAXlB+sX32KgKxB9Tp
	RuFUES30BE7FnU1RMGo2ada0coU2zI0pUMdxpoPIlqkP1+kDfvz53qgbrxae4EO3jt4fXHNDBiu
	oes5y8l0heZDcUGfw139ssBKtYXsLUCZA8ci7KSNNo9Nn4D0m+0EXVLdx5lwSo6/A9aBjdVQUJS
	GE91gapVF1+g/WAxNC4SyKJqyT+vwYGsWYw0bV0wL2JJZxcT5IWKIlBofNBdNTiMGG7XoI=
X-Received: by 2002:a05:6402:a6c7:20b0:69f:4b79:635b with SMTP id
 4fb4d7f45d1cf-69f6bf1f5acmr1435109a12.27.1784863471046; Thu, 23 Jul 2026
 20:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718104406.27897-1-2045gemini@gmail.com> <20260723190621.51e6e4ac@pumpkin>
In-Reply-To: <20260723190621.51e6e4ac@pumpkin>
From: Guidong Han <2045gemini@gmail.com>
Date: Fri, 24 Jul 2026 11:23:54 +0800
X-Gm-Features: AUfX_mzQZ63OD_P9ZD2yILrd7shr1mNAqar8LOrhuTHF-rHoKX7HagJ-Evme9Tg
Message-ID: <CAOPYjvZjCG4HNc3S1oekAme3jAYJiuqoF+LFo6NQ3Gn4DG=rTg@mail.gmail.com>
Subject: Re: [PATCH] eventpoll: pin files while checking reverse paths
To: David Laight <david.laight.linux@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jann Horn <jannh@google.com>, Qi Tang <tpluszz77@gmail.com>, 
	Junxi Qian <qjx1298677004@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 2:06=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Sat, 18 Jul 2026 18:44:06 +0800
> Guidong Han <2045gemini@gmail.com> wrote:
>
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
>
> That seems to hold a reference to 'file' that persists after EPOLL_CTL_AD=
D
> returns.

Thanks for checking.

The reference does not persist after EPOLL_CTL_ADD returns. I went back
and carefully audited both list_file() call sites and every subsequent
exit path. Whenever list_file() adds a head to tfile_check_list,
clear_tfile_check_list() drops the temporary reference before
do_epoll_ctl_file() returns, including on error paths.
