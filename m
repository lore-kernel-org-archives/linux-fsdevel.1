Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AB3DE453
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776349302; cv=pass; b=XR1+5G1G8Jsu9TJ08CqFibFgwfJGcFceTGD15TMMQNlE5Ddsv9vUqg5BNXmAjI+CgpE6vzSr4Y5FwaBP/RMHA7PcY38BQr88GkjLmJbXrUwtgTZoDDGlQRZFtPCBH+xkk+A9h/MFEt+tTTKFUrSBNjFf4UCo1sNtsn/sfomR66I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776349302; c=relaxed/simple;
	bh=MPSStrB5WQZXjuD8LVCQJRe2/QVXDyCuUjmphyPyAE8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=GPqajYoGVz7/Ogw6B89TG6IBSzlzNtwkqZjowSQ4n7+9yjgPEx0ISv8RCP1i4mHSKNf2GJl0Mrd4uTzUbtJsZ1ovMM3zTWFL9UL2V4GqjOwbmThk4y2Y1Q7LDNAigfpdCTu5WeIwAO2pgr4aUVLVd1bD7WeRTZh5lhiMb5EUY44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+O+I06/; arc=pass smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+O+I06/"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-953a5defbbdso421711241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 07:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776349300; cv=none;
        d=google.com; s=arc-20240605;
        b=j37MMpf2AGNtpQJz6//uQZCmLmHGIYxCDUIiQYsRrOkxpbOfMGwqtvD71bvAt2YRsJ
         qm8t/WJfKrmtUbB8tw+qtx/mAj3shMbmJAy7YffVOdN98WqsN0d0omWOhpGGNb8Aophh
         AAri0URPZnEY5wZHcQhr2e0TnlNdhVA0XF+QoFHv/dqtRUWTfMnV1Q/8YOce3cX+Vuiz
         B9K4z175jX/RFIntW18z4Xm+idJD/ChH9kNCQZd++M2BytD6KbkWEiCJtBUvs/aEoGsk
         Bo1s/TeQMU5/c7TXDMOzg/E4eV5EWmbD+g/gFErdAg5Ffo3u0OJqI7IS2aUFIhou6cbN
         /chQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        fh=1P7XuuHhfD34UaqQY+1YePrUnJc4mO1uXQnnEUvG8OM=;
        b=A7tMzSiYcGw+eJtL35geI3o8/zcmdDC6C+dQuSJIi8/7KOuzN2MWDV1CN/2w4NWjX6
         AxJXaScDBXYG0XC2P+8a0k2Nokw1bwzc08K56YbELcXfbneTD8mlSe4+HuR/p64s1pz2
         oIXkbFL/j0KvbEHHEPnbn4lXybX56+0iLIIfDUYybS70lkBQ/hUAb13IfnTjZyrjZPSW
         /ChTS/RbaX/tWg1IClvOZEddZTs+TFr+RIx9fuYBif1+abWTdLSDsDkbwaYFFiMVEBXU
         G3/Mo6QuyZalFE0PEIu/mOMs1jQZnSNdK09bwPjbrA6cYkCsChIuqzQlorwWZ5eBVF1r
         wzmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776349300; x=1776954100; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=S+O+I06/bsndk1ren2sbM0LafnTLke5s/YTY8d+xK85qFvLskc9abtgZQTAAGdHXkW
         gQ8OcqsAvXDSUsE/qTNg9RdNmoee/lFXrdR4ucPesp6PxtFUHBJnk2opxD4WhF7p39fM
         JbLJG4K9nLOk1IWPQT6/9UECkqMXhPWZBwfmOtBlB/tDpW5BKsMpvE9DTyB4a3Knto5N
         O6ngJcs5AXuxkhGkB6nfrl1OMvAfh3fOP4DF0wVQe0Q8EJ96obTWMCn/Ykaj1QnqTfbR
         Y28+pO3WR3EhH13uOiaw9rJINIUVvIgJe+Bk8hsVZpSq8xjX+CnPVc9rKipwxH98+XyE
         eXyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776349300; x=1776954100;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lO8+zS1qnuU0zyUegMfTKGfj9Y7WBTQIob4jJAeuR1I=;
        b=G8MmPCf1IBTVfUkptdr616wCPRj+rU6xO9LrMhxzcznxI6ode22QiAE/qn+zpIqrGT
         irKViVa/TbDDQk1nW42DmF0oTZE80OqnYYu2Jwi4IHKAieMk+ARZrvdcCgCQUhFkDSVU
         Sbvn/aE+NQs6zzaa+eMYdolCHkNdQbcuosef5qhSb3X3kwi1dLY5uPvTzpjYAOc2wCxb
         R+oFPabQGPj/9tQuz21noj8XGTEZkyc7CqRm3qNGt72GUxXRUBTPonfKtw5XDZXROMMz
         uFB/pZvv4FaBxpTt1k57u/tsyhwTl2e43zWhl7hTqCtQE+t0bKDyGF59T7xwvUMYegfz
         chdg==
