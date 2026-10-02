Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8BE3E316B
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790976764; cv=pass; b=Di24eIhHTRwjm7ftIUz9IjRqnXkT0m/7sAqTUEobm2RjUnyDnNweMP76poA/cTg5iIy6xRsC9fV8iNkyi8OryMT8QLKUCbN9egk+yDos3Z8unihbci1ScFmciEcY+Y8c1Z5Hy4JAiXUYP8CVSjYv0JXoc1fAz1KXAx16qbhmucQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790976764; c=relaxed/simple;
	bh=Rw7p5hrp7jSiFBU+jhLnPwozbRKpQWTMWnDkk688+e4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GYdtVGI4bjPeNibkiZkSpL7pa/+95utQO0gHnmSrm/PPD2/fADI7Cfrn/e5yy73wErR8nuy4ly5tYZe5lHSiqanF6haAlWZDXaCMUQLUcPnS9lE27nRseNoULTMW2h51BV1vSdn/UWvpd/uHuS/4eOp9gnA+La1hAy0e46H+ujg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDC9ax43; arc=pass smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDC9ax43"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acae8342d2so504197a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2026 14:32:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790976760; cv=none;
        d=google.com; s=arc-20260327;
        b=It3IyOzqQ90korRzok8iTjsdL8qMwLOJx2kn46boN1jEOsI4mvXJx0Hgfh2Nl0iou4
         8VIC1N8ltriaESAVyj+rTSibKYd5uitppwPzz/dS37s1vAiZNmLTkX07sVX3O7XzcVW8
         KogRyiFR7p+KH0by3b/sQMenFPqGlhPo2nGV3GhvO1aJEcGSSom8vIRRI165dSWNPSSg
         qu+u+G1Ml4v1JVCFWhWCeCu/UJLhCXoE9HtpV/OG5ItbwFzGy051CtkIqC7iAQtX9YPv
         m/t0HhjIOlg8aaeJWU062Xhl4Gh0mSUBNuJT92CKGSu+Wb7UboQw1bkZp15I66xdcAv+
         Fsvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AR8vK2FFVl3T+EWEuf785UBXdKYtqcyiMVEsfOCIyKA=;
        fh=qEjup9UNu+YVN+h2YqLNrwoAeve5fr8Uc5CKBVnh18w=;
        b=hjjm4kBxGY2sPo7uSN81OqJh9+teYrB5sQRkBDYSjarkLUAOYIS1VAdn75eEpARywH
         tfx0BLwFPJghXQE3D0b00IVG3bf3AngCkNfvQn0qqXENsf56NmEyJnw68cj/vtFwTR7V
         zfZwW/65D0eN9avm+AmlrzLqPP3aNpFTU5p7NJWo+vSo6ekghbJOMmG//E+B/1SEvmTK
         +Fnb3e5KjWfGAeDRD6UrvviiTbFdCEzwU3CRuQkif+3r8OC5Usg6WDNZ691VqUXxpWMf
         g/nKOgnMDQ87UNpQtiE1ghooknMjrXjYOCyEpYQeGpapNgkheHJJvDrtYFHbxuMcSekv
         o2AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790976760; x=1791581560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AR8vK2FFVl3T+EWEuf785UBXdKYtqcyiMVEsfOCIyKA=;
        b=iDC9ax43TQvaj4V/hGGUIZW5r4vE2Mk1F/JvRYwGHXEj6bQG2x51jxaNzivaQ0V57S
         r7sR+j1MQFAvaI8Cuze1PoEN7dh9Qrm2TGJvyvo7Zj7WIMrS/tzji2HpjSb7JpdvBM6S
         vPSQNghgtnen5k6GnDTBdeMnMOxmJQsRwc3MdCH0Wi3q1cnpv+X+10ypdeplFoWhgL5a
         IV/lBHeOTDFqY664ni1TzI8LaP5JuN2fzwCkoO7KF9lcI4v2blyWeHvq7xRPSxveg2Or
         HOBgULK2qNggF8xubp3C6P+GDuojikbFaQ5WTSQyWaHVfLtfa9sMQuQfCsyY7Ovqjp7I
         TkIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790976760; x=1791581560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AR8vK2FFVl3T+EWEuf785UBXdKYtqcyiMVEsfOCIyKA=;
        b=peFXSeVpLgZchkeeqMw1o38/w+cbBtlTght2Uy+YddDRWeQRLnmZy5MopB/oUJO/r9
         0kEUq+gTw7O1AGfmc9pyI4QTaWyxd1TrkOhNqHljFmqQQR9AJRL5uQzh9RFlG11GWAws
         fs8c0R45RYmKrQ0r698a+OihFcNN58Ha8ULRPXk8G5/yQLLp0Hxg6OjAKHPwnxI1QFv0
         dw1Fqb33foMzLs2y75cUjfdet/R6iQN+ul5JvGiBbeQ++MO8YuY31QHcGXjnpcPkZ8jZ
         2jcEpEpR+PIOWpqiTty681IYAP/d+9yXHbNIKDbOD/smqp66k33Kg7T9sWkwuT86ttdW
         Aw5Q==
