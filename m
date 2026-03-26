Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5CA2E11BC
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 16:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542263; cv=pass; b=pxim4uWZ1LZcnNI9zCVoFZaHnU8iuWF4c2vzYmqiJehxtuyHEShW0S+WwwOqdYVNS8J/HJ2C5f0jatGJWssonX5YzmWs9oylqDNklnDyup87wlS/jcsY0U2zLuBt0HYVnZy2bD0nxgHPlcoJMYVpJy2Zr8W1YWrHskVV1iZuYjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542263; c=relaxed/simple;
	bh=5UuVGt9aXU7RKic8r0QqsRNSiL+5BCEhAj/jhmOsfSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oVRo6Zuk5JiEs5MU+pd/TmZ3viGnwzp0qyGgWuRs5gkTCfMZUXGO7cCHxXAyReaju2Ysb5vYpYC4940f9gcuHbdXvXNtDgW3ePZ7T0KOJnh95+bYOYZ7jSXIn2RFxrasjdkursMWUyme5G7F9CztmFrWHMw8HDjAdm+4hp7JCVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCkWnDMg; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCkWnDMg"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b980b35534eso351983966b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 09:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774542260; cv=none;
        d=google.com; s=arc-20240605;
        b=OR/eAA6znRr2SlPegK88PExy2f7nZg+Tue0T53QMJ+PljNDkZ3Y0iMP+FNln+1XtbG
         nfg5IAcHvD6MgdK/CM3Q3sw7bqdLlGfQ7cuuve3s1ow3kwP7ngBG4Svz+DFzvdnp6jeI
         KHw+J667JwNOWPd0M+Wmx2Gpg5tpJOWBVuERXa8xfJ3CZ5HyqRgS+pLPRy0SrmWX6lZX
         KkPVsBvqrbAd3+NxiQN+YZ5Sibnm99LHDEkwIOKm84QrgMgjFEFo/CrAYSMKAvTrPm4Q
         jBALKXRUTOCiY/MDqra2mbKdlJl+qQU56YDJsTWHX10I2m+QczT+qMPJaEbJ8BWoRE5z
         QNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1G5mmEJ0GBozKNV/8eztCw+Pxegyp1NNUMRmu9Ezg6E=;
        fh=HBKyxzl7HCuTuMdBKDpBbVqykPvmll4zQi1bk1VFyZ8=;
        b=ixn6rM3MnnXKMdoBjj/Ql+dAnaa+ibzYihAkMiP5EHiGmM4qCxb22spuZNSZ65SQrF
         IwnUCKDH5yCt5QkEL9GFkzApn1OWkB8CHvde3LPYUO55F43ItccMTsQIP+djbY3PPhoc
         29ZxjDr4F4PUdWU8V2E9VjUwJFvdSxpGyvLBcTuq9s19s/Uv0oeHnnNJcl4MUhh6XxG9
         ThX6bz28bMFCLahD+ssyFrOVA/J5KGc9iz2gsVxbPkDbBcgxnHKLHTMtQCY8B2OO7DDh
         CyJE4X78m84byTFKSP/ns80jJotBDoGQni/d/uCZ0cn2Ns5FIBRZDMoB0jr/+bPc587B
         THAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542260; x=1775147060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G5mmEJ0GBozKNV/8eztCw+Pxegyp1NNUMRmu9Ezg6E=;
        b=mCkWnDMg5tppoX9Y2WjKcJyno4pwENMB0RafT44WbKmBO14xq8Vp6QTv1mAvkbBliM
         DRMXAm92zRcmU8900yqO5GyJdhw6VC+5p2N7yFq+sahKUbN8gaI5iieF/B7Lau4j67wj
         Vws3oXjwBOvUXbRZx2NhVxFZVwlsT5i3m7IOStYg0goZaqIX9NnzI9PNepLxop8Kga4e
         BBJlL6eUleFzWkQeIQOnXG0bsvA5A0NQmKvNwPOZhBrpL+r5JjaAYhT18PpSdBJSmsdW
         yIA8pRHbUXiH/epO6JC9XM5IuA8Zmj1eqEgmH+E+6AXRZGd8dPa1wfnCWYN3N44/5SsI
         jDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542260; x=1775147060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1G5mmEJ0GBozKNV/8eztCw+Pxegyp1NNUMRmu9Ezg6E=;
        b=YIRQbS5veXT8DL8wKk+q1Nf0CN47tYTD1ptO0DzUm7dSEurjMtck6i18/u4eKrII4E
         8qqWzLLd5sGZNvrHX9tvDoE2HlXisCBDdOlhrcZY0WnVqUoE+A+LM3DrUnTOheulkHXB
         2qKrKhoVi3IySjD36Jbxg7xt5W3DRdWJDFdPQiHJIHVIRpPeNNPxyhFtlq1rA5xhzzhQ
         I6pKYMfG/K0O2wACBHWeDdZb996w80kUAHdgCKd9b8jCk6gHpxlLi8Ulnhb8QR/IyTRw
         ZhhXaaCPx0CEkBH7eQmRbqmoF1SKPmcp/iFtdOe31dqlBAX18k2nZO9uNgyaXGZe5URX
         6FwA==
X-Forwarded-Encrypted: i=1; AJvYcCX7cBxhjnbl0RKqmZ2PUodPp7eTZa9gB9O3vy28+5IK3Qb7zP/sdBRq21gPThW+Pot5omByh3NQCe9h/fZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YxhQXmi0xAnXCi+qA5swN7LNGhszZH2ip/1u8vHkjV8hbUw/z3w
	NgxzaAXBZctJugIx8gu/WwEbrUkc19TS7kEQ25F8ySSHai17siYzOVbIxJ5cFYsqd2nEcYp9c8m
	9ek3nPUzrv4WHy4d4uoX0vakmcx/LWks=
