Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E353769F9
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788371153; cv=pass; b=JMB9VIBqNqiZFXmSQW3s/5AX+SHDv9sS07VnUh5aG5rhvvD1ThiNi3gqloRFRIjc335IXd3+kvLxFDLUBWacF1ZCjnsudngJzj1uTxsOjznU85eRvQsCGPgizhBklVZKWwhEf6Ae3J5VPzq8KwoNZckMKdytMwiuhVadSIcnBus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788371153; c=relaxed/simple;
	bh=K0HXSYdoGd6S9dM22plvKSCWPk9aEGxVwTcguAvww6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuyDvRnbFHWX8luevU+cCciHT9YoezWqrb4AF2gYdlN9+DKQYbSkeCFvRXdr+UCHIBdck3g5SNTK6rHa2SmxytL6xJGW5Kz79Dv+gxtb2neDDkUv8+fvurVCXLy86lCsUZ3TiTWn8EgLqI+W/H6z35IbBql6OOR7nDoJqVIXuWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VlsTot0D; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VlsTot0D"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-484392e3d33so848109f8f.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 10:45:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788371150; cv=none;
        d=google.com; s=arc-20260327;
        b=C7bPPpzlYYJNsJnY9HsPDqb74bdPJTQQcybbHwnfKKtYpxzi9yYNA+O2zS4Flz50/c
         J3WWIpaV+kCZzHRB9NO2ius3FnPwk44J2CedTUS4RCu0hYMj3lanUClZXCxqEolpnZB7
         Taj3Co7PBuAsXg0PBNKJ54SobaCRmUkDWgdxwxhhx6+0L8lE22ozkcCd7KtJcCaD37Wd
         IUCZ6qSIf1ugbF2xd1JkneEPqP384VDlXLSHzaE84z4Gp3/MopJFdbLfFEpbwsCKVSmp
         l7RXxCITYR9i4f5gDvPzA50JDpBLLB9cPtA0Kq/ddOJd2keg+qMZRetd85Qxt5s7XNjz
         iaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c5v4QLo29+9sYIlbxOvZxTqf1Ctg+I+izJ9dnI+b66k=;
        fh=kgmMLHO+Vg/FClVIIZFmmpgaj/aaXfhbQL8ejq6tCoY=;
        b=R98PWBMhkMs5+lKQ+W0pe7oO90+g8j8Afbh056K2CYKqQMaVSeArfetq8OkWkIOOLN
         3rJPXXXYvhBy8YNy6U3E9jzMhaXO/ONAIPOZ0lTDVQIFbCvWxMe8CqBpZ8enui3tcSDm
         FHefwQTWyjHzIsugVtyqb8t7/1fMt/c8LV1uJoj7zWXZpJ8DrQkawtufaY4BFfDCfyDh
         bOC3Tieu6/VMV79cQ2GTZQIu+Z/ubQHCZPiXCR3HCAYl+rFdpzKFE6A2cXMdfQT0kwHF
         OaKoMdKtm52MU3HRI2Uof0HRB+jLj9OjyqilVZ+4EmzWm9l1HuLIfThcaUCRHawrsw57
         H/ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788371150; x=1788975950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c5v4QLo29+9sYIlbxOvZxTqf1Ctg+I+izJ9dnI+b66k=;
        b=VlsTot0DuYqoC1uVS0+e46rqEw54gX/8RoJftJey6uS4qtgDyq2L42tIag4JLFES8b
         e3SxHmU3++trX1P8SBayIhCmUWHGU2UfEmpfswvTXYROB2pyACACd1td5jpy6hx30FFF
         NzjzBKb74P9EIc/I72L/cR+5J7mkkJSphddDr/VBQ9edji6L5bp8n9Zwqjldd6kD8pG6
         n9eMbLMjt6OgCbjxzXQeiVMlGFXar+2+n3PQqV4/mQCgH6Nm2Oe1cUxp/Fb8h7bNSekx
         kSU91cyvRwriwlXN9VvExNqQzsVNKDHJkn1KmM2X9ovsVYdbd/22I6sZeNs6L6/BkgBW
         ugOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788371150; x=1788975950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c5v4QLo29+9sYIlbxOvZxTqf1Ctg+I+izJ9dnI+b66k=;
        b=XDda6T0sPS/HFR3aUiOdSySl76KYdgTfrEj+v3/HQ8aMA5dnHRe3ro+UQ+/EvtKMMU
         v+K8E5y7nn+3e5IBPj+1+h/8sjWjLtyeJCVnI/Nns0exfznfuUniMCuutAiI0fman4Ur
         QgKiSCBluUgAKDdWD6M65uaFBFIHF/OsymO5EnHVHxafpIT48rdwuSwI9FKWXQe1k4a1
         IuqAjMiNKNFyMqcuanf8Q+lBoDWKcosRNa5BmNjG2pra0ktCdGOO3r3cgXBbZB0jgQi1
         aJ5qQwHAaSfOAcMdxu7OuPFOgZ2qPR0Pqd6Q7TGulgvPpgm/XYDJeLyYsqsMTgMHW0ud
         qKmA==
