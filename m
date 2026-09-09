Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44C635C1AE
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 17:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973687; cv=pass; b=u+dDy5pc5SxcedfqFHnLT/7CKWBxfi3K2274KgTf8uAGy0yQG6J4jILwkV60zaMcduR7zPZVuCfSwFRiircXkzw8vUEcPzsrXlGEWu0k0IBTuIqDy+ea8bbzrewhHBl6B2r309aNbHCLxpWu+e9DdGnnBjOKU+7YOykVKbXyDlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973687; c=relaxed/simple;
	bh=orm5Qd/qml5RDf3JYoCXGYgMUuMwhoo1DTvJIjtV+PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXAo/84zD8e5jdAjvIZzydkqrmtyZHovmYSk3993ZgxeWvZcvwVIGBtW2R0U4vJjZqG7ayZfoWDdHotcE9+0tpiaHPfuquzppUXUjSF9gw+O2qX51fbsxgERf8F9ejJY2jmUQFUBwqaFxMB3pAnnWApqRyG7WfN3xUteUIbftwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q2Ay8Czn; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2Ay8Czn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-39b9a99469fso2113281a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 10:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788973685; cv=none;
        d=google.com; s=arc-20260327;
        b=eL/o2iBCLTEmOrK6D6ou0jrEgquKY03ptwTL3L7TgfcgySxlNQIkdFv5nC8hHZjfhh
         oc62Jd5643TXX5fFOAPuDIS4mmzyJMxyZDQm3Op+frttmD+TC09HHBFddW/ZV20JVVNJ
         oFfhaGHqenhsmtjZ4cqO0VlKq5htOvbiX6yJ4u0dmuoDFc/ulteMClldJoZDfd78IPrT
         VZqWSdGvCLKio3i2jaFKbjTYPfTOz8986m28qa0k9dn6W2+JMe0M4yuNXJ8jWjdvNncw
         TvxzeqwlrX+S15AFcLoR07EP0Tt1EGGQsx1cQecdbPZhiIo0M8dG1lDWRl//yVHItvdk
         Qhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nm/HasVYmWbUem9Wl66NKJ4dCDWyymtLGvDX+MiupM4=;
        fh=chaux8FXU5awoqAoJPj7HWIpT/ZjRIPobjZLc0REbYQ=;
        b=NPhQfBaOQ7maNXwaVqJv0WZcBxs/ofiUsYbkzA5BRGXie5qEct2ZTghZCSuwe7pKUx
         GaurVZPin1d4vgmNWt54SrNKAFp2ztASYZoV006zQKXAqKjimo/Z2Q1tRpcMnwBi3H42
         zld31W/eA1ilKIOjUWBN4oYbrbPtmxhz2gSiYkkPp7STIA888RFcPcAcIGPq+B0QPHl8
         qeNhIQiyQFUeU7h2P2cacKHQknuSsVEHtHGon91tO19ROGNfaFtG9lTKpuWm7aCJjEuP
         +Q4JrBR0tB/MtJCPiiBu/1r/bPH6f+8+zjZq7O0B/HCNbsFabPp/NsbZstDh27kly+z4
         mw3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788973685; x=1789578485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nm/HasVYmWbUem9Wl66NKJ4dCDWyymtLGvDX+MiupM4=;
        b=q2Ay8Czn1N2pG+ulye4TXHJ+7IFfxNnEDRAZbEpLH6m+9IarSNryuPNgF7S8L+fAAJ
         Tql6NXrEJFBXaGynErrBxuNudLO/df688DUAa0DXLrKB3UhHzycL/ER2v2uCHbev28QK
         0cRn87So2vrWTW4z0DLsgvd6rFc3XADuC7ignosX3qxJgQv103cGyfZgq2w+5nqlU3os
         7WmS5aVcy6EtmSUmRJiR2TWBinKUyMMDWrg3r/eFrsmRLaJWREXk3k9WRqS8tOhLa7Hj
         M3hrHdoj6IZxnTNcs2RWBIBbbv8elAERHnbgGQdbIdVgzqvWjeyNZgrFdAcA6F70D5yN
         4Rzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788973685; x=1789578485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nm/HasVYmWbUem9Wl66NKJ4dCDWyymtLGvDX+MiupM4=;
        b=el6BNCCnjac9i/8k1Vr+ACvc99ZHLRYty64AZdW5qkj+m9AW93dWEycaKYbI74oNCq
         7y6E1vfMhMiTpR5UZH/LMsQC9NERWxTQTlGGcW1QHgg/ZQyuZ161WuRpDdhicUpmG4Ix
         RTUbfSet/iGvvQRKh3UTnin+U/hItglT4sN0RxbHkArRya7VFAI3dwWP4hlTGDj2Wigu
         ZYNGmoQRlGbpH+mJ8qJxZ8vCSt5ZCL52m8E+3J4nPoRGMr4juyhtoyhylSYHA6vQ4Igl
         2BkqgbWrSr3GGpdy4zFFfBLAk4cOKLrptXAyoYeVGpKwA+e3KOj0a97BQyXqG3Rxu62x
         Emxg==