X-Gm-Gg: ATEYQzxZlXeOf8eA4rFEnA45L1xD3lBANe1mJkE8u8bT00aiIJ4HiU05E0pi8k+5e7T
	w20Se8v3h5fp3xGwBrgDick4LV/1oABMVDAbZoZffje0Wr6/8K8tc6+2uwST2k4kIdN99mWDkea
	XlFk8qewJMqWl5JRKOF4CekD5dFzHT4MOQqj6IhAWfCgL5NuBl4XKW7CLjLAlkIkKeLWJaESsuT
	Wt545KQpMFtWgToKUjhM1UmeBiC0TTHsrInbjlgBE9uoBXl+jUwEE+niU8zFmMfqzbb2PqmioOn
	ZUEF1SAePSa3i8SU9DGu7YkYhmK7YbJKR1TE1c6HWg==
X-Received: by 2002:a17:907:728d:b0:b84:3fab:4251 with SMTP id
 a640c23a62f3a-b9b2e79a927mr166997166b.15.1774542259841; Thu, 26 Mar 2026
 09:24:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfe18ae0-7dc0-4601-a9f0-c0665f301cfe@linux.alibaba.com>
 <s3y7qrkgwedbkltpt7mjjzisazynzms3btablzpxhdoezapddy@xanux4rrspwd>
 <72eaaed1-24a0-4c98-a7c0-ea249d541f2d@linux.alibaba.com> <9af9ad0e-8070-4aaa-9f64-7d72074bd948@linux.alibaba.com>
 <wo2nf7bux5rhexbpyeutbb5bkpqlumq3ht7iqxdft7lhc2p6va@3q6wsi2xndpu>
 <68116ee5-b1f7-484b-a520-7dc5aefd7738@linux.alibaba.com> <2gyfmxfnnxrglpzb7kz63xbve5vnosl6gi54c3umgrpwbjr4og@lz4e2ptqanfe>
 <20260324-hilfen-reibung-9783005d5d0f@brauner> <b8f5bff1-27bf-4934-9297-0aad551a550c@gmail.com>
 <d2d5c218-7063-4ea0-ab03-1433449f4d83@linux.alibaba.com> <20260326-gemindert-vertuschen-fd3a507eba94@brauner>
 <f1cef32a-1c35-41dd-88af-a8c504d41a93@linux.alibaba.com> <0b8a0d24-1c20-45b3-abd9-e95b3b4d4caf@linux.alibaba.com>
In-Reply-To: <0b8a0d24-1c20-45b3-abd9-e95b3b4d4caf@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 26 Mar 2026 17:24:07 +0100
X-Gm-Features: AQROBzAbTka03XED-totoGzgp-iBZmbbBKUVJFwrSzpxUZxzQlTPQJ-H3MjIib0
Message-ID: <CAOQ4uxjR2h9+=DPKUzV35J4ageNCn0oMHL0QvZSjJiuH5Gfo+g@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Where is fuse going? API cleanup,
 restructuring and more
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, Demi Marie Obenour <demiobenour@gmail.com>, Jan Kara <jack@suse.cz>, 
	"Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Joanne Koong <joannelkoong@gmail.com>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>, 
	Horst Birthelmer <horst@birthelmer.de>, Gao Xiang <xiang@kernel.org>, 
	lsf-pc@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 5:12=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2026/3/26 23:10, Gao Xiang wrote:
>
> ...
>
> >>
> >> I don't understand what exactly people think is going to happen once w=
e
> >> start promising that mounting untrusted images in the kernel for even
> >> one filesystem is fine. This will march us down security madness we ha=
ve
> >> not experienced before with all of the k8s and container workloads out
> >> there.
>
> Yes, my reaction about this is that still depends on
> how you think this.
>
> The whole Linux namespace mechanism is unsafe compared
> with traditional virtualization; no one really imagined
> the implications without implementing, enabling these
> namespaces and trying.  These new mechanisms introduce
> many new CVEs and vulnerabilities from time to time, but
> containerization still drives innovation, and
> cloud-native technologies are heavily based on it.

Interesting example because of how this played out.
Every distro took its own direction, some still carrying out of tree
patches for userns policies to this day.

>
> This is especially true for user namespaces. However, I
> don't think we should remove them entirely from the
> kernel just due to potential CVEs or because they aren't
> implemented in Rust, for example.
>
> Regarding FS_MOUNT_USERNS, my experience over the years
> is: three years ago, honestly, I never cared about this
> feature at all. But soon after, several new attempts
> emerged to resolve the same requirement in different
> ways, which already confused me. I wondered why we
> couldn't work in a cooperative way instead, especially
> since neither of them looks like a very huge project with
> enough development resource. Then, I realized that as
> long as you don't implement something, there will be
> endless new attempts and comments from various small
> group of people.  And the userspace policy will never get
> in agreement.
>
> So, if this is filesystem-specific, my current thinking
> is this: if the security model can be formally documented
> and fuzzing is improved, could it eventually be enabled
> via an opt-in Kconfig within a single filesystem group?
> Would that end the whole story because the Docker image
> requirement is fulfilled?
>

I think that what you are proposing is so controversial
that the chances of reaching a consensus in upstream are low.
Doesn't mean you that you cannot try to sell it to some cloud distros
as an out of tree patch.

If you have buy-in from some downstream container distros, and it
survives the wilderness for a few years, during which you fix CVEs,
you may have a stronger case to present for upstream.
Just saying. Maybe you are charging the wrong hill.

Thanks,
Amir.