X-Forwarded-Encrypted: i=1; AKwUvBxUMBecciu3HNfaUvZZrXXFA/32C3FfC4K4MsEfpl1qeVk1T3Rw67mSyu5ai0E9W9nM8VCs/gi8rZw91vfG@vger.kernel.org
X-Gm-Message-State: AFuF++lMM8U98f9RUsv4XcCnoc5zSB6fGetO1SdAN+tPPmHio3a1+XB6
	h9f/oc3bDW2JPsFrcHIeA66xroMguxO2o0XRWigWVNaKW6gk68+4WQ9dnLbdANMTO8VJ3EYaOT6
	Yi2cUauLc3BEJrSWQvpuz32N4Hvyi1q8=
X-Gm-Gg: AYBFou1FgMzEXbU8ggO/VRpIQ6zkqi+1hBgaf2mIUU46PnBTHlYankOGXtQUYi024Z+
	K7+kH90vLeVhLqdtQB01A/4fhbny1EtEKdSyVwsOkxkO9fdc92bsTidlr1mrdsrCihT4bdAPYO3
	AKdEICGvDbww8sBKz8f7t8syktOWPu8XfUqTPfjApdqNWIhszRM9f1yi0oc7NeTVBGzd87L5HE/
	P8lEJDnzSpXYR/KErJoqVD6HPqVHoL8w1qqCA40zyE9Xpw4yp8OV5N6UckzDYPTGGCdIcfVCwaK
	34dRIZgqsVZPja6FMNWLmM6eWFxJrOxb8M0uWUQxXXZSisSYCzUBHrJAEgK1j1r6G2CGTrarCR7
	4LogJUA01xURN2eHu1NtuunmlhSY=
X-Received: by 2002:a05:6000:b8b:b0:484:4874:db4e with SMTP id
 ffacd0b85a97d-484913b96damr9005716f8f.17.1788371150252; Wed, 02 Sep 2026
 10:45:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729192737.3190206-1-joannelkoong@gmail.com>
 <20260730-habseligkeiten-adrett-axthieb-e619a48325ad@brauner> <20260731-hirte-hacken-atmen-bdecd01097f1@brauner>
In-Reply-To: <20260731-hirte-hacken-atmen-bdecd01097f1@brauner>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 2 Sep 2026 10:45:38 -0700
X-Gm-Features: AcwNN1VeQfLr-lGWKTHuj31ux7CqT9nCh6MBY2zMFOnFauLHmsLD9R1qSF4ix5E
Message-ID: <CAJnrk1aX__NiZs-RE1N1MzDVeCsRt12d_mwX_K7Eq2bHtNfdYA@mail.gmail.com>
Subject: Re: (subset) [PATCH v5 00/22] iomap: convert to in-iter iomap_next() model
To: Christian Brauner <brauner@kernel.org>
Cc: hch@lst.de, "Darrick J . Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org, 
	changfengnan@bytedance.com, kbusch@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Jaegeuk Kim <jaegeuk@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Carlos Maiolino <cem@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, libaokun@linux.alibaba.com, bfoster@redhat.com, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 6:40=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > [20/22] iomap: remove ->iomap_begin()/->iomap_end() legacy path
> >         https://git.kernel.org/vfs/vfs/c/0210c4ba2547
>
> That accidently slipped in. I have not dropped this from the v7.3 merge
> window. I'll get a v7.3-rc1.iomap ready with the last three patches.
>

Hi Christian,

Hope you're having a great week so far. I'm not seeing the last 3
patches as part of v7.3-rc1. Do you think it would make more sense to
have it be included in rc2 or to have it be part of v7.4? I'm happy
with either, just wanted to flag this in case I'm missing something.

Thanks,
Joanne
