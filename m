Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7723EAB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166648; cv=pass; b=lUDA8B3+1+xWNkwzgi47LMqrXuA0r2s/xQWJFF4k5HESHPLF3oK6+vIqheJtHXfVojlOLe5ndwmzyIltbkQUYoi7s8aCp28j8PZCYijRAGR3W5nwejzD1XxiF5U2BcPDvKbUSTpb32ks+04jfvRwSTXN55EA0Fx/jMYiO91q5Y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166648; c=relaxed/simple;
	bh=CtPhftfvGHn6SgDt2zk9OxGOsN7cHsbY3NEdWolQhsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIdnI+1A3DFGIdXLG4IaV+BrPImZTHVM2WvKXIJp+NxzKsT4f+E/QSQjmHWF6YsAqlZPIQkkELkPFbec2OmpQKS1AuTvs7xVbsbHg9p0FXyGRlehVDQIpqhTzkwtDem/hEODJbz0f5FddwEWb3sFMgChgWLDoayQ5OI88rZtRzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgNjrACv; arc=pass smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgNjrACv"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d73ccee442so3052660a34.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 11:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773166646; cv=none;
        d=google.com; s=arc-20240605;
        b=WdbD5jaDyE52ynVxUkUxAnhM7SseGVGHnftN1FY4nQ0T1kFIrwqM2spF4DeNP+0aAQ
         SjpmxEsx+Et8O8KT/xjp7d/HxSq7IsyJjZgrgWqtV8QvZyENJQDkZdKpnlPT2F0I3Rtf
         aOREyNaJB9s+SeiubQnvpCf87y7eKAfd8ZoIGfZzQi+cMVOU6yoymT2ikTU++CNQf0Ei
         2tKd7XHSHXlRvymmvChrapn3R+uKU9BYElWedwwct0vJaJ+Xb2DsksizF7mbMPSQL2OK
         uKof54iMNka0optZiE85M45Zk0oFtWaKvxSw93zlavYUBMQDgFW3fkNz9tQbKsnKbplg
         UutA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CtPhftfvGHn6SgDt2zk9OxGOsN7cHsbY3NEdWolQhsw=;
        fh=PB+sa02BFD/1YeZZSTM5Zx2wMYS7HmuMhvDyHpLsyNc=;
        b=e0VGd4hhbYrk/fqm6G70TR+DnOVnAy1BLi4nr783IWBkF/+sasTEi0qVjJ+EjHVoBP
         PK1WoE+j7ge0i7FqjQFc6CQfuQdrBbVYMFRKNEf8uJn+uG0yb3IUoynWnQ72/sfpoKSS
         UYLnXOsP3rFRluWTR+R2zrKLxyKyc+cqYK5qR9BHdEXxUvK2s7+QHygj5mqVojvbeiKI
         ZLcgv3Bfds9YPwt74FaAO0zDD/edkeyoPP/hKR8bH9vD24D+jxztUKEmWL7py1VN/OjY
         5a2aXBL5gOpWalrvjmRhVMKAXacqHxlH2A+l8Uvzj/FgJEEiPPnGA2rzrL6jUfCSBnvk
         XtrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773166646; x=1773771446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtPhftfvGHn6SgDt2zk9OxGOsN7cHsbY3NEdWolQhsw=;
        b=HgNjrACv1HDbireZERJef3NQzY4L75hPDeaN6O/8c9w8pO87jJN/wa+zA+S1IU7VN/
         Xcv/sB6c8s6fWw28v/uzdMlswVQglCvXudIP9oo7sfm0/+AL7HRcW7hdGEVJcE4zhgo3
         C1tvJS7eUUExTmxKRsZUNjb1+W0C3zf2J6yTlUOvWE3Ba+kMl8yIQLctQPIFfDBCPOIQ
         U9YJjke+MpVdnBjW6WLUDDXRvPIDxToDionH5OQVKGir3CG+/CJqAG1sAy1IwvOuwbj0
         l4J9AnMSgRVr/NfLgukeGsOfbzW1wzTKcAiafTEi4NcAaLMqBA9y4RbyGCpxe2t4xo1q
         tRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773166646; x=1773771446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CtPhftfvGHn6SgDt2zk9OxGOsN7cHsbY3NEdWolQhsw=;
        b=mQG7VZLG1lIdUcSV5ixQbrLtfY6ZqOeIwrjeEcJuy0nAtAfcKTK5QeFY9Raiahi7X7
         AcsGUajY/hwI159xL7tBtlDl59H5PZYVWA1C36tdXuBbiWshXvAu2SEyundjARMa9upg
         1TYfSLbV9o+B8YY0wxq4umRwNXqQkC+u4cBo7gc6xD8DW/3zNslv0sIyyA86jYPLXJrA
         nkGY3+ddFEqeRYML74HGOF+PlMIG51j/Qr8p3Q1xcn0U3FV7gLYVCGqvktMQbtuU6tOV
         +mM5BldwOB8JOh5bB78EMhmtSgBfDfptHgeFViRKLhnS5MCu8UnteRrHDF42or3798xF
         xbpw==
