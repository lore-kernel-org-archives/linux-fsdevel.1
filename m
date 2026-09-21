Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB184CEE52
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 16:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790007905; cv=pass; b=HqPjA7kFLCpkfLq8MayG01S9yeIBSTE7xqPXqdmWUHXvL3PDE3RFuK1OYnYKWTsQ/poBwsu4JQS4vCsCIZt7SbsDnlKZTEjrNafZd1/EBq+NVfuyZ6jsIESzzaa1ZtmdPrKaTv4fZ/DmmDpeyS9drEtkfmvHGs9ejJFViT0CRrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790007905; c=relaxed/simple;
	bh=SkfNaBY6KCTNcsxa0k1naDsMnruw9CvuNlmEUb3KtcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLF/S3zDeqNGSHEWLd73cAyxenCMIyMsLpdkHgaLltRGqF2OgRbXoVRhxuUi5ZkeudzJGNegCfnRzqO48XhN/UtFtt2ZP5W65A9hTX6fDrSt2ZRgiro7SVrewfy0+7ybaP+cqFcXkGyFNtdGHfQgDcRChh3B2f721iKKJe/i9t4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bev/SuTo; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bev/SuTo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2db33db4de9so200565ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 09:25:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790007903; cv=none;
        d=google.com; s=arc-20260327;
        b=N+zBcQYYLKtDKdEzhPDGgHp/uboeuWeiluxQJ72IATUtsu1yaTl6maW8d289tsB6rE
         oo17t5j+bku7pCCr/wY52voBSiYbqJRmzYzt0+MxvO7/Wea/cNwjxSY2IKg5SJJgCIAL
         mrIilsRhmE1mRiVkvVo4d81EepjX5xPj/QJRX3iO5chT+bzL/+1CcjsNpprM1NSUWh4Z
         efug95dRgbtGwZztxKuR2riXDEiwOD+C7/kz2WIvaAgXCcgqtDnK4g61FQZDPQHlaWne
         XygWPZqm0sMcvQzvTK8I6KkXAm2lCd19bYQZG6QoGwcwvMpe3Ck831kcAahvOXokNRKX
         kQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=st2Kt3rk+4KKTtlP7TEInvJBc0m4MIULwR8J6LVT4bc=;
        fh=O9JqZhOSuA+41b32rqMntnC2Ig7mb+8IjuRt+QcNG4I=;
        b=Dw1CC7UI2kj/T3yH1TJe1g6WgGX/QThxihwtyAhBKouMXZF+biAL5FbQNDIhu4sH5f
         7leMeZNcy+5SVVYLU2Sc3Z+NP/cq2UMYP/XXvVjhU9HtqMde2bb1A0rXMTwjFSXneA7Z
         d3dYpxQOwDC0FHLNqZKQPseVM4z6HhZrculoBu/6sujztqqLKSlOXdRCNg8Z7MkjLYFQ
         BtFD0eM1H9bNI0YVG0wtfNfnAXghbRay6uERcwLSWVPAwR2ndTo1Bejt+MpgfjjHwHbO
         XjTKbv7bF3+0f6WU0ACO7jeHapkvnJSns6EnWmovpwGauz1putLALrrXTgutqAOWd0c7
         UXig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790007903; x=1790612703; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=st2Kt3rk+4KKTtlP7TEInvJBc0m4MIULwR8J6LVT4bc=;
        b=bev/SuToFFdMDJ98+Br3p2BbuYH+Z+IPrA3mp6q6+aYUoosVLExJVBrPodPEtacXi0
         HiRa33To9tyOuZtAIx/R3fokVPs5nXDemHtiu8c2oU9/j6BOz9nVA8ftq0c4OmeS4n8n
         Px1H6y/G6mUOpPl7XniYhlQMWRfmr8gxY1Qm4ZwqqYFV8+FO+zCZGQelYG1BySWfugO1
         a+0+ZvWhWXgexQVZnGkjolsXa9tJzxx7EPjUiTtb1NqlIvUs17h4zlOmx40ZQnZQUZwy
         ijBR8aHS04V9nMlwr8uqHbtnZ98UOuy+LJzr5W6ziNydSgTpF7dfONyotbgGX8KIVMJe
         CIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790007903; x=1790612703;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=st2Kt3rk+4KKTtlP7TEInvJBc0m4MIULwR8J6LVT4bc=;
        b=fUV67YppwqJN0p00YMf/7GRy1zGXpkAWJfKGEKTJtJw2Xy5ydNbEOm7TJbfO9MPIid
         AZVUzgcVPuyijX+ALIIjV2WGqXRUlgBWCNIuJGvxNNxnOKkgtBP9Hp27G4EgyHNXI6EG
         zr2aOGKivmSXCaXCTbA323/YEq4BPnEvSmdC4NbKJ2cq0LNA++rYfyUAOeyOODkkMmIB
         gUs+iuFpD9xL5LE3DhfsCkA9lssG5fll4krttNRvH3ytC3WBwhw8aSTh01MAHnZQEJAW
         SRtn3jd2dfpMWvP4NaTs1bewRq7lF0j0gr/PHOH6mMP0v9qOdbTBz3fzym/WA+hdT5Dk
         GYOA==
