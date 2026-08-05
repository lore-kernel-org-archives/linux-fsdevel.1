Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BBF3375C3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Aug 2026 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947460; cv=pass; b=VIcF6Ln7L3SjVnTVPU3gteg/idopLX1IL4JfWAuJqob2C7qSafMPvAan7An212X+fODWEluXlIbXnqoaT50JTYkQ5SEP8boTzjpfwga5IGJWZ3fgwXRd5qcHJml10t2SqCILIqi35KRGfHeCewA/J2op0gH0mdJ4GmYLFlzMNOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947460; c=relaxed/simple;
	bh=pbWb7kCGKCB6M1g0YMYf4YasStY1pf6Chkn/aqApuU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSJyKdZ0xlkQsbhRFrtY/RESBQLIKdJ+CHYue3r1UfV8rKyYpHpW+6VpTXroyAshaiHuevOYr0tFgOpwCfnAWmIPcBQSKGuSx04TNe9n1u15rPUqHo5sEZ6YitprVIz699P93iH6o2zLtOvhjFw/NbzobwV9isggYnu1hXQUCjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dg1p2fSA; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dg1p2fSA"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso1221766a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Aug 2026 09:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785947458; cv=none;
        d=google.com; s=arc-20260327;
        b=p+9NXIl9YNfxvQGzjXXWchOMn1Wcq2QXr/CLiVgfyWX9M1oDi7OwUsVMbpOFaLyT/G
         jMTkNQKOIyZ2+SQMo3nzpcKtp1jokVZsLEeK8JPgiuzDFDMGaYbIlkCr+HFwEgatoYdo
         Ago7gwPGwornbh8p0NblYIIfDS1BKOne7AbhwDS+cwBUkABw5c3lAegjBi+j02tuvoiI
         xLB+iVO5uDvlRQKmsNIrXkqnL5xBHBKebCNFYwpFSVQzJp8ZihyR4SWlKYZUbs/dbDKv
         9u3px6ymo1dPA5WGSprj2L5ERnAWhs0K4t4ibkvoOQtVngFZHQUP5KbptT8ysfw7Zxns
         bk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=++RHzXeH+bbNTwrNL/8n2XihEQ5Pr9Fs69FtXIrvv4w=;
        fh=jpO/5Ev39D6esNjZA5DrS5fYwoRn7Sk/d/nQDB1VcuY=;
        b=RTBg6QDXs4uplnDtuRoGSfHBQ29ZPVdJvCd8diAGVzICahUb6zkL0DhZ05xhnZPbl2
         SGoH3eR1IHyK/j0G1xHQhobUfXQs9bxiVCWRYUTAWEIoTbmoeCB2lxhFvZq/7A38pk+F
         9zCUSZgJILOp8ZMS66DP3o2M721wHtvasjyJTo3Auy+85uweSBFvOlwAeqGlEAHqRrLp
         2yQCYWiv65ecDjaE+weP5cchSQmmdHsfQi0+EfcP+O2GyN01zI2I0ElQ6zjvgqlxfWCq
         QThlrkPTkbuW73dFQi3yn/+T2T+gzh42A4ezIouUD7h2cCBxM+EOnqxQt4aiSwXo/dSY
         5hkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785947458; x=1786552258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=++RHzXeH+bbNTwrNL/8n2XihEQ5Pr9Fs69FtXIrvv4w=;
        b=dg1p2fSAAYKPvAw0oWhqkmyIviIrebRwbBnt3kJxkDImLBxMVP7qwEz01MFblHf2ed
         n6Q+f4Bj5F5ziSzeqpEZuQnx22vzd7Zs8+9SrsXfBLdDOPysXKLe9GtVkOG156eFG/21
         +oMgmlzjFriZ5I7TskPTx6L9Pbb31rPm7y6ACjkgtPxsJIFGAUddwb6IzU0EX965eTmi
         T8lW0ZLxP54ezdec1myXAaFMJEZU+Gob2JASqMR2QUI4DQQFDcHKyOTR868Z8XLToH5U
         PpjDMc7ESgFOxHQXiIacTdFgmHOsfpzViK8GsYZ3AJU2/UjISmB+4zt7Qn6m+ugVk5kD
         jslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947458; x=1786552258;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=++RHzXeH+bbNTwrNL/8n2XihEQ5Pr9Fs69FtXIrvv4w=;
        b=ILHfFn9PxfduU7p8OFUr8UebYCmeMZBUgL3VL7xzjFn3OfBlXgKY0kIw0cnrDmVbjh
         +kxcfd1q6ZPvTRl9ReVNRJPBSASsrkCvSMHahIkTLmyUMisNHg13SnQDOHNxkqx7g3XA
         2S5krtnI0H14COmQWmN7WIdXAckbWr5GgDDtl2X0DfQoUtSMo5GLHPuXDv2nOvh7bq24
         9Uiu3gf8A5Mc1ARpTP7k/TMAb0BapNwo08cLVPRRS80Z4Flga2ffeNcCHRrzCoCgCXRq
         6kNQLtb6S+3THna00p7NnfkuiRk/aM3ZL5mQBlXttY8oGewmzhorONBvsMIIkxirHRvX
         9hNg==