X-Forwarded-Encrypted: i=1; AJvYcCVTE479kUL3skeyPPYcFwwAMVmiVvvxCUf8FeG7RCjDxRo7e4X+TjSb2osmggvZUa5P0NrGXu41sYHpNLFg@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ+bvpdctNuLaqjFQqxOZcGDPbXa9Qn8jwv2GdlO2kxxCBuVen
	kEb1qIitVECaQKckYnpftbMwBDXokQhDSsQCOEaalZN/VmkAtEKn8Pg69P8V3zZGYOQiBSYQRmp
	OVlqQmCIMG3AdAafGa5eeOiWupxR1b/Q=
X-Gm-Gg: ATEYQzwphx5aM2j7SLPEVZ9c6uScsOkp1ra68RQA6Roel/dcycqkAQfqv11djuPhWBV
	/jGGpJHlMqOdqWz+GqXx6A0b0rWx7vqnnJTElC3SreXPc+2c9PwMQnffjRG3NCP7u4qzLN27DFy
	2Xm0x6oaySYi282/aNQhPRLaYxdUSIRK+Ll5EnB8wt71SdMITpFl9SrwLsGLGVIruAH3MMsdRmo
	p8GxO9o7aKgkcwPlG3tVCLLpCJGxnmcJvcocT5Iwm3eeWf5mXKBFFuBGRj9rkS2X1fGuWDl99A5
	59WrBF0=
X-Received: by 2002:a05:6830:6483:b0:7d7:4b31:fc0a with SMTP id
 46e09a7af769-7d74b31fe1bmr4560643a34.6.1773166646345; Tue, 10 Mar 2026
 11:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217180108.1420024-1-avagin@google.com> <CANaxB-wNJWhyM7JUKT3y0Wp73=+8XZRnSkdudxqDwEo2FaJpwQ@mail.gmail.com>
 <202602231428.CAF9D1B913@keescook>
In-Reply-To: <202602231428.CAF9D1B913@keescook>
From: Andrei Vagin <avagin@gmail.com>
Date: Tue, 10 Mar 2026 11:17:15 -0700
X-Gm-Features: AaiRm52EAeZPezNaMYxQ_phYY0Iw71nOMe7J5lxa4Vausj_LtOvbcm1YDNeZQSU
Message-ID: <CANaxB-wFW5CedtQXiGbQ=b6eyOzDwPhPXf+Tp0RK-DSqPsC=4A@mail.gmail.com>
Subject: Re: [PATCH 0/4 v4] exec: inherit HWCAPs from the parent process
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Cyrill Gorcunov <gorcunov@gmail.com>, 
	Mike Rapoport <rppt@kernel.org>, Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, criu@lists.linux.dev, 
	Chen Ridong <chenridong@huawei.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Koutny <mkoutny@suse.com>, 
	Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 2:29=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Mon, Feb 23, 2026 at 10:29:00AM -0800, Andrei Vagin wrote:
> > On Tue, Feb 17, 2026 at 10:01=E2=80=AFAM Andrei Vagin <avagin@google.co=
m> wrote:
> > >
> > > This patch series introduces a mechanism to inherit hardware capabili=
ties
> > > (AT_HWCAP, AT_HWCAP2, etc.) from a parent process when they have been
> > > modified via prctl.
> > >
> > > To support C/R operations (snapshots, live migration) in heterogeneou=
s
> > > clusters, we must ensure that processes utilize CPU features availabl=
e
> > > on all potential target nodes. To solve this, we need to advertise a
> > > common feature set across the cluster.
> > >
> > > Initially, a cgroup-based approach was considered, but it was decided
> > > that inheriting HWCAPs from a parent process that has set its own
> > > auxiliary vector via prctl is a simpler and more flexible solution.
> > >
> > > This implementation adds a new mm flag MMF_USER_HWCAP, which is set w=
hen the
> > > auxiliary vector is modified via prctl(PR_SET_MM_AUXV). When execve()=
 is
> > > called, if the current process has MMF_USER_HWCAP set, the HWCAP valu=
es are
> > > extracted from the current auxiliary vector and inherited by the new =
process.
> > >
> > > The first patch fixes AUXV size calculation for ELF_HWCAP3 and ELF_HW=
CAP4
> > > in binfmt_elf_fdpic and updates AT_VECTOR_SIZE_BASE.
> > >
> > > The second patch implements the core inheritance logic in execve().
> > >
> > > The third patch adds a selftest to verify that HWCAPs are correctly
> > > inherited across execve().
> > >
> > > v4: minor fixes based on feedback from the previous version.
> >
> > Kees,
> >
> > I think it is ready to be merged. Let me know if you have any other
> > comments/concerns/questions.
>
> Yeah, I think it's looking good. I'll land this in for-next/execve after
> rc2 (a week from now).

Hi Kees, just a friendly ping in case this slipped off your radar.

Thanks,
Andrei
