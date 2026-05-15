Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471E7405C37
	for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 21:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778880240; cv=pass; b=BfLq72+D/K7uCjEsWMMzfLBmKJK0MiNjY5eMsJFWhqC/y6LzTADFtbKsLND43JeWJsG2LGjcLsjqSIb+IZluxrNs0ESjriH7YJYMmNxooE95cC2YlL/zZSXihh9UaxRjCFG0HVnISDyaFMx3bPczWcrsPIJr574ZpefOMOi5bIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778880240; c=relaxed/simple;
	bh=Ciax+KscSHd+KM1eU71himblbHXGWQL8PXc1xnvj7EE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nPmbiIaRMp27vGLMgooPJyxxqmF+Z6vEbuVQMDsIfPdJUJBakAFvSlqfuNqMQBSUxZtu/2laBZhHaKHIsoPMLy4xafwfXZpEP7FT0qW9ihzJpbbHoqw5sjkkFHYflPjjjrKc8PYK7h5gbEE9v+qaubPE8AS57DZ6wbXYlL8fbuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhGVSmE9; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhGVSmE9"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so560685a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2026 14:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778880238; cv=none;
        d=google.com; s=arc-20240605;
        b=B31NQjTUDijN9RUVOZfUSpfwnAC75ORaOwABHNzILljI/YAqYbsuGDo4xsLoA3+qJf
         OvFeIDSVA3DCoZ8RfXvJ2EyX6uXJV9VPYYegFA82u/2kB96NvLDYwP9stgaV5XJ6Es6a
         VscD2/q/waqqniIGIXwAZj8MxKqUS67pYLXzwLY95Dh55/gska9I3WeD5lFPTNgC0Px5
         /72X534GG9fXdkyeZN4IQIif9Ok3wSmTeqUa7teGY8nWHlMWy5fpd18h2JBQeRsBVs1D
         ljx7SQVnKuefRSVGmX8dvg531lj5UpzPj4Vuf/CUB67zSw/N8uGIxHw+7rhLdujxmoe+
         344w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ciax+KscSHd+KM1eU71himblbHXGWQL8PXc1xnvj7EE=;
        fh=5OzmEVwFWASD9/IAdyrl+yJp0xfcOvyeLpFVMTiCjWg=;
        b=YMgf7R6JrFFQQ/sxrpk7GBGCyj92cq4h82Oco1eNB8vpKKwSjH5xjWryHaxLq1bgf7
         snDwLo1Nu9TPWM9eQYriGJkrQnR2KH+LAUzURQEWzwiRejY6T0YO/ahUBbdtWFFqGDyO
         tJK8Lr2QhMfHPqSXNXgl4PiZGJcHK/3Ri4B6BRxS/aMFu3cSG2CxJJtu+uxUNe525Ge/
         jGQaR5iD5i+r3QCqB5UyuAZ+s1yLvnRgh2NSnjrrngvF4yjCL9NIVEgLcsjavMbhcoxi
         qu6EMyQA5T5/Eekdu+BtlFu/v+p5LtDNTfJJcS0VXOVzmu3szuzjGlemWxNwyUNpdE+A
         iWig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778880238; x=1779485038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ciax+KscSHd+KM1eU71himblbHXGWQL8PXc1xnvj7EE=;
        b=LhGVSmE99gS3ORgQrVmUb85v5c796nBc8jq1JY9L4Bpvd5EcuiFy+w367Wu0ND1+fZ
         BiOzgXP/35Ebi9/ZoGi0nC9E7AJ66FlnyBtbRLo/wVWHRx48ceUM6WXc+ouZSclolsqa
         TMg1amtLkil64HzyfResVTCsZW9+53+QhRkyYzQvOpbN18VdKde+j+sORD88wx1T2SoN
         EtHdWHMTeNF9bQ1XPNaDEx6bnFXnp8f3n6kU4ues/U9277qEfBV93WXXNk6q19rAdltd
         mvcvxeNZXEtcabaNtJzrWg2fG1c+Ot0XpHcYsidyK3dz6lLSuSFwT4Noap3jNnDKQVqx
         oeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778880238; x=1779485038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ciax+KscSHd+KM1eU71himblbHXGWQL8PXc1xnvj7EE=;
        b=BBRY1pDbU5aGwHJu0nVTXtTecdgZubXPMEKBxu7mkgRHa6qtIplEvmXXrk0WcRKmDh
         bJwm4nV+DQSZVSqwtrwzVVPjnhs5HozvDxCULpNxrNupjgyqFRqCP9NGqxMD9tUC6WPU
         lOJKV/iKU5Afwf+FvmqTM0AqDL93DzlsaNZa/q6B3iYJz2Ikoiic8AWHuUmqzZNhZAou
         8d4c0LZ0YFBjEYY5+m4xEhrTo/EA8Uau/3yQVGvqLC0mxRc6tI+2KXe2UYCuehhwUgOi
         VAEQW81CCrVAJzr6JYTWFZ21BNJfxDusoT6fpmFhBn0P7gz6dTvCRbk1zmGuexzjhGai
         pXuw==
