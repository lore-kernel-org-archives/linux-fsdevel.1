Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106852E04D
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788892746; cv=pass; b=Es5UsR2xYot1GDospzng/jF7iGIE+mNiGU/zM0RSNFTvEfEBtJjsk0ltX55Slu490hb5UG6BcdAqv/qwhvZcYx8O2KIqiNKCMBiqBgjJ5p6GeWxjLCY+NJlFj2lthA4ab2KY7qCiX+UqqlsCb05OD78wK9lgT2VONEPvcflif6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788892746; c=relaxed/simple;
	bh=DNYDseqyoZJVxdaZRzda73aCo1zvS+JC0niDG1HL1VU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEPTKMd6u1N1OCGOKvJGr1hZ1n7p4Yy5EkXZrzz7rkV1DWmEH+LBs69JWy/aRhkopcJuxdgJ5TFaMwOey4aj7PF2AR80TH2ZKw+e+gF54duVszu+LBqiPFCvP59pcLo76EFYYyVGX2irs1b0AIxH89s/d0D+c/i2hkm4kWAQXnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKiLs+2d; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKiLs+2d"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so247512a91.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Sep 2026 11:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788892744; cv=none;
        d=google.com; s=arc-20260327;
        b=VgdazSZ1BQiGIobfEHLNEN3J4NpY5aR+3MT/UUdbLOy3fnlCOJiXd8WAbJdtxUazw/
         UtOUM5007GW4XraBWHbD5MTC5K20HcqhbTZrDoRTCg/dFdom+UvlkvTrfI+d7pWDmR6v
         X7BjinTjdxjkZyLO6uSvgVSviTZFWUKeNQfMod0UFWfeP4tXiPLP2W07FBdQ+izaI3dS
         MGIAcap8iV11FKWH2DmJcs1CBGmHqFEYSoJcPinqBSwDLBFs0ES877pAwIDcBu+kUU4d
         O7YrfShbLCHBBK+1j9Neg5Rt3e5LzTX85hop1xAeS9x2mQG4pdw6aZPVyCcYjBWclO1i
         UNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHQktjygnIEWh5+9kmfRFvjjOg/JlnMZOCs1m/10uXw=;
        fh=j0qZWzX+buTQZr8/ohthY78wTHZ7q7nOlbhPfOFitd4=;
        b=V2mLRjovePKzvyLTHBEoGDTLBNCvOhDHh1OMK/9970EVZ5uDHhlbsT60uwic8OSMWY
         OlAdQRqFpa5RTWpeCM4x7n7EWW+v3xDY5xGS6Zlfmb7qiW4z0CbCB/fOvfvRb2xyz3d8
         orEfCcUCX1XowDhfvocfAVoawS3ix/obQhoEZZJHmHDu2WgoU2QGj0mkjcY7vXEbcSCO
         4G65OjlDCgr/x49DBC1z32fvzkbND+Ush4U1xVtLhekEnxcz1Zgs8K97GyjFEwQ2E8no
         00FMEVQobki/GuZchmAvLeVnv6KquSn3zbtS4jOb8OCIsz1H5vVGeaVmok7UR5e5Rvjs
         hQDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788892744; x=1789497544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHQktjygnIEWh5+9kmfRFvjjOg/JlnMZOCs1m/10uXw=;
        b=iKiLs+2d0dBxvovgIpfSDD1ECFPtZYcxn/caxKar6dLS0ukUKg2wKLANMEgYW9nFIa
         BmTNvyNhf5vot4yqApB1CSJbe2QcT8so1b49DBdId/O6boRbP5+LdqT4ePPjne9QYo03
         lVC7xxsSYeQfrG1J0lK4ekQpKG3qnOhgxGnarwalmn9yAMpKKIK0ep7fKU9C1824TzBE
         L2Lwo0KuQLIPvrZfaxZqDnm2KQCWpyWtwVqg5j/hm98fksuGpcMOY3HYBODgvFQGnkNZ
         7KAn7DxSEbzpKhJzfEX2cz6HS4U3Ahv3yQ22JISC5d7mUdn5f68a3Wg9cCFV6V26cqUc
         PZgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788892744; x=1789497544;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHQktjygnIEWh5+9kmfRFvjjOg/JlnMZOCs1m/10uXw=;
        b=Uw9bYvuYieKOSfnqVxMwZA7kHp4FtgCLJta72p+yS2mzRCngXUHVMP8yL+6MmSp+tt
         7zUSX08MS61jhexzsy3XUSPw5vNUE5KYxLHD3Ycr/Tg0EfjqaqqvwffP6obOl0xeVyWH
         xmLkfV82vuoHMapIr/MudK4BywXmvcpM9QmKiFUzT/mpU44KsVvQ3tHR71RImxvDY9Zm
         puL5wXCMVMD8BsY1AfS4WAKzHP+/qzYL1M4mesn9/1U6H7qyAlOuJz5fnwwP8xdeKJhl
         S5uG4ujf1+zcR2MeQN15IOyEzIk8RGo7jt3xks+MCjaQO+UA7Nrje8NO81QzDv4WJr73
         i5Lg==
