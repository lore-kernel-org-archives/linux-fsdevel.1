Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAF638B7DC
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 14:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666962; cv=pass; b=urKARz1iYPRVa4SgIgUC9f/6m4EsUPbUXYKxxnBgCmt6qTZy+BOisEA9imM/gMBgl5qQuCwcRyXQOjt+Hc6HBy1Jp/VH5JYF8/LjkFOyEE3BD73LQLcY2/Z/PqtP2kCDDw2+OLmXM4EDk42EcB9KB1j1g94WMVZCYgMLKK5qg/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666962; c=relaxed/simple;
	bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyr7Vi7ca5FhlQRMm4+QWlWOTcDoGyILVOQFwXMUgXXFgYk7dQWjXQA4290ssf0DJA5LWMG2CgYF6QGNegxgJFIpNq+Xtpy8C47EZiA0gJ+LfEIPARCqePTgPpOMan7GMhV2j2WIUfxM+Mdq0q+5iso7R3OdtDTj7SvqUy+zexc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nJLKBMn+; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nJLKBMn+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2d3b440b97aso107405ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Aug 2026 07:09:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787666960; cv=none;
        d=google.com; s=arc-20260327;
        b=MxyzcLB6xqmyZx8t5SbgVHrU6Dyoi5Bbzu2NzFLarWfyWMiARToljMBHn8jNY9TSnZ
         JUBlbFLy6s9f193YZK4xCdXHkrrt1A+kXwFYFZDdb1Y6LGj0Uqa5eQ/itiaFupSqZLvK
         S1twkaxAx4kWEklCK/AxHaXrlSQF3Xf2U8/mDTZYiTasN7qewjjAj/SXLHzbj1Om5HeS
         7oIJFA+mH8fACn37XEj6rqwHQOq+/l8iRix2NLOdI5HS0zT9eH3i9Ih3N7wabbk45Iyc
         F7CLTLtaaEJwIUDLkCsuoEXZ2I46ZYDcSQzEYc2J5isA8C//IURMIMND1KXimIAWjzBU
         Yupg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        fh=7uzf7gP4A1aHWTlPsY87+E5YBpHSJpQ+3JatY8ZiD4g=;
        b=p8qXlhD8pHNeuuhXfVnbd1C6eJB/zfg4xxSdgkXy1UFxxiBcxgMejZL24tSTku/Xjv
         II3pqip9Si0r/P8lfFjzDZeMgC4qVNP2zedIib4YAK6/7ajj3i6oQKErAhw0j0cE5sFl
         8Mp6wUYRG4euL3wkFi7nC+XStHF4Y4flXk3uaKyYgnEf5JfYx8nJOmghJo95LcCLrvQ+
         PygJkyJaxf5MKLon+i92ig26QXAbxubJKnIOOHsoBsPdhu7SlskybZfGqGzR80RZJ1oe
         c52DR3RSzTdcPbkP3XwnQuxSNU5pV9N7NBEaOSRdSDgkoFhE1qkmRTnMk2QEs4Gj9LnS
         hgPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787666960; x=1788271760; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        b=nJLKBMn+gbqeBXi6yW6UE/2QTPoaDNWSvx6T7SdOn/yYq8fLbj45nUOydbT8Qokm1n
         YMaZLzYl7hZGcQNu4U13RRqLucKw+z4dW0fYfqovPPaZ9QcnqL5RzE4Z5uKkH8mT8/65
         r+lzEhQYtuTM4HjQ97fb/bN/r2u3GuQcHdd+/4hyyeh9bpR+NrADxss7350OmM9fSppa
         K23QdQwkSx08B0W81dumVO8tSJqpZpJdYupiVEQImqknw242BRAA6Kx/5fx+nkOEkBI1
         QUtNxEr5APYXIunFN1J+9oozXKVq05KLGSYHOWV1R4V+4dzkiMZAuxEAP92toQ/AIhiy
         7jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666960; x=1788271760;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXPt5VZpDf4uErUsjt3ZAZlmlIM/hF9XA8Fbbo+LtZY=;
        b=hm73Qt9suojMzR3Th0lTGqWPmPKUiDLSDRSu4f2mThfuhrpOwmK2O5JKs/YYGTD0Si
         pUcS0YOZ4iOgqMGEssEuvM8Yzko58VVnLElRiT9NNER2jY9NOjfM4BJ16P0UYoZT+gPL
         bIJ1Tf6q/Rv3LmdNn5FQlXIaxw/JXjb1mgUP8ttDMZORrg1dyKGGouptMORMksec3zQy
         HkGyXsFX/Q90XseeNwOibzMcpNX3oLmrvuYFUmYZJPGs3hY0mCNGzACV48sNd66H3CXT
         5P52sU1IghL0gigICnFcmn9vB9Tr06d/wMWCjTjmCP2RVXbCfByP0pJ7PkkcsjSFFszz
         4IGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpbgRdxG44peiOHYyIjRybnHojWh/JmfbxUcJkUTW9aeozVnwYcJ1BMaXsZl0/WeV8UADN2ffO0BXBD59/2@vger.kernel.org