X-Forwarded-Encrypted: i=1; AKwUvBwLpfwfmjP5LRjdYzb4dh+TeoKCAybIDw1OxkeSZYt+mCk/Bn12X13HVzHJcjBAN2M84wkgXqNeYo9de1g8@vger.kernel.org
X-Gm-Message-State: AFuF++n7hBZ48aMIEctKSh4/el5gk/Nh137++FXoW+AtdkUoW+47hLfN
	Tu5Zk2BuvKzNgB5HEkIfKXc1oHeQie4WU1LibCxTqASkI0+mV18h4WuPPy9UfIcKTyR9kTx7eYI
	0j1hmRKKfBbh/gfAbbnUh/VCEoI5tWLzNxbyFZhFm
X-Gm-Gg: AYBFou0nNrgQO6spXnC9NW6ymQW2a1nEXECUA4Je2rg4l6UD7WxPUWv6d3BDO6UZyNg
	LZNu5JX7Vi9fYfbFn3sHu5PcpXU3EBwT/o1i8zw8TGhDYHDm/d6DwZRieosQdcSuHdfuEhHP/Hl
	aJRd5k3PXX/PfziHC2R60T4XujwwRQq8SpE7T2RgTKKGDu0I7/YP3RGqnuFvW1FaKBgqR4tGtHw
	ve3HZgaDBQAYTAhB4qqvJLnqoiuZZZFIRi4mSMXKvDOK4B/vy0Q55pAIa4FMQIu7eMyAOenSQEg
	rQmG8T+74qCQS96YTE+VtpOTWE1yTR1wSkp0nVkEvOaESQxnKMm+czI5tAlfzngkAzzFqqvEPFR
	dgfzD+IRgWcClX84SXiLp9RiNmHwjp2XQOmbwgkdFi05xNOoFNX2M8mPRDuqFPEq9nn9Fqs+YvS
	QealE7CA/VQktn2jXfk5PZQf84
X-Received: by 2002:a17:90b:534e:b0:398:ba0e:96f6 with SMTP id
 98e67ed59e1d1-39b2624f0f4mr52270250a91.23.1788973684291; Wed, 09 Sep 2026
 10:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905233819.1064529-1-kuniyu@google.com> <20260905233819.1064529-3-kuniyu@google.com>
 <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
 <CAAVpQUA0ZKAMkhGipXdGb=4o5GRG1dS1Pv11KWhxYqgXKsw1Sg@mail.gmail.com> <skrtuyahssx5tvphmvo3kbkqy475re5yeb2kdl6luf7kmmfqad@2gsivqhqwtvw>
In-Reply-To: <skrtuyahssx5tvphmvo3kbkqy475re5yeb2kdl6luf7kmmfqad@2gsivqhqwtvw>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 9 Sep 2026 10:07:53 -0700
X-Gm-Features: AcwNN1WcBtWTO7BtuWIKfRzA4m0yr_tEizUkJjHHzn5mMfvB2nRHEGEk4MOQwVY
Message-ID: <CAAVpQUDOXfiVyuSgJ5HqZ=xX3aBM+Bar5i2Gmf8ur+jBT-74yA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 6:44=E2=80=AFAM Joel Granados <joel.granados@kernel.=
org> wrote:
>
> On Tue, Sep 08, 2026 at 11:44:08AM -0700, Kuniyuki Iwashima wrote:
> > On Tue, Sep 8, 2026 at 5:15=E2=80=AFAM Joel Granados <joel.granados@ker=
nel.org> wrote:
> > >
> > > On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima wrote:
> > > > Since the cited commit changed proc_doulongvec_ms_jiffies_minmax()
> > > > to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax() no
> > > > longer applies the range check.
> > > >
> > > > It happened probably because do_proc_ulong_conv_ms_jiffies() does
> > > > not have the _minmax suffix.
> > > >
> > > > In addition, sysctl_msecs_to_jiffies() casts u64 user input to u32,
> > > > and a truncated value could bypass the max check.
> > > This is something that is orthogonal to changing to true in the
> > > proc_ulong_conv call. Please put this in its own commit.
> > >
> > > This also begs the question: why not just use an int converter if the
> > > range of the values is going to be u32?
> >
> > I guess people wanted to use ulong just because jiffies
> > is unsigned long.
> >
> > Looking at these users, none of them need the ulong range
> > and it can be u32 actually.
>
> Exactly. But changing those calls from ulong to uint is up to net and
> parport.