X-Forwarded-Encrypted: i=1; AHgh+RpfX7wWorr0GAovzwN12p/NhW9wmvOrZ1qQSVty7hBMxruCCkST0NgK1LuGctTc3YEyVOUGG5th6veJn0eJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcDQiVl60vf+VQ4xld+tUbTCOUID+gDOkbDkVOraM0iljhnT5E
	8NR/uEgMU5Tz8pjcX7DDkmWLgDsmTCDnKft6aE0wXc+rR4jdEWKRgBjwJ+gr7YZpi0p/UgImDHB
	sJOV7aYXucpmM5Xl89mqUp6rUwboLTWv3lBAI68ta
X-Gm-Gg: AR+sD1287Q1a76zqdfGg4RjFmiExMuq+MjMO+dldngL6G4Oivk8kkvc6RIPsmDAgD/i
	OHEyFXI6uWNd9SOwsnx7h7T3L71wRQI/ABvflGw7ZL9D7Sd3Hbom2ygWDOIMPMmDxzk39Fb+6O/
	yKwQE2Uj2BtVWoV9z/ORrql4VmlMGlHeYGWpA8WY7jAZ7Risj4Og5L31pJt3THH7fsWQ5u+CP4j
	IbDlNdNZOREHN0IaCfmx2VyGsQZ/ZrF5VXZHMySYNaK/k0pa+fDu/JWTTFe4EPIkxd85a54yyQK
	mW9fbKPilvqFjxXeyZ/hE3a8KrvJxgl1PmUOCmf/WbXjMsq31xHj5jo+8/TL2WXCt2aKUzHLQC+
	vjSMuHXl8vj2oEeeaRw5FKU+1sMB2Nho9jhjR33CpfeXK5dKOe8u1SW/E8VSgb/lWZTNXuDv77P
	eMluzsG37v9Ss=
X-Received: by 2002:a17:90a:d445:b0:37e:b6a:6cdf with SMTP id
 98e67ed59e1d1-3903c66ba04mr8802797a91.20.1785947457148; Wed, 05 Aug 2026
 09:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802151212.3294591-1-jkoolstra@xs4all.nl> <20260802151212.3294591-5-jkoolstra@xs4all.nl>
 <CAAVpQUC7O1yiKQ+3FcGWbDkmcd-LeFc5tCC0vF7QgioVOXvb5Q@mail.gmail.com> <1227047202.267333.1785925130131@kpc.webmail.kpnmail.nl>
In-Reply-To: <1227047202.267333.1785925130131@kpc.webmail.kpnmail.nl>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Wed, 5 Aug 2026 09:30:45 -0700
X-Gm-Features: AUfX_mypl_npb1SMGkF-ohFPbuchTwJgwJHTqOv00Xi3ZFFd6UCwRxnqVDvqioA
Message-ID: <CAAVpQUCW4B+9SHPE233TRdHHL0Xv7P0+mH91yEGeMret7vSONA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 4/4] selftest: Add tests for useful handling
 of LSM denials on SCM_RIGHTS
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, cyphar@cyphar.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 3:18=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl> =
wrote:
>
>
> > Op 04-08-2026 19:26 CEST schreef Kuniyuki Iwashima <kuniyu@google.com>:
> >
> > > +TEST_GEN_FILES :=3D scm_rights_denial_lsm.bpf.o
> > > +
> > >  include ../../lib.mk
> > > +include ../bpf.mk
> > > +
> > > +$(OUTPUT)/scm_rights_denial_lsm: $(BPFOBJ)
> > > +$(OUTPUT)/scm_rights_denial_lsm: CFLAGS +=3D -I$(SCRATCH_DIR)/includ=
e
> > > +$(OUTPUT)/scm_rights_denial_lsm: LDLIBS +=3D -lelf -lz
> > > diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testi=
ng/selftests/net/af_unix/config
> > > index 41dbb03c747e..468f7a0bb64e 100644
> > > --- a/tools/testing/selftests/net/af_unix/config
> > > +++ b/tools/testing/selftests/net/af_unix/config
> > > @@ -2,3 +2,10 @@ CONFIG_AF_UNIX_OOB=3Dy
> > >  CONFIG_UNIX=3Dy
> > >  CONFIG_UNIX_DIAG=3Dm
> > >  CONFIG_USER_NS=3Dy
> > > +CONFIG_BPF=3Dy
> > > +CONFIG_BPF_SYSCALL=3Dy
> > > +CONFIG_BPF_EVENTS=3Dy
> > > +CONFIG_BPF_JIT=3Dy
> > > +CONFIG_SECURITY=3Dy
> > > +CONFIG_BPF_LSM=3Dy
> > > +CONFIG_DEBUG_INFO_BTF=3Dy
> >
> > Please sort configs as CI complains.
> > https://patchwork.kernel.org/project/netdevbpf/patch/20260802151212.329=
4591-5-jkoolstra@xs4all.nl/
> >
> >
>
> Oh that is pretty neat!
>
> I wasn't aware there was a canonical sorting for the config. This should =
fix it,
>
> LC_ALL=3DC sort -c tools/testing/selftests/net/af_unix/config
>
> correct?

Yes, assuming you meant without -c.

>
> If I fix these issues today, any chance we can still get this in before t=
he merge window
> starts again?

I think so.

From the Linus's email, it seems we still have next week for rc8.
https://lore.kernel.org/lkml/CAHk-=3Dwhoz5Uy-kmrdzjrpCJCVWW3fni31c-zsHcH7Tk=
OhRhfOA@mail.gmail.com/T/#u