X-Gm-Message-State: AFuF++nNQICtqLRYsAP+lZJLCONth3WJqK0cxRkXnZ+d+SOG9BlaU+aI
	VL0TMx1H4HrfXOjJsxuY0TTZQ0Y8gfmPzpb/6ukjt2uTl/b4Fm9cD4om6Ymr5aa0Ln77XucWrH5
	iGHj5ua1RdqLkqLNXgJ1zhk9QjMkSJaEvtND4m5MS
X-Gm-Gg: AR+sD10pWFs7T+naqYGovfXRwyyUeUOxQuZXAKN9lRP9Ix58F7zz25gDDQJJoBNVc5U
	LRCtvsPyonyC/qI9mv+s2Eaac89xXn7IxEHJxRL5EwhSuS30hegVpnAyjB8nv1FjoySAb/WVIX2
	cvE2xRTA08rRBOT6zjlP4Q2peuWtFn1dS5jNy0QrEF9w1hMef4kfZKQYIytcX85dNvHbRHlcvuF
	74ZKmVvVSORISYykW9J/QfN11673qOKDfxX+DXbD8Wn6buHl9k5Va34KQM3vGMTpBb59FUro7m2
	Uxzr5qsFHvAhIOHHctdXh4+GGexxpbtYn7nnjzkg2I69fujbr8mZZqIklwR2Sj/LIA1MhCkdKIC
	PhuwriiSMJsKczuSSO+3Ns2RbA/eH1w==
X-Received: by 2002:a17:902:ef4c:b0:2d5:db38:8010 with SMTP id
 d9443c01a7336-2d6f2f25ba3mr341215ad.15.1787666958726; Tue, 25 Aug 2026
 07:09:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <741a833d-6889-4ee6-9322-d6a3a8b95893@kernel.org>
 <CAG48ez2Ngo3=VtyykXY6ynVzGwA8px-p4zV3V6U=YfgV-Hy4BA@mail.gmail.com>
 <dd8c34a9-0e09-453b-88e1-0a5511816627@kernel.org> <CAG48ez2bZEV+3ww2x9XV_5vRPZ_3jU_zg6+h=BDKQ94Xrd3Tqg@mail.gmail.com>
 <aoibvf6CY99IXynk@gremlin> <CAG48ez0CX-PT5Yk5gYJuB6wPe26j0gHHXQqYoNtTA=iHe_5Wdw@mail.gmail.com>
 <aox7tVIQBMuz-xFO@gremlin> <CAG48ez2-8UjzOp=St5eTPyG_yd2iBmPF6y7qVBTNaPNJgoX=BA@mail.gmail.com>
 <ao2a33Xf3U0kQmM_@gremlin>
In-Reply-To: <ao2a33Xf3U0kQmM_@gremlin>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 16:08:42 +0200
X-Gm-Features: AcwNN1WtvUE6nvnD4lMNaCfocLK-DLM3bUJQe4WrdBFVB5gGe4Bk4AlrWw9e41Y
Message-ID: <CAG48ez00PjoaXt4xJn1DCNdZfmFn4faya++=U2EeW0_vcYXcqg@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:42=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
> On Mon, Aug 24, 2026 at 07:43:02PM +0200, Jann Horn wrote:
> > On Mon, Aug 24, 2026 at 7:33=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kern=
el.org> wrote:
> > > On Mon, Aug 24, 2026 at 07:06:04PM +0200, Jann Horn wrote:
> > > > On Fri, Aug 21, 2026 at 8:52=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@=
kernel.org> wrote:
> > > > > The sharing a /proc/mem fd seems like that's a pretty dumb thing =
to do in
> > > > > general :) but I guess you have to protect against that.
> > > >
> > > > Yeah, it's a kinda weird thing to do...
> > >
> > > Yup :)) but I guess we have to account for people doing weird stuff..=
.
> > >
> > > In this case (I do mention it in a reply elsewhere I think) it does s=
eem
> > > like perhaps you should separately check for current->mm !=3D mm of (=
what was
> > > originally /proc/self/mm)?
> >
> > I wouldn't want to do it for this access check, since that could lead
> > to "confused deputy" problems.
>
> I guess if it got the decision wrong somehow that'd be a problem? Or wron=
gly
> OK'd it on one level but then that led to the fd being passed on assumpti=
on it
> was OK to do it or something?

The problematic scenario would be something like:

1. process A opens fd1=3Dopen("/proc/self/mem",O_RDWR)
2. process A does lseek(fd1, <address of libc>, SEEK_SET)
3. A sends fd1 to privileged daemon B as a "log output" FD
4. privileged daemon B write()s into fd1

In this scenario, daemon B is just trying to write log output into a
file descriptor. If we checked the current credentials on write(), we
might enable FOLL_FORCE just because daemon B is generally permitted
to use ptrace.

This illustrates why, in general, the "ambient privilege" that a
process has must not influence write() access decisions.

For a similar historical example, see
https://project-zero.issues.chromium.org/issues/42450869 where we used
to do capability checks in the old expand_downwards() logic, which
could be reached by writing into /proc/$pid/mem. That made it possible
for an unprivileged process to map virtual address 0 by providing
/proc/$pid/mem as stderr to a setuid root binary.