Agreed, it should be done in the -next branch of each subsystem.

And later, we can remove do_proc_ulong_conv_ms_jiffies().


> I'm more interested in defining the behavior in
> sysctl_u2k_ulong_conv_ms.
>
> Here is my train of thought:
> 1. u64 values will get truncated when they pass through msecs_to_jiffies
>
> 2. The range of msecs_to_jiffies is:
>    [0, INT_MAX]          --->  ceil(m =C3=97 HZ / 1000)
>    [INT_MAX+1, UINT_MAX] --->  MAX_JIFFY_OFFSET
>
>    Which I interpret as whatever that falls out of [0, INT_MAX]
>    milliseconds is just infinite jiffies (MAX_JIFFY_OFFSET).

nit: for HZ > 1000 (IIRC up to 1200 ?), the max of the range
gets a little bit smaller.


>
> 3. All but one users of do_proc_ulong_conv_ms_jiffies are bound to
>    values under MAX_JIFFY_OFFSET. The exception is net/rds/sysctl.c:67
>    that has a max of ~0UL (is this too high?).

I think this is just set as the theoretical max of @jiffies,
but not specifically for the knob.

The default of the knob is 1 sec (HZ), and even INT_MAX
(24 days) is too high for RDS reconnect.


>
> 4. Since milliseconds to jiffies should be capped at MAX_JIFFY_OFFSET
>    for big values. Should we just return MAX_JIFFY_OFFSET?
>    Like this:
>
>     diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
>     index 213ae1d6a014..400353b0d6f9 100644
>     --- i/kernel/time/jiffies.c
>     +++ w/kernel/time/jiffies.c
>     @@ -136,6 +136,8 @@ static int sysctl_k2u_int_conv_userhz(bool *negp,=
 ulong *u_ptr, const int *k_ptr
>
>      static ulong sysctl_msecs_to_jiffies(const ulong val)
>      {
>     +       if (val > UINT_MAX)
>     +               return MAX_JIFFY_OFFSET;

Given the nit at 2., it should be like this

if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
    return MAX_JIFFY_OFFSET;

as done in _msecs_to_jiffies().


>             return msecs_to_jiffies(val);
>      }
>
>
> >
> > net/rds/sysctl.c:58: .proc_handler   =3D proc_doulongvec_ms_jiffies_min=
max,
> > net/rds/sysctl.c:67: .proc_handler   =3D proc_doulongvec_ms_jiffies_min=
max,
> > net/rxrpc/sysctl.c:59: .proc_handler =3D proc_doulongvec_ms_jiffies_min=
max,
> > net/rxrpc/sysctl.c:68: .proc_handler =3D proc_doulongvec_ms_jiffies_min=
max,
> > drivers/parport/procfs.c:369: .proc_handler =3D proc_doulongvec_ms_jiff=
ies_minmax,
> > drivers/parport/procfs.c:399: .proc_handler =3D proc_doulongvec_ms_jiff=
ies_minmax,
> >
> >
> <...snip...>
> > >   do_proc_vec") incorrectlry removed. Append "_minmax" to the end of =
the
> > >   do_proc_ulong_conv_ms_jiffies so it is clear that there should be a
> > >   range check.
> > >
> > >   Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec=
 with do_proc_vec")
> > >   Signed...
> > >
> > >
> > >
> > >
> > > >
> > > > --
> > > > 2.55.0.1003.g10538fe699-goog
> > > >
>
> Best
>
> Joel