X-Forwarded-Encrypted: i=1; AFNElJ/z7j4tv4dxiVTqI4wymF77ov0UfTgQA3Su5/15n30np6ubr+guzgO61meR/2uxX+9WcDV08U7m7ihCYgGh@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/PtzLGXWOmdVHkGGqcUrPs/3VSlonavIDIrxupin7GkLodCtY
	Yve898BBEC6B0r8NKC50ISQsZrgSnHuKD7vIqzdHSbBYoJJ5XsCzC3300Iur4pO3hGBU4FtLKzj
	vxCk+7ouxTV8IUz/WlL6GrguR7Gng32s=
X-Gm-Gg: AeBDiev0MBmJs4mCNjSUtokWqQo59lz6gq88eCmgTfjdwqCTbbgMPR2JrjiqjUuXSU8
	I9ZTs3sKxNgA9fYS1UMP4is/U/jR3FtmG3Q8aIS/TpZ7oEI2WXzGrLeAbsCk3jsarQIT1HF8sFV
	J0mmEck6j4Fzx1BX7padv3ekyv7Lyva2oGbB+w7N3p+sPya0P5nctgTGxG+uBbLnv/ZfHsdTkcX
	hRFVfib0WkvZanJGjv/e+uXxqvLn80OnGiasupVZ3bkCuiy9qWXF07y50awO5xGbg29+R5GwnHF
	QlMAuMph8LU20fCetYDfWGlZfwoyOX4hxgeDMi38aQ==
X-Received: by 2002:a05:6122:608f:b0:56a:8f7c:49aa with SMTP id
 71dfb90a1353d-56f94725c32mr1843622e0c.4.1776349300022; Thu, 16 Apr 2026
 07:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328172314.45807-1-dorjoychy111@gmail.com>
 <20260328172314.45807-2-dorjoychy111@gmail.com> <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
In-Reply-To: <aeDpIgfDaIKEaBcL@lt-jori.localdomain>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Thu, 16 Apr 2026 20:21:28 +0600
X-Gm-Features: AQROBzCVSNvQ07toCtw3F1sHPLg5Z_-nre3iq90Dw0MflD8nQqdsL_RQ56rFZc0
Message-ID: <CAFfO_h6pkyX=uN5uoXda6toTtT6KsahfBNBLom9i21HdZ7JOmQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jori Koolstra <jkoolstra@xs4all.nl>, Dorjoy Chowdhury <dorjoychy111@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com, 
	alex.aring@gmail.com, arnd@arndb.de, adilger@dilger.ca, mjguzik@gmail.com, 
	smfrench@gmail.com, richard.henderson@linaro.org, mattst88@gmail.com, 
	linmag7@gmail.com, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, davem@davemloft.net, 
	andreas@gaisler.com, idryomov@gmail.com, amarkuze@redhat.com, 
	slava@dubeyko.com, agruenba@redhat.com, trondmy@kernel.org, anna@kernel.org, 
	sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, 
	shuah@kernel.org, miklos@szeredi.hu, hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 7:52=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
> On Sat, Mar 28, 2026 at 11:22:22PM +0600, Dorjoy Chowdhury wrote:
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..fe488bf7c18e 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define OPENAT2_REGULAR      0200000000
> >
>
> I don't quite understand why we are adding OPENAT2_REGULAR inside the
> O_* flag range. Wasn't this supposed to be only supported for openat2()?
> If so, I don't see the need to waste an O_* flag bit. But maybe I am
> missing something.
>

Yes, OPENAT2_REGULAR is only supported for openat2. I am not sure if I
got a specific review to not add OPENAT2_REGULAR in the O_* flag 32
bit range. But as far as I understand, for the old open system calls
we can't easily add new O_* flags as the older codepaths don't strip
off unknown bits which openat2 does. It's not easy to add new O_*
flags for the old open system calls since that could break userspace
programs. So I guess it's okay to add OPENAT2_REGULAR in the 32 bits
range anyway? (Also lots of code paths take 32bit flags param right
now and those would need changing to take uint64_t instead but this is
of course not a reason to not add the new flag outside of the 32
bits).

Regards,
Dorjoy