X-Forwarded-Encrypted: i=1; AKwUvBxmAMJx8icVNElyoylhrkgAedic/HdLh0xJhTGZYYa43G9iJ9/j8bG9GwwC/xotQgkqONiGDALXV+z/EsTR@vger.kernel.org
X-Gm-Message-State: AFuF++l6iJowPpQblU0+GJ+987t4GFiNWpr7DFAMTG3BvdP18qgG5R2c
	ktNkWsupobUeLv9mFWeWrnCPj08O8bUNidmSjMiQMu6HJBJtNvEcv3NoyGhoSzuplotzB8WgPKh
	Rg7BZKC2XU8iCYKnhrV2mmWOlEwafLtIQrmP1U9M3
X-Gm-Gg: AYBFou2Y42g9klS7A9SI0y+cCXvxP7u8+hgWpskCo6wd3GtLNWcf2T7r+m9dDvWE/c5
	OAHAP0ZMi4tmmg1zGh4IOTqufcoFLJGfKLJEyRN5kBgwKynfLkOaXKPZAcn0FliLujMNudB9d7P
	ZREbjGdrf6HHS1f8vT9A/yEvAkueln4pfHZ5RH2RjswLQnXFtTfAaqiE6L3HLaK37MaKx2ED7yJ
	mHXOLKaWFLeKNhT+4xd3ImKKLZbzn/k8IRkVzew10wXopYDLoUmKUaK6yn4DMrYaBtawEjOcxjh
	7BIVAbt1J+pXvNr4yhuIqTU9qgaLqTQaEp+PlXFCHSsG/6dOA4GWImtOFVJccgvQ/A9uILHKDyl
	VeL1pdqmn1mQ2E1dZsDcT4P9eD+Iicz254ryOubYGQ0/JtFz3xkEqkz8v2gDGrlMAS0enC//Pva
	XXPI9MJlzoQp4vOwM=
X-Received: by 2002:a17:90b:3851:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-39bac1389e1mr1593742a91.3.1788892743834; Tue, 08 Sep 2026
 11:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905233819.1064529-1-kuniyu@google.com> <20260905233819.1064529-2-kuniyu@google.com>
 <7yotzsvlkroxfl3zkestrul7f5rh7vmlhuacm33reod7uw2mun@jrs7c2hud6oo>
In-Reply-To: <7yotzsvlkroxfl3zkestrul7f5rh7vmlhuacm33reod7uw2mun@jrs7c2hud6oo>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 8 Sep 2026 11:38:52 -0700
X-Gm-Features: AcwNN1XXn0XECLK7Xtm38IMrZ10p39D1AykCeD7W1Vi3SOkjy6Dsjt6gnEHWKQw
Message-ID: <CAAVpQUBbQYmNXGN3yMyjGJL-EffOPp0cv0jJ8zQDJqgfEHjw3w@mail.gmail.com>
Subject: Re: [PATCH 1/2] sysctl: Make proc_dointvec_ms_jiffies_minmax()
 enforce minmax again.
To: Joel Granados <joel.granados@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 4:06=E2=80=AFAM Joel Granados <joel.granados@kernel.=
org> wrote:
>
> On Sat, Sep 05, 2026 at 11:36:30PM +0000, Kuniyuki Iwashima wrote:
> > When the cited commit converted the SYSCTL_INT_CONV_CUSTOM macro to
> > functions, it accidentally changed do_proc_int_conv_ms_jiffies_minmax()
> > to pass false for k_ptr_range_check.
> >
> > Since then, net.ipv[46].neigh.${dev}.interval_probe_time_ms no
> > longer enforces the lower bound.
> >
> >   # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=3D0
> >   net.ipv4.neigh.bond0.interval_probe_time_ms =3D 0
> >
> > Let's restore the minmax check.
> >
> > With this:
> >
> >   # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=3D0
> >   sysctl: setting key "net.ipv4.neigh.bond0.interval_probe_time_ms": In=
valid argument
> >
> > Fixes: d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with=
 functions")
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  kernel/time/jiffies.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> > index 213ae1d6a014..70926b73905a 100644
> > --- a/kernel/time/jiffies.c
> > +++ b/kernel/time/jiffies.c
> > @@ -181,7 +181,7 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool =
*negp, ulong *u_ptr,
> >                                             int *k_ptr, int dir,
> >                                             const struct ctl_table *tbl=
)
> >  {
> > -     return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
> > +     return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
> >                            sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_=
ms);
>
> oops!!!! Very good catch.
>
> I can see that this needs to be fixed, but your commit message needs
> work. Please re-write like this:
>
>
>  Add the range check to do_proc_int_conv_ms_jiffies_minmax that commit
>  d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with
>  functions") incorrectly removed.
>
>  Fixes: d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with =
functions")
>  Signed....
>
> Why is that info about net is relevant here? I would remove it.

Because it's the only relevant user.

$ grep -rnI proc_dointvec_ms_jiffies_minmax
include/linux/jiffies.h:649:int proc_dointvec_ms_jiffies_minmax(const
struct ctl_table *table, int dir,
net/core/neighbour.c:3679: ret =3D proc_dointvec_ms_jiffies_minmax(&tmp,
write, buffer, lenp, ppos);
kernel/time/jiffies.c:311:int proc_dointvec_ms_jiffies_minmax(const
struct ctl_table *table, int dir,

>
> >  }
> >
> > --
> > 2.55.0.1003.g10538fe699-goog
> >