X-Forwarded-Encrypted: i=1; AKwUvBwDc5IhR2sgucveAe9z4Fva+RuNb+wgCxYA78hWXDWx/HIXFqQ7FmkJ/yR+wIJ/LThf8g6O+w2ZZac/fWwg@vger.kernel.org
X-Gm-Message-State: AFq9FYJG3+uNLlomWy0srOWLKMC1zTH7YeconBIoAo4tgi0GhtDcBIhg
	9sxzsaw+yG4yVQ53/ghXsAF+FAo7uw4q+Al6PNrJHeXvkq/GKUzpebwnn2f/SYhq7gweB4R0W/c
	gH5jT5pHE/K/p/CZTCOQ8FUQ3JbwEpL8=
X-Gm-Gg: AYBFou3G0kWLsz1U5Sp+WGtVgXQo+R2gw7TZCIhlQFSvVZ1FWHoTH7Ybnx46uaSgT+d
	B5USEBMwfQv4NCFCM9fXczlKvxl++8evT58/vq66j8t+HVURffhBVwYvIq7dgyV/utj2eeXc7GU
	BE5MEQQuUvC86JtZ2/5avLjrqA8VXUViVzYvjH7paHqcV2VmLneFibodHAzf750lqMsWEteeh/J
	bR94+kYwJfCr7wmO1xUZaxuWUS72gdPlI8bJbdt3HQRy5n7woO7NrjkSgBUTUTKYGBjtHYz9z/0
	v2Aog17oxdixMZnXVcjYY+itPjI7z9Yjrwqc1N1P+E8YiQTAR8ocgDM=
X-Received: by 2002:a05:6402:46d1:b0:6ac:70f2:9205 with SMTP id
 4fb4d7f45d1cf-6af9e386d01mr2467536a12.43.1790976760359; Fri, 02 Oct 2026
 14:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKLmikMhOYpGEw6uCqX_Bm0JPEg-4FhdJMNa9+tgtw3-Kf+eZg@mail.gmail.com>
 <e75cf549-07a6-4095-bbf8-8caff7a3338b@bsbernd.com>
In-Reply-To: <e75cf549-07a6-4095-bbf8-8caff7a3338b@bsbernd.com>
From: Mitar <mmitar@gmail.com>
Date: Fri, 2 Oct 2026 23:32:29 +0200
X-Gm-Features: AclHuK_SMxUC5ptg7waR4khxz9du87Zel1clvodF34USzNqE3fzoU6-rh2TvexA
Message-ID: <CAKLmikN9Aod9Va=FsqkRmF20=69sdgdDOoV_bUuGh6wTykVcBQ@mail.gmail.com>
Subject: Re: fuse: HANDLE_KILLPRIV_V2 does not kill suid/sgid on fallocate()
 and copy_file_range()
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!

Awesome! I looked at the patch and this is all probably above my head,
but I think the patch should also include some protocol text
describing the flag-only SETATTR, because this is now a new behavior,
no? And probably we should also do a minor version bump so servers can
tell that they can rely on this behavior and decide to request
CAP_HANDLE_KILLPRIV_V2. For example, in our case, we do not request
CAP_HANDLE_KILLPRIV_V2 now because we are aware of this issue with
fallocate() and
copy_file_range().


Mitar

