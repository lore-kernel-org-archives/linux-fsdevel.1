Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D2133AD82
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781798640; cv=pass; b=qmqLzIRg/+8LvLuRdm688MjHAWluYns/zvNhckddnfafrmd1qbtkJ9+FthHeS1aXRlm0GT2ZjbXZfe4UKcxpiTVrWZDhklYehfwbs86bj67R7PbYgdz1o/VtXOlbNjB65QVa/67lMUj4T/JhE0rU/pgNQM/JL+qJs/PNn1lthg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781798640; c=relaxed/simple;
	bh=JxajIuFFPzIDIlNu/ZZSYfy3SGLhW6O+Tar5hg7rAW0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Twq68EGqFrWVHYZJIeV/wgsUeeuFNJXnWBSC/a+/TqfM+bSMRQkQzwpHCRQzb/e58DN/dgvxAsGHSsnCpXV7yjoYn4IAXuk5U70bFSxenKtux92j6e34/iXBv54FXzD0hB5Ar0EDtjF7E2wZb/RvTxYN5FqbXmIOwkG8S+6FPZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MG6+tCQ3; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MG6+tCQ3"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-695469b574eso11924a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Jun 2026 09:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781798638; cv=none;
        d=google.com; s=arc-20260327;
        b=nB9ZV7EnkNrpCU7V/11bPhP9oXm76OMN3+7/0hlMfsVkYuJZSY30aSLNtnNmOoPGx3
         ZYU+WhKm88LLtSO8kwbLgj4MEUKxsEvIzL7gxJPSb3Qxc92pxAW48tHfOr2kxIxDako6
         ydqDZitAlD+DOdq7/+wVzBMVQ3ocXMzw0/84e8NrIG1qCSVAtsfOb2u54MULfO0TzjFs
         H+bCnSpsOAL7lt4tnYGwPkC5Ir73xWM2a3LhupgVsuXUu4jpxpZB+rB4ukaAykeAJxm8
         Fgm8UAQtb+tUAfCkjymi6AQZZmD+5g/x8r4orbfdS8LSj2NxQUJDyAfBjWLsh7v6W8pp
         psIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JxajIuFFPzIDIlNu/ZZSYfy3SGLhW6O+Tar5hg7rAW0=;
        fh=tF7LHA0/gZDn8JyE0Yjsy5t8Hf5yLh7JtMTnV3fOovg=;
        b=gNQR49+bsCSn84HtLW1j2HpgrpEtKL+/BZLRkF7PE7AYJ5XB3d2lzccgDmq/PWMiA1
         g80kqKlgmZJWDnUVGjCT/O5mCOziWSd2s6IR3a/kTfGunp7DXfikYPHqWsVED+a/iapu
         RO8n3GzZXf7uFjOujpxtvj1mf19dtHZJNRHvNm8LUz8J3lqWJAqcHv6J0MKGOruRHODo
         fLrlSlqYS9klzoUAhZvoqWFjcAriGAiqLckFiBWRw6nYNdNvfoQXqNJfEl7aeuHyI0vs
         JKnQxUcsT1Zn5lvVPPru4EHK+Tu1Zzae4Z5Gx/wpJ1qjMuLgKjrpHE7s5kKJ8543isIs
         hJJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781798638; x=1782403438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JxajIuFFPzIDIlNu/ZZSYfy3SGLhW6O+Tar5hg7rAW0=;
        b=MG6+tCQ3Vc9EWVydi+JhN6FhsrMN6MLCCVym6f+WcKnnsWpv6u34tIVSpT0BgpawBi
         70j4dOIxpZLpdp1gsYytvjntjFEAG2txgqhT5T6kiaOhZK9wbZjwyompY0iq/b+g/+Ns
         KS2x5NHQkxybNRmlEmC7I0B8bFXOtndznHIQE5iw7ryQD7dinLAmR6rOMY9sCUbdo4uP
         QJOuUz0eiKNm42YBw9AwQHy2sJd5Nw3J1whaXVeWfu/jkKoB74lfnTgr7KTL0kci2WP9
         +8+pL+JbI2HHp+e71p6RkWfIHocq67BVHjZSjXgeTya/Jgest0SuM6io9CarMvlBmQuF
         PMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781798638; x=1782403438;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JxajIuFFPzIDIlNu/ZZSYfy3SGLhW6O+Tar5hg7rAW0=;
        b=H0phE5ZsizQ8jot9xPQ9flaQH6F8QUYgEFe+4cZ3LGa86cPQ1kESnO4+7sQA0DcNvI
         a7mRrhVcmgAdiKAkm1cVmkQvSZSy73pCXJxKlVH8bTuiR6j+Di7DIBUaGd4MtPU8+MM4
         n4NR5hOvuQiE6Nxlc7cALdR7vCqMU8zLR6TFrMVqCRNipfOWPKEO94aI0jXyPuBd5GWx
         0Wngm8VPBhgamZNwTWdm4UQ1T4HxKUnrBJ/vINmzfrleM5f6xS9iHBUPGKcTiLm9xnWn
         nlbX0Tih8G9JPOXs5W4u9m1dEKiyzF4EXaZC3EFK3kHPY4UfpbTjrt0GN6jtQhvGm2XX
         +l+A==
