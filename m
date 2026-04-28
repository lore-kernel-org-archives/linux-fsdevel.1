Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C00B46AF02
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392762; cv=pass; b=gSdf5gLLb8DBYd9N5rQsGcvhWmitOfQW1ZsXvSD2F5yBtL1Fi4fgdvkeQJ1/MoidCGxSvvXcb85bgUNaukkQ/J7tMnZjhHdxi3CJ9t/TjtFhGDJG55S5aL0E6jpD9DGahO5aTvaY4BJYkXDUDMjH2ygcCkzrsOqQ4oA1OMD+uqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392762; c=relaxed/simple;
	bh=q6JgxFyLvJCahXylzyug/1dX1ICrpJy19p5dtVuDOXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QODIIVbWzZmts9JvA7j8Zgy5iZruBiFuCm2/i9ta23oaH8D67OfnhCEPKCpDUfRwz0f5cc3C6sQ2OXKCqTI+Z7c/TkkCTclZlm3tyDHXWWFRbHmshKxoooUgFXrxhfR1jrY/sSp3q0NmuG/Vh0GVJd0OVa2b1TaDd99nn7bni6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtwWsaTf; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtwWsaTf"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b936331786dso1519946666b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 09:12:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777392759; cv=none;
        d=google.com; s=arc-20240605;
        b=iyjbupmkZrWyRgkNj79yXcipOZI3/pbj4DB8IdFF8TBStw9+3fjMxMJ+7jiS1IUp4e
         CtEXzq2GOZYNnJIJOmdi607bL4htKqYYgoY8bdsNzU36RQLIg8soSH2rDZM6ypwWqyad
         Pu+o2uaKmgSlr2pu3+9+14EBFWa037WpPmliUyeVpjvt6pAz3eZgV+tyZSw4aSxDsSmT
         NFmV0eSm9cXY2Uas2eiWIQzZRqV8FozugdgxFS3qp/5B0od/Qy3liPPPADUXrRg3KQEb
         4BG2mwSYFs1/IRN9Fz7BhcHAIZac/di0cyhRztgiBS0MJ3fN90LYxnN/2G0jtI+VZzM1
         PdwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G8PidlKSHO0r02Iwhfxhmz5vcZ6K78QPaLAA3PHEonk=;
        fh=W+zZgSgFH3D/N0E7GzcCpMHvyIA13FC5eFR90wb4pjM=;
        b=jbDA2BGerzP1OW8wVlJg2o6tpUaTZ2U9KZggXvyZuD3mbuC6sVsm6Zo8+AT4SX58KO
         gkXR37BxDvFZb1jmnMRFkKfUcsQKGFn/xphoOqIeNu9hIqqIn/p1IGqFogAaX00Cu3uZ
         xKdUQ65wvsDvlRGcDZu5EWPQ9lk3nbgu/yQ84nd5ikczfF7uqhQ/+EzHX+/l9bMhmVfI
         mpIKtxd948VZOC8wz97r/wvF+Iw6isWvwupqnYwd2PXW+6Zam4z2HIw+4GYjroCnm/ki
         40jblK24Pp69lZFJYIBDDxj2boVGLL5uN3QTXotHvXeW09xxoLcdu9l087VR7o9/yR8Z
         iGkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777392759; x=1777997559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8PidlKSHO0r02Iwhfxhmz5vcZ6K78QPaLAA3PHEonk=;
        b=YtwWsaTfWEjXVyUzSlvUjUwlTQmsDIAnRThkbQwtw1zXJugfWD0mwtZgARufTDAhVy
         CxpmscJ2Z04rfuiTYI4nGuQLgvxh0+Dt4NKpU/ne6SVn3hQX3WXG4pqcYo/D180LU4A5
         oYEpUTco9bvaxGOvueOHyMP/EHmdbjy0ZTjs6EQWk7cMSU49oIDXdSCtOPhlBFoLFc+8
         8IF2ffdrAm1aviqCvS7YEm3gn79pbKq6HeAQcqVAwN14o16onpdOKkyTEL8kzhSBC53p
         4c19jnqyM8FTuOGmW10WYPFmXOSMCg0vwka1RTLF0kQXI6P7kYHuPD2GkNtFq3B+aCPi
         lVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777392759; x=1777997559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G8PidlKSHO0r02Iwhfxhmz5vcZ6K78QPaLAA3PHEonk=;
        b=eK8dgl6yIkJlf2r9LatI1g0wGjlskGpgFY62tJRYlLiOnbjFaN3I6rdYOOQAOBCmov
         KJvN6yVwddIri5cycSKQ+yL5/EwmgV6PvdfslghL+46BsgzE+TCfujvQ156/zqDQtKHp
         fME1/wZYrF151VGqQtNNz3MxT9paT4NcAlGmMqfogvFEN8v1dTYN5w+rCP63kQTLv5Hq
         VuRSyJgpJL8fUlmBrv4xqMNhB5E41MTlx6w9VAk5hph3TNM2nyeuv//tQ3yxooH1qhG+
         V5/lhHDHA8jCqVl2c01logzne2iojg132kchBjCqxaR3WzQRwBYQ8tMC8GMESPNkJaTk
         WdiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9vou5IIf6H+dLxMbiT+YGR1qeylNvwZQZJ85BQHxanCuBMRKArw2DPdtIEk9WlYeAMMC+YE+y7TL0QDqly@vger.kernel.org