On Thu, Oct 1, 2026 at 12:57=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 9/30/26 23:45, Mitar wrote:
> > Hi!
> >
> > While adding FUSE_HANDLE_KILLPRIV_V2 support to a go-fuse based
> > server, I noticed that with it negotiated, fallocate() and
> > copy_file_range() by a caller without CAP_FSETID no longer clear the
> > setuid and setgid bits of the file they modify, and that the server
> > has no way to learn that it should clear them itself.
> >
> > The kernel makes the decision, but drops it on the way.
> > fuse_file_fallocate() and __fuse_copy_file_range() both call
> > file_modified() before sending the request, which ends in
> > fuse_setattr() with ATTR_KILL_SUID and ATTR_KILL_SGID. Since commit
> > 8981bdfda744 ("fuse: don't send ATTR_MODE to kill suid/sgid for
> > handle_killpriv_v2"), fuse_setattr() drops those when
> > fc->handle_killpriv_v2 is set, expecting the server to kill the bits
> > when the WRITE which follows arrives. But no WRITE follows
> > FUSE_FALLOCATE or FUSE_COPY_FILE_RANGE, and neither carries such a
> > flag. All the server sees is an empty SETATTR before the request,
> > which it cannot tell apart from the one it gets when only
> > ATTR_KILL_PRIV was asked for.
> >
> > For "fallocate -l 8192 f" run by an unprivileged user, on a file with
> > mode 06777 which they may write to, the server receives:
> >
> >   GETXATTR  "security.capability" -> ENODATA
> >   SETATTR   valid=3D0
> >   FALLOCATE offset=3D0 length=3D8192 mode=3D0
> >
> > and the file keeps mode 06777. Without FUSE_HANDLE_KILLPRIV_V2, the
> > same command clears both bits, since fuse_setattr() then turns the
> > request into a SETATTR of the mode. I verified the fallocate() case.
> > The copy_file_range() case is from reading the code, as the server I
> > tested does not implement FUSE_COPY_FILE_RANGE.
> >
> > This matters beyond the mode looking wrong: fallocate() with
> > FALLOC_FL_ZERO_RANGE or FALLOC_FL_PUNCH_HOLE, and copy_file_range()
> > even more so, change what the file holds. So somebody who may write to
> > a setuid file can replace its contents and keep the setuid bit, which
> > is what killing the bits is there to prevent.
> >
> > It looks like an interaction between changes rather than a choice.
> > Commit fe0da9c09b2d ("fuse: copy_file_range needs to strip setuid bits
> > and update timestamps") made copy_file_range() kill the bits in 2019,
> > which stopped working on FUSE_HANDLE_KILLPRIV_V2 connections with
> > 8981bdfda744 in 2020. Commit 4a6f278d4827 ("fuse: add file_modified()
> > to fallocate") added the same to fallocate() in 2022, which takes
> > effect only without FUSE_HANDLE_KILLPRIV_V2. As far as I can tell from
> > its source, virtiofsd with --killpriv-v2 has the same gap: it drops
> > CAP_FSETID for write, open and setattr when asked to, and calls
> > fallocate() and copy_file_range() as they are.
> >
> > I think we should pass the decision with the request, as for WRITE and
> > OPEN. For FUSE_FALLOCATE, a new FUSE_FALLOCATE_KILL_SUIDGID could go
> > into the currently unused fuse_fallocate_in.padding. For
> > FUSE_COPY_FILE_RANGE, it would need a new field, or a bit in
> > fuse_copy_file_range_in.flags behind a new INIT flag: servers pass
> > .flags on to copy_file_range(2) as it is (virtiofsd does), which fails
> > with EINVAL on any bit, so a new bit there cannot be sent to a server
> > which did not ask for it.
> >
> > What do you think?
> >
>
> I had actually noticed this with recent test additions in libfuse and
> had to add workarounds (on the day exactly one month ago).
> Unfortunately had been too busy to post the kernel patch yet.
>
> libfuse commits
> daa6cb7f6996 =E2=80=94 "test: check the KILLPRIV_V2 kill-suidgid flags re=
ach the filesystem"
>
> and
>
> 60ab8c0c35de ("test: check a write through passthrough_hp clears suid/sgi=
d")
>
> When testing the latter commit I had noticed the issue.
>
> Could you try the attached patch? Right now totally untested,
> I can test and send it out earliest during the weekend.
>
>
> Thanks,
> Bernd
>


--=20
https://mitar.tnode.com/
https://noc.social/@mitar
https://bsky.app/profile/mitar.bsky.social