X-Forwarded-Encrypted: i=1; AFNElJ/076taltfvvAxRCoAjgdlADlTP8E/dqTNbXBpCilNdaWpX5Wl4U5Lvk8Hlgf9gKmhipPXyW3UGdDklDL40@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7wFNezeXFoMJ4lPzAwi1n/v8HYnVRm3oz+K+84+WXa/Vqs3w
	tnfS08fWzC4RfVQGcitclkZYQngni/tFFRoNOWXyPrTlTI1F9NKd61d5vrNZzMLfRQz5Gnm+U0A
	riOSjGKAIh8H5ae0OfiBzXlf0tQxuxklsAXPe6XqH6fUozHUdvqo5K4F0t5Q=
X-Gm-Gg: AfdE7cn9he+eiG3nZ4jjtSScreeaBtsdhGbRJXuY/8HqdcrGGljRFbxs3xJtDoH+oXL
	Ynx65+7wLSQwJ+mw8xTeeLSRVCnFDECwf0wFfepJVYbLz0cMZx8UDuKZdnwOkgcx2eewhSlKI4m
	dYCy7CEWwK/UNXD+ADUDZgClkYA5hmxv5/0q9aGRDMQeFFKjl1nSNqXklVlibeoYkufOROmfP7N
	s0xY2snAjJpYkkc21tn0WFzTiykulhzPI+8XjnXr2WleqvBKiVx/H/tibRR2MW2eq/1PZSjFKMi
	boSn3eXKbhfzM7ccPDqsBXFC
X-Received: by 2002:a05:6402:a506:10b0:693:17e4:c6b0 with SMTP id
 4fb4d7f45d1cf-695d04870aamr34694a12.9.1781798636936; Thu, 18 Jun 2026
 09:03:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202606181547.617a6967-lkp@intel.com> <6z2rqmo7b6m2rdhqurspwya25ps4dj7lctdygnmq3rn4xt6h3i@57kiiy72epgd>
 <ajP_-zqVPtbzvc9j@lucifer>
In-Reply-To: <ajP_-zqVPtbzvc9j@lucifer>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 18 Jun 2026 16:03:43 +0000
X-Gm-Features: AVVi8CfU26Kn6wJARZ7W52yMNTl8DSKc66QrvdqWWlF5NJUNYk-ssIW_WadDCkU
Message-ID: <CAJuCfpFed0GuMk+dE-Xn0w45Mn1Spds-pc2BE__FUoWm6+R7_w@mail.gmail.com>
Subject: Re: [linux-next:master] [mm] 7b32f64bc5: pts.svt-av1.Preset13.Bosphorus4K.frames_per_second
 45.8% regression
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jan Kara <jack@suse.cz>, kernel test robot <oliver.sang@intel.com>, 
	Frederick Mayle <fmayle@google.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Andrew Morton <akpm@linux-foundation.org>, Kalesh Singh <kaleshsingh@google.com>, 
	David Hildenbrand <david@kernel.org>, Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 2:30=E2=80=AFPM Lorenzo Stoakes <ljs@kernel.org> wr=
ote:
>
> On Thu, Jun 18, 2026 at 11:30:47AM +0200, Jan Kara wrote:
> > On Thu 18-06-26 16:00:42, kernel test robot wrote:
> > > Hello,
> > >
> > > kernel test robot noticed a 45.8% regression of pts.svt-av1.Preset13.=
Bosphorus4K.frames_per_second on:
> >
> > This one looks serious enough and real. It would be good to figure out =
what
> > happens in this benchmark that it benefits from the readahead across VM=
A
> > boundaries so much...
>
> I think a revert first no? This seems pretty huge for something that isn'=
t key
> to the kernel, then a new attempt can be tried with this issue addressed
> perhaps?

A quick search yields: "The
pts.svt-av1.Preset13.Bosphorus4K.frames_per_second is a benchmarking
metric from the Phoronix Test Suite that measures how many frames per
second a CPU can encode using the open-source SVT-AV1 video encoder."

If this is a video encoding benchmark I would expect it to explicitly
prefetch the data from the disk before measuring the encoding speed.
If limiting readahead caused this regression, I suspect the benchmark
doesn't explicitly prefetch the data...

>
> I seem to recall objecting to this in the past, had a look around and saw=
 [0]
> which has some discussion I think specifically on the VMA boundaries thin=
g.
>
> [0]:https://lore.kernel.org/linux-mm/CAC_TJvfG8GcwG_2w1o6GOTZS8tfEx2h9A91=
qsenYfYsX8Te=3DBg@mail.gmail.com/
>
> (Sorry to be naggy buuut :) - I see there wasn't maintainer [Matthew] sig=
noff on
> this, we should really be in the habit of _requiring_ that for merge).
>
> Thanks, Lorenzo