X-Gm-Message-State: AOJu0YwPd6pKpDlSUzByO+5FHC1VeYRXN97KzSamiPR6KXQJRfsvVKaj
	EPb2uQpEMIbsfdsFMmaozQB53xF1ImFI50LGkMuwuinQ/YmrXs7O79pFx455d1QKhfXfOy53I/x
	eH8IdckaNm07/zf4BTgkO+ig1WAG+/V4=
X-Gm-Gg: AeBDietdGtTsSF13uRQSFAx25P6Cuv0hzuyF6WstlYBXhwsVlZs0+mnc533kNevWtO9
	yDeEYMk2DMDms7WLgjsmIPKgKNo0OWWC9jB8nsg+VpV3JFioFtneUvT5qtAhhvl5QYKu/ExD2H9
	UtP7lu7uqhNHoahsx6FwGUOTcigRTsunAWZqby7YebNX7XyOG0mqy+OXdVwgeE7j/a8DG0SH+FK
	yyncx9aXyvltUfdcLnkB7x4G/yd5B1RjjJV03l5qwsJNb+/OCnPXmARNtrqkyA72PJoDBAjwiOW
	K0hiZLjdJszpXtGe
X-Received: by 2002:a17:907:8714:b0:bae:8734:18b4 with SMTP id
 a640c23a62f3a-bb8023bc02dmr171881566b.16.1777392758324; Tue, 28 Apr 2026
 09:12:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=oV8kcE6hXPoUVQAYGaiz+2OERoSRLAS6X+q9KJ_8w8YQ@mail.gmail.com>
 <438478a7-c965-4a2a-9c4a-84b5f77d6dbe@samba.org> <CANT5p=ortwT7ensa+kKoCa=wMnGETpqaQuBnhDWMSNu82KsqFg@mail.gmail.com>
 <e248f3de-bbaf-48e3-9e86-0beb9a789556@talpey.com>
In-Reply-To: <e248f3de-bbaf-48e3-9e86-0beb9a789556@talpey.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 28 Apr 2026 21:42:27 +0530
X-Gm-Features: AVHnY4K2XjlTsTSCHJLslIA3lI_-DAhznUe5mx_MQp1-M-AJVwKvcSVDlI1FDuI
Message-ID: <CANT5p=rt9V8Guiyt_H_Y8g_NEu2ZgHgbYLGM1CBcgoAZbzjXsg@mail.gmail.com>
Subject: Re: "Intent" of VFS lookups
To: Tom Talpey <tom@talpey.com>
Cc: Ralph Boehme <slow@samba.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 7:11=E2=80=AFPM Tom Talpey <tom@talpey.com> wrote:
>
> On 4/24/2026 9:20 AM, Shyam Prasad N wrote:
> > On Thu, Apr 23, 2026 at 11:13=E2=80=AFPM Ralph Boehme <slow@samba.org> =
wrote:
> >>
> >> On 4/23/26 7:01 PM, Shyam Prasad N wrote:
> >>> Wanted to understand if this is a problem for other filesystems or if
> >>> it is specific to SMB protocol?
> >>> SMB2+ protocol mandate that open call specifies if the file being
> >>> opened is a directory or not (regular file).
> >> sure? From memory (though the logic has always kind of escaped me) if
> >> you neither specify FILE_DIRECTORY_FILE nor FILE_NON_DIRECTORY_FILE th=
e
> >> server is supposed to open the object regardless of the type.
> >
> > Hi Ralph,
> >
> > That's interesting. The spec does not seem to define this. Perhaps purp=
osely?
> > Will try and prototype a change to verify.
>
> This would be filesystem behavior and therefore it would be in MS-FSA,
> not in the SMB2/3 protocol.
>
> MS-FSA does indeed specify that in certain conditions, an open must
> succeed on a directory even if both DIRECTORY_FILE and NON_DIRECTORY_FILE
> are false (page 60 section 2.1.5.1):
>
>   If CreateOptions.FILE_DIRECTORY_FILE is TRUE then StreamTypeToOpen =3D
> DirectoryStream.
> =EF=82=A7 Else if StreamTypeNameToOpen is "$INDEX_ALLOCATION" then
> StreamTypeToOpen =3D
> DirectoryStream.
> =EF=82=A7 Else if CreateOptions.FILE_NON_DIRECTORY_FILE is FALSE,
> StreamNameToOpen is
> empty, StreamTypeNameToOpen is empty, Open.File is not NULL, and
> Open.File.FileType is
> DirectoryFile then StreamTypeToOpen =3D DirectoryStream.
> =EF=82=A7 Else StreamTypeToOpen =3D DataStream
>
> There are a bunch of other cases involving trailing separators, etc.
>
> MS-FSA is, of course, not the only filesystem type which can be
> exported by SMB.
>
> Tom.

Thanks Tom. Will try some experiments with this.

--=20
Regards,
Shyam
