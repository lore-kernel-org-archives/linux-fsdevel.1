Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4980C3CC32B
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226352; cv=pass; b=hF/chaqGESQFO83vvv7eecclIDhqNFvDAyJKtK1WLdN2a827RyfxPUeuAj/iQwvivjC8hRt+kDK2QIuN2+8Q74JkLvKlDGc7S2DHkDXyvucKjVd1qCmV0/1Vl68Gsm4koL0cbPZPkdqk+DM01Jm1cuw8rcU52WIQGoKEkYSrFyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226352; c=relaxed/simple;
	bh=ICkjq/xbZ1plX4sMdA6HTZKiR6LEZANYI9Hn7CqWAro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hTE+aVY5/bU/cjEjreu7ANQ1GyVnEERffjITFzNcrOF9Xb4EQKQyJVlpQsyDT5bzwXqTA5u0Pq7EhJIW3ugNryfDCD1eCXMtYZyLzNyqshKqAAueYv2p5QcJUhU/biVbsvcYOmdopC5zjf+CcBD7Ue9Xsf0+3n8YZabhit/cZhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIUwt71X; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UIUwt71X"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69796a9f04bso4519779a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Jun 2026 07:52:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782226350; cv=none;
        d=google.com; s=arc-20240605;
        b=FzVD5AZLrqp+sOouLzYw8sIIssQEEFq30KvW6O/AdfhM4iFwNvBNUS+3cImndjY090
         t3Hiwf3K4EkrRUWHxIaNtlRZO9Lo1ifOXiBMc1aol0TlQi7H+HgZgoq478I1fM80BTrx
         9mgdUWZV41ZuvkoGjUK4kLo1kOsMXKbWPSTin2nUrBEV18xI3zE5FZJ01r9amVGp2gzb
         L4klQODxIinKaEpIp2ZdJbwyK6FsDHt4sEuH7McAScrGnDu91Lpr8lVjH5NL4O3MpYp3
         /eKcA8oRqHzG4qIIsZRDPl2cfYNNmvaWUzZ302y6GJxcXLnKA2CRQALmYOZ1xOf+Byzs
         9WfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ob4cx6LW2r4Q2SRjcadgRHtWdltOEKPfRXNYhy/X5zY=;
        fh=r1PULiZsHD4kJBSygzqDfjq8m7xYWfIr4eGi+Cl+lf0=;
        b=IRrsMGy4b0A+n0+WPl3ZxkKf1X9XtIPCZ9SNa2P10axW5cReiYxoppnpucq0DvO+QF
         kr7yhnnVu4pXq4amAd1G+78dOpav0HVLpenMvpqMIQEDmhKshEWCzvxXJgb2fOyQKnfs
         6Uj7YD9OO9pWL+BVpV3uXxqdQaJdBSnlMQbYjnnAw5tUV0OxqZfhtM7LTQWEEiJ/4WRX
         ONNM9Vr6vDzEefnnjQ30Nxqb2AqRdsX7XND1qyKR1zNVeH0TbdHvKwD1TrYQ9Q5VJ8vV
         /z3d1J/rOX5AaVaECG0wbg26miDYKDr9mwUiH0Cg1JGzzcE7r3DQvq3NBHEDEPkNzogg
         ky1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782226350; x=1782831150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ob4cx6LW2r4Q2SRjcadgRHtWdltOEKPfRXNYhy/X5zY=;
        b=UIUwt71XqkdCuLCdgEK8Nr6nkBg5M3S4VtIXLBPQ5r3vn5nN0JkVS5GaoAl+koXyvT
         8QZWEPo5JHJgDBgEpFtF8lwHslcPGmq4/ZHLfY7MrYZvzjt7/YbxEnJxfZRyVYQ5Eg/k
         KYeJL8pweX75HbvJ1zL5BN9hSPojrAEfr1+p713+CW/9MbYMNa5/R75bFz6agic7WU/o
         atM9mqt1WpuHkCYJ5coTScRNXvC1DqQdDJovU0LlXwiM/3O2afO9xDi+BbnzNx3P/Uq7
         3gVJ9Khjk2ppRWheMPJwCaoZLe6fwCaIYIddDHopar6J70ZR3x4hd9AgvsmPWbr4Jq3Z
         jDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782226350; x=1782831150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ob4cx6LW2r4Q2SRjcadgRHtWdltOEKPfRXNYhy/X5zY=;
        b=PqIh3xdh8Wfw2UYHTGKiQbs5o69pceCvKJCIMwNeuzOYv9Yzvx51/qu0FEdLom44FX
         bPmWDz/D7MMdMKYHrV3NEAyJBzJ1T4rI01sScIHzxow8/L1ecmivUZpVi2ZGYMrfAnjJ
         PZuZUy7bSkJSbnKgRQlOB+ExYlTq8E5GdeSsLsX9ODE8I2c2nqwraaUEOqgHMK/gWnAx
         wcBg/WKoISBpJAnJ+BKEMa5b1V/JhVoVCTTvwpXEUVcVkkTUS7T+uSiAXLtTSXSYlzgt
         gU3ncuj1BT9gh63x8eA7BtBKn6xy5MXsQlRQaSdVDaNXqNvSLMKTxfpJM1uwOIAjiMp5
         JnBA==