X-Forwarded-Encrypted: i=1; AFNElJ9RSnbZi/8ZsguLoYh8uVesORPp8vQV9261YjvUlaMJEIIR7zWxqQzy7jQ0sdDOEKM4vlGmqKkmMSE4vfNk@vger.kernel.org
X-Gm-Message-State: AOJu0YyDKtst8GliE+M3xGNj4D/+zDXwpdfGcTpwGuKneJASdmRcm7hB
	Ka1x6UizaEdVlyLedmfEyDiFTVrr/yBcj92ton9oIllSz1Sa/9qz8ZX1XiB89FibfxZXrdI2M8i
	rHPo78QunB/uN65CqmQQ6uM1It7fgD4Y=
X-Gm-Gg: Acq92OG1FUZL+UMWG67PUhFxahBdCnOyTunlS4NgkTQXQD9qQhaWA+VQq2DKgWQ+GFh
	iDxfK8nXED8pm4jjJGQhpfR1bKHCX2xmNySgnRzgnKzevFRem2B16bMkGnTkFjVjxnkajQmomvp
	YImXqc3K2SjYnXxjwO2A7anQsaBFeZzEw0DyOKNzg0UPRHLNDQuWfhxVPQsgLVqG2jvuOzdwn3I
	O79k75q4OErd5zHMueWCpp0DbAkSXX1EHgc1EKyKMB+lXBo+kJxNWjkFv1rs/mrgFvP4QL4M1Yu
	/rqbnyBMUBs2kvTVALrjony40nseHjtd5BHe6+VoGOnJ/klhjZf9
X-Received: by 2002:a05:6402:5306:b0:66d:d0c1:f87b with SMTP id
 4fb4d7f45d1cf-683bc8ac52cmr2612530a12.10.1778880237485; Fri, 15 May 2026
 14:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747206436.4103309.9048553717124547447.stgit@frogsfrogsfrogs>
 <177747206595.4103309.11659424316192000821.stgit@frogsfrogsfrogs> <20260514221632.GK9544@frogsfrogsfrogs>
In-Reply-To: <20260514221632.GK9544@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 15 May 2026 23:23:46 +0200
X-Gm-Features: AVHnY4JvsEFYf6nuy33M9KsI0NCjzPcVO0uuSRahvxqaFc0lU0CExhl8ulhxrAs
Message-ID: <CAOQ4uxh48-LP3pq0HmaF8DKC6rf7+F35rL_K5K0uEg+c-CHNpA@mail.gmail.com>
Subject: Re: [PATCH 5/9] fuse: cache atime when in iomap mode
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:16=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Wed, Apr 29, 2026 at 07:34:22AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > When we're running in iomap mode, allow the kernel to cache the access
> > timestamp to further reduce the number of roundtrips to the fuse server=
.
> >

This sounds like an optimization that could benefit other non iomap
servers as well.

Specifically, if the server tells the kernel (who knows in which response)
that the inode is NOATIME, then kernel could cache the atime value.

Thanks,
Amir.