X-Gm-Message-State: AFuF++mJX3SLowcpI8mWHTqCh5tU5aQ2KA1YnqyQrjvhMstlwqm5iRvU
	7TLVPclWYBv+BZZfzE41/6QHqb85wXMOpPk+7zEUtCHXlCZkeVvQSE3K8O2A15JdBxGxFqJyeEQ
	PSpIiONHeTZQrLxwQlD7LnNhguizH/CD2WB0+hrvt
X-Gm-Gg: AYBFou1lbEVwUVvKe+raPpbEi8UqioSFcdFj4JsUcaQZKnbjqQvBFoqk7hvVn2YtVma
	znentuQ/ZAaB//V2haMe/hjjcIxWYlxnCfyQVHf6ekpHepZkPva+uiwZxgyzoaEJ+zwQoFvJnBB
	g9KJrxi4sX4n0BrsyKrD9Q+U8ErP018xacruwl9dDz6OwM5tEVay+Bpjp4lwIa7SOihwziAjbYG
	D0TFGJ7oqUD1m7ZRoPKiPEyz1PdBagf1XD6T1tagL/5bUGKUxwhqji8kojPOHBBSK6h6ONOuy77
	fDDB4O/5FiqsgdYRwg2dDZ3LDFmsXtLQLmXgVCBFYbs/83OXo+2EfRti0VSPtqBLYl5nkZlcFCA
	fpq9rrXe964WlaUpz0UYrYaApKWlbuohhCarC2t+dvrWLZN0q7ZA=
X-Received: by 2002:a17:902:e812:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2ddc165f8d9mr11980525ad.2.1790007902717; Mon, 21 Sep 2026
 09:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260921-work-file-close_range_except-v1-0-c20d0b49270d@kernel.org>
 <20260921-work-file-close_range_except-v1-8-c20d0b49270d@kernel.org>
In-Reply-To: <20260921-work-file-close_range_except-v1-8-c20d0b49270d@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Mon, 21 Sep 2026 18:24:25 +0200
X-Gm-Features: AcwNN1Uk9IjN9fhJC7D6AxK8QTdTmass4l0HpcTRrRrEcQ6vJQGt8vOOzDIKmnw
Message-ID: <CAG48ez23cnVa9kia8z+ny9-vMRxuNtCcoG0hV4Vy6YUvkC4xDw@mail.gmail.com>
Subject: Re: [PATCH 08/10] file: let dup_fd() drop only close-on-exec descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Neil Brown <neil@brown.name>, 
	Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 4:16=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> Add FD_RANGE_CLOEXEC_ONLY. When set dup_fd() leaves everything behind
> except for fds that are close-on-exec. Without FD_RANGE_EXCEPT the
> clone loses the close-on-exec descriptors in the range. With it the
> clone keeps the range and loses the close-on-exec descriptors everywhere
> else. Descriptors without the flag are carried over either way.
[...]
> @@ -393,15 +396,37 @@ static unsigned int sane_fdtable_size(struct fdtabl=
e *fdt, struct fd_range *rang
>
>         if (last =3D=3D fdt->max_fds)
>                 return NR_OPEN_DEFAULT;
> -       /* Only words up to the last open descriptor can hold a kept one.=
 */
> -       i =3D last / BITS_PER_LONG + 1;
> -       while (i--) {
> -               unsigned long dropped =3D dup_fd_dropped_word(i, range);
> +       if (!range)
> +               return ALIGN(last + 1, BITS_PER_LONG);
> +
> +       if (range->flags & FD_RANGE_CLOEXEC_ONLY) {
> +               /* The close-on-exec bits decide what is dropped, walk th=
e words. */
> +               i =3D last / BITS_PER_LONG + 1;
> +               while (i--) {
> +                       unsigned long dropped =3D dup_fd_dropped_word(fdt=
, i, range);
> +
> +                       if (fdt->open_fds[i] & ~dropped)
> +                               return (i + 1) * BITS_PER_LONG;
> +               }
> +               return NR_OPEN_DEFAULT;
> +       }
>
> -               if (fdt->open_fds[i] & ~dropped)
> -                       return (i + 1) * BITS_PER_LONG;
> +       if (range->flags & FD_RANGE_EXCEPT) {
> +               /* Only the range is carried over. */
> +               if (last > range->to) {
> +                       last =3D find_last_bit(fdt->open_fds, range->to +=
 1);
> +                       if (last > range->to)
> +                               return NR_OPEN_DEFAULT;
> +               }
> +               if (last < range->from)
> +                       return NR_OPEN_DEFAULT;
> +       } else if (last >=3D range->from && last <=3D range->to) {
> +               /* The last open descriptor goes, the kept ones sit below=
 the range. */
> +               last =3D find_last_bit(fdt->open_fds, range->from);
> +               if (last =3D=3D range->from)
> +                       return NR_OPEN_DEFAULT;
>         }

Maybe integrate this part of the patch, except for the
FD_RANGE_CLOEXEC_ONLY branch, into "file: let dup_fd() leave the
punched hole behind", which introduced the loop in sane_fdtable_size()
that is being removed here, and "file: let dup_fd() drop everything
outside of the range", which introduces FD_RANGE_EXCEPT?