X-Forwarded-Encrypted: i=1; AFNElJ+odqWLxCtbxXT8s8RHgqnmbdtmI0fa8aK8CFSq02eeHJSWb3rr5iK080+Tb4uhdD/Fptm0uZNdQ7IfxG87@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5VjCOkmGvl08DBR47pe1ije161AEiWKTRxZ0UQk55m8hnyYfd
	V8ltHUpvzPwAFIcL/afo++hknHVxk+cXyRGUS3d3fRbWKI3m/DwH3UDAkZL+m7RJeXTuLWJ6Sae
	F5c5O6OvZqok/aEU1lAi2p0TZudzK+rw=
X-Gm-Gg: AfdE7cmOiqsDCXmD4Hht8Lm5cPs5EDsLMYPXaRJCIYU8beuNxHgVXk0pOHojKN3AhKs
	MSufpeHSDIFMkWwUX2A368uwJcFxzQFAeJItOHvOP4semGizga/7WLjypkVIPJ3Z4GjApontIH6
	i74l9MzyrfHnqobHzwXi6I0nGbnzi9lP5DJWJEE18ZR5GBR04WpzKUQh2q2J/GlQRlKpiZS1Jgs
	coaBn7wrlXxbTJ4PMj+DaISXuttNvRQABARlacvY8AyzO3OqohswBCc0HcSzL4TBuS1/0xuOkyd
	BLINMYS7KK6nle9duewRs91QxUdmouQ=
X-Received: by 2002:a17:907:971c:b0:c05:21a7:6b0d with SMTP id
 a640c23a62f3a-c0c666c20f3mr767424866b.47.1782226349556; Tue, 23 Jun 2026
 07:52:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALOAHbAY-3GAd=7DsA74W4ax7aPdXC7ecYt6b+tHoxFu754ZjA@mail.gmail.com>
 <bfdf1d1e-2313-46e7-8567-da2a363d6b3d@linux.alibaba.com> <CALOAHbAShZ-xYWw5yObqea4hB-4=NmTz1HiKQrApZpxsHvG_wg@mail.gmail.com>
 <ac56e537-d095-487b-8272-726d6739d0af@linux.alibaba.com> <CALOAHbCBo2eB0xVoSv8Vi+r3DwbwTticismFSL3EXyYuwFkEzA@mail.gmail.com>
 <13bb8cba-c82e-4a41-aff1-0a6418873bf1@linux.alibaba.com> <CALOAHbCkbSBVqUStUbWB=4vUUOEyB63yMsXvS_cZUZOwr-nmew@mail.gmail.com>
 <a5a1b56f-0b1a-473d-8fc9-8cbfba85813e@linux.alibaba.com> <CALOAHbCrvbvT04O3v+p-CmdqVN2BGJYKj6F7we70kPwbs-hmRw@mail.gmail.com>
 <b4d43064-7a7d-4d65-b65c-56e80d47ed17@linux.alibaba.com> <20260623134240.GA7980@lst.de>
 <1cc0931b-648e-4baf-9667-742175b3f9d0@linux.alibaba.com>
In-Reply-To: <1cc0931b-648e-4baf-9667-742175b3f9d0@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 23 Jun 2026 16:52:18 +0200
X-Gm-Features: AVVi8CcjqEnIW2CG6GS3bOoBn4_gVy_UbGzZpgc9FUENLu4p5-6IMD_YoyDKWjs
Message-ID: <CAOQ4uxhURfuQWMd3y_W1iFebJms3aohn+koy5_sjxbcc4ZBQ-w@mail.gmail.com>
Subject: Re: [PATCH] ovl: Allow changing default fsync_mode
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, miklos@szeredi.hu, 
	linux-unionfs@vger.kernel.org, fuweid89@gmail.com, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 3:47=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Christoph,
>
> On 2026/6/23 21:42, Christoph Hellwig wrote:
> > I have no idea where this coming from as I can't find an earlier
> > version in the fsdevel archives.  But changing user visible mount
> > options through konfig options is simply bonkers.
> >
> > I'd also like to not that the submitter does have a history of crazy
> > patches including those to support proprietary modules and then
> > attacking people criticizing those patches, so I can only suggest to
> > every maintainer to ignore them for their own sanity.
>
> Sorry about that I didn't Cc the proper list at first,
> but it could be checked by using lore:
> https://lore.kernel.org/linux-unionfs/20260623084337.54344-1-laoar.shao@g=
mail.com/T/#u
>
> This topic is very specific to overlayfs details, I'm
> not sure how I could say the background in brief.
>
> But almost every single container user uses overlayfs
> now, so in order to be responsible for end users,
> container runtimes and applications, I used some
> aggressive way this time.

Gao,

Thank you for holding the fort!
and for foreseeing this containerd regression.

I also agree with all your other arguments that "volatile" should never be =
the
system/module default - it is too risky - one needs to know what they are d=
oing
when using  "volatile".

I will respect your NACK.

Yafang,

I agree with you that your patch appears to follow precedents
in overlayfs, but I also think that "volatile" is not a good candidate for
this practice, mostly because it makes mount cycle fail.

Since it is so much easier for your employer to live patch the kernel
than to upgrade/patch docker, how about applying this live patch to
your kernels?

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index c93fcaa45d4a3..2105a51d12439 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -155,7 +155,7 @@ static const char *ovl_fsync_mode(struct ovl_config *co=
nfig)

 static int ovl_fsync_mode_def(void)
 {
-       return OVL_FSYNC_AUTO;
+       return OVL_FSYNC_VOLATILE;
 }

Thanks,
Amir.
